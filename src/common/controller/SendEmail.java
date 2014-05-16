package common.controller;

import java.io.IOException;
import java.io.Reader;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import user.buyer.dto.BuyerDTO;
import user.seller.dto.SellerDTO;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import common.RNG;

@Controller
public class SendEmail {
	
	private String from; // The email address of the sender
	private String to; // Who to send the email to?
	private String subject; // subject of the email
	private String content; // The actual email content
	
	String content_img_main = "http://blogfiles.naver.net/20140425_61/ljw7426_1398389790756PQfsf_PNG/%C1%A6%B8%F1.png";
    String content_putter = "http://blogfiles.naver.net/20140425_268/ljw7426_1398389791006NHcfO_PNG/%C7%AA%C5%CD.png";

    static Properties properties = new Properties();
    static {
    	properties.put("mail.smtp.starttls.enable", "true");
    	properties.put("mail.transport.protocol", "smtp");
    	properties.put("mail.smtp.host", "smtp.gmail.com");
    	properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
    	properties.put("mail.smtp.socketFactory.port", "465");
    	properties.put("mail.smtp.auth", "true");
    }
	
	private Reader reader;
	private SqlMapClient sqlMapper;
	
	public SendEmail() throws IOException {
		reader = Resources.getResourceAsReader("sqlMapConfig.xml");
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		reader.close();
	}

	// 이메일 인증 요청 시에 발송되는 메일
	@RequestMapping("/email/verificationSend.do")
	public String VerificationSend(HttpServletRequest request) {	
		
		String user_type = "";
		String user_id = "";		
		String ev_code = ""; // 인증코드
		
		user_type = request.getParameter("user_type");
		user_id = request.getParameter("user_id");
		        
        try {
            Session session = Session.getInstance(properties,
                    new javax.mail.Authenticator() {
                        protected PasswordAuthentication getPasswordAuthentication() {
                            return new PasswordAuthentication("kh.team6@gmail.com", "dkagh1234");
                        }
                    });                   
            
            /* RNG */
            RNG rng = new RNG();
            ev_code = rng.generateEvCode();
            
            /* 메시지 작성 */
            Message message = new MimeMessage(session);              
            
            // BUYER에게 보내는 메일
            if (user_type.equals("buyer")) {
            	
            	// Buyer 정보 얻기
            	BuyerDTO buyer = new BuyerDTO();
        		buyer.setBuyer_id(user_id);
        		buyer = (BuyerDTO) sqlMapper.queryForObject("Buyer.getBuyerId", buyer);
        		
        		// message에 넣을 값 설정
            	from = "kh.team6@gmail.com";
        		to = buyer.getBuyer_email();
        		subject = "[JOGIYO] Please verify your email '" + buyer.getBuyer_email() + "'";
        		/* StringBuffer를 사용해 content를 작성한다. */
        		StringBuffer sb = new StringBuffer(); // StringBuffer
        		sb.append("Taz'dingo, we want to verify that you are indeed \"");
        		sb.append(buyer.getBuyer_name());
        		sb.append("\". if that's the case, please type the following verification code: ");
        		sb.append(ev_code); // 인증코드
        		sb.append(". if you're not ");
        		sb.append(buyer.getBuyer_name());
        		sb.append(" or didn't request verification, you can ignore this email.");
        		/* END StringBuffer */
        		sb.append("content");
        		content = sb.toString();            
            
            // SELLER에게 보내는 메일
            } else if (user_type.equals("seller")) {
            	
            	// Seller 정보 얻기
            	SellerDTO seller = new SellerDTO();
        		seller.setSeller_id(user_id);
        		seller = (SellerDTO) sqlMapper.queryForObject("Seller.getSellerId", seller);
        		
        		// message에 넣을 값 설정
            	from = "kh.team6@gmail.com";
        		to = seller.getSeller_email();
        		subject = "[JOGIYO] Please verify your email '" + seller.getSeller_email() + "'";
        		/* StringBuffer를 사용해 content를 작성한다. */
        		StringBuffer sb = new StringBuffer(); // StringBuffer
        		sb.append("Taz'dingo, we want to verify that you are indeed \"");
        		sb.append(seller.getSeller_name());
        		sb.append("\". if that's the case, please type the following verification code: ");
        		sb.append(ev_code); // 인증코드
        		sb.append(". if you're not ");
        		sb.append(seller.getSeller_name());
        		sb.append(" or didn't request verification, you can ignore this email.");
        		/* END StringBuffer */
        		sb.append("content");
        		content = sb.toString(); 
            }            

            message.setFrom(new InternetAddress(from, MimeUtility.encodeText("조기요","UTF-8","B")));
            //message.setFrom(new InternetAddress(from));           
            
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));           
            //InternetAddress[] iAddress = {new InternetAddress(to)};            
            //message.setRecipients(Message.RecipientType.TO, iAddress);
            
            message.setSubject(subject);
            
            message.setSentDate(new java.util.Date());
            
            message.setContent(content, "text/html; charset=UTF-8");
            
            Transport.send(message);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        // 발송 내역을 DB에 저장하러 간다.
        request.setAttribute("ev_requested", to);
        request.setAttribute("ev_code", ev_code);
        return "/verification/insert.do";
        
	}
	
	
	@RequestMapping("/email/customerServiceSend.do")
	public String CustomerServiceSend(HttpServletRequest request, HttpSession httpSession) {
		
		String enquirer_id = ""; // 문의자 아이디
		String enquirer_email = ""; // 문의자 이메일
		String enquiry = ""; // 문의 내용
		String rest_writer_email = ""; // 받는 사람
		
		enquirer_id = (String) httpSession.getAttribute("session_id");
		enquirer_email = request.getParameter("email");
		enquiry = request.getParameter("content");
		rest_writer_email = request.getParameter("rest_writer_email");
		        
        try {
            Session session = Session.getInstance(properties,
                    new javax.mail.Authenticator() {
                        protected PasswordAuthentication getPasswordAuthentication() {
                            return new PasswordAuthentication("kh.team6@gmail.com", "dkagh1234");
                        }
                    });                            
            
            /* 메시지 작성 */
            Message message = new MimeMessage(session);                       
        		
    		// message에 넣을 값 설정
        	from = "kh.team6@gmail.com"; // 문의하는 사람. 서버에서 메일이 발송된다고 가정한다.
    		to = rest_writer_email;
    		subject = enquirer_id + " 님이 문의하신 글입니다.";
    		/* StringBuffer를 사용해 content를 작성한다. */
    		StringBuffer sb = new StringBuffer(); // StringBuffer
    		sb.append("<img src='"+content_img_main+"'/><br/>");
    		sb.append("<br/><br/>");
    		sb.append("<b>문의 내용</b><br/>"+enquiry+"<br/>");
    		sb.append("<b>답변 메일</b> : "+enquirer_email+"<br/>");
    		sb.append(". if you're not ");
    		sb.append("<br/><hr><br/>");
    		sb.append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
    		sb.append("자주 묻는 질문 확인은 <a href='http://localhost:8000/jogiyo/listQna.action'>여기</a>를 클릭하세요.");
    		sb.append("빠른 시간내에 답변드리겠습니다. 감사합니다.<br/><hr><br/>");
    		sb.append("<img src='"+content_putter+"'/><br/>");
    		/* END StringBuffer */
    		sb.append("content");
    		content = sb.toString();           

            message.setFrom(new InternetAddress(from, MimeUtility.encodeText("조기요","UTF-8","B")));
            //message.setFrom(new InternetAddress(from));           
            
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));           
            //InternetAddress[] iAddress = {new InternetAddress(to)};            
            //message.setRecipients(Message.RecipientType.TO, iAddress);
            
            message.setSubject(subject);
            
            message.setSentDate(new java.util.Date());
            
            message.setContent(content, "text/html; charset=UTF-8");
            
            Transport.send(message);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return "/welcome.do";
		
	}	
	
}
