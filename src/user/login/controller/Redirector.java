package user.login.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Redirector {

	@RequestMapping("/redirector.do")
	public String redirector(HttpSession session) {
		
		/*
		 * redirect 예외 목록
		 * error.do
		 * loginForm.do
		 * logout.do
		 */		
		
		String url = "";
		url = (String) session.getAttribute("url_prior_login");
		
		// url에 "error.do"가 있다면 (없으면 -1을 리턴한다)
		if (url.indexOf("error.do") != -1) {
			url = "/home.do";
		}
		
		return "redirect:"+url;		
	}
	
}
