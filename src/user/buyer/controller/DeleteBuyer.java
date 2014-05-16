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
public class DeleteBuyer {
	
	private Reader reader;
	private SqlMapClient sqlMapper;
	
	public DeleteBuyer() throws IOException {
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}

	@RequestMapping("/user/buyer/delete.do")
	public String deleteBuyer(HttpServletRequest request) throws SQLException {
		
		BuyerDTO buyerDTO = (BuyerDTO) request.getAttribute("buyerDTO");
		sqlMapper.delete("Buyer.deleteBuyer", buyerDTO);
		
		return "/user/logout.do";		
	}
}
