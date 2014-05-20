<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ page isELIgnored="false" %> --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="huks">
<link rel="shortcut icon" href="assets/ico/jogiyo.png">

<title>eMenu</title>

<!-- Bootstrap core CSS -->
<link href="dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="view/jogiyo.css" rel="stylesheet">
<link href="view/common/common-template.css" rel="stylesheet">

</head>

<body>

	<!-- header -->
	<%@ include file="/view/common/header.jsp"%>
	<!-- end of header -->

	<!-- container -->
	<div class="container">

		<!-- test board pretty -->
		<div class="col-md-12">
			<h3>테스트 게시판</h3>
		</div>

		<div class="col-md-12 well">
			<table class="table table-striped table-forum">
				<thead>
					<tr>
						<th class="text-center" colspan="2">제목</th>
						<th class="text-center" style="width: 200px;">작성자</th>
						<th class="text-center" style="width: 200px;">작성일</th>
						<th class="text-center" style="width: 100px;">조회</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="list" items="${list}">			
						<c:url var="url" value="readTest.action">
							<c:param name="test_num" value="${list.test_num}"/>
							<c:param name="currentPage" value="${currentPage}"/>
						</c:url>
						<tr>
							<td colspan="2"><a href="${url}">${list.test_subject}</a></td>
							<td class="text-center">${list.test_writer_name}</td>
							<td class="text-center"><fmt:formatDate value="${list.test_reg_date}" type="date" /></td>
							<td class="text-center">${list.test_readcount}</td>
						</tr>
					</c:forEach>
					
					<c:if test="${list eq null}">
						<tr>
							<td colspan="5">등록된 게시물이 없습니다.</td>
						</tr>
					</c:if>		
					
				</tbody>
			</table>

			<div class="text-center">
				<ul class="pagination pagination-sm">
					<s:property value="pagingHtml" escape="false" />
				</ul>
			</div>

			<div class="pull-right">
				<a
					href="insertTestForm.action?currentPage=<s:property value="currentPage"/>"
					class="btn btn-primary">글쓰기</a>
			</div>

		</div>
		<!-- end of test board pretty -->

	</div>
	<!-- /.container -->


	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="dist/js/bootstrap.min.js"></script>
</body>
</html>
