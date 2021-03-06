package user.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GetUser {
	
	@RequestMapping("/user/get.do")
	public String getUser(HttpServletRequest request) throws SQLException {
		
		String user_type = "";
		//String user_id = "";
		String actionStatus = "";
		
		user_type = request.getParameter("user_type");
		//System.out.println("user_type:"+user_type);
		//user_id = request.getParameter("user_id");
		
		actionStatus = request.getParameter("actionStatus");
		request.setAttribute("actionStatus", actionStatus);
		
		//System.out.println("actionStatus:"+request.getAttribute("actionStatus"));
		
		// 구매자
		if (user_type.equals("buyer")) {
			return "/user/buyer/get.do";
			
		// 판매자
		} else if (user_type.equals("seller")) {
			return "/user/seller/get.do";
			
		// 관리자
		} else if (user_type.equals("admin")) {
			return "/user/admin/dashboard.do";
		}
		
		return "redirect:/error.do";
		
	}
	
}
