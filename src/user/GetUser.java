package user;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GetUser {
	
	@RequestMapping("/user/getUser.do")
	public String getUser(HttpServletRequest request) {
		
		String user_type = "";
		//String user_id = "";
		
		user_type = request.getParameter("user_type");
		//user_id = request.getParameter("user_id");
		
		// 구매자
		if (user_type.equals("buyer")) {
			return "/user/buyer/getBuyer.do";
			
		// 판매자
		} else if (user_type.equals("seller")) {
			return "/user/seller/getSeller.do";
			
		// 관리자
		} else if (user_type.equals("admin")) {
			return "/user/admin/dashboard.do";
		}
		
		return "redirect:/error.do";
		
	}
	
}
