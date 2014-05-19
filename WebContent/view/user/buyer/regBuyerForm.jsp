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
<link rel="shortcut icon" href="/emenu/assets/ico/jogiyo.png">

<title>JOGIYO</title>

<!-- Bootstrap core CSS -->
<link href="/emenu/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="/emenu/view/jogiyo.css" rel="stylesheet">
<link href="/emenu/view/user/register/signup.css" rel="stylesheet">

<script type="text/javascript">
	// 선택하는 가입유형에 따라 다른 폼을 로딩합니다.
	function selectRegType(){
	    var option = document.getElementById("reg_type").value;
	    if(option == "buyer"){
	    	url = "/emenu/user/register/form.do?reg_type=" + option;
	    	document.location.href = url;
	    }
	    if(option == "seller"){
	    	url = "/emenu/user/register/form.do?reg_type=" + option;
			document.location.href = url;
	    }
	}
		
	// 실시간 ID validation
	function validateRegId(userinput) {
		if (userinput.buyer_id.value == "") {
			feedbackRegId.innerHTML = "아이디를 입력해주세요.";
			regForm.feedbackRegId.value = "0";
			$('#divRegId').removeClass('has-error'); // bootstrap validation
			$('#divRegId').removeClass('has-success'); // bootstrap validation
			//$('#btnSubmit').prop('disabled', true);
			//okSubmit();
			return;
		} else {
			var hanchk = hanCheck();

			if (userinput.buyer_id.value.length < 4 && hanchk) {
				feedbackRegId.innerHTML = "아이디는 4자 이상이여야합니다.";
				regForm.feedbackRegId.value = "0";
				$('#divRegId').addClass('has-error'); // bootstrap validation
				//$('#btnSubmit').prop('disabled', true);
				//okSubmit();
				return false;
			} else if (hanchk) {				
				url = "/emenu/user/checkDup.do?reg_id="+userinput.buyer_id.value;
				document.getElementById('checkDup').contentWindow.location.href = url;
			}
			regForm.feedbackRegId.value = "1";
		}

		// open(url, "confirm", "toolbar=no,status=no,menubar=no,scrollbars=no,resizable=no,width=300, height=200");

	}
	
	// 한글인지 체크
	function hanCheck() {
		for (i = 0; i < regForm.buyer_id.value.length; i++) {
			var a = regForm.buyer_id.value.charCodeAt(i);
			if (a > 128) {
				feedbackRegId.innerHTML = "ID 는 영문, 숫자만 사용하세요.";
				regForm.feedbackRegId.value = "0";
				regForm.buyer_id.focus();
				$('#divRegId').addClass('has-error'); // bootstrap validation
				//$('#btnSubmit').prop('disabled', true);
				//okSubmit();
				return false;
			}
		}
		return true;
	}
	
	// 비밀번호
	function buyerPw() {
		confirmPw();
		if (document.regForm.buyer_pw.value.length < 2) {
			feedbackBuyerPw.innerHTML = "2자리 이상 입력하셔야 합니다.";
			regForm.feedbackBuyerPw.value = "0";
			$('#divBuyerPw').addClass('has-error'); // bootstrap validation
			//$('#btnSubmit').prop('disabled', true);
			//okSubmit();
			
		} else {
			//confirmPw();
			feedbackBuyerPw.innerHTML = "사용하셔도 좋은 비밀번호 입니다.";
			regForm.feedbackBuyerPw.value = "1";
			$('#divBuyerPw').removeClass('has-error'); // bootstrap validation
			$('#divBuyerPw').addClass('has-success'); // bootstrap validation
			//$('#btnSubmit').prop('disabled', false);
			//okSubmit();
		}
	}
	
	// 비밀번호 확인
	function confirmPw() {
		if (document.regForm.confirm_pw.value != document.regForm.buyer_pw.value) {
			feedbackConfirmPw.innerHTML = "비밀번호가 동일하지 않습니다.";
			regForm.feedbackConfirmPw.value = "0";
			$('#divConfirmPw').addClass('has-error'); // bootstrap validation
			//$('#btnSubmit').prop('disabled', true);
			//okSubmit();
		} else if (document.regForm.confirm_pw.value == document.regForm.buyer_pw.value) {
			feedbackConfirmPw.innerHTML = "비밀번호가 동일합니다.";
			regForm.feedbackConfirmPw.value = "0";
			$('#divConfirmPw').removeClass('has-error'); // bootstrap validation
			$('#divConfirmPw').addClass('has-success'); // bootstrap validation
			//$('#btnSubmit').prop('disabled', false);
			//okSubmit();
		}		
	}
	
	// 사용되지 않음.
	function okSubmit() {
		var regId = regForm.feedbackRegId.value;
		var buyerPw = regForm.feedbackBuyerPw.value;
		var confirmPw = regForm.feedbackConfirmPw.value;
		
		if ( regId == "1" && buyerPw == "1" && confirmPw == "1" ) {			
			$('#btnSubmit').prop('disabled', false);
		}
		$('#btnSubmit').prop('disabled', true);
	}
	
	function validateSumbit() {		
		if ($('#divRegId').hasClass('has-error')) {
			alert("아이디를 확인해주세요!");
			return false;
		} else if ($('#divBuyerPw').hasClass('has-error')) {
			alert("비밀번호를 확인해주세요!");
			return false;
		} else if ($('#divConfirmPw').hasClass('has-error')) {
			alert("비밀번호가 동일하지 않습니다!");
			return false;
		}
		return true;
	}
	
</script>

</head>

<body>

	<!-- header -->
	<%@ include file="/view/common/header.jsp"%>
	<!-- /.header -->

	<!-- container -->
	<div class="container">

		<form class="form-signup" name="regForm" method="post" action="/emenu/user/register.do" onsubmit="return validateSumbit();">
		    <!-- btnSubmit을 위한 체커. okSubmit 미완성으로 사용되지 않음. -->
			<input type="hidden" name="feedbackRegId" value="0" />
			<input type="hidden" name="feedbackBuyerPw" value="0" />
			<input type="hidden" name="feedbackConfirmPw" value="0" />
			<!-- /.btnSubmit을 위한 체커 -->
        	<h2 class="form-signup-heading">계정을 생성합니다.</h2>			
			<div class="form-group">
			  <label>가입유형을 선택하세요.</label>
			    <select class="form-control" id="reg_type" name="reg_type" onchange="selectRegType()">
			      <option value="buyer" selected>구매자</option>
			      <option value="seller">판매자</option>
			    </select>		  
			</div>
			<div class="form-group" id="divRegId">
			  <label>구매자 아이디</label>
			  <input type="text" class="form-control" id="buyer_id" name="buyer_id" onkeyup="validateRegId(this.form);" required autofocus>
			  <p class="help-block" id="feedbackRegId">아이디를 입력해주세요.</p>
			  <iframe src="blink.html" id="checkDup" style="display:none;"></iframe>			  
			</div>						
			<div class="form-group">
			  <label>이름</label>
			  <input type="text" class="form-control" name="buyer_name" required>
			</div>
			<div class="form-group" id="divBuyerPw">
			  <label>비밀번호</label>
			  <input type="password" class="form-control" name="buyer_pw" placeholder="4~20자로 입력해주세요." onkeyup="buyerPw();" required>
			  <p class="help-block" id="feedbackBuyerPw">비밀번호를 입력해주세요.</p>
			</div>
			<div class="form-group" id="divConfirmPw">
			  <label>비밀번호 확인</label>
			  <input type="password" class="form-control" name="confirm_pw" placeholder="비밀번호를 재입력 해주세요." onkeyup="confirmPw();" required>
			  <p class="help-block" id="feedbackConfirmPw">비밀번호를 동일하게 입력해주세요.</p>
			</div>
			<div class="form-group">
			  <label>휴대폰</label>
			  <input type="text" class="form-control" placeholder="'-'를 제외하고 입력해주세요." name="buyer_mobilenum" required>
			</div>			
			<div class="form-group">
			  <label>이메일</label>
			  <input type="email" class="form-control" placeholder="you@jogiyo.com" name="buyer_email" required>
			</div>
			
			<!-- button property disabled="disabled" removed -->
        	<button type="submit" class="btn btn-lg btn-primary btn-block" id="btnSubmit">회원가입</button>        	
      	</form>
	</div>
	<!-- /.container -->


	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->	
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="/emenu/dist/js/bootstrap.min.js"></script>

	<script type="text/javascript">
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
