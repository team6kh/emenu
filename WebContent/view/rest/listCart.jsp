<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ page isELIgnored="false" %> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="shortcut icon" href="assets/ico/jogiyo.png">

<!-- Bootstrap core CSS -->
<link href="dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom styles for this template -->
<link href="jogiyo.css" rel="stylesheet">
<link href="common/common-template.css" rel="stylesheet">

<style type="text/css">
	body {
  		padding-top: 0px;
	}
</style>

<script type="text/javascript">
	function goPayment(form) {
		form.action = "payRest.action";
		form.submit();
		return false;
	}

	function goDelete() {
		alert("장바구니가 비워졌습니다.");
		var rest_num = document.getElementById("rest_num").value;
		var rest_subject = document.getElementById("rest_subject").value;
		var session_id = document.getElementById("session_id").value;
		var url = "deleteCart.action?rest_num="+rest_num+"&rest_subject="+rest_subject+"&session_id="+session_id;
		document.location.href=url;
		return false;
	}
</script>
</head>

<body>
<form id="cartForm" name="cartForm" target="_parent">
	<input type="hidden" id="rest_num" name="rest_num" value="${rest_num}" />
	<input type="hidden" id="rest_subject" name="rest_subject" value="${rest_subject}" />
	<input type="hidden" id="session_id" name="session_id" value="${sessionScope.session_id}" />

	<!-- 장바구니 list -->
	<c:forEach var="list" items="${list}">
		<div class="col-sm-3 col-md-2">
			<div class="thumbnail">
				<img src="${list.cart_restopt_destFile1}" alt="N/A"
					style="min-height: 100px; height: 100px;" />
				<div class="caption" align="center">
					<font color=green><b>${list.cart_restopt_subject}</b></font>&nbsp;
					${list.cart_restopt_priceplus} 원 <br />
				</div>
			</div>
		</div>
	</c:forEach>

	<!-- 장바구니 결제 버튼 -->
	<div align="center">
		<button type="button" class="btn btn-primary" onclick="goPayment(this.form)">구매하기</button>		
		<button type="button" class="btn btn-danger" onclick="goDelete()">비우기</button>
	</div>
	
</form>
</body>