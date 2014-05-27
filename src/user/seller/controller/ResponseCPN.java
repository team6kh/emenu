package user.seller.controller;

import java.io.Reader;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;








import paid.dto.PaidDTO;
import rest.dto.RestDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

@Controller
public class ResponseCPN
{
    // ibatis 연동을 위해 필요한 변수
    private Reader reader;
    private SqlMapClient sqlMapper;
    private List<PaidDTO>list = new ArrayList<PaidDTO>();
    private List<RestDTO>list1 = new ArrayList<RestDTO>();
    private int rest_num;
        
    public ResponseCPN() throws Exception 
    {
        reader = Resources.getResourceAsReader("sqlMapConfig.xml");
        sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
        reader.close();
    }
    
    @RequestMapping("/user/responseCPN.do")
    public String responseCPN(HttpServletRequest request, HttpSession session, @RequestParam(value="requestPaid_num", required=false) int[] reqPaid) throws Exception
    {
       String session_id = (String) session.getAttribute("session_id"); 
        
        int count = (Integer)sqlMapper.queryForObject("Rest.selectCountForSeller", session_id);
        if(count==0){ //등록된 상품이 없는경우
                rest_num = 0;
        }else{ //등록된 상품이 있는 경우
                list1 = sqlMapper.queryForList("Rest.selectSellerGoods", session_id);
                rest_num = list1.get(0).getRest_num();
        }
        
        if(rest_num!=0){ //등록된 상품이 있는 경우 추가적으로 요청된 쿠폰을 구함
                int count1 = (Integer)sqlMapper.queryForObject("Paid.getRequestedCpnInfo", rest_num);
                if(count1==0){ //요청된 쿠폰이 없을경우 0으로 초기화
                        session.setAttribute("session_cpn", 0);
                }else{ //요청된 쿠폰이 있을 경우
                        list = sqlMapper.queryForList("Paid.selectRequestedCpnInfo", rest_num);
                        session.setAttribute("session_cpn", list.size());
                }
        }
        
        if(reqPaid != null)
        {
            for(int i=0; i< reqPaid.length; i++) 
            {
                sqlMapper.update("Paid.updateResponseCpn", reqPaid[i]);
            }
        }
        
        return "redirect:/user/dashSeller.do";
    }
    
}
