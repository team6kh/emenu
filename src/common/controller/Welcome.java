package common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Welcome {

	@RequestMapping("/welcome.do")
	public String welcome() {
		return "/view/common/welcome.jsp";
	}
}
