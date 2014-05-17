package user.seller.controller;

import java.io.Reader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import paid.dto.MenuDTO;
import paid.dto.PaidDTO;
import paid.dto.SearchConditionDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

@Controller
public class DashSeller
{
    // ibatis 연동을 위해 필요한 변수
    private Reader reader;
    private SqlMapClient sqlMapper;
    
    private String seller_id; // 판매자id 값을 저장하기 위한 변수    
    private String startDate;   // 검색 조건 - 조회할 기간의 시작 날짜   
    private String endDate;  // 검색 조건 - 조회할 기간의 마지막 날짜
    
    
    // 날짜값을 일정한 패턴으로 표시하기 위한 format
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    
    
    // 쿼리문 실행 후 쿠폰 사용 요청 내역을 담을 List
    private List<PaidDTO> cpnRes = new ArrayList<PaidDTO>();    
    // 쿼리문 실행 후 결제 내역 결과를 담는 List
    private List<PaidDTO> paidRes = new ArrayList<PaidDTO>();    
    // 쿼리문 실행 후 인기 메뉴결과를 담는 List
    private List<MenuDTO> menuRes = new ArrayList<MenuDTO>();
    
    // 생성자 : ibatis 연동
    public DashSeller() throws Exception
    {
        reader = Resources.getResourceAsReader("sqlMapConfig.xml");
        sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
        reader.close();
    }
    
    // dashSeller 페이지
    @RequestMapping("/user/dashSeller.do")
    public String dashSeller(HttpSession session, HttpServletRequest request,
            @ModelAttribute("searchDTO")
            SearchConditionDTO searchDTO) throws Exception
    {
        seller_id = (String) session.getAttribute("session_id");
        
        // 판매자의 session_id 값이 없는 경우에는 일단 메인홈 페이지로 보낸다
        if (seller_id == null)
        {
            return "redirect:/home.do";
        }
        // 판매자의 session_id 값이 있는 경우
        else
        {
            searchDTO.setSession_id(seller_id);
            
            /* dashSeller.jsp 중단에 띄울 결과물을 위한 쿼리 호출 - 쿠폰 요청 내역을 전부 추출 */
            
            cpnRes = sqlMapper.queryForList("Paid.selectRequestedCpn", searchDTO);
            
            
            /* dashSeller.jsp 하단에 띄울 결과물을 위한 코드 - 일정기간 동안의 결제내역과 인기메뉴*/
            
            // 검색 기간조건 값이 없는 경우에는 검색기간을 어제로 설정 
            if((searchDTO.getStartDate() == null) || (searchDTO.getEndDate() == null))
            {
                Calendar cal = Calendar.getInstance();
                
                // 어제 날짜 값을 searchDTO에 세팅
                cal.add(cal.DATE, -1);
                searchDTO.setEndDate(sdf.format(cal.getTime()));
                searchDTO.setStartDate(sdf.format(cal.getTime()));
            }
        
            // 결제 내역을 가져온다. 
            paidRes = sqlMapper.queryForList("Paid.selectPaidList", searchDTO);
            // 판매자가 등록한 상품의 인기 메뉴 내역을 가져온다. (추출해내는 레코드 개수 제한 설정 필요)
            menuRes = sqlMapper.queryForList("Paid.selectHotMenu", searchDTO);
              
            
        }
        
        request.setAttribute("cpnRes", cpnRes);
        request.setAttribute("paidRes", paidRes);
        request.setAttribute("menuRes", menuRes);
        return "/view/user/seller/dashSeller.jsp";
    }
    
}
