package test.action;

import com.opensymphony.xwork2.Action;

public class PageTestAction implements Action
{
    // 로그인 전 페이지로 돌아가기 위해 필요합니다. 예) 리뷰에서 로그인 실행 후 다시 리뷰.
    private String actionName = "pageTest";

    public String execute() throws Exception
    {
        return SUCCESS;
    }

    public String getActionName()
    {
        return actionName;
    }
    
}
