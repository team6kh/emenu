<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ page isELIgnored="false" %> --%>
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
	// 비밀번호
	function buyerPw() {
		if (document.regForm.buyer_pw.value.length < 2) {
			//feedbackBuyerPw.innerHTML = "2자리 이상 입력하셔야 합니다.";
			$('#divBuyerPw').addClass('has-error'); // bootstrap validation
			//$('#btnSubmit').prop('disabled', true);
			
		} else {
			confirmPw();
			//feedbackBuyerPw.innerHTML = "사용하셔도 좋은 비밀번호 입니다.";
			$('#divBuyerPw').removeClass('has-error'); // bootstrap validation
			$('#divBuyerPw').addClass('has-success'); // bootstrap validation
			//$('#btnSubmit').prop('disabled', false);
		}
	}
	
	// 비밀번호 확인
	function confirmPw() {
		if (document.regForm.confirm_pw.value != document.regForm.buyer_pw.value) {
			//feedbackConfirmPw.innerHTML = "비밀번호가 동일하지 않습니다.";
			$('#divConfirmPw').addClass('has-error'); // bootstrap validation
			//$('#btnSubmit').prop('disabled', true);
		} else if (document.regForm.confirm_pw.value == document.regForm.buyer_pw.value) {
			//feedbackConfirmPw.innerHTML = "비밀번호가 동일합니다.";
			$('#divConfirmPw').removeClass('has-error'); // bootstrap validation
			$('#divConfirmPw').addClass('has-success'); // bootstrap validation
			//$('#btnSubmit').prop('disabled', false);
		}		
	}
</script>

</head>

<body>

	<!-- header -->
	<%@ include file="/view/common/header.jsp"%>
	<!-- ./header -->

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

			<form class="form-signup" name="regForm" method="post" action="updateBuyer.action">
	        	<h2 class="form-signup-heading">계정을 수정합니다.</h2>			
				<div class="form-group">
				  <label>가입유형</label>
				    <select class="form-control" id="user_type" disabled>
				      <option value="buyer">구매자</option>
				      <option value="seller">판매자</option>
				    </select>			  
				</div>
				<div id="div_regid" class="form-group">
				  <label>아이디</label>
				  <input type="text" class="form-control" value="${buyerDTO.buyer_id}" disabled>
				  <input type="hidden" name="buyer_id" value="${buyerDTO.buyer_id}">		  
				</div>						
				<div class="form-group">
				  <label>이름</label>
				   <input type="text" class="form-control" value="${buyerDTO.buyer_name}" disabled>
				</div>
				<div class="form-group" id="divBuyerPw">
				  <label>비밀번호</label>
				  <input type="password" class="form-control" name="buyer_pw" placeholder="4~20자로 입력해주세요." value="${buyerDTO.buyer_pw}" onkeyup="buyerPw();" required>
				  <!-- <p class="help-block" id="feedbackBuyerPw">비밀번호를 입력해주세요.</p>  -->
				</div>
				<div class="form-group" id="divConfirmPw">
				  <label>비밀번호 확인</label>
				  <input type="password" class="form-control" name="confirm_pw" placeholder="비밀번호를 재입력 해주세요." onkeyup="confirmPw();" required>
				  <!-- <p class="help-block" id="feedbackConfirmPw">비밀번호를 동일하게 입력해주세요.</p>  -->
				</div>
				<div class="form-group">
				  <label>휴대폰</label>
				  <input type="text" class="form-control" placeholder="'-'를 제외하고 입력해주세요." name="buyer_mobilenum" value="${buyerDTO.buyer_mobilenum}" onkeyup="confirmPw();" required>
				</div>			
				<div class="form-group">
				  <label>이메일</label>
				  <input type="email" class="form-control" placeholder="you@jogiyo.com" name="buyer_email" value="${buyerDTO.buyer_email}" required>
				</div>	
				
	        	<button type="submit" class="btn btn-lg btn-primary btn-block" id="btnSubmit">수정</button>
	      	</form>
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
	<script src="dist/js/bootstrap.min.js"></script>
	
	<script>
		$("#user_type").val("buyer");

		// disable spaces in input
		$("input").on({
			keydown : function(e) {
				if (e.which === 32)
					return false;
			},
			change : function() {
				this.value = this.value.replace(/\s/g, "");
			}
		});
	</script>
</body>
</html>
