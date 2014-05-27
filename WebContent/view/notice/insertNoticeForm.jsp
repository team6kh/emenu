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
<script type="text/javascript" src="<%=request.getContextPath()%>/assets/se1/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/assets/se1/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script>
<title>eMenu</title>

<!-- Bootstrap core CSS -->
<link href="dist/css/bootstrap.min.css" rel="stylesheet">
ㅋ`
<!-- Custom styles for this template -->
<link href="view/jogiyo.css" rel="stylesheet">
<link href="view/common/common-template.css" rel="stylesheet">

</head>

<body >

	<!-- header -->
	<%@ include file="/view/common/header.jsp"%>
	<!-- end of header -->

	<!-- container -->
	<div class="container">
		<div class="col-md-12">
			<h3>공지사항/이벤트</h3>
		</div>
		
		<!-- 꾸미기 시작 -->
	  	<div class="col-md-12 well">
	  		<c:if test="${resultClass == NULL }">
				<form name="f" action="insertNotice.do" method="post" enctype="multipart/form-data" onSubmit="submitContents(this);">
			</c:if>
			<c:if test="${resultClass != NULL }">
			  	<form name="u" action="updateNotice.do" method="post" enctype="multipart/form-data" onSubmit="submitContents(this);">
			  	<input type="hidden" name="notice_num" id="notice_num" value="${resultClass.notice_num }" />
			  	<input type="hidden" name="currentPage" id="currentPage" value="${currentPage }" />
			</c:if>
			
	  		<div class="form-group">
				<label>제목</label>
				<br>
				<div style="float:left;"><select name="notice_headtag" style="width: 200px;" class="form-control">
	  				<option>-----------------</option>
	  				<option>[공지]</option>
	  				<option>[이벤트]</option>
	  				<option>[스마트팁]</option>
	  			</select>
	  			
	  			</div>
	  			<input type="text" class="form-control" style="width: 898px;" name="notice_subject" value="${resultClass.notice_subject}" placeholder="제목" required>
	  		</div>
	  			
	  		<div class="form-group">
				<label for="test_content">내용</label>
	  			<textarea name="notice_content" id="notice_content" Style="width:1098px">${resultClass.notice_content}</textarea>
	  		</div>
	      	    
	  		<div class="pull-right">
	  			<a href="listNotice.do?currentPage=${currentPage }" class="btn btn-default">목록</a>
	  			<button type="submit" class="btn btn-primary">완료</button>	  			
	  		</div>  	  		
		
		</div>
		<!-- 꾸미기 끝 -->
		
	</div>
	<!-- /.container -->


	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->

	<script type="text/javascript">
		var oEditors = [];
			nhn.husky.EZCreator.createInIFrame({
    		oAppRef: oEditors,
    		elPlaceHolder: "notice_content",
    		sSkinURI: "<%=request.getContextPath()%>/assets/se1/SmartEditor2Skin.html",
    		fCreator: "createSEditor2"
		});
			
		function submitContents(elClickedObj){ 
			oEditors.getById["notice_content"].exec("UPDATE_CONTENTS_FIELD", []);
			try{ 
				elClickedObj.f.submit();
			}catch(e){} 
		} 
		
		// textArea에 이미지 첨부
		function pasteHTML(filepath){
		    var sHTML = '<img src="<%=request.getContextPath()%>/assets/se1/notice_upload/'+filepath+'">';
		    oEditors.getById["notice_content"].exec("PASTE_HTML", [sHTML]); 
		}
	</script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="dist/js/bootstrap.min.js"></script>
</body>