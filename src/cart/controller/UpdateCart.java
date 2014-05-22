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

import cart.dto.CartDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

@Controller
public class UpdateCart {
	//장바구니관련
	private CartDTO paramClass = new CartDTO();
	private List<CartDTO> list = new ArrayList<CartDTO>();
	
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
		//	cart_rest_num, cart_restopt_subject , session_id
		
		paramClass.setCart_amount(list.get(0).getCart_amount());
		//옵션중복시에 장바구니 데이터 수량만 update
		sqlMapper.update("Cart.minusAmount", paramClass);
		
		return "redirect:listCart.do?rest_num="+cart_rest_num+"&rest_subject="+cart_rest_subject;
	}
}
