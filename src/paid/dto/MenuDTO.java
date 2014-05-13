package paid.dto;

public class MenuDTO
{  
    private String paid_restopt_subject; // 레스토랑의 메뉴명
    private String paid_sales_volume; // 메뉴 매출 건수
    private int paid_sales_price; //메뉴 총 매출금액 (매출금액의 합)
       
    public String getPaid_restopt_subject()
    {
        return paid_restopt_subject;
    }
    public void setPaid_restopt_subject(String paid_restopt_subject)
    {
        this.paid_restopt_subject = paid_restopt_subject;
    }
    public String getPaid_sales_volume()
    {
        return paid_sales_volume;
    }
    public void setPaid_sales_volume(String paid_sales_volume)
    {
        this.paid_sales_volume = paid_sales_volume;
    }
    public int getPaid_sales_price()
    {
        return paid_sales_price;
    }
    public void setPaid_sales_price(int paid_sales_price)
    {
        this.paid_sales_price = paid_sales_price;
    }    
}