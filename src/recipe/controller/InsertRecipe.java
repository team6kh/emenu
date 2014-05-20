package recipe.controller;

import java.io.IOException;
import java.io.Reader;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
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
public class InsertRecipe {
	
	SqlMapClientTemplate ibatis = null;
	public static Reader reader;
	public static SqlMapClient sqlMapper;
	private RecipeDTO resultClass;
	
	private int currentPage; // 현재 페이지
	private int recipe_num; // 현재 글 고유 번호

	Calendar today = Calendar.getInstance(); // 오늘 날짜 구하기.

	//DB커넥트 생성자 버전
	public InsertRecipe() throws IOException{
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}
	//.DB커넥트 생성자 버전 끝
	
	//insertRecipeForm.do
		@RequestMapping("/insertRecipeForm.do")
		public String insertRecipeForm(HttpServletRequest request, HttpSession session){
			return "/view/recipe/insertRecipe.jsp";
		}
	
	//insertRecipe.do
		@RequestMapping(value="/insertRecipe.do")
		public String insertRecipe(HttpServletRequest request, HttpSession session, @ModelAttribute("RecipeDTO") RecipeDTO paramClass) throws Exception{
									//파라미터 request				//세션용				//파라미터 DTO로 자동 set(), get()
			
			paramClass.setRecipe_reg_date(today.getTime());

			// 등록 쿼리 수행.
			sqlMapper.insert("Recipe.insertRecipe", paramClass);
			
			return "listRecipe.do";


		}

}
