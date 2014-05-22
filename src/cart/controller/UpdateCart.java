package cart.controller;

import java.io.IOException;
import java.io.Reader;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import user.buyer.dto.BuyerDTO;
import cart.dto.CartDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

@Controller
public class UpdateCart {
	//장바구니관련
	private CartDTO paramClass = new CartDTO();
	private List<CartDTO> list = new ArrayList<CartDTO>();
	private BuyerDTO buyerDTO = new BuyerDTO();
	private int pay_num;
	private String pay_rest_subject;
	private String pay_restopt_subject;
	private int pay_pricetotal = 0;
	
	//iBatis관련
	SqlMapClientTemplate ibatis = null;
	public static Reader reader;
	public static SqlMapClient sqlMapper;

	//생성자(연결)
	public UpdateCart() throws IOException{
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}
	
	//plusAmount.do
	@RequestMapping("/plusAmount.do")
	public String plusAmount(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		String session_id = (String) session.getAttribute("session_id");
		
		int cart_rest_num = Integer.parseInt(request.getParameter("cart_rest_num"));
		String cart_rest_subject = request.getParameter("cart_rest_subject");
		String cart_restopt_subject = request.getParameter("cart_restopt_subject");
		
		paramClass.setCart_rest_num(cart_rest_num);
		paramClass.setCart_restopt_subject(cart_restopt_subject);
		paramClass.setSession_id(session_id);
		
		//해당 리스트의 레코드를 get함
		list = sqlMapper.queryForList("Cart.getAmount", paramClass);
		
		paramClass.setCart_amount(list.get(0).getCart_amount());
		//옵션중복시에 장바구니 데이터 수량만 update
		sqlMapper.update("Cart.plusAmount", paramClass);
		
		return "redirect:listCart.do?rest_num="+cart_rest_num+"&rest_subject="+cart_rest_subject;
	}
	
	//minusAmount.do
	@RequestMapping("/minusAmount.do")
	public String minusAmount(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		String session_id = (String) session.getAttribute("session_id");
		
		int cart_rest_num = Integer.parseInt(request.getParameter("cart_rest_num"));
		String cart_rest_subject = request.getParameter("cart_rest_subject");
		String cart_restopt_subject = request.getParameter("cart_restopt_subject");
		
		paramClass.setCart_rest_num(cart_rest_num);
		paramClass.setCart_restopt_subject(cart_restopt_subject);
		paramClass.setSession_id(session_id);
		
		//해당 리스트의 레코드를 get함
		list = sqlMapper.queryForList("Cart.getAmount", paramClass);
		
		
		
		//옵션중복시에 장바구니 데이터 수량만 update
		int amount = list.get(0).getCart_amount(); //현재 레코드의 수량이 뭔지 알아봄.
		if(amount == 1){ //수량이 0일 경우
			paramClass.setCart_amount(2);
			sqlMapper.update("Cart.minusAmount", paramClass);
		}else{ // 0이 아닌 다른 숫자일 경우
			paramClass.setCart_amount(amount);
			sqlMapper.update("Cart.minusAmount", paramClass);
		}
		
		return "redirect:listCart.do?rest_num="+cart_rest_num+"&rest_subject="+cart_rest_subject;
	}
	
	
	//user/payment.do
	@RequestMapping("/payment.do")
    public String payment(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestParam(value="requestCart_num", required=false) int[] reqPaid) throws Exception{
		String session_id = (String) session.getAttribute("session_id");
		int rest_num = Integer.parseInt(request.getParameter("rest_num"));
		String rest_subject = request.getParameter("rest_subject");
		
		//체크한값을 1로 업데이트
		for(int i=0; i< reqPaid.length; i++) {
            sqlMapper.update("Cart.updatePayList", reqPaid[i]);
        }
		
		//값이 1인것들만 list로 받음
		paramClass.setCart_rest_num(rest_num);
		paramClass.setSession_id(session_id);
		
		//현재 체크된 상품만 리스트에 담음  (상품넘버and세션아이디and체크=1)
		list = sqlMapper.queryForList("Cart.selectForCheckedPayment",paramClass);
		
		
		
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
		request.setAttribute("pay_rest_subject", pay_rest_subject);
		request.setAttribute("pay_restopt_subject", pay_restopt_subject);
		request.setAttribute("pay_pricetotal", pay_pricetotal);
		request.setAttribute("buyerDTO", buyerDTO);
		
		//리스트 보낸 뒤 1인것들을 다시 0으로 바꿈
		sqlMapper.update("Cart.rollback");
		
		return "/agspay/AGS_pay.jsp";
    }
	
}
