package user.login.controller;

import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import user.buyer.dto.BuyerDTO;
import user.login.dto.LoginDTO;
import user.seller.dto.SellerDTO;

@Controller
public class Login {
	
	private Reader reader;
	private SqlMapClient sqlMapper;
	
	public Login() throws IOException {
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}

	@RequestMapping("/user/loginForm.do")
	public String loginForm(HttpServletRequest request) {
		
		// 로그인 폼으로 요청이 올 때, 세션에 referer를 저장합니다.
		String referer = request.getHeader("Referer");
		if (referer != null) {
			request.getSession().setAttribute("url_prior_login", referer);
		}
		
		return "/view/user/login/loginForm.jsp";
	}
	
	@RequestMapping(value="/user/loginFormPro.do",method=RequestMethod.POST)
	public String loginFormPro(HttpSession session, @ModelAttribute LoginDTO login) throws SQLException {
		
		/* 로그인 후 이전 페이지로 redirect 기능 구현 필요
		 * 로그인 후에는 여기를 숨겨야 한다 */		
		
		// 로그인 타입이 "구매자"
		if (login.getLogin_type().equals("buyer")) {
			
			// BuyerDTO 객체 생성
			BuyerDTO param = new BuyerDTO();
			BuyerDTO result = new BuyerDTO();
			
			// param에 id와 pw 설정
			param.setBuyer_id(login.getLogin_id());
			param.setBuyer_pw(login.getLogin_pw());
			
			// param으로 쿼리 실행해 result를 구한다.			
			result = (BuyerDTO) sqlMapper.queryForObject("Buyer.getBuyerPw", param);		
			
			// result가 있다면 로그인 성공. 세션을 생성한다.
			if (result != null) {
				session.setAttribute("session_type", login.getLogin_type());
				session.setAttribute("session_id", result.getBuyer_id());
				session.setAttribute("session_name", result.getBuyer_name());
								
				// 구매자 로그인 성공입니다. "redirector"로 갑니다.
				return "/redirector.do";
			}
			
			// 구매자 로그인 실패입니다. redirect to "error"
			return "redirect:/error.do";
		
		// 로그인 타입이 "판매자"
		} else if (login.getLogin_type().equals("seller")) {
			
			// SellerDTO 객체 생성
			SellerDTO param = new SellerDTO();
			SellerDTO result = new SellerDTO();
			
			// param에 id와 pw 설정
			param.setSeller_id(login.getLogin_id());
			param.setSeller_pw(login.getLogin_pw());
			
			// param으로 쿼리 실행해 result를 구한다.
			try {
				result = (SellerDTO) sqlMapper.queryForObject("Seller.getSellerPw", param);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			// result가 있다면 로그인 성공. 세션을 생성한다.
			if (result != null) {
				session.setAttribute("session_type", login.getLogin_type());
				session.setAttribute("session_id", result.getSeller_id());
				session.setAttribute("session_name", result.getSeller_name());				
								
				// 판매자 로그인 성공입니다. "redirector"로 갑니다.
				return "/redirector.do";
			}
			
			// 판매자 로그인 실패입니다. redirect to "error"
			return "redirect:/error.do";			
		
		// 로그인 타입이 "관리자"
		} else if (login.getLogin_type().equals("admin")) {
			
			// 로그인 id가 "admin"이고, pw가 "1234"이면 성공
            if (login.getLogin_id().equals("admin") && login.getLogin_pw().equals("1234"))
            {
            	session.setAttribute("session_type", login.getLogin_type());
				session.setAttribute("session_id", "admin");
				session.setAttribute("session_name", "관리자");	
                
				// 관리자 로그인 성공입니다. redirect to "dashboard"
				return "redirect:/user/admin/dashboard.do";
            }
            
            // 관리자 로그인 실패입니다. redirect to "error"
         	return "redirect:/error.do";	
        }
		
		// 로그인 타입이 없습니다. 로그인 실패입니다. redirect to "error"
		return "redirect:/error.do";	
		
	} // end of loginFormPro
	
}
