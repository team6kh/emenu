package user.seller.controller;

import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import user.seller.dto.SellerDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

@Controller
public class DeleteSeller {

	private Reader reader;
	private SqlMapClient sqlMapper;
	
	public DeleteSeller() throws IOException {
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}
	
	@RequestMapping("/user/seller/delete.do")
	public String deleteSeller(HttpServletRequest request) throws SQLException {
		
		SellerDTO sellerDTO = (SellerDTO) request.getAttribute("sellerDTO");
		sqlMapper.delete("Seller.deleteSeller", sellerDTO);
		
		return "/user/logout.do";		
	}
}
