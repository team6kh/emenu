package claim.dto;

import java.util.Date;

public class ClaimDTO
{
    private int claim_num; // 신고번호 (PK - 시퀀스)
    private String board_name; // 신고된 글의 게시판명
    private int article_num; // 신고된 글의 글번호
    private String article_writer; // 신고된 글의 작성자
    private String article_viewUrl; // 신고된 글 읽기 주소
    private String claimer;   // 신고자
    private String claim_category; // 신고 분류
    private String claim_reason; // 신고 사유
    private String article_delUrl; // 신고글 삭제 주소 (실제로 글을 삭제처리하진 않겠지만...........)
    private Date claim_reg_date; // 신고일
    private String claim_result; // 신고처리 결과
    
    
    public int getClaim_num()
    {
        return claim_num;
    }
    public void setClaim_num(int claim_num)
    {
        this.claim_num = claim_num;
    }
    public String getBoard_name()
    {
        return board_name;
    }
    public void setBoard_name(String board_name)
    {
        this.board_name = board_name;
    }
    public int getArticle_num()
    {
        return article_num;
    }
    public void setArticle_num(int article_num)
    {
        this.article_num = article_num;
    }
    public String getArticle_writer()
    {
        return article_writer;
    }
    public void setArticle_writer(String article_writer)
    {
        this.article_writer = article_writer;
    }
    public String getArticle_viewUrl()
    {
        return article_viewUrl;
    }
    public void setArticle_viewUrl(String article_viewUrl)
    {
        this.article_viewUrl = article_viewUrl;
    }
    public String getClaimer()
    {
        return claimer;
    }
    public void setClaimer(String claimer)
    {
        this.claimer = claimer;
    }
    public String getClaim_category()
    {
        return claim_category;
    }
    public void setClaim_category(String claim_category)
    {
        this.claim_category = claim_category;
    }
    public String getClaim_reason()
    {
        return claim_reason;
    }
    public void setClaim_reason(String claim_reason)
    {
        this.claim_reason = claim_reason;
    }
    public String getArticle_delUrl()
    {
        return article_delUrl;
    }
    public void setArticle_delUrl(String article_delUrl)
    {
        this.article_delUrl = article_delUrl;
    }
    public Date getClaim_reg_date()
    {
        return claim_reg_date;
    }
    public void setClaim_reg_date(Date claim_reg_date)
    {
        this.claim_reg_date = claim_reg_date;
    }
    public String getClaim_result()
    {
        return claim_result;
    }
    public void setClaim_result(String claim_result)
    {
        this.claim_result = claim_result;
    }
    
    
    
    
 
    
}
