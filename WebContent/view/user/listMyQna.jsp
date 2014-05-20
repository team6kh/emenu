<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ page isELIgnored="false" %> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="shortcut icon" href="/emenu/assets/ico/jogiyo.png">

<title>JOGIYO</title>

<!-- Bootstrap core CSS -->
<link href="/emenu/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="/emenu/view/jogiyo.css" rel="stylesheet">
<link href="/emenu/view/user/dashboard.css" rel="stylesheet">
<link href="/emenu/view/common/common-template.css" rel="stylesheet">
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
					<li><a href="/emenu/cartboard.do">장바구니</a></li>
					<li><a href="/emenu/user/listMyRecipe.do">마이 레시피</a></li>
					<li class="active"><a href="/emenu/user/listMyQna.do?session_id=${session_id}">마이 문의하기</a></li>
				</ul>
			</div>
			<!-- /.sidebar -->

			<!-- main -->
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">						

				<div class="col-md-12">
					<h3>마이 문의하기</h3>
				</div>				

				<!-- col-md-12 well -->
				<div class="col-md-12">
					<table class="table">
						<thead>
							<tr>
								<th class="text-center" style="width: 100px;">번호</th>
								<th class="text-center" style="width: 100px;">카테고리</th>
								<th class="text-center" style="width: 100px;">제목</th>
								<th class="text-center" style="width: 100px;">작성일</th>
								<th class="text-center" style="width: 100px;">조회수</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="list" items="${list }">
								<tr>
									<td class="text-center"><c:out value="${list.qna_num }" />
									</td>
									<td class="text-center"><c:choose>
											<c:when test="${list.qna_category eq '01' }">회원가입</c:when>
											<c:when test="${list.qna_category eq '02' }">바로결제</c:when>
											<c:when test="${list.qna_category eq '03' }">리뷰</c:when>
											<c:when test="${list.qna_category eq '04' }">이용문의</c:when>
											<c:when test="${list.qna_category eq '05' }">광고문의</c:when>
											<c:when test="${list.qna_category eq '06' }">기타</c:when>
											<c:otherwise>전체</c:otherwise>
										</c:choose></td>
									<td class="text-left">

									<a href="/emenu/getQna.do?qna_num=${list.qna_num }"> 
										<c:out value="${list.qna_subject }" />
									</a></td>
									<td class="text-center"><c:out
											value="${list.qna_reg_date }" /></td>
									<td class="text-center"><c:out
											value="${list.qna_readcount }" /></td>
								</tr>
							</c:forEach>
							<c:if test="${empty list}">
								<tr>
									<td colspan="5">등록된 게시물이 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>

					<div class="text-center">
						<ul class="pagination pagination-sm">
							${pagingHtml }
						</ul>
					</div>

					<!-- <div class="pull-right">
						<a href="insertQnaForm.action" class="btn btn-primary">글쓰기</a>
					</div> -->

				</div>
				<!-- /.col-md-12 well -->

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
	<script src="/emenu/dist/js/bootstrap.min.js"></script>
</body>
</html>