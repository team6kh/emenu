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
<link rel="shortcut icon" href="/emenu/assets/ico/jogiyo.png">

<title>JOGIYO</title>

<!-- Bootstrap core CSS -->
<link href="/emenu/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="/emenu/view/jogiyo.css" rel="stylesheet">
<link href="/emenu/view/user/dashboard.css" rel="stylesheet">
<link href="/emenu/view/user/register/signup.css" rel="stylesheet">

<script type="text/javascript">
	// "이메일을 인증해주세요" 메시지를 클릭 시 실행
	function requestEv()
	{	
		//alert("requstEv");
		$('#alert_div').removeClass('alert-info');
		$('#alert_div').addClass('alert-warning');
		document.getElementById('alert_placeholder').innerHTML = "Loading..."; // 상태창은 Loading으로 바꾼다.
		form = document.getElementById('form-signup');
		form.action = "emailer.action";
		form.submit();
		
		return false;
	}
	
	// 인증 버튼 클릭 시 실행
	function checkEv()
	{
		//form = document.getElementById('form-signup');
		//form.action = "checkEv.action";
		//form.submit();
		var ev_requested = document.getElementById("buyer_email").value; // 요청자 이메일
		var ev_code_input = document.getElementById("ev_code_input").value; // 입력한 인증 코드
		
		// verification update를 위해 필요하다.
		var user_type = document.getElementById("user_type").value;
		var user_id = document.getElementById("user_id").value;
		
		// 이렇게 4개의 파라미터가 담긴 url 생성 후 checkEv라는 이름의 숨겨진 iframe에서 페이지 이동
		url = "checkEv.action?ev_requested="+ev_requested+"&ev_code_input="+ev_code_input+"&user_type="+user_type+"&user_id="+user_id;
		document.getElementById('checkEv').contentWindow.location.href = url;
		
		return true;
	}
	
	// 공통 비밀번호 체커
	function checkPass(form)
	{
		//var modalParam = document.getElementById("modalParam").value;
		//var modalParam_key = document.getElementById("modalParam_key").value;
		//var modalParam_pw = document.getElementById("modalParam-pw").value;		
		form.action = "checkPass.action";
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
					<li><a href="dashBuyer.action?session_id=${session_id}">구매목록</a></li>
					<li><a href="listMyRecipe.action?session_id=${session_id}">마이 레시피</a></li>
					<li><a href="listMyQna.action?session_id=${session_id}">마이 문의하기</a></li>
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
					<c:if test="${buyerDTO.buyer_verification eq 'no' && actionStatus eq null}">						
					<div class="alert alert-info alert-dismissable" id="alert_div">			  
						<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
						<a href="#" class="alert-link" id="alert_placeholder" onclick="requestEv()">이메일을 인증해주세요.</a>			  
					</div>
					</c:if>
						<!-- 이메일 인증 요청을 받으면 인증번호가 담긴 메일이 발송되었다는 메시지를 출력한다. -->
						<c:if test="${buyerDTO.buyer_verification eq 'no' && actionStatus eq 'evRequested'}">
						<div class="alert alert-success alert-dismissable">
							<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
							<a href="#" class="alert-link">이메일을 확인해주세요.</a>
						</div>
						</c:if>
					<!-- /.인증이 되지 않았을 시 뜬다. -->
					
					<!-- 인증 성공 시 -->
					<c:if test="${buyerDTO.buyer_verification eq 'yes' && actionStatus eq 'evSuccess'}">
					<div class="alert alert-success alert-dismissable">
						<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
						<a href="#" class="alert-link">인증 성공</a>
					</div>
					</c:if>
					<!-- /.인증 성공 시 -->
					
					<!-- 숨겨진 iframe -->
					<iframe src="blink.html" id="checkEv" style="display:none;"></iframe>
					<!-- /.숨겨진 iframe -->
					
			       	<h2 class="form-signup-heading">${buyerDTO.buyer_name} 님의 정보</h2>			       				
					
					<div class="form-group">
						<label>가입유형</label>
					 		<select class="form-control" id="user_type" disabled>
					      		<option value="buyer">구매자</option>
					      		<option value="seller">판매자</option>
					    	</select>
					    	<!-- 이메일 발송을 위해 필요한 히든 파라미터 user_type -->
					    	<input type="hidden" id="user_type" name="user_type" value="${session_type}">			  
					</div>
					<div class="form-group">
						<label>아이디</label>
						<input type="text" class="form-control" value="${buyerDTO.buyer_id}" disabled>
						<!-- 이메일 발송을 위해 필요한 히든 파라미터 user_id -->
						<input type="hidden" id="user_id" name="user_id" value="${buyerDTO.buyer_id}">		  
					</div>						
					<div class="form-group">
						<label>이름</label>
						<input type="text" class="form-control" value="${buyerDTO.buyer_name}" disabled>
						<!-- 이메일 발송을 위해 필요한 히든 파라미터 buyer_name -->
						<input type="hidden" name="buyer_name" value="${buyerDTO.buyer_name}">
					</div>
					<div class="form-group">
						<label>휴대폰</label>
						<input type="text" class="form-control" value="${buyerDTO.buyer_mobilenum}" disabled>
					</div>							
					<div class="form-group">
						<label>이메일</label>
						<input type="text" class="form-control" value="${buyerDTO.buyer_email}" disabled>
						<!-- 이메일 발송을 위해 필요한 히든 파라미터 buyer_email -->
						<input type="hidden" id="buyer_email" name="buyer_email" value="${buyerDTO.buyer_email}">
					</div>
					
					<!-- 인증이 되지 않았을 시 입력폼이 뜬다. -->
					<c:if test="${buyerDTO.buyer_verification eq 'no'}">
					<div class="form-group">
						<label>인증번호</label>
						<div class="input-group">
							<input type="text" class="form-control" id="ev_code_input" name="ev_code_input">
							<span id="btnCheckEv" class="input-group-addon btn btn-default" onclick="checkEv()">인증</span>
						</div>
					</div>
					</c:if>
					<!-- /.인증이 되지 않았을 시 입력폼이 뜬다. -->
										
				</form>
				<!-- /.form-signup -->
			
				<!-- form-signup looklike div -->
				<div class="form-signup">
				    <!-- pull-right -->			
					<div class="pull-right">
					
						<!-- Button trigger modal : 수정 -->
						<button class="btn btn-default insertModalParam" data-toggle="modal"
							data-target="#checkModal" data-id="updateBuyerForm">수정</button>
							
						<!-- Button trigger modal : 탈퇴 -->
						<button class="btn btn-default insertModalParam" data-toggle="modal"
							data-target="#checkModal" data-id="deleteBuyer">탈퇴</button>					
						
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
											<input type="hidden" id="modalParam_key" name="modalParam_key" value="${buyerDTO.buyer_id}">								
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
		<!-- /.row	-->
	</div>
	<!-- /.container -->

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->	
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="/emenu/dist/js/bootstrap.min.js"></script>
	
	<script>
		// user_type의 값을 buyer로 설정. select의 값이 설정된다.
		$("#user_type").val("buyer");
		
		// insertModalParam 버튼 클릭 시 data-id값을 파라미터로 넘긴다.
		$(document).on("click", ".insertModalParam", function() {
			var thisModalParam = $(this).data('id');
			$(".modal-footer #modalParam").val(thisModalParam);
		});
	</script>
</body>
</html>
