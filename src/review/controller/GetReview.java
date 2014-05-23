package review.controller;

import java.io.Reader;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import review.dto.ReviewDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

@Controller
public class GetReview
{
 // ibatis 연동을 위한 변수
     private static Reader reader;
     private static SqlMapClient sqlMapper;
    
    
    public GetReview() throws Exception
    {
        reader = Resources.getResourceAsReader("sqlMapConfig.xml");
        sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
        reader.close();
    }
    
    @RequestMapping("/getReview.do")
    public String getReview(HttpServletRequest request) throws Exception    
    {
        int review_num = Integer.parseInt(request.getParameter("review_num"));
        ReviewDTO reviewDTO = (ReviewDTO) sqlMapper.queryForObject("Review.selectReviewOne", review_num);
        request.setAttribute("reviewDTO", reviewDTO);
        
        return "/view/review/getReview.jsp";
    }
}
