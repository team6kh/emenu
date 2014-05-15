<%@ page import="java.util.*,java.text.*,java.net.*" contentType="text/html; charset=utf-8" %>
<%@ page import="java.security.MessageDigest" %>

<%
request.setCharacterEncoding("UTF-8");
%>

<script language=javascript>//"지불처리중"팝업창 닫는 부분 (AGS_pay.html에서 submit 전에 띄운 팝업 창을 닫는 스크립트)
	var openwin = window.open("AGS_progress.html","popup","width=300,height=160");
	openwin.close();
</script>

<%
	String rOrdNo = request.getParameter("rOrdNo");	
	String session_id = (String)session.getAttribute("session_id");
	response.sendRedirect("../payRestResult.do?rest_num="+rOrdNo+"&session_id="+session_id);
%>

