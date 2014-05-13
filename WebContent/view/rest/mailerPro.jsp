<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ page isELIgnored="false" %> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<meta http-equiv="Refresh" content="3; URL=http://localhost:8000/jogiyo/home.action"/>
<link rel="shortcut icon" href="assets/ico/jogiyo.png">


<title>JOGIYO</title>

<!-- Bootstrap core CSS -->
<link href="dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom styles for this template -->
<link href="view/jogiyo.css" rel="stylesheet">
<link href="view/common/common-template.css" rel="stylesheet">

<style type="text/css">
	html {
		height: 100%
	}
	body {
		height: 100%;
		margin: 3% 0% 0% 1.5%;
		padding: 0
	}
</style>

<body>
	<!-- header -->
	<%@ include file="/view/common/header.jsp"%>
	<!-- end of header -->
	
	<!-- container -->
	<div class="container">
		
		<div class="col-md-12">
			<h3>문의하기</h3>
		</div>
		
		<div class="col-md-12" align="center">
			<br/><br/><br/>
			<font color=green size=4 ><b>문의메일이 성공적으로 전송되었습니다. </b></font> <br/>
			
			<font color=gray size=2>3초 뒤 매인화면으로 돌아갑니다.</font>
		</div>
		
	</div>
	<!-- end of container -->
				
	
	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="dist/js/bootstrap.min.js"></script>

</body>	