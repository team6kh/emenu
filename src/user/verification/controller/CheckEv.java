package user.verification.controller;

import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import user.buyer.dto.BuyerDTO;
import user.seller.dto.SellerDTO;
import user.verification.dto.EvDTO;

@Controller
public class CheckEv {
	
	int isSuccess = 0;
	
	private Reader reader;
	private SqlMapClient sqlMapper;
	
	public CheckEv() throws IOException {
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}

	@RequestMapping("/verification/check.do")
	public String checkEv(HttpServletRequest request) throws SQLException {
		
		//System.out.println("/verification/check.do");
		
		String ev_requested;
		String ev_code_input;
		String user_type;
		String user_id;		
		
		ev_requested = request.getParameter("ev_requested");		
		ev_code_input = request.getParameter("ev_code_input"); // 사용자가 입력한 인증코드
		user_type = request.getParameter("user_type");
		user_id = request.getParameter("user_id");
		
		//System.out.println("ev_requested:"+ev_requested);
		//System.out.println("ev_code_input:"+ev_code_input);
		
		EvDTO evDTO = new EvDTO();
		evDTO.setEv_requested(ev_requested);
		evDTO.setEv_code(ev_code_input);
		
		evDTO = (EvDTO) sqlMapper.queryForObject("Ev.getLatestEvCode", evDTO);
		
		if (evDTO != null) {
			
			isSuccess = 0;	
			
			//System.out.println("evDTO not null");
			
			if (user_type.equals("buyer")) {
				BuyerDTO buyerDTO = new BuyerDTO();
				buyerDTO.setBuyer_id(user_id);
				buyerDTO.setBuyer_verification("yes");				
				sqlMapper.update("Buyer.updateVerification", buyerDTO);				
				isSuccess = 1;				
				
			} else if (user_type.equals("seller")) {
				SellerDTO sellerDTO = new SellerDTO();
				sellerDTO.setSeller_id(user_id);
				sellerDTO.setSeller_verification("yes");				
				sqlMapper.update("Seller.updateVerification", sellerDTO);				
				isSuccess = 1;
			}
		}
		
		//System.out.println("isSuccess:"+isSuccess);
		
		// 결과값 isSuccess
        request.setAttribute("isSuccess", isSuccess);
        request.setAttribute("user_type", user_type);
        request.setAttribute("user_id", user_id);
        
		return "/view/user/verification/checkEv.jsp";
	}
	
}
