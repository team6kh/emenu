package common;

import java.io.Reader;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

public class ConDAOInterceptor implements Interceptor
{
    Reader reader = null;
    SqlMapClient sqlMapper = null;

    public void init()
    {
        try{
            // sqlMapConfig.xml 파일의 설정내용을 가져온다.
            reader = Resources.getResourceAsReader("sqlMapConfig.xml");
            // sqlMapConfig.xml의 SQL맵만 다시 읽어들임 = DAO
            sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
            reader.close();
        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    public void destroy()
    {
        sqlMapper = null;
    }

    public String intercept(ActionInvocation invocation) throws Exception
    {
        Object action = invocation.getAction(); // 액션의 객체 생성
        
        // 액션의 메서드가 Aware과 인터페이스 구현관계에 있으면
        if (action instanceof ConDAOAware)
        { 
            ConDAOAware conDAOAware = (ConDAOAware) action;
            conDAOAware.setConDAO(sqlMapper); // 다시 액션메서드로 가서 conDAO호출함
        }
        return invocation.invoke();
    }
    
}
