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
<link href="jogiyo.css" rel="stylesheet">
<link href="common/common-template.css" rel="stylesheet">

</head>

<body>

	<!-- container -->
	<div class="container">

		<h3>비밀번호 확인</h3>

		<form action="checkRecipePwAction.do" method="post">
			<input type="hidden" id="recipe_num" name="recipe_num" value="${recipe_num}" />
			<input type="hidden" id="currentPage" name="currentPage" value="${currentPage}" />
             
			<table class="table">

				<tr>
					<td width="100">비밀번호 입력</td>
					<td width="150">
						&nbsp;&nbsp;<input type="password" name="recipe_password" maxlength="20" />
						&nbsp;&nbsp;<input name="submit" type="submit" value="확인"/>
					</td>
				</tr>

			</table>

		</form>

	</div>
	<!-- /.container -->


	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="dist/js/bootstrap.min.js"></script>
</body>
</html>