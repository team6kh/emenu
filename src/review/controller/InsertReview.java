package review.controller;

import java.io.Reader;
import java.util.ArrayList;
import java.util.Calendar;
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
public class InsertReview
{
    
    // ibatis 연동을 위한 변수
    public static Reader reader;
    
    public static SqlMapClient sqlMapper;
    
    // 페이징을 위한 변수
    private int ccp;
    
    // 오늘 날짜값을 구하기 위해서 Calendar 클래스의 객체 가져오기
    Calendar today = Calendar.getInstance();
    
    // 첨부파일을 위한 변수
    private List<MultipartFile> review_files = new ArrayList<MultipartFile>();
    
    //생성자 : ibatis 연동
    public InsertReview() throws Exception
    {
        reader = Resources.getResourceAsReader("sqlMapConfig.xml");
        sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
        reader.close();
    }
    
    @RequestMapping("/insertReviewPro.do")
    public String insertReviewPro(@ModelAttribute("reviewDTO")
    ReviewDTO reviewDTO, MultipartHttpServletRequest request) throws Exception
    {
  
        // 후기글의 작성일값 세팅
        reviewDTO.setReview_reg_date(today.getTime());
        
        // 첨부파일을 제외한 나머지 프로퍼티들 DB에 insert
        sqlMapper.insert("Review.insertReview", reviewDTO);
        
        // 첨부파일이 있으면, 서버의 지정된 경로로 첨부파일 복사하기
        if (!request.getFiles("review_files").get(0).isEmpty())
        {
            // 업로드된 첨부파일 꺼내오기
            review_files = request.getFiles("review_files");
            // 첨부파일 저장할 경로
            String fileUploadPath = Constants.COMMON_FILE_PATH
                    + Constants.REVIEW_FILE_PATH;
            
            // review_num 값을 가져온다.
            reviewDTO = (ReviewDTO) sqlMapper.queryForObject("Review.selectLastNum");
                   
            
            // 서버에 저장될 파일명을 설정 ex) review_0
            String fileRename = "review_" + reviewDTO.getReview_num();
            
            // 파일업로드에 관한 연산 처리를 해주는 uploadFiles() 메서드 호출
            FileReview fileUpload = new FileReview();
            String saveFileName = fileUpload.uploadFiles(review_files,
                                                         fileUploadPath,
                                                         fileRename);
            
            // 연산결과 값(변경된 첨부파일명들)을 빈에 세팅해준다
            reviewDTO.setReview_file(saveFileName);
            // DB update 처리를 한다. (첨부파일명을 DB에 저장)
            sqlMapper.update("Review.updateReviewFile", reviewDTO);
         
            // 후기 페이지 값 설정
            ccp = 1;
            request.setAttribute("ccp", ccp);
        }
     
        return "/view/review/goReadRest.jsp";
    }
    
}
