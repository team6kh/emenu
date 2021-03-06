package user.register.controller;

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
		
		// Buyer, Seller 객체 생성
		BuyerDTO buyer = new BuyerDTO();
		SellerDTO seller = new SellerDTO();
		
		// reg_id를 각 회원의 아이디값으로 설정
		buyer.setBuyer_id(reg_id);
		seller.setSeller_id(reg_id);
		
		// DB에 해당 아이디가 있는지 쿼리 실행
		buyer = (BuyerDTO) sqlMapper.queryForObject("Buyer.getBuyerId", buyer);
        seller = (SellerDTO) sqlMapper.queryForObject("Seller.getSellerId", seller);
        
        // buyer에 있거나 seller에 있다면 중복
        if (buyer != null || seller != null) {
            isDup = 1;
            
        // 금지어("admin")으로 가입하려 해도 중복 처리
        } else if (reg_id.equals("admin")) {
        	isDup = 1;
        	
        // 그렇지 않다면 가입 가능한 아이디
    	} else {
            isDup = 0;
        }
        
        // 결과값 isDup
        request.setAttribute("isDup", isDup);
        
        //System.out.println("isDup:"+isDup);
        
        return "/view/user/register/checkDup.jsp";
		
	}

}
