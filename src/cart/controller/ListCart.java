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

import rest.dto.RestDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import cart.dto.CartDTO;

@Controller
public class ListCart {
	//장바구니관련
		private CartDTO paramClass1 = new CartDTO();
		private List<CartDTO> list = new ArrayList<CartDTO>();
		
		//iBatis관련
		SqlMapClientTemplate ibatis = null;
		public static Reader reader;
		public static SqlMapClient sqlMapper;
		
		
		//생성자(연결)
		public ListCart() throws IOException{
			reader = Resources.getResourceAsReader("sqlMapConfig.xml");
			sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
			reader.close();
		}
		
		//listCart.do
		@RequestMapping("/listCart.do")
		public String listCart(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
			String session_id = (String) session.getAttribute("session_id");
			int rest_num = Integer.parseInt(request.getParameter("rest_num"));
			String rest_subject = request.getParameter("rest_subject");
			
			paramClass1.setCart_rest_num(rest_num);
			paramClass1.setSession_id(session_id);
			//카트리스트
			list = sqlMapper.queryForList("Cart.selectCartAll", paramClass1);
			
			request.setAttribute("rest_num", rest_num);
			request.setAttribute("rest_subject", rest_subject);
			request.setAttribute("list", list);

			return "/view/rest/listCart.jsp";//"redirect:listCart.do?rest_num="+rest_num+"&rest_subject="+rest_subject;
		}
		

}
