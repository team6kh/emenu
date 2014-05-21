package user.controller;

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

import recipe.dto.RecipeDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import common.PagingAction;

@Controller
public class ListMyRecipe {
	//내글관련
	private List<RecipeDTO> list = new ArrayList<RecipeDTO>();
	private recipe.dto.RecipeDTO paramClass = new recipe.dto.RecipeDTO();
	private int totalCount;
	private String pagingHtml; 
	private PagingAction page; 
	private String session_id;
	
	//iBatis관련
	SqlMapClientTemplate ibatis = null;
	public static Reader reader;
	public static SqlMapClient sqlMapper;
	
	//생성자(연결)
	public ListMyRecipe() throws IOException{
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}
	
	
	///user/listMyRecipe.do
	@RequestMapping("/user/listMyRecipe.do")
	public String formPro(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		session_id = (String) session.getAttribute("session_id");
		
		list = sqlMapper.queryForList("Recipe.selectMyRecipe",session_id );
		totalCount = list.size(); // recipe 전체 글 갯수를 구한다.
		
		int currentPage = 1; 
		int blockCount = 10; 
		int blockPage = 5;
		String actionName = "listMyRecipe";
		if(request.getParameter("currentPage")==null){
			currentPage=1;
		}else{
			currentPage=Integer.parseInt(request.getParameter("currentPage"));
		}
		page = new PagingAction(actionName, currentPage, totalCount, blockCount, blockPage, session_id); // PagingAction 객체 생성
		pagingHtml = page.getPagingHtml().toString(); // 페이지 HTML 생성.
		
		//이미지 추가
		String[] imgPath = new String[list.size()];

		for(int i = 0; i<list.size(); i++){
			String content = list.get(i).getRecipe_content();
			int isInclude =content.indexOf("src=");

			if(isInclude>-1){
				int temp1 = content.indexOf("src=");
				int temp2 = content.indexOf("\">");
				int start = temp1+5;
				int end = temp2;

				imgPath[i] = content.substring(start, end);
				//update
				paramClass.setRecipe_num(list.get(i).getRecipe_num());
				paramClass.setRecipe_file(imgPath[i]);
				sqlMapper.update("Recipe.updateFile", paramClass);
			}else{
				imgPath[i] = "no Image in content";
				//update
				paramClass.setRecipe_num(list.get(i).getRecipe_num());
				paramClass.setRecipe_file(imgPath[i]);
				sqlMapper.update("Recipe.updateFile", paramClass);
			}
		}
		//


		// 현재 페이지에서 보여줄 마지막 글의 번호 설정.
		int lastCount = totalCount;

		// 현재 페이지의 마지막 글의 번호가 전체의 마지막 글 번호보다 작으면 lastCount를 +1 번호로 설정.
		if (page.getEndCount() < totalCount)
			lastCount = page.getEndCount() + 1;

		// 전체 리스트에서 현재 페이지만큼의 리스트만 가져온다.
		list = list.subList(page.getStartCount(), lastCount);

		request.setAttribute("list", list);
		request.setAttribute("pagingHtml", pagingHtml);
		request.setAttribute("currentPage", currentPage);

		return "/view/user/listMyRecipe.jsp";
	}
}
