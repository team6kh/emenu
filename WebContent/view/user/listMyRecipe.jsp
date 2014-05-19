<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ page isELIgnored="false" %> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<link href="/emenu/view/user/dashboard.css" rel="stylesheet">
<link href="/emenu/view/common/common-template.css" rel="stylesheet">

<!-- 스크립트 -->
<script type="text/javascript">
	function searchtype() {
		var sel = document.getElementById("recipe_search_target").value;
		var frm = document.getElementById("recipe_search_input");

		if ((sel == "recipe_time" || sel == "recipe_price")) {
			frm.innerHTML = "<input type=text name=key1>~<input type=text name=key2><input type=submit value=검색>";
		} else if ((sel == "recipe_subject,content" || sel == "recipe_foodkind")) {
			frm.innerHTML = "<input type=text name=key1><input type=submit value=검색>";
		} else if ((sel == "recipe_searchselect")) {
			frm.innerHTML = "<input type=submit value=검색>";
		}

	}

	function detailsearch() {
		var sel = document.getElementById("recipe_search_target").value;

		if (sel == "recipe_detailsearch") {
			document.getElementById('detailsearch').style.display = "block";
		} else if (sel == "null") {
			document.getElementById('detailsearch').style.display = "none";
		}
	}

	function recipe_readcountarray() {
		//var click = false;
		//if(click==false){

		//click = true;
		document.location.href = 'readcountRecipeDesc.action';
		//}if(click==true){
		//	click = false;
		//	window.location.href='readcountRecipeAsc.action';
		//}
	}

	function recipe_timearray() {
		document.location.href = 'timeRecipeDesc.action';
	}

	function recipe_pricearray() {
		document.location.href = 'priceRecipeDesc.action';
	}
</script>
<!-- 스크립트 끝 -->

</head>

<body>

	<!-- header -->
	<%@ include file="/view/common/header.jsp"%>
	<!-- /.header -->

	<!-- container -->
	<div class="container-fluid">
		<!-- row -->
		<div class="row">

			<!-- sidebar -->
			<div class="col-sm-3 col-md-2 sidebar">
				<ul class="nav nav-sidebar">
					<li><a href="readUser.action?user_type=${session_type}&user_id=${session_id}">회원정보</a></li>
					<!-- 구매자일시 -->
					<li><a href="dashBuyer.action?session_id=${session_id}">구매목록</a></li>
					<!-- 판매자일시 미구현 -->
					<!-- <li><a href="dashSeller.action?session_id=${session_id}">판매목록</a></li> -->
					<li class="active"><a href="listMyRecipe.do">마이 레시피</a></li>
					<li><a href="listMyQna.action?session_id=${session_id}">마이 문의하기</a></li>
				</ul>
			</div>
			<!-- /.sidebar -->

			<!-- main -->
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

				<!-- 게시판 윗부분 -->
				<div class="col-md-12">
					<h3>마이 레시피</h3>
				</div>
				<!-- /.게시판 윗부분 -->

				<!-- 게시판 바디 -->
				<div class="col-md-12">
					<table class="table">
						<tr align="center" bgcolor="">
							<td><strong>번호</strong></td>
							<td><strong>종류</strong></td>
							<td><strong>제목</strong></td>
							<td><strong>요리명</strong></td>
							<td><strong>작성자</strong></td>
							<td><strong>작성일</strong></td>
							<td><strong><a href="javascript:return false;" onClick="recipe_timearray()">소비시간</a></strong></td>
							<td><strong><a href="javascript:return false;"onClick="recipe_pricearray()">비용</a></strong></td>
							<td><strong><a href="javascript:return false;"onClick="recipe_readcountarray()">조회수</a></strong></td>
							<td><strong><a href="javascript:return false;"onClick="recipe_recommendarray()">추천수</a></strong></td>
						</tr>

						<c:forEach var="list" items="${list}" >
							<tr bgcolor="#FFFFFF" align="center">
								<td>${list.recipe_num}</td>
								<td align="center">${list.recipe_foodkind}</td>
								<td align="center">&nbsp; <a href="readRecipe.do?recipe_num=${list.recipe_num}&currentPage=${currentPage}" >${list.recipe_subject}</a></td>
								<td align="center">${list.recipe_foodsubject}</td>
								<td align="center">${list.recipe_writer}></td>
								<td align="center">${list.recipe_reg_date}</td>
								<td align="center">${list.recipe_time}</td>
								<td align="center">${list.recipe_price}</td>
								<td align="center">${list.recipe_readcount}</td>
								<td align="center">${list.recipe_recommend}</td>
							</tr>
						</c:forEach>


						<c:if test="list.size() <= 0">
							<tr bgcolor="#FFFFFF" align="center">
								<td colspan="10">등록된 게시물이 없습니다.</td>
							</tr>
							<tr bgcolor="#777777">
								<td height="1" colspan="10"></td>
							</tr>
						</c:if>
					</table>
				</div>
				<!-- /.게시판 바디 -->

				<!-- 페이징 -->
		<div class="text-center">
			<ul class="pagination pagination-sm">
				${pagingHtml}
			</ul>
		</div>
		<!-- /페이징 -->

				<!-- 버튼 -->
				<div class="col-md-12">
			<div class="form-inline pull-right">
				<!-- 검색[선택] -->
				<select class="form-control" name="recipe_search_target" id="recipe_search_target" title="검색" onchange="detailsearch()">
					<option value="null">검색[선택]</option>
					<option value="recipe_detailsearch">MyRecipe상세검색</option>
				</select>
				<!-- /.검색[선택] -->
				</div>
				</div>
				<!-- /.버튼 -->
				
				<br />
		<br />

		<!-- 상세검색 폼 -->
		<form name="recipe_search" method="post" action="searchMyRecipe.do?session_id=${session_id}" enctype="multipart/form-data">
             
			<!-- 상세검색 시에 나타난다. -->
			<div id="detailsearch" style="display: none">
				<div class="col-md-12">
					<table class="table table-condensed">
						<tr>
							<td class="text-center">종류</td>
							<td>
								<select name="recipe_foodkind" style="width: 120px" id="recipe_foodkind">
									<option value="">선택하세요</option>
									<option value="한식">한식</option>
									<option value="중식">중식</option>
									<option value="일식">일식</option>
									<option value="양식">양식</option>
									<option value="기타">기타</option>
								</select>
							</td>
							
							<td><input type="hidden" name="recipe_writerinput" value="${session_id }">${session_id }</td>
						</tr>
						<tr>
							<td class="text-center">요리명</td>
							<td colspan="3"><input type="text" name="recipe_foodnameinput"></td>
						</tr>
						<tr>
							<td class="text-center">제목+내용</td>
							<td colspan="3"><input type="text" name="recipe_subjectinput"></td>
						</tr>
						<tr>
							<td class="text-center">소요시간</td>
							<td colspan="3">
								<input type="text" name="recipe_timeinput1" size="5">&nbsp;~&nbsp;<input type="text" name="recipe_timeinput2" size="5">
							</td>
						</tr>
						<tr>
							<td class="text-center">비용</td>
							<td colspan="3">
								<input type="text" name="recipe_priceinput1" size="5">&nbsp;~&nbsp;<input type="text" name="recipe_priceinput2" size="5">
							</td>
						</tr>
						<tr>
							<td class="text-right" colspan="4">
								<input type="reset" class="btn btn-default" value="초기화" />&nbsp;<input type="submit" class="btn btn-primary" value="검색">
							</td>
						</tr>
					</table>
				</div>
			</div>
			<!--/.상세검색 시에 나타난다. -->
			
			</div>
			<!-- /.main -->

		</div>
		<!-- /.row -->

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