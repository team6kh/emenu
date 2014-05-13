package common;

import com.ibatis.sqlmap.client.SqlMapClient;

public interface ConDAOAware
{
    public void setConDAO(SqlMapClient sqlMapper);
}