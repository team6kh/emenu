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

import common.PagingAction;
import cart.dto.CartDTO;

@Controller
public class ListCart {
		//장바구니관련
		private CartDTO paramClass1 = new CartDTO();
		private List<CartDTO> list = new ArrayList<CartDTO>();

		//페이지관련
		private int blockCount = 10; // 한 페이지의 게시물의 수
		private int blockPage = 5; // 한 화면에 보여줄 페이지
		private String pagingHtml; // 페이지를 구현할 HTML
		private PagingAction page; // 페이징 클래스
		private String actionName = "cartboard";
		private int currentPage = 1; // 현재 페이지
		private int totalCount; // 총 게시물의 수

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

			return "/view/rest/listCart.jsp";
		}


		//cartboard.do
		@RequestMapping("/cartboard.do")
		public String cartboard(HttpServletRequest request, HttpSession session) throws Exception{
			String session_id = (String) session.getAttribute("session_id");

			//현재 로그인된 세션의 카트리스트
			list = sqlMapper.queryForList("Cart.selectCartBoard", session_id);

			totalCount = list.size(); 
			if (request.getParameter("currentPage") == null){
				currentPage = 1;
			} else {
				currentPage = Integer.parseInt(request.getParameter("currentPage"));
			}
			page = new PagingAction(actionName, currentPage, totalCount, blockCount, blockPage, session_id); // PagingAction 객체 생성
			pagingHtml = page.getPagingHtml().toString(); 

			int lastCount = totalCount;
			if (page.getEndCount() < totalCount)
				lastCount = page.getEndCount() + 1;

			list = list.subList(page.getStartCount(), lastCount);

			request.setAttribute("list", list);
			request.setAttribute("pagingHtml", pagingHtml);
			request.setAttribute("currentPage", currentPage);

			return "/view/user/buyer/cartBoard.jsp";
		}
}