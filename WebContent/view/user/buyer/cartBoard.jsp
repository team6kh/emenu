<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ page isELIgnored="false" %> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="shortcut icon" href="assets/ico/jogiyo.png">

<title>eMenu</title>

<!-- Bootstrap core CSS -->
<link href="/emenu/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="/emenu/view/jogiyo.css" rel="stylesheet">
<link href="/emenu/view/user/dashboard.css" rel="stylesheet">
<link href="/emenu/view/common/common-template.css" rel="stylesheet">

<!-- 스크립트 -->
<script type="text/javascript">
	function searchtype() {
		var sel = document.getElementById("recipe_search_target").value;
		var frm = document.getElementById("recipe_search_input");

		if ((sel == "recipe_time" || sel == "recipe_price")) {
			frm.innerHTML = "<input type=text name=key1>~<input type=text name=key2><input type=submit value=검색>";
		} else if ((sel == "recipe_subject,content" || sel == "recipe_foodkind")) {
			frm.innerHTML = "<input type=text name=key1><input type=submit value=검색>";
		} else if ((sel == "recipe_searchselect")) {
			frm.innerHTML = "<input type=submit value=검색>";
		}

	}

	function detailsearch() {
		var sel = document.getElementById("recipe_search_target").value;

		if (sel == "recipe_detailsearch") {
			document.getElementById('detailsearch').style.display = "block";
		} else if (sel == "null") {
			document.getElementById('detailsearch').style.display = "none";
		}
	}

	function recipe_readcountarray() {
		//var click = false;
		//if(click==false){

		//click = true;
		document.location.href = 'readcountRecipeDesc.action';
		//}if(click==true){
		//	click = false;
		//	window.location.href='readcountRecipeAsc.action';
		//}
	}

	function recipe_timearray() {
		document.location.href = 'timeRecipeDesc.action';
	}

	function recipe_pricearray() {
		document.location.href = 'priceRecipeDesc.action';
	}
</script>
<!-- 스크립트 끝 -->

</head>

<body>

	<!-- header -->
	<%@ include file="/view/common/header.jsp"%>
	<!-- /.header -->

	<!-- container -->
	<div class="container-fluid">
		<!-- row -->
		<div class="row">

			<!-- sidebar -->
			<div class="col-sm-3 col-md-2 sidebar">
				<ul class="nav nav-sidebar">
					<li><a href="/emenu/user/get.do?user_type=${session_type}&user_id=${session_id}">회원정보</a></li>
					<li>
						<c:if test="${sessionScope.session_type=='buyer'}"><!-- 구매자일시 -->
							<a href="/emenu/user/buyer/dashboard.do?session_id=${session_id}">구매목록</a>
						</c:if>
					</li>
					<li class="active"><a href="/emenu/cartboard.do">장바구니</a></li>
					<li><a href="/emenu/user/listMyRecipe.do">마이 레시피</a></li>
					<li><a href="/emenu/user/listMyQna.do?session_id=${session_id}">마이 문의하기</a></li>
				</ul>
			</div>
			<!-- /.sidebar -->

			<!-- main -->
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

					<!-- 게시판 윗부분 -->
					<div class="col-md-12">
						<h3>마이 카트</h3>
					</div>
					<!-- /.게시판 윗부분 -->

					<!-- 게시판 바디 -->
					<div class="col-md-12">
						<table class="table">
							<tr align="center" bgcolor="">
								<td><strong>상품번호</strong></td>
								<td><strong>상호명</strong></td>
								<td><strong>옵션사진</strong></td>
								<td><strong>옵션명</strong></td>
								<td><strong>가격</strong></td>
							</tr>

							<c:forEach var="list" items="${list}" >
								<tr bgcolor="#FFFFFF" align="center">
									<td align="center">${list.cart_rest_num}</td>
									<td align="center"><a href="/emenu/readRest.do?rest_num=${list.cart_rest_num}">${list.cart_rest_subject}</a></td>
									<td align="center"><a href="/emenu/readRest.do?rest_num=${list.cart_rest_num}"><img src="/emenu/${list.cart_restopt_destFile1}" alt="N/A" class="img-responsive" style="min-height:40px;height:40px;"></a></td>
									<td align="center"><a href="/emenu/readRest.do?rest_num=${list.cart_rest_num}">${list.cart_restopt_subject}</a></td>
									<td align="center">${list.cart_restopt_priceplus}</td>
								</tr>
							</c:forEach>

							<c:if test="list.size() <= 0">
								<tr bgcolor="#FFFFFF" align="center">
									<td colspan="10">장바구니에 담은 물품이 없습니다.</td>
								</tr>
								<tr bgcolor="#777777">
									<td height="1" colspan="10"></td>
								</tr>
							</c:if>
						</table>
					</div>
					<!-- /.게시판 바디 -->

					<!-- 페이징 -->
					<div class="text-center">
						<ul class="pagination pagination-sm">
							${pagingHtml}
						</ul>
					</div>
					<!-- /페이징 -->

			</div>
			<!-- /.main -->

		</div>
		<!-- /.row -->

	</div>
	<!-- /.container -->

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="dist/js/bootstrap.min.js"></script>
</body>
</html>