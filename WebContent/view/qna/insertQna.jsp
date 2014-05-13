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
<script type="text/javascript">
	function fn_checkLogin(){
		if("${session_id}" == '') {
			alert("!로그인 하셔야 글을 쓰실 수 있습니다.");
			window.location.href= "listQna.action";
		}
	}
</script>
</head>

<body onload="fn_checkLogin();">

	<!-- header -->
	<%@ include file="/view/common/header.jsp"%>
	<!-- end of header -->

	<!-- container -->
	<div class="container">

		<!-- test form pretty -->
		<div class="col-md-12">
			<h3>글쓰기</h3>
		</div>
		<c:set var="actionName"/>
		<c:set var="textName"/>
		<c:if test="${resultClass.qna_num ne 0}">
			<c:set var="actionName" value="updateQna.action"/>
			<c:set var="textName" value="수정"/>
		</c:if>
		<c:if test="${resultClass.qna_num eq 0}">
			<c:set var="actionName" value="insertQna.action"/>
			<c:set var="textName" value="등록"/>
		</c:if>
		<div class="col-md-12 well">
		<form action="${actionName }" method="post" enctype="multipart/form-data">
		<input type="hidden" name="qna_num" value="${resultClass.qna_num }"/>

			<input type="hidden" name="qna_id" value="${session_id}"/>
	
			<div class="form-group">
				<label for="qna_category">카테고리</label>
				<select name="qna_category" id="qna_category">
					<option value="">전체</option>
					<option value="01" <c:if test="${resultClass.qna_category eq '01'}">selected</c:if>>회원가입</option>
					<option value="02" <c:if test="${resultClass.qna_category eq '02'}">selected</c:if>>바로결제</option>
					<option value="03" <c:if test="${resultClass.qna_category eq '03'}">selected</c:if>>리뷰</option>
					<option value="04" <c:if test="${resultClass.qna_category eq '04'}">selected</c:if>>이용문의</option>
					<option value="05" <c:if test="${resultClass.qna_category eq '05'}">selected</c:if>>광고문의</option>
					<option value="06" <c:if test="${resultClass.qna_category eq '06'}">selected</c:if>>기타</option>
				</select>
			</div>
			
			<div class="form-group">
				<label for="qna_subject">제목</label>
				<input type="text" class="form-control" name="qna_subject" maxlength="60" placeholder="60자 이하로 작성해 주세요" value="${resultClass.qna_subject }" required>
			</div>
			<div class="form-group">
				<label for="qna_content">글내용</label>
				<textarea class="form-control" rows="3" id="qna_content" name="qna_content" maxlength="4000" placeholder="4000자 이하로 작성해 주세요" required>${resultClass.qna_content }</textarea>
			</div>
			<div class="form-group">
				<c:if test="${session_id eq 'admin'}">				
				<label for="qna_reply">답변글</label>
				<textarea class="form-control" rows="3" id="qna_reply" name="qna_reply" maxlength="2000" placeholder="2000자 이하로 작성해 주세요" required>${resultClass.qna_reply }</textarea>
			</div></c:if>
			<div class="pull-right">
				<a href="listQna.action" class="btn btn-default">글목록</a>
				<button type="submit" class="btn btn-primary">${textName }</button>				
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
