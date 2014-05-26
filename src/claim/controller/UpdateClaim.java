package claim.controller;

import java.io.Reader;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import review.controller.DeleteReview;
import claim.dto.UpdateClaimDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

@Controller
public class UpdateClaim
{
    // ibatis 연동을 위한 변수
    private static Reader reader;
    
    private static SqlMapClient sqlMapper;
    
    // 생성자 : iBatis 연동
    public UpdateClaim() throws Exception
    {
        reader = Resources.getResourceAsReader("sqlMapConfig.xml");
        sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
        reader.close();
    }
    
    @RequestMapping("/user/admin/updateClaim.do")
    public String updateClaim(HttpServletRequest request, @ModelAttribute
    UpdateClaimDTO updateClaimDTO)
    {
        try
        {
            if (updateClaimDTO.getClaim_result().equals("rejection"))
            {
                sqlMapper.update("Claim.updateClaim_rejection", updateClaimDTO);
                
                return "redirect:/user/admin/listClaim.do";
            }
            else if (updateClaimDTO.getClaim_result().equals("admission"))
            {
                if (updateClaimDTO.getBoard_name().equals("review"))
                {
                    new DeleteReview().deleteReviewPro(request);
                }
                sqlMapper.update("Claim.updateClaim_admission", updateClaimDTO);
            }
            else
            {
                System.out.println("claim_result값이 잘못되었음");
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        
        return "redirect:/user/admin/listClaim.do";
    }
}
