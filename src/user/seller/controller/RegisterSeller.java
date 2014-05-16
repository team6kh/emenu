package user.seller.controller;

import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import user.login.dto.LoginDTO;
import user.seller.dto.SellerDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

@Controller
public class RegisterSeller {
	
	private Calendar today = Calendar.getInstance(); // 오늘 날짜 구하기
	
	private Reader reader;
	private SqlMapClient sqlMapper;
	
	public RegisterSeller() throws IOException {
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}
	
	@RequestMapping("/user/seller/register.do")
	public String regSeller(
			@ModelAttribute SellerDTO seller,
			@ModelAttribute LoginDTO login,
			HttpServletRequest request) throws SQLException {
		
		seller.setSeller_reg_date(today.getTime());
		seller.setSeller_verification("no"); // 가입시 인증값 default는 no
		
		sqlMapper.insert("Seller.insertSeller", seller);
		
		/*
		 * 회원가입 후 바로 로그인 
		 * primary : login 값을 request 객체에 설정 후 loginFormPro.do로 이동 
		 * alternative : 여기서 바로 세션 생성
		 */
		
		// login 모델의 값을 설정한다.
		login.setLogin_type("seller");
		login.setLogin_id(seller.getSeller_id());
		login.setLogin_pw(seller.getSeller_pw());
		
		// request 객체에 login 값을 설정한다.
		request.setAttribute("login", login);
		
		return "/user/login.do";		
		
	}

}
