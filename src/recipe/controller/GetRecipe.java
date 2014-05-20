package recipe.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.Reader;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import recipe.dto.RecipeCommandDTO;
import recipe.dto.RecipeDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

@Controller
public class GetRecipe {
	
	SqlMapClientTemplate ibatis = null;
	public static Reader reader;
	public static SqlMapClient sqlMapper;
	
	private int isrecommand = 1;
/*	private RecipeDTO paramClass = new RecipeDTO(); // 파라미터를 저장할 객체
	private RecipeDTO resultClass = new RecipeDTO(); // 쿼리 결과 값을 저장할 객체
	private RecipeCommandDTO paramRC = new RecipeCommandDTO();
	private RecipeCommandDTO resultRC = new RecipeCommandDTO();
*/	
	private int currentPage;
	private int recipe_num;
	private String recipe_password;
	private InputStream inputStream;
	private String contentDisposition;
	private long contentLength;
	// 추가한것.
	

	
	//DB커넥트 생성자 버전
	public GetRecipe() throws IOException{
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}
	//.DB커넥트 생성자 버전 끝
	
	//checkRecipePwForm.do
		@RequestMapping("/checkRecipePwForm.do")
		public String checkRecipePwForm(HttpServletRequest request){
			
			request.setAttribute("recipe_num", recipe_num);
			request.setAttribute("currentPage", currentPage);
			return "/view/recipe/checkPassword.jsp";
		}
		
	//checkRecipePwAction.do
		@RequestMapping(value="/checkRecipePwAction.do")
		public String checkRecipePwAction(HttpServletRequest request, @ModelAttribute("RecipeDTO") RecipeDTO paramClass) throws Exception{
												//파라미터 request		 //파라미터 DTO로 자동 set(), get()
			recipe_num = paramClass.getRecipe_num();
			recipe_password = paramClass.getRecipe_password();
			int currentPage = Integer.parseInt(request.getParameter("currentPage"));
			
			
			// 비밀번호 입력값 파라미터 설정.
			paramClass.setRecipe_num(recipe_num);
			paramClass.setRecipe_password(recipe_password);
			RecipeDTO resultClass = new RecipeDTO();
			// 현재 글의 비밀번호 가져오기.
			resultClass = (RecipeDTO) sqlMapper.queryForObject("Recipe.selectRecipe_password", paramClass);

			
			request.setAttribute("recipe_num", recipe_num);
			request.setAttribute("currentPage", currentPage);
				
			// 입력한 비밀번호가 틀리면 ERROR 리턴.
			if (resultClass == null){
			
				return "/view/recipe/checkError.jsp";
			}else{
			
			return "/view/recipe/checkSuccess.jsp";
			}
		}
	
		//recommendRecipe.do
				@RequestMapping(value="/recommendRecipe.do")
				public String recommendRecipe(HttpServletRequest request, HttpSession session, @ModelAttribute("RecipeDTO") RecipeDTO paramClass) throws Exception{
														//파라미터 request		//세션용					//파라미터 DTO로 자동 set(), get()
					
					RecipeDTO resultClass = new RecipeDTO();
					RecipeCommandDTO paramRC = new RecipeCommandDTO();
					RecipeCommandDTO resultRC = new RecipeCommandDTO();
					String session_id = (String) session.getAttribute("session_id");
					// 해당글에 추천 유무 확인
					
					recipe_num = paramClass.getRecipe_num();
					
					paramClass.setRecipe_num(recipe_num);
					paramRC.setRecipeCommand_num(recipe_num);
					paramRC.setRecipeCommand_writer(session_id);
                    
					resultRC = (RecipeCommandDTO) sqlMapper.queryForObject("Recipe.selectCommandId", paramRC);
					
					if (resultRC == null) {
						
						// 해당 글의 추천수 +1.
						sqlMapper.insert("Recipe.insertRecipeCommand", paramRC);
						sqlMapper.update("Recipe.updateRecommand", paramClass);

						// 해당 번호의 글을 가져온다.
						resultClass = (RecipeDTO) sqlMapper.queryForObject("Recipe.selectOne", recipe_num);
						isrecommand = 0;
					} else {
						isrecommand = 1;
					}
					
					request.setAttribute("isrecommand", isrecommand);
					request.setAttribute("resultClass", resultClass);

					return "/view/recipe/isRecommend.jsp";
				
				}
	//readRecipe.do
		@RequestMapping(value="/readRecipe.do")
		public String readRecipe(HttpServletRequest request, HttpSession session, @ModelAttribute("RecipeDTO") RecipeDTO paramClass) throws Exception{
										//파라미터 request		//세션용					//파라미터 DTO로 자동 set(), get()
			String session_id = (String) session.getAttribute("session_id");
			RecipeDTO resultClass = new RecipeDTO();
			RecipeCommandDTO paramRC = new RecipeCommandDTO();
			RecipeCommandDTO resultRC = new RecipeCommandDTO();
			
			
			recipe_num = paramClass.getRecipe_num();
						
			if(request.getParameter("currentPage")== ""){
				currentPage=1;
			}else{
				currentPage=Integer.parseInt(request.getParameter("currentPage"));
			}

			
			
			paramClass.setRecipe_num(recipe_num);
			paramRC.setRecipeCommand_num(recipe_num);
			paramRC.setRecipeReadCount_writer(session_id);
			
	        
			resultRC = (RecipeCommandDTO) sqlMapper.queryForObject("Recipe.selectReadcountId", paramRC);
			
			

			if (!(session_id == null) && resultRC == null) {
				// 해당 글의 조회수 +1.
				sqlMapper.insert("Recipe.insertRecipeReadCount", paramRC);
				sqlMapper.update("Recipe.updateReadcount", paramClass);

			} else {

			}

			// 해당 번호의 글을 가져온다.
			resultClass = (RecipeDTO) sqlMapper.queryForObject("Recipe.selectOne", recipe_num);

			StringBuffer pagingHtml = new StringBuffer();
			pagingHtml.append(resultClass.getRecipe_content());
			request.setAttribute("resultClass", resultClass);
			request.setAttribute("pagingHtml", pagingHtml);
			request.setAttribute("currentPage", currentPage);
			
			return "/view/recipe/readRecipe.jsp";
			


		}
}
