package claim.controller;

import java.io.Reader;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import claim.dto.ClaimDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;



@Controller
public class ListClaim
{
    // ibatis 연동을 위한 변수
    private static Reader reader;
    private static SqlMapClient sqlMapper;
    
    //신고내역 리스트를 받기 위한 변수
    List<ClaimDTO> reportRes = new ArrayList<ClaimDTO>();
    
    // 생성자 : DB 연동
    public ListClaim() throws Exception
    {
        reader = Resources.getResourceAsReader("sqlMapConfig.xml");
        sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
        reader.close();
    }
    
    
    @RequestMapping("")
    public String listReport(HttpServletRequest request) throws Exception
    {
        
        reportRes = sqlMapper.queryForList("Report.selectReportList", "");
        
        request.setAttribute("reportRes", reportRes);
        return "";
    }
}
