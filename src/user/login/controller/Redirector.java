package user.login.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Redirector {

	@RequestMapping("/redirector.do")
	public String redirector(HttpSession session) {
		String url = (String) session.getAttribute("url_prior_login");
		// url에 "error.do"가 있다면
		if (url.indexOf("error.do") != -1) {
			url = "/home.do";
		}
		return "redirect:"+url;		
	}
	
}
