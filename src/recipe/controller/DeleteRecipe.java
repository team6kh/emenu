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
public class DeleteRecipe {
	
	SqlMapClientTemplate ibatis = null;
	public static Reader reader;
	public static SqlMapClient sqlMapper;
	
	private recipe.dto.RecipeDTO paramClass = new recipe.dto.RecipeDTO(); // 파라미터를 저장할 객체
	private recipe.dto.RecipeDTO resultClass = new recipe.dto.RecipeDTO(); // 쿼리 결과 값을 저장할 객체

	private int currentPage; // 현재 페이지
	private int recipe_num;
	
	//DB커넥트 생성자 버전
	public DeleteRecipe() throws IOException{
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}
	//.DB커넥트 생성자 버전 끝
	
	//deleteRecipe.do
		@RequestMapping(value="/deleteRecipe.do")
		public String deleteRecipe(HttpServletRequest request, HttpServletResponse response, HttpSession session, @ModelAttribute("RecipeDTO") RecipeDTO dto) throws Exception{
									//파라미터 request				//파라미터 response			 //세션용							//파라미터 DTO로 자동 set(), get()
			
			int Recipe_num = Integer.parseInt(request.getParameter("recipe_num"));
			// 해당 번호의 글을 가져온다.
			resultClass = (RecipeDTO) sqlMapper.queryForObject("Recipe.selectOne", Recipe_num);

			// 삭제할 항목 설정.
			paramClass.setRecipe_num(Recipe_num);

			// 삭제 쿼리 수행.
			sqlMapper.update("Recipe.deleteRecipe", paramClass);
			return "listRecipe.do";
			
			
		}
}
