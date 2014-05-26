<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${isSuccess==1}">
<script type="text/javascript">
	parent.alert("인증성공");
	
//	var url = parent.location.href;
//	if (url.indexOf('?') != -1) {
//		url += '&actionStatus=evSuccess';
//	} else {
//		url += '?actionStatus=evSuccess';
//	}
//	parent.location.href = url;
	
	//parent.location.reload();
	// 'true' keyword to force the reloaded page to come form the server (instead of cache)
	
	var url = "/emenu/user/get.do?user_type=${user_type}&user_id=${user_id}&actionStatus=evSuccess";
	//parent.alert(url);
	parent.location.href = url;
</script>
</c:if>

<c:if test="${isSuccess==0}">
<script type="text/javascript">
	parent.alert("인증실패");
</script>
</c:if>