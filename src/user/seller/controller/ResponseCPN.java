package user.seller.controller;

import java.io.Reader;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

@Controller
public class ResponseCPN
{
    // ibatis 연동을 위해 필요한 변수
    private Reader reader;
    private SqlMapClient sqlMapper;
    
        
    public ResponseCPN() throws Exception 
    {
        reader = Resources.getResourceAsReader("sqlMapConfig.xml");
        sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
        reader.close();
    }
    
    @RequestMapping("/user/responseCPN.do")
    public String responseCPN(HttpServletRequest request, @RequestParam(value="requestPaid_num", required=false) int[] reqPaid) throws Exception
    {
        for(int i=0; i< reqPaid.length; i++) {
            sqlMapper.update("Paid.updateResponseCpn", reqPaid[i]);
        }
        return "redirect:/user/dashSeller.do";
    }
}
