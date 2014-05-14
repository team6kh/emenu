<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="huks">
<link rel="shortcut icon" href="assets/ico/jogiyo.png">

<title>JOGIYO</title>

<!-- Bootstrap core CSS -->
<link href="dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="view/jogiyo.css" rel="stylesheet">
<link href="view/user/dashboard.css" rel="stylesheet">
<link href="view/user/register/signup.css" rel="stylesheet">

<script type="text/javascript">
	function requestEv()
	{	
		//alert("requstEv");
		$('#alert_div').removeClass('alert-info');
		$('#alert_div').addClass('alert-warning');
		document.getElementById('alert_placeholder').innerHTML = "Loading...";
		form=document.getElementById('form-signup');
		form.action="emailer.action";
		form.submit();
		
		return false;
	}
	
	function checkEv()
	{
		//document.getElementById('btnCheckEv').innerHTML = "인증 중";		
		//form=document.getElementById('form-signup');
		//form.action="checkEv.action";
		//form.submit();
		var ev_requested = document.getElementById("seller_email").value;
		var ev_code_input = document.getElementById("ev_code_input").value;
		
		// verification update를 위해 필요하다.
		var user_type = document.getElementById("user_type").value;
		var user_id = document.getElementById("user_id").value;
		
		url = "checkEv.action?ev_requested="+ev_requested+"&ev_code_input="+ev_code_input+"&user_type="+user_type+"&user_id="+user_id;
		document.getElementById('checkEv').contentWindow.location.href = url;
		
		return true;
	}
	
	function checkPass(form)
	{
		//var modalParam = document.getElementById("modalParam").value;
		//var modalParam_key = document.getElementById("modalParam_key").value;
		//var modalParam_pw = document.getElementById("modalParam_pw").value;		
		form.action="checkPass.action";
		form.submit();
		
		return true;
	}
</script>

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
            		<li class="active"><a href="readUser.action?user_type=${session_type}&user_id=${session_id}">회원정보</a></li>
            		<li><a href="dashSeller.action?sesssion_id=${session_id}">판매목록</a></li>
          		</ul>
        	</div>
        	<!-- /.sidebar -->
        	
        	<!-- main -->
        	<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        	
        		<!--
        			form-signup:
        			disabled는 정보출력스타일을 폼으로 유지하기 위해 사용. 값은 액션으로 안 넘어간다.
        		-->        		
				<form class="form-signup" id="form-signup" method="post">
				
					<br />
					
				  	<!-- 인증이 되지 않았을 시 뜬다. -->		  	
					<c:if test="${sellerDTO.seller_verification eq 'no' && actionStatus eq null}">						
					<div class="alert alert-info alert-dismissable" id="alert_div">			  
						<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
						<a href="#" class="alert-link" id="alert_placeholder" onclick="requestEv()">이메일을 인증해주세요.</a>			  
					</div>
					</c:if>
						<!-- 이메일 인증 요청을 받으면 인증번호가 담긴 메일이 발송되었다는 메시지를 출력한다. -->
						<c:if test="${sellerDTO.seller_verification eq 'no' && actionStatus eq 'evRequested'}">
						<div class="alert alert-success alert-dismissable">
							<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
							<a href="#" class="alert-link">이메일을 확인해주세요.</a>
						</div>
						</c:if>
					<!-- /.인증이 되지 않았을 시 뜬다. -->
					
					<!-- 인증 성공 시 -->
					<c:if test="${sellerDTO.seller_verification eq 'yes' && actionStatus eq 'evSuccess'}">
					<div class="alert alert-success alert-dismissable">
						<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
						<a href="#" class="alert-link">인증 성공</a>
					</div>
					</c:if>
					<!-- /.인증 성공 시 -->
					
					<!-- 숨겨진 iframe -->
					<iframe src="blink.html" id="checkEv" style="display:none;"></iframe>
					<!-- /.숨겨진 iframe -->
					
			       	<h2 class="form-signup-heading">${sellerDTO.seller_name} 님의 정보</h2>	       	
			       
					<div class="form-group">
						<label>가입유형</label>
							<select class="form-control" id="user_type" disabled>
								<option value="buyer">구매자</option>
								<option value="seller">판매자</option>
							</select>
							<!-- 이메일작성을 위해 필요한 히든 파라미터 user_type -->
							<input type="hidden" id="user_type" name="user_type" value="${session_type}">			  
					</div>			
					<div class="form-group">
						<label>상호명</label>
						<input type="text" class="form-control" value="${sellerDTO.seller_rest_name}" disabled>
					</div>
					<div class="form-group">
						<label>주소</label>
						<input type="text" class="form-control" value="${sellerDTO.seller_rest_address}" disabled>
					</div>
					<div class="form-group">
						<label>전화번호</label>
						<input type="text" class="form-control" value="${sellerDTO.seller_telnum}" disabled>
					</div>		
					<div class="form-group">
						<label>아이디</label>
						<input type="text" class="form-control" value="${sellerDTO.seller_id}" disabled>
						<!-- 이메일작성을 위해 필요한 히든 파라미터 user_id -->
						<input type="hidden" id="user_id" name="user_id" value="${sellerDTO.seller_id}">		  
					</div>						
					<div class="form-group">
						<label>이름</label>
						<input type="text" class="form-control" value="${sellerDTO.seller_name}" disabled>
						<!-- 이메일작성을 위해 필요한 히든 파라미터 seller_name -->
						<input type="hidden" name="seller_name" value="${sellerDTO.seller_name}">
					</div>
					<!-- 
					<div class="form-group">
						<label>비밀번호</label>
						<input type="password" class="form-control" value="${sellerDTO.seller_pw}" disabled>
					</div>  -->
					<div class="form-group">
						<label>휴대폰</label>
						<input type="text" class="form-control" value="${sellerDTO.seller_mobilenum}" disabled>
					</div>				
					<div class="form-group">
						<label>이메일</label>
						<input type="text" class="form-control" value="${sellerDTO.seller_email}" disabled>
						<!-- 이메일작성을 위해 필요한 히든 파라미터 seller_email -->
						<input type="hidden" id="seller_email" name="seller_email" value="${sellerDTO.seller_email}">
					</div>
					
					<!-- 인증이 되지 않았을 입력폼이 뜬다. -->
					<c:if test="${sellerDTO.seller_verification eq 'no'}">
					<div class="form-group">
						<label>인증번호</label>
							<div class="input-group">
								<input type="text" class="form-control" id="ev_code_input" name="ev_code_input">
								<span id="btnCheckEv" class="input-group-addon btn btn-default" onclick="checkEv()">인증</span>
							</div>
					</div>
					</c:if>
					<!-- /.인증이 되지 않았을 입력폼이 뜬다. -->	
										
				</form>
				<!-- /.form-signup -->
				
				<!-- form-signup looklike div -->
				<div class="form-signup">			
					<div class="pull-right">
					
						<!-- Button trigger modal : 수정 -->
						<button class="btn btn-default insertModalParam" data-toggle="modal"
							data-target="#checkModal" data-id="updateSellerForm">수정</button>
							
						<!-- Button trigger modal : 탈퇴 -->
						<button class="btn btn-default insertModalParam" data-toggle="modal"
							data-target="#checkModal" data-id="deleteSeller">탈퇴</button>					
						
						<!-- Modal -->
						<div class="modal fade" id="checkModal" tabindex="-1" role="dialog" aria-labelledby="checkModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<form id="checkPass" method="post">
									<div class="modal-content">							
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
											<h4 class="modal-title" id="checkModalLabel">비밀번호를 입력하세요.</h4>
										</div>
										<div class="modal-body">
											<div class="form-group">
												<label>비밀번호</label>
												<input type="password" class="form-control" id="modalParam_pw" name="modalParam_pw">										
											</div>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>		
											<input type="hidden" id="modalParam" name="modalParam">						
											<input type="hidden" id="modalParam_key" name="modalParam_key" value="${sellerDTO.seller_id}">								
											<button class="btn btn-primary" onclick="checkPass(this.form)">입력</button>
										</div>							
									</div>
								</form>
							</div>
						</div>
						<!-- /.Modal -->											
					</div>
					<!-- /.pull-right -->				
		       	</div>
		       	<!-- /.form-signup looklike div -->
			</div>
			<!-- /.main -->
		</div>
		<!-- /.row -->		      
	</div>
	<!-- /.container -->
	
	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->	
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="dist/js/bootstrap.min.js"></script>
	<script>
		$("#user_type").val("seller");
		
		$(document).on("click", ".insertModalParam", function() {
			var thisModalParam = $(this).data('id');
			$(".modal-footer #modalParam").val(thisModalParam);
		});
	</script>
</body>
</html>
