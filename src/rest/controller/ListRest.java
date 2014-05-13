package rest.controller;

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


@Controller
public class ListRest {
	//필요인스턴스변수
	private List<RestDTO> list = new ArrayList<RestDTO>();
	private RestDTO paramClass = new RestDTO();
	int permission; // 판매자가 글 작성여부 판단
	
	//페이지관련
	private int totalCount;// 총 게시물의 수
	private int blockCount = 12;// 한 페이지의 게시물의 수
	private int blockPage = 5;// 한 화면에 보여줄 페이지 수
	private String pagingHtml;// 페이징을 구현한 HTML
	private PagingAction page;// 페이징 클래스
	private String actionName = "listRest";// 페이징액션과 로그인액션에서 쓰인다
	int currentPage;
	
	//iBatis관련
	SqlMapClientTemplate ibatis = null;
	public static Reader reader;
	public static SqlMapClient sqlMapper;
	
	//생성자(연결)
	public ListRest() throws IOException{
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}
	
	
	//listRest.do
	@RequestMapping("/listRest.do")
	public String formPro(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{

		String rest_localcategory = request.getParameter("rest_localcategory");
		String rest_typecategory = request.getParameter("rest_typecategory");
		
		if(null == request.getParameter("currentPage")){
			currentPage = 1;
		}else{
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		
		//카테고리별 분기
		if(rest_localcategory==null&&rest_typecategory==null){
			list = sqlMapper.queryForList("Rest.selectAll");
		}else if(rest_localcategory.equals("1")&&rest_typecategory.equals("1")){//지역카테고리 전체글
			list = sqlMapper.queryForList("Rest.selectLocalAll");
		}else if(rest_localcategory.equals("2")&&rest_typecategory.equals("2")){//종류카테고리 전체글
			list = sqlMapper.queryForList("Rest.selectTypeAll");
		}else if(rest_typecategory.equals("0")){//지역카테고리에 속하면
			paramClass.setRest_localcategory(rest_localcategory);
			list = sqlMapper.queryForList("Rest.selectLocal", paramClass);
		}else  if(rest_localcategory.equals("0")){//종류카테고리에 속하면
			paramClass.setRest_typecategory(rest_typecategory);
			list = sqlMapper.queryForList("Rest.selectType", paramClass);
		}
		
		totalCount = list.size(); // 전체 글 갯수
		page = new PagingAction(actionName, currentPage, totalCount, blockCount, blockPage); // pagingAction 객체 생성.
		pagingHtml = page.getPagingHtml().toString(); // 페이지 HTML 생성.

		int lastCount = totalCount;
		// 현재 페이지의 마지막 글의 번호가 전체의 마지막 글 번호보다 작으면 lastCount를 +1 번호로 설정.
		if (page.getEndCount() < totalCount)
			lastCount = page.getEndCount() + 1;
		// 전체 리스트에서 현재 페이지만큼의 리스트만 가져온다.
		list = list.subList(page.getStartCount(), lastCount);
		
		//카운트
		String session_id = (String) session.getAttribute("session_id");
		Integer count = (Integer) sqlMapper.queryForObject("Rest.selectCountForSeller", session_id);
		
		//count값으로 셀러가 글을 썻는지 안썻는지 판단함. (즉 0이면 글을 쓸수 있어야 함. )
		if(count == 0){
			permission = 0;
		}else{ //글을 썻을때
			permission = 1;
		}
		
		request.setAttribute("pagingHtml", pagingHtml);
		request.setAttribute("permission", permission);
		request.setAttribute("list", list);
		
		return "/view/rest/listRest.jsp";
	}
}
