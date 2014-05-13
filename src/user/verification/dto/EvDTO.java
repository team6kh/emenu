package user.verification.dto;

import java.util.Date;

public class EvDTO
{
    private int ev_seq;
    private String ev_requested;
    private String ev_code;
    private Date ev_reg_date;
    
    public int getEv_seq()
    {
        return ev_seq;
    }
    public void setEv_seq(int ev_seq)
    {
        this.ev_seq = ev_seq;
    }
    public String getEv_requested()
    {
        return ev_requested;
    }
    public void setEv_requested(String ev_requested)
    {
        this.ev_requested = ev_requested;
    }
    public String getEv_code()
    {
        return ev_code;
    }
    public void setEv_code(String ev_code)
    {
        this.ev_code = ev_code;
    }
    public Date getEv_reg_date()
    {
        return ev_reg_date;
    }
    public void setEv_reg_date(Date ev_reg_date)
    {
        this.ev_reg_date = ev_reg_date;
    }
    
}
