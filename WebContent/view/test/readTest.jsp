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

		<!-- test form pretty -->
		<div class="col-md-12">
			<h3>테스트 게시판 > 읽기</h3>
		</div>

		<div class="col-md-12 well">

			<table class="table table-striped table-forum">
				<thead>
					<tr>
						<th colspan="2">${testDTO.test_subject}</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="text-center">
							<span class="glyphicon glyphicon-user"></span> &nbsp; <strong>${testDTO.test_writer_name}</strong></td>
						<td>등록일 : <em>${testDTO.test_reg_date}</em></td>
					</tr>
					<tr>
						<td class="text-center" style="width: 12%;">
							<!-- 공백 -->
						</td>
						<td>
							<p>이 글의 비밀번호는 ${testDTO.test_writer_pw} 입니다. 밑에서부터는 글 내용입니다.</p>
							<p>${testDTO.test_content}</p>
						</td>
					</tr>
					<!-- end Post -->

				</tbody>
			</table>

			<div class="pull-right">

				<!-- Button trigger modal : 수정 -->
				<button class="btn btn-default insertModalParam" data-toggle="modal"
					data-target="#checkModal" data-id="updateTestForm">수정</button>
					
				<!-- Button trigger modal : 삭제 -->
				<button class="btn btn-default insertModalParam" data-toggle="modal"
					data-target="#checkModal" data-id="deleteTest">삭제</button>

				<!-- Modal -->
				<div class="modal fade" id="checkModal" tabindex="-1" role="dialog" aria-labelledby="checkModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<form action="checkPass.action" method="post">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
									<h4 class="modal-title" id="checkModalLabel">비밀번호를 입력하세요.</h4>
								</div>
								<div class="modal-body">
									<div class="form-group">
										<label>비밀번호</label>
										<input type="password" class="form-control" name="modalParam_pw">										
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>		
									<input type="hidden" name="modalParam" id="modalParam">						
									<input type="hidden" name="modalParam_key" value="${test_num}">
									<input type="hidden" name="currentPage" value="${currentPage}">									
									<button type="submit" class="btn btn-primary">입력</button>
								</div>
							</form>
						</div>
					</div>
				</div><!-- END of Modal -->			

				<a href="listTest.action?currentPage=${currentPage}" class="btn btn-default">목록</a>
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
	<script>
		$(document).on("click", ".insertModalParam", function() {
			var thisModalParam = $(this).data('id');
			$(".modal-footer #modalParam").val(thisModalParam);
		});
	</script>
</body>
</html>
