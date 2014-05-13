package common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Error {
	
	@RequestMapping("/error.do")
	public String error() {
		return "/view/common/error.jsp";
	}

}
