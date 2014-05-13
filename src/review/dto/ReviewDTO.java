package review.dto;

import java.util.Date;

public class ReviewDTO {
	
	private int review_num; // 리뷰글번호(PK)
	private int review_rest; // 레스토랑 코드 (FK) 
	private String review_writer; //작성자 (FK - 구매자 ID)  
	private String review_content; // 글내용
	private String review_file; // 첨부파일
	private Date review_reg_date; // 작성일
	private int review_rating; // 별점	
	
	// getter & setter
	public int getReview_num() {
		return review_num;
	}
	public void setReview_num(int review_num) {
		this.review_num = review_num;
	}
	public int getReview_rest() {
		return review_rest;
	}
	public void setReview_rest(int review_rest) {
		this.review_rest = review_rest;
	}
	public String getReview_writer() {
		return review_writer;
	}
	public void setReview_writer(String review_writer) {
		this.review_writer = review_writer;
	}
	public String getReview_content() {
		return review_content;
	}
	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}
	public String getReview_file() {
		return review_file;
	}
	public void setReview_file(String review_file) {
		this.review_file = review_file;
	}
	public Date getReview_reg_date() {
		return review_reg_date;
	}
	public void setReview_reg_date(Date review_reg_date) {
		this.review_reg_date = review_reg_date;
	}
    public int getReview_rating()
    {
        return review_rating;
    }
    public void setReview_rating(int review_rating)
    {
        this.review_rating = review_rating;
    }

}
