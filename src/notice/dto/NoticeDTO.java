package notice.dto;

import java.util.Date;

public class NoticeDTO {

	private int notice_num;
	private String notice_headtag;
	private String notice_subject;
	private String notice_content;
	private Date notice_reg_date;
	private int notice_readcount;
	private int rnum;	

    public int getRnum() {
        return rnum;
    }
    public void setRnum(int rnum) {
        this.rnum = rnum;
    }
    public int getNotice_num() {
		return notice_num;
	}
	public void setNotice_num(int notice_num) {
		this.notice_num = notice_num;
	}
	public String getNotice_headtag() {
		return notice_headtag;
	}
	public void setNotice_headtag(String notice_headtag) {
		this.notice_headtag = notice_headtag;
	}
	public String getNotice_subject() {
		return notice_subject;
	}
	public void setNotice_subject(String notice_subject) {
		this.notice_subject = notice_subject;
	}
	public String getNotice_content() {
		return notice_content;
	}
	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}
	public Date getNotice_reg_date() {
		return notice_reg_date;
	}
	public void setNotice_reg_date(Date notice_reg_date) {
		this.notice_reg_date = notice_reg_date;
	}
	public int getNotice_readcount() {
		return notice_readcount;
	}
	public void setNotice_readcount(int notice_readcount) {
		this.notice_readcount = notice_readcount;
	}
}
