package common.dto;

public class EmailDTO {

	private String from; // The email address of the sender
    private String password; // The password of the above account
    private String to; // Who to send the email to?
    private String subject; // subject of the email
    private String body; // The actual email message  
    
	public String getFrom() {
		return from;
	}
	public void setFrom(String from) {
		this.from = from;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getTo() {
		return to;
	}
	public void setTo(String to) {
		this.to = to;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}   
    
}
