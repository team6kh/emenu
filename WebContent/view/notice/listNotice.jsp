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
						<s:iterator value="list" status="stat">
							<s:url id="readNoticeURL" action="readNoticeAction">
								<s:param name="notice_num">
									<s:property value="notice_num" />
								</s:param>
								<s:param name="currentPage">
									<s:property value="currentPage" />
								</s:param>
								<s:param name="rnum">
									<s:property value="rnum" />
								</s:param>
							</s:url>

							<tr bgcolor="#FFFFFF" align="center">
								<td><s:property value="rnum" /></td>
								<td align="left">&nbsp;<s:a href="%{readNoticeURL}">
										<s:if test="notice_headtag == '-----------------'">
											<font color="orange" size="3"><s:property
													value="notice_subject" /></font>
										</s:if>
										<s:elseif test="notice_headtag == '[공지]'">
											<font color="blue" size="3"> <s:property
													value="notice_headtag" />&nbsp; <s:property
													value="notice_subject" /></font>
										</s:elseif>
										<s:elseif test="notice_headtag == '[이벤트]'">
											<font color="green" size="3"> <s:property
													value="notice_headtag" />&nbsp; <s:property
													value="notice_subject" /></font>
										</s:elseif>
										<s:elseif test="notice_headtag == '[스마트팁]'">
											<font color="red" size="3"> <s:property
													value="notice_headtag" />&nbsp; <s:property
													value="notice_subject" /></font>
										</s:elseif>
									</s:a></td>
								<td align="center"><s:property value="notice_reg_date" /></td>
								<td><s:property value="notice_readcount" /></td>
							</tr>
						</s:iterator>

						<s:if test="list.size() <= 0">
							<tr bgcolor="#FFFFFF" align="center">
								<td colspan="4">등록된 게시물이 없습니다.</td>
							</tr>
						</s:if>
					</tbody>
				</table>

				<div class="text-center">
					<ul class="pagination pagination-sm">
						<s:property value="pagingHtml" escape="false" />
					</ul>
				</div>

				<div id="gotop"></div>
				<c:if test="${session_id eq 'admin'}">
					<div class="pull-right">
						<a href="insertNoticeForm.action?currentPage=<s:property value="currentPage"/>"
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