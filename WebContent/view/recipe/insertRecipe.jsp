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
<script type="text/javascript" src="<%=request.getContextPath()%>/assets/se2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/assets/se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script>
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
	<!-- /.header -->

	<!-- container -->
	<div class="container">

		<!-- insert 게시판 윗부분 -->
		<div class="col-md-12">
			<h3>RECIPE 게시판</h3>
		</div>
		
		<!-- insert 게시판 body -->
		<!-- 게시판 바디 -->
		<div class="col-md-12">
			<c:if test="${resultClass == null && session_id == null}">
			<form name="inputWarning" action="insertRecipe.do" method="post" enctype="multipart/form-data"  onSubmit="return submitContents(this);">
			</c:if>
			
			<c:if test="${resultClass == NULL && session_id != null}">
			<form name="inputWarning" action="insertRecipe.do" method="post" enctype="multipart/form-data"  onSubmit="return submitContents(this);">
			</c:if>
			
			<c:if test="${resultClass != NULL && session_id == null}">
			<form name="inputWarning" action="updateRecipe.do" method="post" enctype="multipart/form-data"  onSubmit="return submitContents(this);">
				<input type="hidden" id="recipe_num" name="recipe_num" value="${resultClass.recipe_num}" />
				<input type="hidden" id="currentPage" name="currentPage" value="${currentPage}" />
			</c:if>
			
			<c:if test="${resultClass != NULL && pagingHtml != NULL && session_id != null}">
		    <form name="inputWarning" action="updateRecipe.do" method="post" enctype="multipart/form-data"  onSubmit="return submitContents(this);">
				<input type="hidden" id="recipe_num" name="recipe_num" value="${resultClass.recipe_num}" />
				<input type="hidden" id="currentPage" name="currentPage" value="${currentPage}" />
				<input type="hidden" id="pagingHtml" name="pagingHtml" value="${pagingHtml}" />
			</c:if>
			
				<!-- table -->
				<table class="table table-striped">
					<tr>
						<td style="width: 20%;" align="center">종류</td>
						<td align="left" colspan="3">&nbsp; 
						<select name="recipe_foodkind" id="recipe_foodkind" value="${resultClass.recipe_foodkind}" required>
								<option value="${resultClass.recipe_foodkind}">${resultClass.recipe_foodkind}</option>
								<option value="한식">한식</option>
								<option value="양식">양식</option>
								<option value="일식">일식</option>
								<option value="중식">중식</option>
								<option value="기타">기타</option>
						</select>
					</tr>
					<tr>
						<td style="width: 20%;" align="center">제목</td>
						<td colspan="3" align="left">
						  <input type="text" name="recipe_subject" value="${resultClass.recipe_subject}" required /></td>
					</tr>
					<tr>
						<td style="width: 20%;" align="center">요리명</td>
						<td colspan="3" align="left">
						  <input type="text" name="recipe_foodsubject" value="${resultClass.recipe_foodsubject}" required /></td>
					</tr>
					
					<c:if test="${session_id != null}">
					<tr>
						<td style="width: 20%;" align="center">작성자</td>
						<td colspan="3" align="left">${session_id}
						  <input type="hidden" name="recipe_memberwriter" value="${session_id}" />
						  <input type="hidden" name="recipe_writer" value="${session_id}"/></td>
					</c:if>
					
					<c:if test="${session_id == null}">
					<tr>
						<td style="width: 20%;" align="center">작성자</td>
						<td colspan="3" align="left">
							<input type="text" name="recipe_writer" value="${resultClass.recipe_writer}" required />
						</td>
					</tr>
					</c:if>
	
					<tr>
						<td style="width: 20%;" align="center">비밀번호</td>
						<td colspan="3" align="left">
							<input type="password" name="recipe_password" value="${resultClass.recipe_password}" required />
						</td>
					</tr>
					<tr>
						<td style="width: 20%;" align="center">재료</td>
						<td colspan="3" align="left">
							<input type="text" size="50" maxlength="50" name="recipe_method" value="${resultClass.recipe_method}" required />
						</td>
					</tr>
					<tr>
						<td style="width: 20%;" align="center">소요 시간</td>
						<td align="left">
							<input type="text" name="recipe_time" value="${resultClass.recipe_time}" required />&nbsp;&nbsp;분</td>
						<td style="width: 20%;" align="center">비용</td>
						<td align="left">
							<input type="text" name="recipe_price" value="${resultClass.recipe_price}" required />&nbsp;&nbsp;원</td>
					</tr>
					<tr>
					
						<td style="width: 20%;" align="center">방법 및 상세내용</td>
						<td colspan="3">
					    	<textarea name="recipe_content" id="recipe_content" Style="width:850px" >${pagingHtml}</textarea>
					    </td>
					</tr>
	
					<tr>
						<td colspan="4" align="right">		
							<input class="btn btn-default" type="reset" value="다시작성">	
							<input class="btn btn-default" name="list" type="button" value="목록보기" OnClick="javascript:location.href='listRecipe.do?currentPage=${currentPage}'">				    
						    <input class="btn btn-primary" name="submit" type="submit" value="등록"> 
						</td>
					</tr>
				</table>
				<!-- /.table -->
			</form>
			<!-- /.form -->
				
		</div>
		<!-- /.게시판 바디 -->

	</div>
	<!-- /.container -->


	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script type="text/javascript">
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "recipe_content",
		sSkinURI: "<%=request.getContextPath()%>/assets/se2/SmartEditor2Skin.html",
		fCreator: "createSEditor2"
	});

	function submitContents(elClickedObj){ 

		oEditors.getById["recipe_content"].exec("UPDATE_CONTENTS_FIELD", []);
		
		if("<br>"==(document.getElementById("recipe_content").value) || ""==(document.getElementById("recipe_content").value)){
            alert("본문 내용을 입력해주세요.");
            return false;
         }
		
		try{ 
			elClickedObj.inputWarning.submit();
		}catch(e){} 
	} 

	// textArea에 이미지 첨부
	function pasteHTML(filepath){
	    var sHTML = '<img src="<%=request.getContextPath()%>/assets/se2/recipe_upload/'+filepath+'">';
	    oEditors.getById["recipe_content"].exec("PASTE_HTML", [sHTML]); 
	}
	</script>
	
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="dist/js/bootstrap.min.js"></script>
</body>
</html>