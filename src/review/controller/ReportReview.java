package review.controller;

import java.io.Reader;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import claim.dto.ClaimDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import review.dto.ReviewDTO;

@Controller
public class ReportReview
{
    // ibatis 연동을 위한 변수
    public static Reader reader;
    
    public static SqlMapClient sqlMapper;
    
    
    
    
    // 생성자 : ibatis 연동
    public ReportReview() throws Exception
    {
        reader = Resources.getResourceAsReader("sqlMapConfig.xml");
        sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
        reader.close();
        
    }
    
    
    
    // 신고하기 폼으로 가기
    @RequestMapping("/reportReviewForm.do")
    public String reportReviewForm(HttpServletRequest request)
    {
        // 신고될 글 번호 값을 반드시 "article_num"이란 이름에 담아서 파라메터 넘길 것
        String actionUrl = "/emenu/reportReviewPro.do"; // 일단 절대경로로 잡아두었음
        request.setAttribute("article_num", request.getParameter("review_num"));
        
        /*
         * insertReportForm.jsp 페이지에 있는 form의 action 값(즉 매핑될 url 값)이므로 반드시
         * "actionUrl"이름에 담아서 해당 값을 담아서 파라메터로 넘길 것
         */
        request.setAttribute("actionUrl", actionUrl);
        return "/view/claim/insertClaimForm.jsp";
    }
    
    
    
    // 신고내역 DB 입력처리
    @RequestMapping("/reportReviewPro.do")
    public String reportReviewPro(@ModelAttribute ClaimDTO claimDTO) throws Exception
    {
        
        // 게시판명 세팅
        claimDTO.setBoard_name("review");
        
       // 신고된 글의 작성자 id를 꺼내오기 -> 레시피 게시판에서 비로그인 상태에서 쓴 글은 "익명"으로 처리해야 하나?
        int review_num = claimDTO.getArticle_num();
        ReviewDTO reviewDTO = (ReviewDTO) sqlMapper.queryForObject("Review.selectReviewOne", review_num);
        claimDTO.setArticle_writer(reviewDTO.getReview_writer());
        
        // 신고된 글 읽기 url값 세팅
        String article_viewUrl ="getReview.do?review_num=" + review_num;
        claimDTO.setArticle_viewUrl(article_viewUrl);
        // 신고된 글 삭제 url 값 세팅
        String article_delUrl = "/emenu/deleteReviewPro.do?review_num=" + review_num;
                
        claimDTO.setArticle_delUrl(article_delUrl);
        
        sqlMapper.insert("Claim.insertClaim", claimDTO);
        
        return "/view/claim/insertClaimPro.jsp";
    }
}
