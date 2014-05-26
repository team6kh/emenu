<%@ page import="java.util.*,java.text.*,java.net.*" contentType="text/html; charset=utf-8" %>
<%@ page import="java.security.MessageDigest" %>

<%
request.setCharacterEncoding("UTF-8");
%>


<%
	String rOrdNo = request.getParameter("rOrdNo");	
	String session_id = (String)session.getAttribute("session_id");
	response.sendRedirect("../payRestResult.do?rest_num="+rOrdNo+"&session_id="+session_id);
%>

