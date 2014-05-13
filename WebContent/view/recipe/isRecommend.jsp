<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${isRecommend==1}">
<script type="text/javascript">
	parent.alert("이미 추천을 하였습니다~");
	parent.window.location.reload(true);
</script>
</c:if>

<c:if test="${isRecommend==0}">
<script type="text/javascript">
	parent.alert("추천에 성공하였습니다~");
	parent.window.location.reload(true);
</script>
</c:if>