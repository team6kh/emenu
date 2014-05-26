package claim.dto;

public class SearchClaimDTO
{
    private String board_name; // 신고된 글의 게시판명
    private int article_num; // 신고된 글의 글번호
    
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
    
    
    
    
}
