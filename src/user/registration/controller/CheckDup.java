package user.registration.controller;

import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import user.buyer.dto.BuyerDTO;
import user.seller.dto.SellerDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

@Controller
public class CheckDup {
	
	int isDup; // 중복인가 아닌가
	
	private Reader reader;
	private SqlMapClient sqlMapper;
	
	public CheckDup() throws IOException {
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}
	
	@RequestMapping("/user/checkDup.do")
	public String checkDup(HttpServletRequest request) throws SQLException {
		
		String reg_id = request.getParameter("reg_id");
        //System.out.println("reg_id:"+reg_id);
		
		BuyerDTO buyerDTO = new BuyerDTO();
		SellerDTO sellerDTO = new SellerDTO();
		
		buyerDTO = (BuyerDTO) sqlMapper.queryForObject("Buyer.getBuyerId", buyerDTO);
        sellerDTO = (SellerDTO) sqlMapper.queryForObject("Seller.getSellerId", sellerDTO);

        if (buyerDTO != null || sellerDTO != null) {
            isDup = 1;
        } else if (reg_id.equals("admin")) {
        	isDup = 1;
    	} else {
            isDup = 0;
        }
        
        request.setAttribute("isDup", isDup);
        //System.out.println("isDup:"+isDup);
        
        return "/view/user/registration/checkDup.jsp";
		
	}

}
