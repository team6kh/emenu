package recipe.controller;

import java.io.IOException;
import java.io.Reader;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import recipe.dto.RecipeDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import common.PagingAction;

@Controller
public class ListRecipe {
	
	SqlMapClientTemplate ibatis = null;
	public static Reader reader;
	public static SqlMapClient sqlMapper;
	
	private List<recipe.dto.RecipeDTO> list = new ArrayList<recipe.dto.RecipeDTO>();
	private recipe.dto.RecipeDTO paramClass = new recipe.dto.RecipeDTO();
	
	private int currentPage = 1; //현재 페이지
	private int totalCount;      //총 게시물의 수
	private int blockCount = 10; //한 페이지의 게시물의 수
	private int blockPage = 5; //한 화면에 보여줄 페이지
	private String pagingHtml; //페이지를 구현할 HTML
	private common.PagingAction page;  //페이징 클래스
	
	private String actionName = "listRecipe" ; //페이지 액션과 로그인 액션에서 쓰인다.
	private String myactionName = "myListRecipe";
	private String session_id;

	
	//DB커넥트 생성자 버전
	public ListRecipe() throws IOException{
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}
	//.DB커넥트 생성자 버전 끝
	
	//listRecipe.do
		@RequestMapping(value="/listRecipe.do")
		public String listRecipe(HttpServletRequest request, HttpServletResponse response1, HttpSession session, @ModelAttribute("RecipeDTO") RecipeDTO dto) throws Exception{
								//파라미터 request1				//파라미터 response1			 //세션용				//파라미터 DTO로 자동 set(), get()

			list = sqlMapper.queryForList("Recipe.selectAll");
			totalCount = list.size(); //전체 글 갯수를 구한다.
			page = new PagingAction(actionName, currentPage, totalCount, blockCount, blockPage); //PagingAction 객체 생성
			pagingHtml = page.getPagingHtml().toString();  //페이지 HTML 생성.
			
			
			// 현재 페이지에서 보여줄 마지막 글의 번호 설정.
					int lastCount = totalCount;

					// 현재 페이지의 마지막 글의 번호가 전체의 마지막 글 번호보다 작으면 lastCount를 +1 번호로 설정.
					if (page.getEndCount() < totalCount)
						lastCount = page.getEndCount() + 1;

					// 전체 리스트에서 현재 페이지만큼의 리스트만 가져온다.
					list = list.subList(page.getStartCount(), lastCount);
					request.setAttribute("list", list);
	                return "/view/recipe/listRecipe.jsp";
	
		}
		
		//myListRecipe.do
				@RequestMapping(value="/myListRecipe.do")
				public String myListRecipe(HttpServletRequest request, HttpServletResponse response1, HttpSession session, @ModelAttribute("RecipeDTO") RecipeDTO dto) throws Exception{
										//파라미터 request1				//파라미터 response1			 //세션용				//파라미터 DTO로 자동 set(), get()
					String session_id = request.getParameter("session_id");
					list = sqlMapper.queryForList("Recipe.myListRecipe", session_id);

					totalCount = list.size(); // 전체 글 갯수를 구한다.
					page = new PagingAction(myactionName, currentPage, totalCount, blockCount, blockPage, session_id); // PagingAction 객체 생성
					pagingHtml = page.getPagingHtml().toString(); // 페이지 HTML 생성.

					// 현재 페이지에서 보여줄 마지막 글의 번호 설정.
					int lastCount = totalCount;

					// 현재 페이지의 마지막 글의 번호가 전체의 마지막 글 번호보다 작으면 lastCount를 +1 번호로 설정.
					if (page.getEndCount() < totalCount)
						lastCount = page.getEndCount() + 1;

					// 전체 리스트에서 현재 페이지만큼의 리스트만 가져온다.
					list = list.subList(page.getStartCount(), lastCount);
					
					request.setAttribute("list", list);

					return "/view/user/listMyRecipe.jsp";

				
				
				}
}
