package review.controller;

import java.io.Reader;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import review.dto.ReviewDTO;
import review.util.FileReview;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import common.Constants;

@Controller
public class UpdateReview
{
    
    // ibatis 연동을 위한 변수
    public static Reader reader;
    
    public static SqlMapClient sqlMapper;
    
    // 후기 페이지 값
    private int ccp;
    
    // 첨부파일을 위한 변수
    private List<MultipartFile> review_files = new ArrayList<MultipartFile>();
    
    // 생성자 : ibatis 연동
    public UpdateReview() throws Exception
    {
        reader = Resources.getResourceAsReader("sqlMapConfig.xml");
        sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
        reader.close();
    }
    
    @RequestMapping("/updateReviewPro.do")
    public String updateReview(@ModelAttribute("reviewDTO")
    ReviewDTO reviewDTO, MultipartHttpServletRequest request) throws Exception
    {
        // 첨부파일 이외의 값들 DB update
        sqlMapper.update("Review.updateReview", reviewDTO);
        review_files = request.getFiles("review_files");
        
        // 새로운 첨부한 파일이 있는 경우, 기존 첨부파일을 삭제하고 새 첨부파일을 서버에 저장한다
        if (!review_files.isEmpty())
        {
            // 첨부파일 저장된 경로
            String fileUploadPath = Constants.COMMON_FILE_PATH
                    + Constants.REVIEW_FILE_PATH;
            
            // 파일 관련 연산처리를 해주기 위해 클래스 객체 생성
            FileReview fileReview = new FileReview();
            
            // DB에서 해당 글을 가져옴
            reviewDTO = (ReviewDTO) sqlMapper
                    .queryForObject("Review.selectReviewOne", reviewDTO.getReview_num());
            
            // 이전에 업로드된 첨부파일이 있는 경우에 서버에서 삭제
            if (reviewDTO.getReview_file() != null)
            {
          
                // 이전 첨부파일명 값을 꺼냄
                String filesName = reviewDTO.getReview_file();
                // 첨부파일 삭제 메서드 호출
                fileReview.deleteFiles(filesName, fileUploadPath);
                // 기존 첨부파일 삭제 완료
            }
            
            // 새로 첨부된 파일 업로드 시작
            // 파일명 변경시 공통으로 붙여줄 이름
            String fileRename = "review_" + reviewDTO.getReview_num();
            // 파일 업로드 메서드 호출
            String saveFileName = fileReview.uploadFiles(review_files,
                                                         fileUploadPath,
                                                         fileRename);
            
            // 서버에 저장된 파일명을 빈에 세팅
            reviewDTO.setReview_file(saveFileName);
            // DB file update 진행
            sqlMapper.update("Review.updateReviewFile", reviewDTO);
            
        }
        
        // 후기 페이지 값 설정
        request.setAttribute("ccp", request.getParameter("ccp"));
        return "/view/review/goReadRest.jsp";
    }
    
}
