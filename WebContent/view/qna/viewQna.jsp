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
			<h3>게시판  글보기</h3>
		</div>
		<c:set var="actionName"/>
		<c:set var="textName"/>
		<c:if test="${resultClass.qna_num ne 0}">

			<c:set var="actionName" value="updateQnaForm.do"/>
			<c:set var="textName" value="수정"/>
		</c:if>
		<c:if test="${resultClass.qna_num eq 0}">
			<c:set var="actionName" value="insertQna.do"/>
			<c:set var="textName" value="등록"/>
		</c:if>
		<div class="col-md-12 well">
		<form action="updateQnaForm.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="qna_num" value="${resultClass.qna_num }"/>
		<div class="form-group">
				<label for="qna_category"><font size="4" color="blue">카테고리:</label></font>
					<c:choose>
						<c:when test="${resultClass.qna_category eq '01' }" >회원가입</c:when>
						<c:when test="${resultClass.qna_category eq '02' }" >바로결제</c:when>
						<c:when test="${resultClass.qna_category eq '03' }" >리뷰</c:when>
						<c:when test="${resultClass.qna_category eq '04' }" >이용문의</c:when>
						<c:when test="${resultClass.qna_category eq '05' }" >광고문의</c:when>
						<c:when test="${resultClass.qna_category eq '06' }" >기타</c:when>
						<c:otherwise>전체</c:otherwise>
					</c:choose>
			</div>
			<div class="form-group">
				<label for="qna_id"><font size="4" color="black">작성자:</label></font>
				<font size="4">${resultClass.qna_id }</font>
			</div>
			<div class="form-group">
				<label for="qna_subject"><font size="4" color="green">제목:</label></font>
				<font size="4">${resultClass.qna_subject }</font>
			</div>
			<div class="form-group">
				<label for="qna_content"><font size="4" color="orange">내용:</label></font>
				<pre style="border: 0px" ><font size="4">${resultClass.qna_content }</pre></font>
			</div>
			<div class="form-group">
				<label for="qna_reply"><font size="4" color="red">답변:</label></font>
				<pre style="border: 0px" ><font size="4">${resultClass.qna_reply }</pre></font>
			</div>


			<div class="pull-right">				
				<c:if test="${session_id == resultClass.qna_id}">
					<button type="submit" class="btn btn-default">수정</button>
					<a href="deleteQna.do?qna_num=${resultClass.qna_num }" class="btn btn-default">삭제</a>
				</c:if>
				<a href="listQna.do" class="btn btn-default">목록</a>
				<c:if test="${session_id eq 'admin'}">
					<a href="deleteQna.do?qna_num=${resultClass.qna_num }" class="btn btn-default">삭제</a>
					<button type="submit" class="btn btn-primary">답변</button>					
				</c:if>	
			</div>
		</form>
		</div>
		<!-- end of test board pretty -->

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