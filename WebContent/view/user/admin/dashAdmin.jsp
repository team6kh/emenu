<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ page isELIgnored="false" %> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="huks">
<link rel="shortcut icon" href="assets/ico/jogiyo.png">

<title>JOGIYO</title>

<!-- Bootstrap core CSS -->
<link href="dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="view/jogiyo.css" rel="stylesheet">
<link href="view/common/common-template.css" rel="stylesheet">
<link href="view/user/dashboard.css" rel="stylesheet">

</head>

<body>

	<!-- header -->
	<%@ include file="/view/common/header.jsp"%>
	<!-- END of header -->

	<!-- container -->
	<div class="container">

		<!-- Administrator's Dashboard -->
		<div class="dash-admin"><!-- CSS 미지정 -->

          <h1 class="page-header">관리자 대시보드</h1>      
          
          <!-- placeholders -->
          <div class="row placeholders">
            	<!-- 상품 개수 -->
				<div class="col-xs-6 col-sm-3 placeholder">
					<h1>${countRest}</h1>
					<span class="text-muted">상품 개수</span>
				</div>
				<!-- 메뉴 개수 -->
				<div class="col-xs-6 col-sm-3 placeholder">
					<h1>${countRestopt}</h1>
					<span class="text-muted">메뉴 개수</span>
				</div>
				<!-- 결재 건수 -->
				<div class="col-xs-6 col-sm-3 placeholder">
					<h1>${countPaid}</h1>
					<span class="text-muted">결재 건수</span>
				</div>
				<!-- 리뷰 개수 -->
				<div class="col-xs-6 col-sm-3 placeholder">
					<h1>${countReview}</h1>
					<span class="text-muted">리뷰 개수</span>
				</div>
				<!-- 레시피 개수 -->
				<div class="col-xs-6 col-sm-3 placeholder">
					<h1>${countRecipe}</h1>
					<span class="text-muted">레시피 개수</span>
				</div>
				<!-- 공지사항 글 개수 -->
				<div class="col-xs-6 col-sm-3 placeholder">
					<h1>${countNotice}</h1>
					<span class="text-muted">공지사항 글 개수</span>
				</div>
				<!-- 문의하기 글 개수 -->
				<div class="col-xs-6 col-sm-3 placeholder">
					<h1>${countQna}</h1>
					<span class="text-muted">문의하기 글 개수</span>
				</div>
				<!-- 구매자 수 -->
				<div class="col-xs-6 col-sm-3 placeholder">
					<h1>${countBuyer}</h1>
					<span class="text-muted">구매자 수</span>
				</div>
				<!-- 판매자 수 -->
				<div class="col-xs-6 col-sm-3 placeholder">
					<h1>${countSeller}</h1>
					<span class="text-muted">판매자 수</span>
				</div>
          </div>
          <!-- /placeholders -->          

		  <!-- 구매자 현황 -->
          <h2 class="sub-header">구매자 현황</h2>
          <div class="table-responsive">
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>user_seq</th>
                  <th>buyer_id</th>
                  <th>buyer_pw</th>
                  <th>buyer_name</th>
                  <th>buyer_email</th>
                  <th>buyer_verification</th>
                  <th>buyer_reg_date</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="listBuyer" items="${listBuyer}">
                <tr>
                  <td>${listBuyer.user_seq}</td>
                  <td>${listBuyer.buyer_id}</td>
                  <td>${listBuyer.buyer_pw}</td>
                  <td>${listBuyer.buyer_name}</td>
                  <td>${listBuyer.buyer_email}</td>
                  <td>${listBuyer.buyer_verification}</td>
                  <td>${listBuyer.buyer_reg_date}</td>
                </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
          <!-- 구매자 현황 끝 -->
          
          <!-- 판매자 현황 -->
          <h2 class="sub-header">판매자 현황</h2>
          <div class="table-responsive">
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>user_seq</th>
                  <th>seller_id</th>
                  <th>seller_pw</th>
                  <th>seller_name</th>
                  <th>seller_rest_name</th>
                  <th>seller_rest_address</th>
                  <th>seller_email</th>
                  <th>seller_verification</th>                  
                  <th>seller_reg_date</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="listSeller" items="${listSeller}">
                <tr>
                  <td>${listSeller.user_seq}</td>
                  <td>${listSeller.seller_id}</td>
                  <td>${listSeller.seller_pw}</td>
                  <td>${listSeller.seller_name}</td>
                  <td>${listSeller.seller_rest_name}</td>
                  <td>${listSeller.seller_rest_address}</td>
                  <td>${listSeller.seller_email}</td>
                  <td>${listSeller.seller_verification}</td>                  
                  <td>${listSeller.seller_reg_date}</td>
                </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
          <!-- 구매자 현황 끝 -->
          
		</div>
		<!-- END of Administrator's Dashboard -->

	</div>
	<!-- /.container -->


	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="dist/js/bootstrap.min.js"></script>
</body>
</html>