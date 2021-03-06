package claim.controller;

import java.io.Reader;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import claim.dto.ClaimDTO;
import claim.dto.SearchClaimDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import common.PagingAction;

@Controller
public class ListClaim
{
    // ibatis 연동을 위한 변수
    private static Reader reader;
    
    private static SqlMapClient sqlMapper;
    
    // 신고내역 리스트를 받기 위한 변수
    List<ClaimDTO> claimRes = new ArrayList<ClaimDTO>();
    
    // 페이징을 위한 변수
    private int currentPage = 1; // 현재 페이지
    
    private int totalCount; // 총 게시물의 수
    
    private int blockCount = 10; // 한 페이지의 게시물의 수
    
    private int blockPage = 5; // 한 화면에 보여줄 페이지
    
    private String pagingHtml; // 페이지를 구현할 HTML
    
    private PagingAction page; // 페이징 클래스
    
    private String actionName = "listClaim"; // 페이지 액션과 로그인 액션에서 쓰인다.
    
    // 생성자 : DB 연동
    public ListClaim() throws Exception
    {
        reader = Resources.getResourceAsReader("sqlMapConfig.xml");
        sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
        reader.close();
    }
    
    @RequestMapping("/user/admin/listClaim.do")
    public String listClaim(HttpSession session, HttpServletRequest request)
            throws Exception
    {
        // 관리자가 아닌 경우에는 일단 에러 페이지로
        if ((session.getAttribute("session_type") == null)
                || (!session.getAttribute("session_type").equals("admin")))
        {
            System.out.println("관리자만 접근 가능한 페이지");
            return "redirect:/error.do";
        }
        
        // 글 보기 경로 설정
        StringBuffer url = request.getRequestURL();
        String path = url.substring(0, url.indexOf(request.getServletPath()))
                + "/";
        request.setAttribute("path", path);
        
        // 신고내역 페이징
        claimRes = sqlMapper.queryForList("Claim.selectClaimList");
        
        totalCount = claimRes.size(); // 전체 글 갯수를 구한다.
        
        if (request.getParameter("currentPage") == null)
        {
            currentPage = 1;
        }
        else
        {
            currentPage = Integer.parseInt(request.getParameter("currentPage"));
        }
        
        page = new PagingAction(actionName, currentPage, totalCount,
                blockCount, blockPage);
        
        pagingHtml = page.getPagingHtml().toString(); // 페이지 HTML 생성.
        
        // 현재 페이지에서 보여줄 마지막 글의 번호 설정.
        int lastCount = totalCount;
        
        // 현재 페이지의 마지막 글의 번호가 전체의 마지막 글 번호보다 작으면 lastCount를 +1 번호로 설정.
        if (page.getEndCount() < totalCount)
            lastCount = page.getEndCount() + 1;
        
        // 전체 리스트에서 현재 페이지만큼의 리스트만 가져온다.
        claimRes = claimRes.subList(page.getStartCount(), lastCount);
        
        request.setAttribute("claimRes", claimRes);
        request.setAttribute("pagingHtml", pagingHtml);
        return "/view/user/admin/listClaim.jsp";
    }
    
    @RequestMapping("/user/admin/searchClaim.do")
    public String searchCalim(HttpServletRequest request, @ModelAttribute
    SearchClaimDTO searchClaimDTO) throws Exception
    {
        claimRes = sqlMapper.queryForList("Claim.selectSearchedClaimList",
                                          searchClaimDTO);
        
        // 글 보기 경로 설정
        StringBuffer url = request.getRequestURL();
        String path = url.substring(0, url.indexOf(request.getServletPath()))
                + "/";
        request.setAttribute("path", path);
        
        totalCount = claimRes.size(); // 전체 글 갯수를 구한다.
        
        if (request.getParameter("currentPage") == null)
        {
            currentPage = 1;
        }
        else
        {
            currentPage = Integer.parseInt(request.getParameter("currentPage"));
        }
        
        page = new PagingAction(actionName, currentPage, totalCount,
                blockCount, blockPage);
        
        pagingHtml = page.getPagingHtml().toString(); // 페이지 HTML 생성.
        
        // 현재 페이지에서 보여줄 마지막 글의 번호 설정.
        int lastCount = totalCount;
        
        // 현재 페이지의 마지막 글의 번호가 전체의 마지막 글 번호보다 작으면 lastCount를 +1 번호로 설정.
        if (page.getEndCount() < totalCount)
            lastCount = page.getEndCount() + 1;
        
        // 전체 리스트에서 현재 페이지만큼의 리스트만 가져온다.
        claimRes = claimRes.subList(page.getStartCount(), lastCount);
        
        request.setAttribute("claimRes", claimRes);
        request.setAttribute("pagingHtml", pagingHtml);
        
        return "/view/user/admin/listClaim.jsp";
    }
}
