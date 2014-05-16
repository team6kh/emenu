package user.admin.controller;

import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import user.admin.dto.DashAdminDTO;

@Controller
public class DashAdmin {
	
	private Reader reader;
	private SqlMapClient sqlMapper;
	
	public DashAdmin() throws IOException {
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}

	@RequestMapping("/user/admin/dashboard.do")
	public String dashAdmin(HttpServletRequest request, @ModelAttribute("dashAdmin") DashAdminDTO dashAdmin) throws SQLException {
		// 상품 개수를 구한다.
		dashAdmin.setCountRest((Integer)sqlMapper.queryForObject("Common.getRestCount"));
		// 메뉴 개수를 구한다.
    	dashAdmin.setCountRestOpt((Integer)sqlMapper.queryForObject("Common.getRestOptCount"));
    	// 결재 개수를 구한다.
    	dashAdmin.setCountPaid((Integer)sqlMapper.queryForObject("Common.getPaidCount"));
    	// 리뷰 개수를 구한다.
    	dashAdmin.setCountReview((Integer)sqlMapper.queryForObject("Common.getReviewCount"));
    	// 레시피 개수를 구한다.
    	dashAdmin.setCountRecipe((Integer)sqlMapper.queryForObject("Common.getRecipeCount"));
    	// 공지사항 개수를 구한다.
    	dashAdmin.setCountNotice((Integer)sqlMapper.queryForObject("Common.getNoticeCount"));
    	// 문의하기 개수를 구한다.
    	dashAdmin.setCountQna((Integer)sqlMapper.queryForObject("Common.getQnaCount"));
    	// 구매자 수를 구한다.
    	dashAdmin.setCountBuyer((Integer)sqlMapper.queryForObject("Buyer.getBuyerCount"));
    	// 판매자 수를 구한다.
    	dashAdmin.setCountSeller((Integer) sqlMapper.queryForObject("Seller.getSellerCount"));
    	// 모든 구매자 정보를 가져와 listBuyer에 넣는다.
        dashAdmin.setListBuyer(sqlMapper.queryForList("Buyer.listBuyer"));
        // 모든 판매자 정보를 가져와 listSeller에 넣는다.
        dashAdmin.setListSeller(sqlMapper.queryForList("Seller.listSeller"));
        
        request.setAttribute("dashboard", dashAdmin);
        
        return "/view/user/admin/dashAdmin.jsp";
	}
}
