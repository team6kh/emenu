package user.login.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Logout {
	
	@RequestMapping("/user/logout")
	public String logout(HttpSession session) {
		
		// 세션을 지운다.
		session.invalidate();
		
		// 리턴할 페이지
		return "redirect:/home.do";
		
	}

}
