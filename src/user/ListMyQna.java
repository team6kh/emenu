package user;

import java.io.Reader;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import qna.dto.QnaDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import common.PagingAction;


@Controller
public class ListMyQna {
	public static Reader reader;
	public static SqlMapClient sqlMapper;
	
	private List<QnaDTO> list = new ArrayList<QnaDTO>();	
	
	private int currentPage = 1; // 현재 페이지
	private int totalCount; // 총 게시물의 수
	private int blockCount = 10; // 한 페이지의 게시물의 수
	private int blockPage = 5; // 한 화면에 보여줄 페이지 수
	private int topCount = 0;
	private String pagingHtml; // 페이징을 구현한 HTML
	private PagingAction page; // 페이징 클래
	private String actionName = "listMyQna"; // 페이징액션과 로그인액션에서 쓰인다...
	
	
	
	
	public ListMyQna() throws Exception{
	reader = Resources.getResourceAsReader("sqlMapConfig.xml");
	sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
	reader.close();
	}
	
	@RequestMapping("/user/listMyQna.do")
	public String listMyQna(HttpServletRequest request) throws Exception{
		
		String qna_id = request.getParameter("session_id");
		
		list = sqlMapper.queryForList("Qna.selectMyQnaList", qna_id);
		
		
					
		if(request.getParameter("currentPage") == null)
		{
			currentPage = 1;
		}
		else
		{
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		totalCount = list.size(); // 전체 글 갯수를 구한다.
		page = new PagingAction(actionName, currentPage, totalCount,blockCount, blockPage); // pagingAction 객체 생성.
		pagingHtml = page.getPagingHtml().toString(); // 페이지 HTML 생성.
		
		

		// 현재 페이지에서 보여줄 마지막 글의 번호 설정.
		int lastCount = totalCount;

		// 현재 페이지의 마지막 글의 번호가 전체의 마지막 글 번호보다 작으면 lastCount를 +1 번호로 설정.
		if (page.getEndCount() < totalCount)
			lastCount = page.getEndCount() + 1;

		// 전체 리스트에서 현재 페이지만큼의 리스트만 가져온다.
		list = list.subList(page.getStartCount(), lastCount);
		

		/*
		 * for(int i=0;i<list.size();i++){ QnaDTO a = list.get(i);
		 * System.out.println("index = " + a.toString()); }
		 */

		// sqlMapper.update("Qna.updateReadCount", getQna_num());
		// resultClass = (QnaDTO)sqlMapper.queryForObject("Qna.qnaDetail",
		// getQna_num());	
		request.setAttribute("list", list);
		request.setAttribute("pagingHtml", pagingHtml);	
		
		return "/view/user/listMyQna.jsp";
	}

}
