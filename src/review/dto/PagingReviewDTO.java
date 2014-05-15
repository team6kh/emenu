package review.dto;

public class PagingReviewDTO
{
    // 페이징을 위한 변수
    private int rest_num;
    private int review_rest_currentPage;
    private int review_num;
    private int ccp;
    
    
    public int getRest_num()
    {
        return rest_num;
    }
    public void setRest_num(int rest_num)
    {
        this.rest_num = rest_num;
    }
    public int getReview_rest_currentPage()
    {
        return review_rest_currentPage;
    }
    public void setReview_rest_currentPage(int review_rest_currentPage)
    {
        this.review_rest_currentPage = review_rest_currentPage;
    }
    public int getReview_num()
    {
        return review_num;
    }
    public void setReview_num(int review_num)
    {
        this.review_num = review_num;
    }
   
    public int getCcp()
    {
        return ccp;
    }
    public void setCcp(int ccp)
    {
        this.ccp = ccp;
    }
  
    
}
