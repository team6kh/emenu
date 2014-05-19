package user.buyer.controller;

import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import paid.dto.PaidDTO;
import paid.dto.SearchConditionDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import common.PagingAction;

@Controller
public class DashBuyer {
	
	private List<PaidDTO> list = new ArrayList<PaidDTO>();
	
	private int blockCount = 10; // 한 페이지의 게시물의 수
	private int blockPage = 5; // 한 화면에 보여줄 페이지
	private String pagingHtml; // 페이지를 구현할 HTML
	private PagingAction page; // 페이징 클래스
	private String actionName = "dashboard";
	
	private int currentPage = 1; // 현재 페이지
	private int totalCount; // 총 게시물의 수
	
	private Reader reader;
	private SqlMapClient sqlMapper;
	
	public DashBuyer() throws IOException {
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}
	
	@RequestMapping("/user/buyer/dashboard.do")
	public String dashBuyer(HttpServletRequest request, HttpSession session) throws SQLException {
		
		String session_id = (String) session.getAttribute("session_id");
		
		list = sqlMapper.queryForList("Paid.selectMyCpn", session_id);
		totalCount = list.size(); // 전체 글 갯수를 구한다.
		// currentPage 설정
		if (request.getParameter("currentPage") == null){
			currentPage = 1;
		} else {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		page = new PagingAction(actionName, currentPage, totalCount, blockCount, blockPage, session_id); // PagingAction 객체 생성
		pagingHtml = page.getPagingHtml().toString(); // 페이지 HTML 생성.

		// 현재 페이지에서 보여줄 마지막 글의 번호 설정.
		int lastCount = totalCount;
		// 현재 페이지의 마지막 글의 번호가 전체의 마지막 글 번호보다 작으면 lastCount를 +1 번호로 설정.
		if (page.getEndCount() < totalCount)
			lastCount = page.getEndCount() + 1;

		// 전체 리스트에서 현재 페이지만큼의 리스트만 가져온다.
		list = list.subList(page.getStartCount(), lastCount);
		
		request.setAttribute("list", list);
		request.setAttribute("pagingHtml", pagingHtml);
		
		return "/view/user/buyer/dashBuyer.jsp";		
	}
	
	
	@RequestMapping("/user/buyer/searchMyCpn.do")
	public String searchMyCpn(HttpServletRequest request, HttpSession session, @ModelAttribute SearchConditionDTO searchDTO) throws SQLException, ParseException {
			
		String session_id = (String) session.getAttribute("session_id");		
		String startDate = (String) request.getParameter("startDate");
		String endDate = (String) request.getParameter("endDate");
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		searchDTO.setSession_id(session_id);
		searchDTO.setStartDate(sdf.format(sdf.parse(startDate)));
		searchDTO.setEndDate(sdf.format(sdf.parse(endDate)));	
		
		list = sqlMapper.queryForList("Paid.selectMyDate", searchDTO);
		
		request.setAttribute("list", list);
		
		return "/view/user/buyer/dashBuyer.jsp";	
	}
	
	
	@RequestMapping("/user/buyer/requestCpn")
	public String requestCpn(HttpServletRequest request) throws SQLException {
		
		int paid_num = Integer.parseInt(request.getParameter("paid_num"));				
		
		sqlMapper.update("Paid.updateRequestCpn", paid_num);
		
		return "/user/buyer/dashboard.do";
	}
	
}
