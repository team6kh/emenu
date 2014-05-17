package review.controller;

import java.io.Reader;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import review.dto.PagingReviewDTO;
import review.dto.ReviewDTO;
import review.util.FileReview;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import common.Constants;

@Controller
public class DeleteReview
{
    // ibatis 연동을 위한 변수
    public static Reader reader;
    
    public static SqlMapClient sqlMapper;
    
    
    ReviewDTO reviewDTO = new ReviewDTO();
  
    // 생성자 : ibatis 연동
    public DeleteReview() throws Exception
    {
        reader = Resources.getResourceAsReader("sqlMapConfig.xml");
        sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
        reader.close();
    }
    
    
    // 후기글 삭제 폼으로 가기 위한 메서드
    @RequestMapping("/deleteReviewForm.do")
    public String deleteReviewForm(@ModelAttribute PagingReviewDTO pagingDTO, HttpServletRequest request) throws Exception
    {
        request.setAttribute("pagingReviewDTO", pagingDTO);
        
        return "/view/review/deleteReview.jsp";
    }
    
    
    // 후기글 삭제 처리
    @RequestMapping("deleteReviewPro.do")
    public String deleteReviewPro(HttpServletRequest request) throws Exception
    {
        int review_num = Integer.parseInt(request.getParameter("review_num"));
        
     // 첨부파일 삭제를 위해 DB에서 해당 글을 가져옴
        reviewDTO = (ReviewDTO) sqlMapper.queryForObject("Review.selectReviewOne", review_num);

        // 첨부파일명 값을 꺼냄
        String filesName = reviewDTO.getReview_file();

        // 첨부파일이 있으면 첨부파일 삭제 진행
        if (filesName != null) {
                
                // 첨부파일 저장된 경로
                String fileUploadPath = Constants.COMMON_FILE_PATH + Constants.REVIEW_FILE_PATH;
                                
                // 파일업로드, 파일삭제 메서드를 이용하기 위해 객체 생성
                FileReview fileReview = new FileReview();
                // 첨부파일 삭제 메서드 호출
                fileReview.deleteFiles(filesName, fileUploadPath);

        }


        // DB에서 레코드 삭제
        sqlMapper.delete("Review.deleteReview", reviewDTO);
        
        // 후기 페이지 값 설정
        request.setAttribute("ccp", request.getParameter("ccp"));
        return "/view/review/goReadRest.jsp";
    }
}
