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
public class GetSeller {
	
	private Reader reader;
	private SqlMapClient sqlMapper;
	
	public GetSeller() throws IOException {
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}

	@RequestMapping("/user/seller/get.do")
	public String getSeller(HttpServletRequest request) throws SQLException {
		
		String user_id = "";
		user_id = request.getParameter("user_id");
		
		SellerDTO sellerDTO = new SellerDTO();
		sellerDTO.setSeller_id(user_id);
		sellerDTO = (SellerDTO) sqlMapper.queryForObject("Seller.getSellerId", sellerDTO);
		
		request.setAttribute("sellerDTO", sellerDTO);
		
		return "/view/user/seller/getSeller.jsp";		
	}
}
