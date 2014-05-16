package user.login.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class Logout {
	
	@RequestMapping(value="/user/logout.do",method=RequestMethod.POST)
	public String logout(HttpSession session) {
		
		/* HTTP Status 405 - Request method 'GET' not supported */ 
		
		// 세션을 지운다.
		session.invalidate();
		
		// 리턴할 페이지
		return "redirect:/home.do";
		
	}

}
