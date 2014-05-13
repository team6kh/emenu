<%@ page language="java" contentType="text/html; charset=UTF-8"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Untitled Document</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%
	String rest_num = request.getParameter("rest_num");
	String review_rest_currentPage = request.getParameter("review_rest");
	String session_id = (String)session.getAttribute("session_id");
	response.sendRedirect("readRest.action?rest_num="+rest_num+"&currentPage="+review_rest_currentPage);
%>

</head>

<body>
	
</body>
</html>


