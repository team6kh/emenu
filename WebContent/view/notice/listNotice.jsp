<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ page isELIgnored="false" %> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
	<form>
		<div class="container">
			<div class="col-md-12">
				<h3>공지사항</h3>
			</div>

			<div class="col-md-12 well">
				<table class="table table-striped">
					<thead>
						<tr bgcolor="#F3F3F3" align="center">
							<th class="text-center" style="width: 100px;">번호</th>
							<th class="text-center" style="width: 450px;">제목</th>
							<th class="text-center" style="width: 150px;">날짜</th>
							<th class="text-center" style="width: 100px;">조회</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach var="list" items="${list }">
							<c:url var="readNoticeURL" value="readNotice.do">
								<c:param name="notice_num" value="${list.notice_num }" />
								<c:param name="currentPage" value="${currentPage }" />
								<c:param name="rnum" value="${list.rnum }" />
							</c:url>

							<tr bgcolor="#FFFFFF" align="center">
								<td>${list.rnum }</td>
								<td align="left">&nbsp;<a href=${readNoticeURL}>
										<c:if test="${list.notice_headtag == '-----------------' }">
											<font color="orange" size="3">${list.notice_subject }</font>
										</c:if>
										<c:if test="${list.notice_headtag == '[공지]' }">
											<font color="blue" size="3"> ${list.notice_headtag }&nbsp; 
												${list.notice_subject }</font>
										</c:if>
										<c:if test="${list.notice_headtag == '[이벤트]' }">
											<font color="green" size="3"> ${list.notice_headtag }&nbsp;
												${list.notice_subject }</font>
										</c:if>
										<c:if test="${list.notice_headtag == '[스마트팁]' }">
											<font color="red" size="3"> ${list.notice_headtag }&nbsp;
												${list.notice_subject }</font>
										</c:if>
									</a></td>
								<td align="center"><fmt:formatDate value="${list.notice_reg_date}" pattern="yyyy-MM-dd HH:mm"/></td>
								<td>${list.notice_readcount }</td>
							</tr>
						</c:forEach>

						<c:if test="list.size() <= 0">
							<tr bgcolor="#FFFFFF" align="center">
								<td colspan="4">등록된 게시물이 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>

				<div class="text-center">
					<ul class="pagination pagination-sm">
						${pagingHtml }
					</ul>
				</div>

				<div id="gotop"></div>
				<c:if test="${session_id eq 'admin'}">
					<div class="pull-right">
						<a href="insertNoticeForm.do?currentPage=${currentPage }"
							class="btn btn-primary">글쓰기</a>
					</div>
				</c:if>
			</div>

		</div>
		<!-- /.container -->
	</form>

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="dist/js/bootstrap.min.js"></script>
</body>
</html>