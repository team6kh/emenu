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
			<h3>구매완료 페이지</h3>
		</div>
		
		<div class="col-md-12" align="center">
			<img src="assets/img/common/Jogiyo_paidResult.png" width="800px" height="200px">
		</div>
		
		<div class="col-md-12 well">
			<div class="col-md-2">
			</div>
			<div class="col-md-1">
				상품코드
			</div>
			<div class="col-md-3">
				상품
			</div>
			<div class="col-md-1">
				가격
			</div>
			<div class="col-md-2">
				쿠폰
			</div>
			<div class="col-md-3">
				발행일
			</div>
		
			<c:forEach var="list2" items="${list2}">
				<div class="col-md-12 well">
					<div class="col-md-2">
						<img src="${list2.paid_restopt_destFile1}" alt="N/A" style="min-height:50px;height:50px;">
					</div>
					<div class="col-md-1">
						${list2.paid_rest_num}
					</div>
					<div class="col-md-3">
						${list2.paid_rest_subject}, ${list2.paid_restopt_subject}
					</div>
					<div class="col-md-1">
						${list2.paid_restopt_priceplus}
					</div>
					<div class="col-md-2">
						 ${list2.paid_cpn}
					</div>
					<div class="col-md-3">
						${list2.paid_reg_date}
					</div>
				</div>
			</c:forEach>
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