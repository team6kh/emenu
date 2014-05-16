package user.buyer.controller;

import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import user.buyer.dto.BuyerDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

@Controller
public class UpdateBuyer {
	
	private Reader reader;
	private SqlMapClient sqlMapper;
	
	public UpdateBuyer() throws IOException {
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}

	@RequestMapping("/user/buyer/update/form.do")
	public String updateBuyerForm(HttpServletRequest request) {
		
		request.getAttribute("buyerDTO");		
		
		return "/view/user/buyer/updateBuyerForm.jsp";		
	}
	
	@RequestMapping("/user/buyer/update.do")
	public String updateBuyerFormSubmit(@ModelAttribute BuyerDTO buyerDTO) throws SQLException {
		
		sqlMapper.update("Buyer.updateBuyer", buyerDTO);	
		
		return "/user/get.do?user_type=buyer&user_id="+buyerDTO.getBuyer_id();		
	}	
}
