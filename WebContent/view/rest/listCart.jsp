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
		form.action = "payRest.do";
		form.submit();
		return false;
	}

	function goDelete() {
		alert("장바구니가 비워졌습니다.");
		var rest_num = document.getElementById("rest_num").value;
		var rest_subject = document.getElementById("rest_subject").value;
		var session_id = document.getElementById("session_id").value;
		var url = "deleteCart.do?rest_num="+rest_num+"&rest_subject="+rest_subject+"&session_id="+session_id;
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
			
				<img src="${list.cart_restopt_destFile1}" alt="N/A" style="min-height: 100px; height: 100px;" />
				<div class="caption" align="center">
					<font color=green size=3><b>${list.cart_restopt_subject}</b></font><br/>
					<font size=3><b>${list.cart_restopt_priceplus}원</b></font>
					<font size=2>x ${list.cart_amount}</font>
					<a href="/emenu/plusAmount.do?cart_rest_num=${list.cart_rest_num}&cart_rest_subject=${list.cart_rest_subject}&cart_restopt_subject=${list.cart_restopt_subject}" ><span class="glyphicon glyphicon-plus-sign"></span></a>
					<a href="/emenu/minusAmount.do?cart_rest_num=${list.cart_rest_num}&cart_rest_subject=${list.cart_rest_subject}&cart_restopt_subject=${list.cart_restopt_subject}" ><span class="glyphicon glyphicon-minus-sign"></span></a><br />
					<input type="hidden" name="cart_amount" value="${list.cart_amount}" />
				</div>
				
			</div>
		</div>
	</c:forEach>

	<!-- 장바구니 결제 버튼 -->
	<div align="center">
		<c:if test="${list == '[]'}">
			<button type="button" class="btn btn-primary" disabled onclick="goPayment(this.form)">구매하기</button>
			<button type="button" class="btn btn-danger" disabled onclick="goDelete()">비우기</button>
		</c:if>
		<c:if test="${list != '[]'}">
			<button type="button" class="btn btn-primary" onclick="goPayment(this.form)">구매하기</button>		
			<button type="button" class="btn btn-danger" onclick="goDelete()">비우기</button>
		</c:if>
	</div>
	
</form>
</body>