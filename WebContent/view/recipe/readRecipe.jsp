<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ page isELIgnored="false" %> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
<script type="text/javascript">
	function open_win_noresizable(url, name) {
		var oWin = window.open(url, name, "scrollbars=no,status=no,resizable=no,width=400,height=200");
	}
</script>
</head>

<body>

	<!-- header -->
	<%@ include file="/view/common/header.jsp"%>
	<!-- /.header -->

	<!-- container -->
	<div class="container">
		<div class="col-md-12">
			<h3>${resultClass.recipe_subject}</h3>
			<!-- 로그인 후 보이는 추천 버튼 -->
			<c:if test="${sessionScope.session_id != null}">
			<div class="pull-right">
			
				<button type="button" class="btn btn-primary" name="list" onClick="javascript:document.getElementById('isRecommend').contentWindow.location.href='recommendRecipe.do?recipe_num=${resultClass.recipe_num} &session_id=${session_id}'">
					<span class="glyphicon glyphicon-thumbs-up"></span>&nbsp;&nbsp;추천
				</button>
				<br />
				<br />
			</div>
			<iframe src="blink.html" id="isRecommend" style="display: none;"></iframe>
			</c:if>
			<!-- /.로그인 후 보이는 추천 버튼 -->	
		</div>		
			
		<input type="hidden" id="session_id" name="session_id" value="${sessionScope.session_id}" />			
		
		<!-- 컨텐츠  -->
		<div class="col-md-12">

			<!-- 테이블 바디 -->
			<table class="table table-striped">		

				<tr>
					<td class="text-center" style="width: 20%;">번호</td>
					<td>${resultClass.recipe_num}</td>
				</tr>
		
				<tr>
					<td class="text-center" style="width: 20%;">종류</td>
					<td>${resultClass.recipe_foodkind}</td>
				</tr>

				<tr>
					<td class="text-center" style="width: 20%;">작성일</td>
					<td><fmt:formatDate value="${resultClass.recipe_reg_date}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
				</tr>
			
				<tr>
					<td class="text-center" style="width: 20%;">제목</td>
					<td>${resultClass.recipe_subject}</td>
				</tr>

				<tr>
					<td class="text-center" style="width: 20%;">요리명</td>
					<td>${resultClass.recipe_foodsubject}</td>
				</tr>			

				<tr>
					<td class="text-center" style="width: 20%;">재료</td>
					<td>${resultClass.recipe_method}</td>
				</tr>				

				<tr>
					<td class="text-center" style="width: 20%;">소비 시간</td>
					<td>${resultClass.recipe_time}&nbsp;분
					</td>
				</tr>

				<tr>
					<td class="text-center" style="width: 20%;">비용</td>
					<td>${resultClass.recipe_price}&nbsp;원
					</td>
				</tr>
				
				<tr>
					<td class="text-center" style="width: 20%;">회원ID</td>
					<td>${resultClass.recipe_memberwriter}</td>
				</tr>
				
				<tr>
					<td class="text-center" style="width: 20%;">작성자</td>
					<td>${resultClass.recipe_writer}</td>
				</tr>

				<tr>
					<td class="text-center" style="width: 20%;">내용</td>
					<td colspan="3">${pagingHtml}</td>
				</tr>
				
				<tr>
					<td class="text-center" style="width: 20%;">조회수</td>
					<td>${resultClass.recipe_readcount}</td>
				</tr>

				<tr>
					<td class="text-center" style="width: 20%;">추천수</td>
					<td>${resultClass.recipe_recommend}</td>
				</tr>
				
				<tr>
					<td class="text-right" colspan="2">
						<c:url var="updateRecipeURL" value="updateRecipeForm.do">
							<c:param name="recipe_num" value="${recipe_num}"/>
						</c:url>
						<c:url var="deleteRecipeURL" value="deleteRecipe.do">
							<c:param name="recipe_num" value="${recipe_num}" />
						</c:url>
						<c:if test="${resultClass.recipe_memberwriter == NULL && session_id == null}">
							
							<input class="btn btn-default" name="list" type="button" value="수정" onClick="javascript:open_win_noresizable('checkRecipePwForm.do?recipe_num=${resultClass.recipe_num}&currentPage=${currentPage}','update')">
							<input class="btn btn-default" name="list" type="button" value="삭제" onClick="javascript:open_win_noresizable('checkRecipePwForm.do?recipe_num=${resultClass.recipe_num}&currentPage=${currentPage}','delete')">
						</c:if>
						<c:if test="${resultClass.recipe_memberwriter != NULL && resultClass.recipe_memberwriter == session_id && !(session_id eq 'admin')}">
							
							<input class="btn btn-default" name="list" type="button" value="수정" onClick="javascript:open_win_noresizable('checkRecipePwForm.do?recipe_num=${resultClass.recipe_num}&currentPage=${currentPage}','update')">
							<input class="btn btn-default" name="list" type="button" value="삭제" onClick="javascript:open_win_noresizable('checkRecipePwForm.do?recipe_num=${resultClass.recipe_num}&currentPage=${currentPage}','delete')">
						</c:if>
						<c:if test="${session_id eq 'admin'&& !(resultClass.recipe_memberwriter eq 'admin')}">
							<input class="btn btn-default" name="list" type="button" value="삭제" onClick="javascript:location.href='deleteRecipe.do?recipe_num=${resultClass.recipe_num}&currentPage=${currentPage}'">
						</c:if>
						<c:if test="${session_id eq 'admin' && resultClass.recipe_memberwriter == 'admin'}">
						
						    <input class="btn btn-default" name="list" type="button" value="수정" onClick="javascript:location.href='updateRecipeForm.do?recipe_num=${resultClass.recipe_num}&currentPage=${currentPage}'">
							<input class="btn btn-default" name="list" type="button" value="삭제" onClick="javascript:location.href='deleteRecipe.do?recipe_num=${resultClass.recipe_num}&currentPage=${currentPage}'">
						</c:if>
							<input class="btn btn-default" name="list" type="button" value="전체 목록" onClick="javascript:location.href='listRecipe.do?currentPage=${currentPage}'">
						<c:if test="${session_id != null}">
						    <input class="btn btn-default" name="list" type="button" value="마이레시피 목록" onClick="javascript:location.href='/emenu/user/listMyRecipe.do?session_id=${session_id}'">
						</c:if>
					</td>
				</tr>

			</table>
			<!-- /.테이블 바디 -->
		
		</div>			
		<!-- /.컨텐츠 -->			

	</div>
	<!-- /.container -->

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="dist/js/bootstrap.min.js"></script>
</body>
</html>