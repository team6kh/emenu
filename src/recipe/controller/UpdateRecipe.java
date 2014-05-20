package recipe.controller;

import java.io.IOException;
import java.io.Reader;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;




import recipe.dto.RecipeDTO;




import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

@Controller
public class UpdateRecipe {
	
	SqlMapClientTemplate ibatis = null;
	public static Reader reader;
	public static SqlMapClient sqlMapper;
	
	private recipe.dto.RecipeDTO paramClass; // 파라미터를 저장할 객체
	private recipe.dto.RecipeDTO resultClass = new recipe.dto.RecipeDTO(); // 쿼리 결과 값을 저장할 객체

	private int currentPage; // 현재 페이지

	private int recipe_num;

	//DB커넥트 생성자 버전
	public UpdateRecipe() throws IOException{
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}
	//.DB커넥트 생성자 버전 끝
	
	//updateRecipeForm.do
			@RequestMapping("/updateRecipeForm.do")
			public String updateRecipeForm(HttpServletRequest request, @ModelAttribute("RecipeDTO") RecipeDTO paramClass) throws Exception{
										//파라미터 request				//파라미터 DTO로 자동 set(), get()
				
				resultClass = (RecipeDTO) sqlMapper.queryForObject("Recipe.selectOne", paramClass.getRecipe_num());
				StringBuffer pagingHtml = new StringBuffer();
				pagingHtml.append(resultClass.getRecipe_content());
				request.setAttribute("resultClass", resultClass);
				request.setAttribute("pagingHtml", pagingHtml);
				request.setAttribute("currentPage", request.getParameter("currentPage"));
				return "insertRecipeForm.do";

			
			}
	//updateRecipe.do
		@RequestMapping(value="/updateRecipe.do",method=RequestMethod.POST)
		public String updateRecipe(HttpServletRequest request,  @ModelAttribute("RecipeDTO") RecipeDTO paramClass) throws Exception{
									//파라미터 request				//파라미터 DTO로 자동 set(), get()
			
			// 일단 항목만 수정한다.
			sqlMapper.update("Recipe.updateRecipe", paramClass);

			// 수정이 끝나면 view 페이지로 이동.
			resultClass = (RecipeDTO) sqlMapper.queryForObject("Recipe.selectOne", paramClass.getRecipe_num());
			System.out.println("update 컨트롤러에서 페이지 : " + request.getParameter("currentPage"));
			request.setAttribute("currentPage", request.getParameter("currentPage"));
			request.setAttribute("resultClass", resultClass);
			return "/readRecipe.do";


	
		}
}
