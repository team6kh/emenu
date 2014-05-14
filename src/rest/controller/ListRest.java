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
import restopt.dto.RestOptDTO;
import review.dto.ReviewDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import common.Constants;
import common.PagingAction;


@Controller
public class ListRest {
	//필요인스턴스변수
	private List<RestDTO> list = new ArrayList<RestDTO>();
	private List<RestOptDTO> list1 = new ArrayList<RestOptDTO>();
	private RestDTO paramClass = new RestDTO();
	private RestDTO resultClass = new RestDTO();
	private int permission; // 판매자가 글 작성여부 판단
	private int rest_num; // 글 읽기시 필요 변수
	
	//후기관련
	private List<ReviewDTO> reviewRes = new ArrayList<ReviewDTO>();
	//private String reviewFile_Path = Constants.COMMON_FILE_PATH+ Constants.REVIEW_FILE_PATH;
	
	//페이지관련
	private int totalCount;// 총 게시물의 수
	private int blockCount;// 한 페이지의 게시물의 수
	private int blockPage;// 한 화면에 보여줄 페이지 수
	private String pagingHtml;// 페이징을 구현한 HTML
	private PagingAction page;// 페이징 클래스
	private String actionName;// 페이징액션과 로그인액션에서 쓰인다
	private int currentPage; //상품 현재페이지
	private int ccp;//리뷰 현재페이지
	
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
	public String listRest(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		String rest_localcategory = request.getParameter("rest_localcategory");
		String rest_typecategory = request.getParameter("rest_typecategory");
		
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
		
		//페이지관련
		blockCount = 12;// 한 페이지의 게시물의 수
		blockPage = 5;// 한 화면에 보여줄 페이지 수
		actionName = "listRest";// 페이징액션과 로그인액션에서 쓰인다
		totalCount = list.size(); // 전체 글 갯수
		//currentPage 초기화
		if(null == request.getParameter("currentPage")){
			currentPage = 1;
		}else{
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		page = new PagingAction(actionName, currentPage, totalCount, blockCount, blockPage, rest_localcategory, rest_typecategory); // pagingAction 객체 생성.
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
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("permission", permission);
		request.setAttribute("list", list);
		
		return "/view/rest/listRest.jsp";
	}
	
	
	
	
	//readRest.do
	@RequestMapping("/readRest.do")
	public String readRest(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		rest_num = Integer.parseInt(request.getParameter("rest_num"));
		if(null == request.getParameter("currentPage")){
			currentPage = 1;
		}else{
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		//글 조회수 +1
		paramClass.setRest_num(rest_num);
		sqlMapper.update("Rest.updateRest_readcount", paramClass);
		
		//해당글번호의 레코드를 가져옴(상품테이블, 옵션테이블)
		resultClass = (RestDTO)sqlMapper.queryForObject("Rest.selectRestOne", rest_num);
		
		//옵션 get
		list1 = (List<RestOptDTO>) sqlMapper.queryForList("Rest.selectRestoptOne", rest_num);
		
		//후기리스트
        reviewRes = sqlMapper.queryForList("Review.selectReviewList", rest_num);
       // reviewFile_Path = reviewFile_Path.replace("\\", "/").substring(27); //파일경로 재정의
        
        // 페이징 관련 코드
        ccp = 1; // 현재 페이지
        blockCount = 5; // 한 페이지의 게시물의 수
        blockPage = 5; // 한 화면에 보여줄 페이지 수
        actionName = "readRest"; // 페이징액션과 로그인액션에서 쓰인다...
        totalCount = reviewRes.size();
        page = new PagingAction(actionName, ccp, totalCount, blockCount, blockPage, rest_num, currentPage);
        pagingHtml = page.getPagingHtml().toString();
        
        // 현재 페이지에서 보여줄 마지막 글의 번호 설정
        int lastCount = totalCount;

        // 현재 페이지의 마지막 글의 번호가 전체의 마지막 글 번호보다 작으면 lastCount를 +1 번호로 설정.
        if (page.getEndCount() < totalCount)
            lastCount = page.getEndCount() + 1;

        // 전체 리스트에서 현재 페이지만큼의 리스트만 가져온다.
        reviewRes = reviewRes.subList(page.getStartCount(), lastCount);
				
        request.setAttribute("resultClass", resultClass); //상품
        request.setAttribute("list1", list1); // 옵션
        request.setAttribute("reviewRes", reviewRes); // 리뷰
        
        request.setAttribute("rest_num", rest_num);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("pagingHtml", pagingHtml);
        
		return "/view/rest/readRest.jsp";
	}
}
