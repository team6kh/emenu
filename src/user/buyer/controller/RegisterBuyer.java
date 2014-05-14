package user.buyer.controller;

import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import user.buyer.dto.BuyerDTO;
import user.login.controller.Login;
import user.login.dto.LoginDTO;

@Controller
public class RegisterBuyer {
	
	private Calendar today = Calendar.getInstance(); // 오늘 날짜 구하기
	
	private Reader reader;
	private SqlMapClient sqlMapper;
	
	public RegisterBuyer() throws IOException {
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}

	@RequestMapping("/user/buyer/register.do")
	public String regBuyer(
			@ModelAttribute BuyerDTO buyer,
			@ModelAttribute LoginDTO login,
			HttpServletRequest request) throws SQLException {
		
		//System.out.println("regBuyer()");
		
		buyer.setBuyer_reg_date(today.getTime());
		buyer.setBuyer_verification("no"); // 가입시 인증값 default는 no
		
		sqlMapper.insert("Buyer.insertBuyer", buyer);
		
		/*
		 * 회원가입 후 바로 로그인
		 * primary : login 값을 request 객체에 설정 후 loginFormPro.do로 이동
		 * alternative : 여기서 바로 세션 생성
		 */
		
		// login 모델의 값을 설정한다.
		login.setLogin_type("buyer");
		login.setLogin_id(buyer.getBuyer_id());
		login.setLogin_pw(buyer.getBuyer_pw());
				
		// request 객체에 login 값을 설정한다.
		request.setAttribute("login", login);
		
		return "/user/loginFormPro.do";
		
	}
	
}
