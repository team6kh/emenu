package user.registration.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Registration {

	@RequestMapping("/user/registrationForm.do")
	public String regForm(HttpServletRequest request) {
		
		String reg_type = request.getParameter("reg_type");
		
		if (reg_type != null) {
			// reg_type에 따라 폼 리턴
			if (reg_type.equals("buyer")) {
				return "/view/user/buyer/regBuyerForm.jsp";
			} else if (reg_type.equals("seller")) {
				return "/view/user/seller/regSellerForm.jsp";
			}
			// 잘못된 reg_type입니다.
			return "redirect:/error.do";
		}	
		
		// 최초 요청시에는(if reg_type == null) BUYER로
		return "/view/user/buyer/regBuyerForm.jsp";
	}
	
	@RequestMapping("/user/registrationFormPro.do")
	public String regFormPro(HttpServletRequest request) {
		
		String reg_type = (String) request.getParameter("reg_type");
		System.out.println("reg_type:"+reg_type);

		if (reg_type != null) {
			// 구매자 가입 요청
			if (reg_type.equals("buyer")) {
				System.out.println("buyer reg requested");
				return "/user/buyer/register.do";
			// 판매자 가입 요청
			} else if (reg_type.equals("seller")) {
				System.out.println("seller reg requested");
				return "/user/seller/register.do";
			}
			System.out.println("reg_type error");
			return "redirect:/error.do";
		}		
		System.out.println("reg_type null");
		return "redirect:/error.do";
	}
		
}
