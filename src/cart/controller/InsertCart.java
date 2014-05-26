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

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import cart.dto.CartDTO;

@Controller
public class InsertCart {
	
	//장바구니관련
	private CartDTO paramClass = new CartDTO();
	private List<CartDTO> list = new ArrayList<CartDTO>();
	
	//iBatis관련
	SqlMapClientTemplate ibatis = null;
	public static Reader reader;
	public static SqlMapClient sqlMapper;
	
	
	//생성자(연결)
	public InsertCart() throws IOException{
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}
	
	//insertCart.do
	@RequestMapping("/insertCart.do")
	public String insertCart(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		String session_id = (String) session.getAttribute("session_id");
		
		int cart_rest_num = Integer.parseInt(request.getParameter("cart_rest_num"));
		String cart_rest_subject = request.getParameter("cart_rest_subject");
		int cart_restopt_num = Integer.parseInt(request.getParameter("cart_restopt_num"));
		String cart_restopt_destFile1 = request.getParameter("cart_restopt_destFile1");
		String cart_restopt_subject = request.getParameter("cart_restopt_subject");
		int cart_restopt_priceplus = Integer.parseInt(request.getParameter("cart_restopt_priceplus"));
		
		paramClass.setCart_rest_num(cart_rest_num);
		paramClass.setCart_rest_subject(cart_rest_subject);
		paramClass.setCart_restopt_num(cart_restopt_num);
		paramClass.setCart_restopt_destFile1(cart_restopt_destFile1);
		paramClass.setCart_restopt_subject(cart_restopt_subject);
		paramClass.setCart_restopt_priceplus(cart_restopt_priceplus);
		paramClass.setSession_id(session_id);
		
		System.out.println("cart_rest_num"+cart_rest_num);
		System.out.println("cart_restopt_subject"+cart_restopt_subject);
		System.out.println("session_id"+session_id);
		
		int count = 0;
		count = (Integer) sqlMapper.queryForObject("Cart.getCount", paramClass);
		System.out.println("count값 : "+count);
		
		if(count == 0){ //해당되는 레코드가 없을 경우
			System.out.println("1번 insert 분기문 진입");
			//새로운옵션일경우 장바구니 데이터 insert
			sqlMapper.insert("Cart.insertCart", paramClass);
		}else{
			System.out.println("2번 update 분기문 진입");
			//해당 리스트의 amount를 +1 update하기 위해 레코드를 get함
			list = sqlMapper.queryForList("Cart.getAmount", paramClass);
			paramClass.setCart_amount(list.get(0).getCart_amount());
			//옵션중복시에 장바구니 데이터 수량만 update
			sqlMapper.update("Cart.plusAmount", paramClass);
		}
		
		/*
		//장바구니 레코드를 가져옴
		list = sqlMapper.queryForList("Cart.selectCartAll", paramClass);
		request.setAttribute("list", list);
	 	*/
		
		return "redirect:listCart.do?rest_num="+cart_rest_num+"&rest_subject="+cart_rest_subject;
	}

}
