package qna.controller;

import java.io.Reader;
import java.util.ArrayList;
import java.util.HashMap;
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
public class ListQna {
	
	public static SqlMapClient sqlMapper;

	private QnaDTO paramClass = new QnaDTO();

	private QnaDTO resultClass = new QnaDTO();

	private int qna_num;

	private String qna_category;
	private String searchText;
	private String qna_checkreply;

	private List<QnaDTO> list = new ArrayList<QnaDTO>();
	private List<QnaDTO> topList = new ArrayList<QnaDTO>();
	
	private int currentPage = 1; // 현재 페이지
	private int totalCount; // 총 게시물의 수
	private int blockCount = 10; // 한 페이지의 게시물의 수
	private int blockPage = 5; // 한 화면에 보여줄 페이지 수
	private int topCount = 0;
	private String pagingHtml; // 페이징을 구현한 HTML
	private PagingAction page; // 페이징 클래
	private String actionName = "listQna"; // 페이징액션과 로그인액션에서 쓰인다...
	
	
	public static Reader reader;
	
	public ListQna() throws Exception{
	reader = Resources.getResourceAsReader("sqlMapConfig.xml");
	sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
	reader.close();
	}
	
	@RequestMapping("/listQna.do")
	public String listQna(HttpServletRequest request) throws Exception{
		QnaDTO qnaDTO = new QnaDTO();

		topList = sqlMapper.queryForList("Qna.listTopQna");		

		topCount = topList.size();		
		
		HashMap<String, String> param = new HashMap<String, String>();

			param.put("qna_category", request.getParameter("qna_category"));			
			param.put("qna_checkreply",request.getParameter("qna_checkreply"));
			param.put("searchText", request.getParameter("searchText"));

			list = sqlMapper.queryForList("Qna.listQna", param);
			
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
		searchText = "";
		request.setAttribute("searchText", searchText);
		request.setAttribute("topList", topList);
		request.setAttribute("pagingHtml", pagingHtml);
		request.setAttribute("list", list);
		request.setAttribute("topCount", topCount);
		return "/view/qna/listQna.jsp";
	}
	
	@RequestMapping("/detail.do")
	public String detail(HttpServletRequest request) throws Exception{
		// 조회수 증가
				sqlMapper.update("Qna.updateReadCount", Integer.parseInt(request.getParameter("qna_num")));

				
				// 상세보기 조회
				resultClass = (QnaDTO) sqlMapper.queryForObject("Qna.qnaDetail",Integer.parseInt(request.getParameter("qna_num")));
				// resultClass.setQna_content(resultClass.getQna_content().replaceAll("\n",
				// "<br/>"));
				request.setAttribute("resultClass", resultClass);
		return "/view/qna/listQna.jsp";
	}
		
	
}
