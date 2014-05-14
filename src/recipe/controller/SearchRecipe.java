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
import recipe.dto.RecipeSearchDTO;



import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import common.PagingAction;

@Controller
public class SearchRecipe {
	recipe.dto.RecipeSearchDTO paramClass;
	SqlMapClientTemplate ibatis = null;
	public static Reader reader;
	public static SqlMapClient sqlMapper;
	private List<recipe.dto.RecipeDTO> list = new ArrayList<recipe.dto.RecipeDTO>();
    private int currentPage = 1; //현재 페이지
    private int totalCount;      //총 게시물의 수
    private int blockCount = 10; //한 페이지의 게시물의 수
    private int blockPage = 5; //한 화면에 보여줄 페이지
    private String pagingHtml; //페이지를 구현할 HTML
    private common.PagingAction page;  //페이징 클래스
    
    private String actionName = "searchRecipe" ; //페이지 액션과 로그인 액션에서 쓰인다.
    private String myListactionName = "listMyRecipe" ;
    private String session_id;

	
	//DB커넥트 생성자 버전
	public SearchRecipe() throws IOException{
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}
	//.DB커넥트 생성자 버전 끝
	
	//searchRecipe.do
		@RequestMapping(value="/searchRecipe.do",method=RequestMethod.POST)
		public String searchRecipe(HttpServletRequest request, HttpServletResponse response, HttpSession session, @ModelAttribute("RecipeSearchDTO") recipe.dto.RecipeSearchDTO dto) throws Exception{
							//파라미터 request1				//파라미터 response1			 //세션용				//파라미터 DTO로 자동 set(), get()
			
			if(paramClass.getRecipe_priceinput1()==0 && paramClass.getRecipe_priceinput2()==0 && paramClass.getRecipe_timeinput1()==0 && paramClass.getRecipe_timeinput2()==0){
	        	list = sqlMapper.queryForList("Recipe.detailSearchRecipeEmpty", paramClass);
	        }else if(paramClass.getRecipe_timeinput1()==0 && paramClass.getRecipe_timeinput2()==0){
	        	list = sqlMapper.queryForList("Recipe.detailSearchRecipePrice", paramClass);
	        }else if(paramClass.getRecipe_priceinput1()==0 && paramClass.getRecipe_priceinput2()==0){
	        	list = sqlMapper.queryForList("Recipe.detailSearchRecipeTime", paramClass);
	        }else{//모두 기입했을때
	        	list = sqlMapper.queryForList("Recipe.detailSearchRecipeAll", paramClass);
	        }
	        
	        totalCount = list.size(); //전체 글 갯수를 구한다.
	        page = new common.PagingAction(actionName, currentPage, totalCount, blockCount, blockPage); //PagingAction 객체 생성
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
		
		//myrecipe_search.do
		@RequestMapping(value="/myrecipe_search.do",method=RequestMethod.POST)
		public String myrecipe_search(HttpServletRequest request, HttpServletResponse response, HttpSession session, @ModelAttribute("RecipeSearchDTO") recipe.dto.RecipeSearchDTO dto) throws Exception{
										//파라미터 request1				//파라미터 response1			 //세션용				//파라미터 DTO로 자동 set(), get()
			
			if(paramClass.getRecipe_priceinput1()==0 && paramClass.getRecipe_priceinput2()==0 && paramClass.getRecipe_timeinput1()==0 && paramClass.getRecipe_timeinput2()==0){
	         	list = sqlMapper.queryForList("Recipe.detailSearchRecipeEmpty", paramClass);
	         }else if(paramClass.getRecipe_timeinput1()==0 && paramClass.getRecipe_timeinput2()==0){
	         	list = sqlMapper.queryForList("Recipe.detailSearchRecipePrice", paramClass);
	         }else if(paramClass.getRecipe_priceinput1()==0 && paramClass.getRecipe_priceinput2()==0){
	         	list = sqlMapper.queryForList("Recipe.detailSearchRecipeTime", paramClass);
	         }else{//모두 기입했을때
	         	list = sqlMapper.queryForList("Recipe.detailSearchRecipeAll", paramClass);
	         }
	         
	         totalCount = list.size(); //전체 글 갯수를 구한다.
	         page = new PagingAction(myListactionName, currentPage, totalCount, blockCount, blockPage, session_id); //PagingAction 객체 생성
	         pagingHtml = page.getPagingHtml().toString();  //페이지 HTML 생성.
	         
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
