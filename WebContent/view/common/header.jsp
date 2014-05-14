<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
.dropdown:hover .dropdown-menu {
	display: block;
}
.btn-link {
	color: #fff;
}
.btn-link:hover, .btn-link:focus {
	color: #fff;
	text-decoration: line;
}

</style>

<div class="navbar navbar-inverse navbar-fixed-top">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="/emenu/home.do">JOGIYO</a>
		</div>
		<div class="navbar-collapse collapse">
			<ul class="nav navbar-nav">
				<li class="dropdown">
	              <a href="listRest.action?rest_localcategory=1&rest_typecategory=1&session_id=${sessionScope.session_id}" class="dropdown-toggle disabled" data-toggle="dropdown">지역별<b class="caret"></b></a>
	              <ul class="dropdown-menu">
	                <li><a href="listRest.action?rest_localcategory=11&rest_typecategory=0&session_id=${sessionScope.session_id}">서울특별시</a></li>
	                <li><a href="listRest.action?rest_localcategory=12&rest_typecategory=0&session_id=${sessionScope.session_id}">경기/인천</a></li>
	                <li><a href="listRest.action?rest_localcategory=13&rest_typecategory=0&session_id=${sessionScope.session_id}">부산/경남</a></li>
	                <li><a href="listRest.action?rest_localcategory=14&rest_typecategory=0&session_id=${sessionScope.session_id}">대구/경북</a></li>
	                <li><a href="listRest.action?rest_localcategory=15&rest_typecategory=0&session_id=${sessionScope.session_id}">대전/전북</a></li>
	                <li><a href="listRest.action?rest_localcategory=16&rest_typecategory=0&session_id=${sessionScope.session_id}">광주/전남</a></li>
	                <li><a href="listRest.action?rest_localcategory=17&rest_typecategory=0&session_id=${sessionScope.session_id}">그 외 지역</a></li>
	              </ul>
	            </li>
	            <li class="dropdown">
	              <a href="listRest.action?rest_localcategory=2&rest_typecategory=2&session_id=${sessionScope.session_id}" class="dropdown-toggle disabled" data-toggle="dropdown">종류별<b class="caret"></b></a>
	              <ul class="dropdown-menu">
	                <li><a href="listRest.action?rest_localcategory=0&rest_typecategory=21&session_id=${sessionScope.session_id}">한식</a></li>
	                <li><a href="listRest.action?rest_localcategory=0&rest_typecategory=22&session_id=${sessionScope.session_id}">양식</a></li>
	                <li><a href="listRest.action?rest_localcategory=0&rest_typecategory=23&session_id=${sessionScope.session_id}">중식</a></li>
	                <li><a href="listRest.action?rest_localcategory=0&rest_typecategory=24&session_id=${sessionScope.session_id}">일식</a></li>
	                <li><a href="listRest.action?rest_localcategory=0&rest_typecategory=25&session_id=${sessionScope.session_id}">기타</a></li>
	              </ul>
	            </li>
				<!-- <li><a href="listReview.action">후기</a></li>  -->
				<li><a href="listRecipe.do">레시피</a></li>
				<li><a href="listNotice.action">공지사항</a></li>
				<li><a href="listQna.action">문의하기</a></li>
				<!-- 테스트 메뉴 삭제하였습니다. -->
			</ul>
			<c:choose>
				<%-- 로그인 전 --%>
				<c:when test="${empty session_id}">
					<form class="navbar-form navbar-right">						
						<a href="registrationForm.action" class="btn btn-default">회원가입</a>
						<button type="button" class="btn btn-primary" onclick="goLoginForm(this.form)">로그인</button>
					</form>					
				</c:when>
				<%-- 로그인 후 --%>
				<c:when test="${not empty session_id}">
					<form class="navbar-form navbar-right" action="/emenu/user/logout.do">
						<a href="readUser.action?user_type=${session_type}&user_id=${session_id}" class="btn btn-link">${session_name} (${session_id}) 님 환영합니다.</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="submit" class="btn btn-warning">로그아웃</button>
					</form>
				</c:when>				
			</c:choose>
		</div>
		<!--/.nav-collapse -->
	</div>
</div>

<script>
	// 왜 스크립트로 해야지 로그인 폼으로 넘어가는지 모르겠음...
	function goLoginForm(form) {
		form.action = "/emenu/user/loginForm.do";
		form.submit();
	}
</script>