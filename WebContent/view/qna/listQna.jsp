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
    
    <script type="text/javascript">
    	var num = 0;
    	var totcnt = "<c:out value="${topCount }"/>";
    	function fn_show(row_id, row_seq){
    		var rId = document.getElementById(row_id);
    		if(num == row_seq){
    			rId.style.display = "none";
    			num = 0;
    		}else{
    			for(var i=1;i<=totcnt;i++){
    				var cId = document.getElementById("row"+i);
    				cId.style.display = "none";
    			}
	    		rId.style.display = "";
	    		num = row_seq;
    		}
    	}
    	
    	function fn_search(){
    		document.searchForm.action = "listQna.do";
    		document.searchForm.submit();
    	
    	}
    	
    	// 글쓰기 버튼 체크    
		function checkId() {

			if("${session_id}" != '') {
				window.location.href= "insertQnaForm.do";
			}else {
			alert("!로그인 하셔야 글을 쓰실 수 있습니다.");

			}
    	}
    	
    	function fn_reply(qna_num){
    		var reply = document.getElementById("qna_reply_"+qna_num).value;
    		alert(reply);
    	}
    	
    	function fn_checkreply(){
    		
    		var qna_checkreply = document.getElementById("qna_checkreply").value;
    		
    		window.location.href = "listQna.do?qna_checkreply=" + qna_checkreply;
    		
    	}    	
    </script>

</head>
<body>

	<%@ include file="/view/common/header.jsp"%>
	
	<!-- container -->
	<div class="container">		

		<!-- 자주 묻는 질문 TOP 10 -->
		<div class="col-md-12">
			<h3>자주 묻는 질문 TOP 10</h3>
		</div>
		
		<div class="col-md-12">
			<table class="table">
				<tbody>
					<c:forEach var="list" items="${topList }">

						<tr onclick="fn_show('row${list.qna_num }', '${list.qna_num }');" style="cursor: pointer;">
							<td class="text-center">
								<c:out value="${list.qna_num }" />
							</td>
							<td class="text-left">
								<c:choose>
									<c:when test="${list.qna_category eq '01' }"><font color="blue">[회원가입]</c:when>
									<c:when test="${list.qna_category eq '02' }"><font color="orange">[바로결제]</c:when>
									<c:when test="${list.qna_category eq '03' }"><font color="#747474">[리뷰]</c:when>
									<c:when test="${list.qna_category eq '04' }"><font color="#8041D9">[이용문의]</c:when>
									<c:when test="${list.qna_category eq '05' }"><font color="green">[광고문의]</c:when>
									<c:when test="${list.qna_category eq '06' }"><font color="#00D8FF">[기타]</c:when>
									<c:otherwise><font color="red">[전체]</c:otherwise>
								</c:choose>
								<c:out value="::${list.qna_subject }" /></font>
							</td>
						</tr>
						
						<tr id="row${list.qna_num }" style="display: none;">
							<td class="text-center">&nbsp;</td>
							<td class="text-left">
								<pre style="border: 0px">글내용:${list.qna_content}</pre>
								<input type="hidden" id="qna_reply_${list.qna_num}" value="${list.qna_reply}" />
								<!-- 답변보기 경고창 -->
								<div class="pull-right">
									<button type="button" class="btn btn-primary" onclick="fn_reply('${list.qna_num}')">답변보기</button>																												
								</div>
								<!-- /.답변보기 경고창 -->
							</td>				
						</tr>

					</c:forEach>
					
					<c:if test="${empty topList}">
						<tr>
							<td colspan="5">등록된 게시물이 없습니다.</td>
						</tr>
					</c:if>
					
				</tbody>
			</table>
		</div>
		<!-- /.자주 묻는 질문 TOP 10 -->

		<!-- 글목록 -->
		<div class="col-md-12">
			<h3>글목록</h3>
			<form class="form-inline" name="searchForm" id="searchForm" method="post">
				<select class="form-control" name="qna_category" id="qna_category" onchange="fn_search();">
					<option value="">전체</option>
					<option value="01" <c:if test="${qna_category eq '01'}">selected</c:if>>회원가입</option>
					<option value="02" <c:if test="${qna_category eq '02'}">selected</c:if>>바로결제</option>
					<option value="03" <c:if test="${qna_category eq '03'}">selected</c:if>>리뷰</option>
					<option value="04" <c:if test="${qna_category eq '04'}">selected</c:if>>이용문의</option>
					<option value="05" <c:if test="${qna_category eq '05'}">selected</c:if>>광고문의</option>
					<option value="06" <c:if test="${qna_category eq '06'}">selected</c:if>>기타</option>
				</select>
				<input class="form-control" type="text" name="searchText" maxlength="17"  value="${searchText }">
				<a href="javascript:fn_search()" class="btn btn-primary">검색</a>
				<c:if test="${session_id eq 'admin'}">
				<input type="checkbox" name="qna_checkreply" value="Y" id="reply1" onclick="fn_search()"/>&nbsp;<label for="reply1">답변미완료</label>
				</c:if>
				<br />
				<br />
				
			
			</form>
		</div>			

		<div class="col-md-12 well">
			<table class="table table-striped">
				<thead>
					<tr>
						<th class="text-center" style="width: 100px;">번호</th>
						<th class="text-center" style="width: 100px;">작성자</th>
						<th class="text-center" style="width: 100px;">카테고리</th>
						<th class="text-center" style="width: 100px;" >제목</th>
						<th class="text-center" style="width: 100px;">작성일</th>
						<th class="text-center" style="width: 100px;">조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="list" items="${list }">					
						<tr>
							<td class="text-center">
								<c:out value="${list.qna_num }" />
							</td>
							<td class="text-center"><c:out value="${list.qna_id }"/></td>
						<td class="text-center">
							<c:choose>
								<c:when test="${list.qna_category eq '07' }"><font color="#CFFF24">[작성자]</c:when>
								<c:when test="${list.qna_category eq '01' }"><font color="blue">[회원가입]</c:when>
								<c:when test="${list.qna_category eq '02' }"><font color="orange">[바로결제]</c:when>
								<c:when test="${list.qna_category eq '03' }"><font color="#747474">[리뷰]</c:when>
								<c:when test="${list.qna_category eq '04' }"><font color="#8041D9">[이용문의]</c:when>
								<c:when test="${list.qna_category eq '05' }"><font color="green">[광고문의]</c:when>
								<c:when test="${list.qna_category eq '06' }"><font color="#00D8FF">[기타]</c:when>
								<c:otherwise><font color="red">[전체]</c:otherwise>
							</c:choose>
						</td>
							<td class="text-left">
								<a href="getQna.do?qna_num=${list.qna_num }">
								<c:out value="${list.qna_subject }" />
								</a>
							</td>
							<td class="text-center"><c:out value="${list.qna_reg_date }" /></td>
							<td class="text-center"><c:out value="${list.qna_readcount }" /></td>
						</tr>
					</c:forEach>
					
					<c:if test="${empty list}">
						<tr>
							<td colspan="5">등록된 게시물이 없습니다.</td>
						</tr>
					</c:if>

				</tbody>
			</table>

			<div class="text-center">
				<ul class="pagination pagination-sm">
					 ${pagingHtml }
				</ul>
			</div>

			<div class="pull-right">
			<c:if test="${!(session_id eq 'admin')}">
				<button type="button" class="btn btn-primary" onclick="return checkId()">글쓰기</button>
				</c:if>
			</div>

		</div>
		<!-- /.글목록 -->

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