<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>



<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="shortcut icon" href="/emenu/assets/ico/jogiyo.png">

<!-- Bootstrap core CSS -->
<link href="/emenu/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="/emenu/view/jogiyo.css" rel="stylesheet">
<link href="/emenu/view/common/common-template.css" rel="stylesheet">
<link href="/emenu/view/user/dashboard.css" rel="stylesheet">

<title>eMenu</title>
</head>

<body>

	<form method="post" onsubmit="confirm()">
	
		<input type="hidden" id="rest_num" name="rest_num" value="${pagingReviewDTO.rest_num}" />
		<input type="hidden" id="review_rest_currentPage" name="review_rest_currentPage" value="${pagingReviewDTO.review_rest_currentPage}" />
		<input type="hidden" id="ccp" name="ccp" value="${pagingReviewDTO.ccp}" /> 
		<input type="hidden" id="review_num" name="review_num" value="${pagingReviewDTO.review_num}" />
					
		<table class="table table-striped table-forum" style="text-align: center">
			<tr>
				<td align="center">
					<br/>
					<font size=4 color="red"><b>정말 삭제하시겠습니까?</b></font>
				</td>
			</tr>
			<tr>
				<td align="center">
					<br/>
                    <button type="submit" class="btn btn-danger">확 인</button>
                    <button type="button"class="btn btn-default" onclick="javascript:self.close()">취 소</button>
				</td>
			</tr>
		</table>
	</form>
	
	<script type="text/javascript">
		function confirm() {
			var rest_num = document.getElementById("rest_num").value;
			var review_rest_currentPage = document.getElementById("review_rest_currentPage").value;
			var ccp = document.getElementById("ccp").value;
			var review_num = document.getElementById("review_num").value;
			
			opener.window.location.href = "deleteReviewPro.do?rest_num="+rest_num+"&review_rest_currentPage="+review_rest_currentPage+"&ccp="+ccp+"&review_num="+review_num;
			self.close();
		}
	</script>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script src="/emenu/dist/js/bootstrap.min.js"></script>
</body>
</html>