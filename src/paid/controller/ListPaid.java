package paid.controller;

import java.io.IOException;
import java.io.Reader;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import paid.dto.PaidDTO;
import user.buyer.dto.BuyerDTO;
import cart.dto.CartDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import coupon.dto.CouponDTO;



@Controller
public class ListPaid {
	//결제(주문)
	private List<CartDTO> list = new ArrayList<CartDTO>();
	private CartDTO paramClass = new CartDTO();
	private BuyerDTO buyerDTO = new BuyerDTO();
	private int pay_num;
	private String pay_rest_subject;
	private String pay_restopt_subject;
	private int pay_pricetotal = 0;
	
	//결제(완료)
	private CartDTO paramClass1 = new CartDTO();
	private PaidDTO paramClass2 = new PaidDTO();
	private CouponDTO paramClass3 = new CouponDTO();
	private PaidDTO resultClass = new PaidDTO();
	private List<CartDTO> list1 = new ArrayList<CartDTO>();
	private List<PaidDTO> list2 = new ArrayList<PaidDTO>();
	private String cooResult;
	private Calendar today = Calendar.getInstance();
	
	//iBatis관련
	SqlMapClientTemplate ibatis = null;
	public static Reader reader;
	public static SqlMapClient sqlMapper;
	
	//생성자(연결)
	public ListPaid() throws IOException{
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}
	
	//payRest.do
	@RequestMapping("/payRest.do")
	public String payRest(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		String session_id = (String) session.getAttribute("session_id");
		int rest_num = Integer.parseInt(request.getParameter("rest_num"));
		String rest_subject = request.getParameter("rest_subject");
		
		paramClass.setCart_rest_num(rest_num);
		paramClass.setSession_id(session_id);
		
		//현재 카트에 담긴 레코드를 리스트에 담음 (상품넘버and세션아이디)
		list = sqlMapper.queryForList("Cart.selectForPayment",paramClass);
		
		//결제 필수 4종 파라미터 생성, and get() to AGS_pay.jsp
		pay_num = rest_num;
		pay_rest_subject = rest_subject;
		
		pay_pricetotal = 0;
		for(int i=0; i<list.size(); i++){
			pay_restopt_subject += list.get(i).getCart_restopt_subject()+", ";
			pay_pricetotal += list.get(i).getCart_restopt_priceplus() * list.get(i).getCart_amount(); //가격 * 수량 값을 pricetotal에 누적
		}
		
		//회원정보
		buyerDTO = (BuyerDTO) sqlMapper.queryForObject("Buyer.getBuyerSession", session_id);
		
		
		request.setAttribute("list", list);
		request.setAttribute("pay_num", pay_num);
		request.setAttribute("pay_rest_subject", "eMenu");
		request.setAttribute("pay_restopt_subject", pay_restopt_subject);
		request.setAttribute("pay_pricetotal", pay_pricetotal);
		request.setAttribute("buyerDTO", buyerDTO);
		
		return "/agspay/AGS_pay.jsp";
	}
	
	
	
	//payRestResult.do
	@RequestMapping("/payRestResult.do")
	public String payRestResult(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		String session_id = (String) session.getAttribute("session_id");
		int rest_num = Integer.parseInt(request.getParameter("rest_num"));
		
		//장바구니에 담은 레코드들을 get
		paramClass1.setCart_rest_num(rest_num);
		paramClass1.setSession_id(session_id);
		list1 = sqlMapper.queryForList("Cart.selectCartAll", paramClass1);
		
		//결제 테이블 insert전 레코드가 없는지 있는지 판단.
		Integer count = (Integer)sqlMapper.queryForObject("Paid.selectPaidCount");
		if( count != 0){ //레코드가 있을 경우, LastNum set
			resultClass = (PaidDTO) sqlMapper.queryForObject("Paid.selectPaidLastNum"); //라스트넘 이상 select 하도록
		}else{ //레코드가 없을 경우, 0 set
			resultClass.setPaid_num(0);
		}
		
		//장바구니 테이블 -> 결과테이블로 insert
		for(int i=0; i<list1.size(); i++){
			paramClass2.setPaid_rest_num(list1.get(i).getCart_rest_num());
			paramClass2.setPaid_rest_subject(list1.get(i).getCart_rest_subject());
			paramClass2.setPaid_restopt_num(list1.get(i).getCart_restopt_num());
			paramClass2.setPaid_restopt_subject(list1.get(i).getCart_restopt_subject());
			paramClass2.setPaid_restopt_priceplus(list1.get(i).getCart_restopt_priceplus());
			paramClass2.setPaid_restopt_destFile1(list1.get(i).getCart_restopt_destFile1());
			
			//쿠폰생성
			cooResult = Integer.toString((int)(Math.random() * 999999))+ "-" + Integer.toString((int)(Math.random() * 99999999))+ "-" + Integer.toString((int)(Math.random() * 777777));
			count = (Integer)sqlMapper.queryForObject("Coupon.selectCheckedCpn", cooResult);
			while(count != 0){ //값이 중복이 안될때까지 다시 생성
				cooResult = Integer.toString((int)(Math.random() * 777777))+ "-" + Integer.toString((int)(Math.random() * 99999999))+ "-" + Integer.toString((int)(Math.random() * 999999));
				count = (Integer)sqlMapper.queryForObject("Coupon.selectCheckedCpn", cooResult);
			}
			
			//중복되지 않은 쿠폰번호 cooResult를 쿠폰테이블로 insert
			paramClass3.setCpn_num(cooResult);
			sqlMapper.insert("Coupon.insertCpn", paramClass3);
			
			paramClass2.setPaid_cpn(cooResult); //쿠폰번호
			paramClass2.setPaid_cpn_used(0); // 0발행완료, 1사용함, 2유효기간초과 되면서 처리되는 논리값
			paramClass2.setSession_id(session_id); //주문한 세션아이디
			paramClass2.setPaid_reg_date(today.getTime()); // 쿠폰 발행일자
			
			sqlMapper.insert("Paid.insertPaid", paramClass2);
		}
		
		//최종 장바구니 레코드 삭제
		sqlMapper.delete("Cart.deleteCartForPaid", paramClass1);
		
		//방금 장바구니로 구매한 레코드 (=방금 결제완료한 레코드)
		list2 = sqlMapper.queryForList("Paid.selectPaidNow", resultClass);
		
		request.setAttribute("list2", list2);
		
		return "/view/rest/payRestResult.jsp";
	}
	
	
}
