package test.dto;

import java.util.Date;

public class TestDTO
{
    private int test_num;
    private String test_writer_name;
    private String test_writer_pw;
    private String test_subject;
    private String test_content;
    private int test_readcount;
    private Date test_reg_date;

    public int getTest_num()
    {
        return test_num;
    }

    public void setTest_num(int test_num)
    {
        this.test_num = test_num;
    }

    public String getTest_writer_name()
    {
        return test_writer_name;
    }

    public void setTest_writer_name(String test_writer_name)
    {
        this.test_writer_name = test_writer_name;
    }

    public String getTest_writer_pw()
    {
        return test_writer_pw;
    }

    public void setTest_writer_pw(String test_writer_pw)
    {
        this.test_writer_pw = test_writer_pw;
    }

    public String getTest_subject()
    {
        return test_subject;
    }

    public void setTest_subject(String test_subject)
    {
        this.test_subject = test_subject;
    }

    public String getTest_content()
    {
        return test_content;
    }

    public void setTest_content(String test_content)
    {
        this.test_content = test_content;
    }

    public int getTest_readcount()
    {
        return test_readcount;
    }

    public void setTest_readcount(int test_readcount)
    {
        this.test_readcount = test_readcount;
    }

    public Date getTest_reg_date()
    {
        return test_reg_date;
    }

    public void setTest_reg_date(Date test_reg_date)
    {
        this.test_reg_date = test_reg_date;
    }
    
}
