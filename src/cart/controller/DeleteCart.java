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
public class DeleteCart {
	
	//장바구니 관련
	private CartDTO paramClass = new CartDTO();
	private List<CartDTO> list = new ArrayList<CartDTO>();
	
	//iBatis관련
	SqlMapClientTemplate ibatis = null;
	public static Reader reader;
	public static SqlMapClient sqlMapper;
	
	//생성자(연결)
	public DeleteCart() throws IOException{
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}
	
	
	//deleteCart.do
	@RequestMapping("/deleteCart.do")
	public String deleteCart(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		String session_id = (String) session.getAttribute("session_id");
		int rest_num = Integer.parseInt(request.getParameter("rest_num"));
		String rest_subject = request.getParameter("rest_subject");
		
		paramClass.setCart_rest_num(rest_num);
		paramClass.setSession_id(session_id);
		//장바구니 레코드 삭제
		sqlMapper.delete("Cart.deleteCartForPaid", paramClass);
		//장바구니 레코드 가져오기.
		list = sqlMapper.queryForList("Cart.selectCartAll", paramClass);
		
		request.setAttribute("rest_num", rest_num);
		request.setAttribute("rest_subject", rest_subject);
		request.setAttribute("list", list);
		
		return "/view/rest/listCart.jsp";//"redirect:listCart.do?rest_num="+rest_num+"&rest_subject="+rest_subject;
	}

}
