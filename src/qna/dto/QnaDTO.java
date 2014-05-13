package qna.dto;

public class QnaDTO {
    private int qna_num;
    private String qna_id;
    private String qna_subject;
   
    private String qna_category;
    private String qna_content;
    private String qna_reply;
    private int qna_readcount;
    private String qna_reg_date;
   

    public int getQna_num() {
        return qna_num;
    }
    public void setQna_num(int qna_num) {
        this.qna_num = qna_num;
    }

    public String getQna_subject() {
        return qna_subject;
    }
    public void setQna_subject(String qna_subject) {
        this.qna_subject = qna_subject;
    }
 
    public String getQna_category() {
        return qna_category;
    }
    public void setQna_category(String qna_category) {
        this.qna_category = qna_category;
    }
    public String getQna_content() {
        return qna_content;
    }
    public void setQna_content(String qna_content) {
        this.qna_content = qna_content;
    }

    public int getQna_readcount() {
        return qna_readcount;
    }
    public void setQna_readcount(int qna_readcount) {
        this.qna_readcount = qna_readcount;
    }
    public String getQna_reg_date() {
        return qna_reg_date;
    }
    public void setQna_reg_date(String qna_reg_date) {
        this.qna_reg_date = qna_reg_date;
    }
 
  
    public String getQna_id() {
		return qna_id;
	}
	public void setQna_id(String qna_id) {
		this.qna_id = qna_id;
	}

	public String getQna_reply() {
		return qna_reply;
	}
	public void setQna_reply(String qna_reply) {
		this.qna_reply = qna_reply;
	}
	@Override
    public String toString()
    {
        return "QnaDTO [qna_num=" + qna_num + ", qna_id=" + qna_id
                + ", qna_subject=" + qna_subject + ", qna_isprivate="+ ", qna_category=" + qna_category  + ", qna_content=" 
        		+ qna_content + ", qna_readcount="
                + qna_readcount + ", qna_reg_date=" + qna_reg_date
                + ", qna_ref="  + ", qna_ref_step=" + ", qna_ref_level="+ "]";
    }

}