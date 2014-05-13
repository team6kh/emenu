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
<link rel="shortcut icon" href="assets/ico/jogiyo.png">

<title>JOGIYO</title>

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

		<!-- test form pretty -->
		<div class="col-md-12">
			<h3>테스트 게시판 > 글쓰기</h3>
		</div>

		<div class="col-md-12 well">
			<form action="insertTest.action" method="post" enctype="multipart/form-data">
				<div class="form-group">
					<label>제목</label>
					<input type="text" class="form-control" name="test_subject" placeholder="제목" required>
				</div>
				<c:if test="${session_name eq null}">
				<div class="form-group">
					<label>작성자</label>
					<input type="text" class="form-control" name="test_writer_name" placeholder="작성자" required>
				</div>
				</c:if>
				<c:if test="${session_name ne null}">
				<div class="form-horizontal">
					<div class="form-group">
	    				<label class="col-sm-1 control-label">작성자</label>
	    				<div class="col-sm-11">
	      					<p class="form-control-static">${session_name}</p>
	      					<input type="hidden" name="test_writer_name" value="${session_name}">
	    				</div>
	 			 	</div>
	 			</div>					
				</c:if>			
				<c:if test="${session_pw eq null}">
				<div class="form-group">
					<label for="test_writer_pw">비밀번호</label>
					<input type="password" class="form-control" name="test_writer_pw" placeholder="비밀번호" required>
				</div>
				</c:if>
				<c:if test="${session_pw ne null}">
				<input type="hidden" name="test_writer_pw" value="${session_pw}">
				</c:if>
				<div class="form-group">
					<label for="test_content">내용</label>
					<textarea class="form-control" rows="3" id="test_content" name="test_content" required></textarea>
				</div>

				<div class="pull-right">
					<button type="submit" class="btn btn-primary">글쓰기</button>
					<a href="listTest.action?currentPage=${currentPage}" class="btn btn-default">목록</a>
				</div>
			</form>

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
