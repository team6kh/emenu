<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ page isELIgnored="false" %> --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="huks">
<link rel="shortcut icon" href="/emenu/assets/ico/jogiyo.png">

<title>eMenu</title>

<!-- Bootstrap core CSS -->
<link href="/emenu/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="/emenu/view/jogiyo.css" rel="stylesheet">
<link href="/emenu/view/user/login/signin.css" rel="stylesheet">

</head>

<body>

	<!-- header -->
	<%@ include file="/view/common/header.jsp"%>
	<!-- /.header -->

	<!-- container -->
	<div class="container">

		<form class="form-signin" action="/emenu/user/login.do" method="post">
		
			<h2 class="form-signin-heading">조기요...</h2>
			
			<select class="form-control" name="login_type">
				<option value="buyer">구매자</option>
				<option value="seller">판매자</option>
				<option value="admin">관리자</option>
			</select>
			<input type="text" class="form-control" placeholder="아이디" name="login_id" required autofocus>
			<input type="password" class="form-control" placeholder="비밀번호" name="login_pw" required>
			
			<input type="hidden" name="actionName" value="${actionName}">
			<input type="hidden" name="queryString" value="${queryString}">
			
			<button class="btn btn-lg btn-primary btn-block" type="submit">로그인</button>
			
		</form>

	</div>
	<!-- /.container -->

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="/emenu/dist/js/bootstrap.min.js"></script>
</body>
</html>
