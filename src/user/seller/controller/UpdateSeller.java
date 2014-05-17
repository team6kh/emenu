package user.seller.controller;

import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import user.seller.dto.SellerDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

@Controller
public class UpdateSeller {

	private Reader reader;
	private SqlMapClient sqlMapper;
	
	public UpdateSeller() throws IOException {
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}
	
	@RequestMapping("/user/seller/update/form.do")
	public String updateSellerForm(HttpServletRequest request) {
		
		request.getAttribute("sellerDTO");
		
		return "/view/user/seller/updateSellerForm.jsp";
	}
	
	@RequestMapping("/user/seller/update.do")
	public String updateSellerFormSubmit(@ModelAttribute SellerDTO sellerDTO) throws SQLException {
		
		sqlMapper.update("Seller.updateSeller", sellerDTO);
		
		return "/user/get.do?user_type=seller&user_id="+sellerDTO.getSeller_id();		
	}
}
