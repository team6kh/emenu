package rest.dto;

import java.util.Date;

public class RestDTO {

	private int rest_num;
	private String rest_subject;
	private String rest_localcategory;
	private String rest_typecategory;

	private String rest_destFile1;
	private String rest_main_orgname;
	private String rest_main_savname;
	private String rest_content_orgname;
	private String rest_content_savname;

	private String rest_destFile2;
	
	private String rest_writer_id;
	private String rest_writer_name;
	private String rest_writer_telnum;
	private String rest_writer_mobilenum;
	private String rest_writer_address;
	private String rest_writer_email;
	
	private Date rest_reg_date;
	private int rest_readcount;//
		
	public String getRest_writer_email() {
		return rest_writer_email;
	}
	public void setRest_writer_email(String rest_writer_email) {
		this.rest_writer_email = rest_writer_email;
	}
	public int getRest_num() {
		return rest_num;
	}
	public void setRest_num(int rest_num) {
		this.rest_num = rest_num;
	}
	public String getRest_subject() {
		return rest_subject;
	}
	public void setRest_subject(String rest_subject) {
		this.rest_subject = rest_subject;
	}
	public String getRest_localcategory() {
		return rest_localcategory;
	}
	public void setRest_localcategory(String rest_localcategory) {
		this.rest_localcategory = rest_localcategory;
	}
	public String getRest_typecategory() {
		return rest_typecategory;
	}
	public void setRest_typecategory(String rest_typecategory) {
		this.rest_typecategory = rest_typecategory;
	}
	public String getRest_destFile1() {
		return rest_destFile1;
	}
	public void setRest_destFile1(String rest_destFile1) {
		this.rest_destFile1 = rest_destFile1;
	}
	public String getRest_main_orgname() {
		return rest_main_orgname;
	}
	public void setRest_main_orgname(String rest_main_orgname) {
		this.rest_main_orgname = rest_main_orgname;
	}
	public String getRest_main_savname() {
		return rest_main_savname;
	}
	public void setRest_main_savname(String rest_main_savname) {
		this.rest_main_savname = rest_main_savname;
	}
	public String getRest_content_orgname() {
		return rest_content_orgname;
	}
	public void setRest_content_orgname(String rest_content_orgname) {
		this.rest_content_orgname = rest_content_orgname;
	}
	public String getRest_content_savname() {
		return rest_content_savname;
	}
	public void setRest_content_savname(String rest_content_savname) {
		this.rest_content_savname = rest_content_savname;
	}
	public String getRest_destFile2() {
		return rest_destFile2;
	}
	public void setRest_destFile2(String rest_destFile2) {
		this.rest_destFile2 = rest_destFile2;
	}
	public String getRest_writer_id() {
		return rest_writer_id;
	}
	public void setRest_writer_id(String rest_writer_id) {
		this.rest_writer_id = rest_writer_id;
	}
	public String getRest_writer_name() {
		return rest_writer_name;
	}
	public void setRest_writer_name(String rest_writer_name) {
		this.rest_writer_name = rest_writer_name;
	}
	public String getRest_writer_telnum() {
		return rest_writer_telnum;
	}
	public void setRest_writer_telnum(String rest_writer_telnum) {
		this.rest_writer_telnum = rest_writer_telnum;
	}
	public String getRest_writer_mobilenum() {
		return rest_writer_mobilenum;
	}
	public void setRest_writer_mobilenum(String rest_writer_mobilenum) {
		this.rest_writer_mobilenum = rest_writer_mobilenum;
	}
	public String getRest_writer_address() {
		return rest_writer_address;
	}
	public void setRest_writer_address(String rest_writer_address) {
		this.rest_writer_address = rest_writer_address;
	}
	public Date getRest_reg_date() {
		return rest_reg_date;
	}
	public void setRest_reg_date(Date rest_reg_date) {
		this.rest_reg_date = rest_reg_date;
	}
	public int getRest_readcount() {
		return rest_readcount;
	}
	public void setRest_readcount(int rest_readcount) {
		this.rest_readcount = rest_readcount;
	}
}