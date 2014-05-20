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

<title>JOGIYO</title>

<!-- Bootstrap core CSS -->
<link href="dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="view/jogiyo.css" rel="stylesheet">
<link href="view/common/common-template.css" rel="stylesheet">

</head>

<body>
<script type="text/javascript">
	function deleteCheck(){
		 check1=confirm('삭제하시겠습니까?');
         if(check1){
        	 location = "deleteNotice.do?notice_num=${resultClass.notice_num}&currentPage=${currentPage}";
         }else{
			return false;
         }
	}
</script>
	<!-- header -->
	<%@ include file="/view/common/header.jsp"%>
	<!-- end of header -->

	<!-- container --> 
	<div class="container">
 
	<!-- 밑으로 view 꾸미기 -->
	<div class="col-md-12">
		<h3>공지사항/이벤트</h3>
	</div>
		
	<div class="col-md-12 well">
		<table class="table table-striped">
			<thead>
	  			<tr>
      				<th class="text-center" width="50"><strong>${rnum }</strong></th>
					<th class="text-center"><strong>&nbsp;&nbsp;
						<c:if test="${resultClass.notice_headtag == '-----------------' }" >
							${resultClass.notice_subject }
						</c:if>
						<c:if test="${resultClass.notice_headtag != '-----------------' }" >
							${resultClass.notice_headtag }&nbsp;${resultClass.notice_subject }
						</c:if></strong>
					</th>
        			<th width="100" class="text-center"><strong>${resultClass.notice_reg_date }</strong></th>
      			</tr>
      	    </thead>
      	    <tbody>
      			<tr>
        			<td bgcolor="#FFFFFF" height="600" colspan="3" align="left">
          			&nbsp;&nbsp;${pagingHtml }
        			</td>
      			</tr>
      			<tr>
        			<td align="right" colspan="3">
        				<c:url var="updateNoticeURL" value="UpdateNotice.do" >
						<c:param name="notice_num">
						${notice_num }
						</c:param>
	        			</c:url>
					
	        			<c:url var="deleteNoticeURL" value="DeleteNotice.do" >
						<c:param name="notice_num">
						${notice_num }
						</c:param>
	        			</c:url>
	        			<div style="float:left;" align="left">
	        			<c:url var="readNoticeURL" value="readNotice.do">
							<c:param name="notice_num">
								${notice_num }
							</c:param>
							<c:param name="currentPage">
								${currentPage }
							</c:param>
							<c:param name="rnum">
								${rnum }
							</c:param>
						</c:url> 
	        			<c:if test="${rnum == 1 }">
	        				<img  src="view/notice/img/ico-btn-pre2_.gif"> 다음글&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        				<a href="readNotice.do?notice_num=${resultClass.notice_num}&currentPage=${currentPage}&rnum=${rnum+1}">
	        				<c:if test="${resultClass.notice_headtag == '-----------------' }">
	        					${aClass.notice_subject }
	        				</c:if> 
	        				<c:if test="${resultClass.notice_headtag != '-----------------' }">
	        					${aClass.notice_headtag } ${aClass.notice_subject }
	        				</c:if></a><br/>
	        				<img  src="view/notice/img/ico-btn-net2_.gif"> 이전글&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        				<a href="javascript:alert('이전글이 없습니다.')">이전글이 없습니다.</a> 
						</c:if>
						<c:if test="${rnum == n_count }">
							<img  src="view/notice/img/ico-btn-pre2_.gif"> 다음글&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:alert('다음글이 없습니다.')">다음글이 없습니다.</a><br/>
							<img  src="view/notice/img/ico-btn-net2_.gif"> 이전글&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        				<a href="readNotice.do?notice_num=${resultClass.notice_num}&currentPage=${currentPage}&rnum=${rnum-1}">
	        				<c:if test="${resultClass.notice_headtag == '-----------------' }">
	        					${bClass.notice_subject } 
	        				</c:if>
	        				<c:if test="${resultClass.notice_headtag != '-----------------' }">
	        					${bClass.notice_headtag } ${bClass.notice_subject }
	        				</c:if></a>
						</c:if>
						<c:if test="${rnum != 1 && rnum != n_count }">
							<img  src="view/notice/img/ico-btn-pre2_.gif"> 다음글&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        				<a href="readNotice.do?notice_num=${resultClass.notice_num}&currentPage=${currentPage}&rnum=${rnum+1}">
	        				<c:if test="${aClass.notice_headtag == '-----------------' }">
	        					${aClass.notice_subject }
	        				</c:if>
	        				<c:if test="${aClass.notice_headtag != '-----------------' }">
	        					${aClass.notice_headtag } ${aClass.notice_subject }
	        				</c:if></a><br/>
	        				<img  src="view/notice/img/ico-btn-net2_.gif"> 이전글&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        				<a href="readNotice.do?notice_num=${resultClass.notice_num}&currentPage=${currentPage}&rnum=${rnum-1}">
	        				<c:if test="${bClass.notice_headtag == '-----------------' }">
	        					${bClass.notice_subject }
	        				</c:if>
	        				<c:if test="${bClass.notice_headtag != '-----------------' }">
	        					${bClass.notice_headtag } ${bClass.notice_subject }
	        				</c:if></a>
						</c:if>
						</div>
						<c:if test="${session_id eq 'admin'}">
	        			<a href="updateNoticeForm.do?notice_num=${resultClass.notice_num}" class="btn btn-default">수정</a>
	        			<a href="#" onclick="deleteCheck()" class="btn btn-default">삭제</a>
	        			</c:if>
	        			<a href="listNotice.do?currentPage=${currentPage}" class="btn btn-default">목록</a>
					</td>
      			</tr>
      		</tbody>
		</table>
		<!-- 꾸미기 끝 -->
		</div>

	</div>
	<!-- /.container -->


	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="dist/js/bootstrap.min.js"></script>
</body>
