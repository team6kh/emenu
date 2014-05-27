package user.login.controller;

import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import paid.dto.PaidDTO;
import rest.dto.RestDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import user.buyer.dto.BuyerDTO;
import user.login.dto.LoginDTO;
import user.seller.dto.SellerDTO;

@Controller
public class Login {
	
	private Calendar today = Calendar.getInstance();
	
	private Reader reader;
	private SqlMapClient sqlMapper;
	private List<PaidDTO>list = new ArrayList<PaidDTO>();
	private List<RestDTO>list1 = new ArrayList<RestDTO>();
	private int rest_num;
	
	public Login() throws IOException {
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}

	@RequestMapping("/user/login/form.do")
	public String loginForm(HttpServletRequest request) {
		
		// save "referer" in session
		String referer = "";
		referer = request.getHeader("Referer");		
		request.getSession().setAttribute("url_prior_login", referer);
		//System.out.println("url_prior_login:"+referer);
		
		return "/view/user/login/loginForm.jsp";
	}
	
	@RequestMapping(value="/user/login.do",method=RequestMethod.POST)
	public String loginFormSubmit(
			HttpSession session,
			@ModelAttribute LoginDTO login,
			HttpServletRequest request) throws SQLException {
		
		System.out.println(login.getLogin_id() + " is attemping to login at " + today.getTime());
		
		String loginFeedback = "";
		
		/*
		 * HTTP Status 405 - Request method 'GET' not supported
		 * Disable "loginFormPro" after logged in
		 */		
		
		// request 객체에 login 값이 있으면(회원가입 후 바로 로그인일 시), 그 값으로 로그인 시도한다.
		if (request.getAttribute("login") != null) {
			login = (LoginDTO) request.getAttribute("login");	
		}		
		
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
				
				//쿠폰 사이즈를 구해 세션을 생성한다.
				int count = (Integer)sqlMapper.queryForObject("Paid.getUnusedCpnInfo", result.getBuyer_id());
				
				if(count==0){
					session.setAttribute("session_cpn", 0);
				}else{
					list = sqlMapper.queryForList("Paid.selectUnusedCpnInfo", result.getBuyer_id());
					session.setAttribute("session_cpn", list.size());
				}
								
				// 구매자 로그인 성공입니다. "redirector"로 갑니다.
				return "/redirector.do";
			}
			
			// 구매자 로그인 실패입니다.
			loginFeedback = "login_error";
			request.setAttribute("loginFeedback", loginFeedback);
			return "/user/login/form.do";
		
		// 로그인 타입이 "판매자"
		} else if (login.getLogin_type().equals("seller")) {
			
			// SellerDTO 객체 생성
			SellerDTO param = new SellerDTO();
			SellerDTO result = new SellerDTO();
			
			// param에 id와 pw 설정
			param.setSeller_id(login.getLogin_id());
			param.setSeller_pw(login.getLogin_pw());
			
			// param으로 쿼리 실행해 result를 구한다.
			result = (SellerDTO) sqlMapper.queryForObject("Seller.getSellerPw", param);
						
			// result가 있다면 로그인 성공. 세션을 생성한다.
			if (result != null) {
				session.setAttribute("session_type", login.getLogin_type());
				session.setAttribute("session_id", result.getSeller_id());
				session.setAttribute("session_name", result.getSeller_name());		
				
				//아이디로 등록된 상품을 검색.
				int count = (Integer)sqlMapper.queryForObject("Rest.selectCountForSeller", result.getSeller_id());
				if(count==0){ //등록된 상품이 없는경우
					session.setAttribute("session_comment", "미등록");
					rest_num = 0;
				}else{ //등록된 상품이 있는 경우
					list1 = sqlMapper.queryForList("Rest.selectSellerGoods", result.getSeller_id());
					rest_num = list1.get(0).getRest_num();
					session.setAttribute("session_comment", "");
				}
				
				if(rest_num!=0){ //등록된 상품이 있는 경우 추가적으로 요청된 쿠폰을 구함
					int count1 = (Integer)sqlMapper.queryForObject("Paid.getRequestedCpnInfo", rest_num);
					if(count1==0){ //요청된 쿠폰이 없을경우 0으로 초기화
						session.setAttribute("session_cpn", 0);
					}else{ //요청된 쿠폰이 있을 경우
						list = sqlMapper.queryForList("Paid.selectRequestedCpnInfo", rest_num);
						session.setAttribute("session_cpn", list.size());
					}
				}
								
				// 판매자 로그인 성공입니다. "redirector"로 갑니다.
				return "/redirector.do";
			}
			
			// 판매자 로그인 실패입니다.
			loginFeedback = "login_error";
			request.setAttribute("loginFeedback", loginFeedback);
			return "/user/login/form.do";		
		
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
            
            // 관리자 로그인 실패입니다.
            loginFeedback = "login_error";
			request.setAttribute("loginFeedback", loginFeedback);
			return "/user/login/form.do";	
        }
		
		// 로그인 타입이 없습니다. 로그인 실패입니다. redirect to "error"
		return "redirect:/error.do";	
		
	} // end of loginFormPro
	
}
