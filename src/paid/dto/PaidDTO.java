package paid.dto;

import java.util.Date;

public class PaidDTO {
	
	private int paid_num;
	private int paid_rest_num;
	private String paid_rest_subject;
	private int paid_restopt_num;
	private String paid_restopt_subject;
    private int paid_restopt_priceplus;
    private String paid_restopt_destFile1;
    private String paid_cpn;
    private int paid_cpn_used;
    private String session_id;
    private Date paid_reg_date;
    
	public int getPaid_num() {
		return paid_num;
	}
	public void setPaid_num(int paid_num) {
		this.paid_num = paid_num;
	}
	public int getPaid_rest_num() {
		return paid_rest_num;
	}
	public void setPaid_rest_num(int paid_rest_num) {
		this.paid_rest_num = paid_rest_num;
	}
	public String getPaid_rest_subject() {
		return paid_rest_subject;
	}
	public void setPaid_rest_subject(String paid_rest_subject) {
		this.paid_rest_subject = paid_rest_subject;
	}
	public int getPaid_restopt_num() {
		return paid_restopt_num;
	}
	public void setPaid_restopt_num(int paid_restopt_num) {
		this.paid_restopt_num = paid_restopt_num;
	}
	public String getPaid_restopt_subject() {
		return paid_restopt_subject;
	}
	public void setPaid_restopt_subject(String paid_restopt_subject) {
		this.paid_restopt_subject = paid_restopt_subject;
	}
	public int getPaid_restopt_priceplus() {
		return paid_restopt_priceplus;
	}
	public void setPaid_restopt_priceplus(int paid_restopt_priceplus) {
		this.paid_restopt_priceplus = paid_restopt_priceplus;
	}
	public String getPaid_restopt_destFile1() {
		return paid_restopt_destFile1;
	}
	public void setPaid_restopt_destFile1(String paid_restopt_destFile1) {
		this.paid_restopt_destFile1 = paid_restopt_destFile1;
	}
	public int getPaid_cpn_used() {
		return paid_cpn_used;
	}
	public void setPaid_cpn_used(int paid_cpn_used) {
		this.paid_cpn_used = paid_cpn_used;
	}
	public String getSession_id() {
		return session_id;
	}
	public void setSession_id(String session_id) {
		this.session_id = session_id;
	}
	public Date getPaid_reg_date() {
		return paid_reg_date;
	}
	public void setPaid_reg_date(Date paid_reg_date) {
		this.paid_reg_date = paid_reg_date;
	}
	public String getPaid_cpn() {
		return paid_cpn;
	}
	public void setPaid_cpn(String paid_cpn) {
		this.paid_cpn = paid_cpn;
	}
	
}
