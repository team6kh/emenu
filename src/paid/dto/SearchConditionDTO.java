package paid.dto;

public class SearchConditionDTO
{
    private String session_id; // 세션id
    private int rest_num; // 식당 코드
    private String startDate; // 기간 검색조건 : 시작 날짜 
    private String endDate; // 기간 검색조건 : 마지막 날짜     
    
    public String getSession_id()
    {
        return session_id;
    }
    public void setSession_id(String session_id)
    {
        this.session_id = session_id;
    }
    public int getRest_num()
    {
        return rest_num;
    }
    public void setRest_num(int rest_num)
    {
        this.rest_num = rest_num;
    }
    public String getStartDate()
    {
        return startDate;
    }
    public void setStartDate(String startDate)
    {
        this.startDate = startDate;
    }
    public String getEndDate()
    {
        return endDate;
    }
    public void setEndDate(String endDate)
    {
        this.endDate = endDate;
    }    
    
}