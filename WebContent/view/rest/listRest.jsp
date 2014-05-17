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
<link href="/emenu/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="/emenu/view/jogiyo.css" rel="stylesheet">
<link href="/emenu/view/common/common-template.css" rel="stylesheet">

</head>


<body>

	<!-- header -->
	<%@ include file="/view/common/header.jsp"%>
	<!-- end of header -->

	<!-- container -->
	<div class="container">
		<div class="col-md-12">
			<h3>상품</h3>
		</div>

		<div class="col-md-12 well">
			<div class="col-md-12">

			<c:forEach var="list" items="${list}">

				<c:url var="url" value="readRest.do">
					<c:param name="rest_num" value="${list.rest_num}"/>
					<c:param name="currentPage" value="${currentPage}"/>
				</c:url>			

				<div class="col-sm-4 col-md-3">					
			    	<div class="thumbnail">
			      		<a href="${url}">
			      		<img src="${list.rest_destFile1}" alt="N/A" class="img-responsive" style="min-height:125px;height:125px;">
			      		</a>
			      		<div class="caption">
			        		<h3>${list.rest_subject}</h3>
			      		</div>
			    	</div>
		      	</div>		      			      	
			</c:forEach>

			</div>

			<c:if test="${list eq null}">
			<div class="text-center">
				<p>등록된 게시물이 없습니다.</p>
			</div>
			</c:if>

			<div class="text-center">
				<ul class="pagination pagination-sm">
				<%-- 	<s:property value="pagingHtml" escape="false" /> --%>
					${ pagingHtml}
				</ul>
			</div>
			
			
			<c:if test="${sessionScope.session_type=='seller' && permission==0}">
				<div class="pull-right">
					<a href="insertRestForm.do" class="btn btn-primary">글쓰기</a>
				</div>
			</c:if>

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
