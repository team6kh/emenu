package review.dto;

public class PagingReviewDTO
{
    // 페이징을 위한 변수
    private String rest_num;
    private String review_rest_currentPage;
    private String review_num;
    private String ccp;
    public String getRest_num()
    {
        return rest_num;
    }
    public void setRest_num(String rest_num)
    {
        this.rest_num = rest_num;
    }
    public String getReview_rest_currentPage()
    {
        return review_rest_currentPage;
    }
    public void setReview_rest_currentPage(String review_rest_currentPage)
    {
        this.review_rest_currentPage = review_rest_currentPage;
    }
    public String getReview_num()
    {
        return review_num;
    }
    public void setReview_num(String review_num)
    {
        this.review_num = review_num;
    }
    public String getCcp()
    {
        return ccp;
    }
    public void setCcp(String ccp)
    {
        this.ccp = ccp;
    }
    
 
    
}
