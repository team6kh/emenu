package user.buyer.dto;

import java.util.Date;

public class BuyerDTO
{
    private int user_seq;
    private String buyer_id;
    private String buyer_pw;
    private String buyer_name;
    private Date buyer_reg_date;
    private String buyer_email;
    private String buyer_mobilenum;
    private String buyer_verification;

    public int getUser_seq()
    {
        return user_seq;
    }

    public void setUser_seq(int user_seq)
    {
        this.user_seq = user_seq;
    }

    public String getBuyer_id()
    {
        return buyer_id;
    }

    public void setBuyer_id(String buyer_id)
    {
        this.buyer_id = buyer_id;
    }

    public String getBuyer_pw()
    {
        return buyer_pw;
    }

    public void setBuyer_pw(String buyer_pw)
    {
        this.buyer_pw = buyer_pw;
    }

    public String getBuyer_name()
    {
        return buyer_name;
    }

    public void setBuyer_name(String buyer_name)
    {
        this.buyer_name = buyer_name;
    }

    public Date getBuyer_reg_date()
    {
        return buyer_reg_date;
    }

    public void setBuyer_reg_date(Date buyer_reg_Date)
    {
        this.buyer_reg_date = buyer_reg_Date;
    }

    public String getBuyer_email()
    {
        return buyer_email;
    }

    public void setBuyer_email(String buyer_email)
    {
        this.buyer_email = buyer_email;
    }

    public String getBuyer_mobilenum()
    {
        return buyer_mobilenum;
    }

    public void setBuyer_mobilenum(String buyer_mobilenum)
    {
        this.buyer_mobilenum = buyer_mobilenum;
    }

    public String getBuyer_verification()
    {
        return buyer_verification;
    }

    public void setBuyer_verification(String buyer_verification)
    {
        this.buyer_verification = buyer_verification;
    }
    
}
