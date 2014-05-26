package claim.dto;

public class UpdateClaimDTO
{
    private int claim_num; // 신고번호 (PK - 시퀀스)
    private String board_name; // 신고된 글의 게시판명
    private int article_num; // 신고된 글의 글번호
    private String article_delUrl; // 신고글 삭제 주소
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
    public String getClaim_result()
    {
        return claim_result;
    }
    public void setClaim_result(String claim_result)
    {
        this.claim_result = claim_result;
    }
    public String getArticle_delUrl()
    {
        return article_delUrl;
    }
    public void setArticle_delUrl(String article_delUrl)
    {
        this.article_delUrl = article_delUrl;
    }
    
   
    
}
