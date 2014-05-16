package user.buyer.controller;

import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import user.buyer.dto.BuyerDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

@Controller
public class GetBuyer {
	
	private Reader reader;
	private SqlMapClient sqlMapper;
	
	public GetBuyer() throws IOException {
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}
	
	@RequestMapping("/user/buyer/get.do")
	public String getBuyer(HttpServletRequest request) throws SQLException {
		
		String user_id = "";
		user_id = request.getParameter("user_id");
		
		BuyerDTO buyerDTO = new BuyerDTO();
		buyerDTO.setBuyer_id(user_id);
		buyerDTO = (BuyerDTO) sqlMapper.queryForObject("Buyer.getBuyerId", buyerDTO);
		
		request.setAttribute("buyerDTO",buyerDTO);
		
		return "/view/user/buyer/getBuyer.jsp";	
	}
	
}
