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
<link href="/emenu/view/user/registration/registration.css" rel="stylesheet">

<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false&key="></script>

<script type="text/javascript">
	// 선택하는 가입유형에 따라 다른 폼을 로딩합니다.
	function selectRegType(){
	    var option = document.getElementById("reg_type").value;
	    if(option == "buyer"){
	    	url = "/emenu/user/registrationForm.do?reg_type=" + option;
	    	document.location.href = url;
	    }
	    if(option == "seller"){
	    	url = "/emenu/user/registrationForm.do?reg_type=" + option;
			document.location.href = url;
	    }
	}

	// 실시간 ID validation
	function validateRegId(userinput) {
		if (userinput.seller_id.value == "") {
			feedbackRegId.innerHTML = "아이디를 입력해주세요.";
			regForm.feedbackRegId.value = "0";
			//alert("아이디를 입력하세요");
			$('#divRegId').removeClass('has-error'); // bootstrap validation
			$('#divRegId').removeClass('has-success'); // bootstrap validation
			//$('#btnSubmit').prop('disabled', true);
			return;
		} else {
			var hanchk = hanCheck();

			if (userinput.seller_id.value.length < 4 && hanchk) {
				feedbackRegId.innerHTML = "아이디는 4자 이상이여야합니다.";
				regForm.feedbackRegId.value = "0";
				$('#divRegId').addClass('has-error'); // bootstrap validation
				//$('#btnSubmit').prop('disabled', true);
				return false;
			} else if (hanchk) {
				url = "/emenu/user/checkDup.do?reg_id="+userinput.seller_id.value;
				document.getElementById('checkDup').contentWindow.location.href = url;
			}
			regForm.feedbackRegId.value = "1";
		}

		// open(url, "confirm", "toolbar=no,status=no,menubar=no,scrollbars=no,resizable=no,width=300, height=200");

	}
	
	// 한글인지 체크
	function hanCheck() {
		for (i = 0; i < regForm.seller_id.value.length; i++) {
			var a = regForm.seller_id.value.charCodeAt(i);
			if (a > 128) {
				feedbackRegId.innerHTML = "ID 는 영문, 숫자만 사용하세요.";
				regForm.feedbackRegId.value = "0";
				regForm.seller_id.focus();
				$('#divRegId').addClass('has-error'); // bootstrap validation
				//$('#btnSubmit').prop('disabled', true);
				return false;
			}
		}
		return true;
	}
	
	// 비밀번호
	function sellerPw() {
		if (document.regForm.seller_pw.value.length < 2) {
			feedbackSellerPw.innerHTML = "2자리 이상 입력하셔야 합니다.";
			$('#divSellerPw').addClass('has-error'); // bootstrap validation
			//$('#btnSubmit').prop('disabled', true);
			
		} else {
			confirmPw();
			feedbackSellerPw.innerHTML = "사용하셔도 좋은 비밀번호 입니다.";
			$('#divSellerPw').removeClass('has-error'); // bootstrap validation
			$('#divSellerPw').addClass('has-success'); // bootstrap validation
			//$('#btnSubmit').prop('disabled', false);
		}
	}
	
	// 비밀번호 확인
	function confirmPw() {
		if (document.regForm.confirm_pw.value != document.regForm.seller_pw.value) {
			feedbackConfirmPw.innerHTML = "비밀번호가 동일하지 않습니다.";
			$('#divConfirmPw').addClass('has-error'); // bootstrap validation
			//$('#btnSubmit').prop('disabled', true);
		} else if (document.regForm.confirm_pw.value == document.regForm.seller_pw.value) {
			feedbackConfirmPw.innerHTML = "비밀번호가 동일합니다.";
			$('#divConfirmPw').removeClass('has-error'); // bootstrap validation
			$('#divConfirmPw').addClass('has-success'); // bootstrap validation
			//$('#btnSubmit').prop('disabled', false);
		}		
	}
	
	//
	// Geolocation with Google Maps
	function getCurrentPosition() {
	    if(navigator.geolocation)
	        navigator.geolocation.getCurrentPosition(handleGetCurrentPosition, handleGetCurrentPositionError);		
	}
	
	function handleGetCurrentPosition(location){
	    
	    var position = new google.maps.LatLng(location.coords.latitude, location.coords.longitude)
	    
	    new google.maps.Geocoder().geocode({location: position}, handleGeocoderGetLocations);
	}
	
	function handleGeocoderGetLocations( addresses, status ){
	        if (status != google.maps.GeocoderStatus.OK)
	            return maybe_log( 'failed to talk to google' );
	            
	        var city = getCityFromPlacemarks(addresses);
	        //var country = getCountryFromPlacemarks(addresses);
	        
	        //mapOverlay.style.visibility = 'visible';
	        document.getElementById('seller_rest_address').value = addresses[0].formatted_address;
	    }
	    	    
	function getCityFromPlacemarks( placemarks ){
	    return extractNameFromGoogleGeocoderResults('locality', placemarks)
	}

	function getCountryFromPlacemarks(placemarks){
	    return extractNameFromGoogleGeocoderResults('country', placemarks)
	}

	function extractNameFromGoogleGeocoderResults(type, results){
	    for( var i = 0, l = results.length; i < l; i ++)
	        for(var j = 0, l2 = results[i].types.length; j < l2; j++ )
	            if( results[i].types[j] == type )
	                 return results[i].address_components[0].long_name;
	    return ''
	}
	    
	function handleGetCurrentPositionError(){
	    mapDiv.innerHTML = 'Something went horribly wrong!';
	}
</script>

</head>

<body>

	<!-- header -->
	<%@ include file="/view/common/header.jsp"%>
	<!-- /.header -->

	<!-- container -->
	<div class="container">

		<form class="form-signup" name="regForm" method="post" action="/emenu/user/registrationFormPro.do">
			<input type="hidden" name="feedbackRegId" value="0" />
        	<h2 class="form-signup-heading">계정을 생성합니다.</h2>			
			<div class="form-group">
			  <label>가입유형을 선택하세요.</label>
			    <select class="form-control" id="reg_type" name="reg_type" onchange="selectRegType()">
			      <option value="buyer">구매자</option>
			      <option value="seller" selected>판매자</option>
			    </select>		  
			</div>
			<div class="form-group">
			  <label>상호명</label>
			  <input type="text" class="form-control" id="seller_rest_name" name="seller_rest_name" required autofocus>
			</div>
			<div class="form-group">
			  <label>주소</label>
			  <input type="text" class="form-control" id="seller_rest_address" name="seller_rest_address" required>
			  <button type="button" class="btn btn-default btn-block" onclick="getCurrentPosition(); return false;">
			    <span class="glyphicon glyphicon-map-marker"></span> 현재위치 자동검색
			  </button>
			</div>							
			<div class="form-group">
			  <label>전화번호</label>
			  <input type="text" class="form-control" placeholder="'-'를 제외하고 입력해주세요." name="seller_telnum" required>
			</div>
			<div class="form-group" id="divRegId">
			  <label>판매자 아이디</label>
			  <input type="text" class="form-control" id="seller_id" name="seller_id" onkeyup="validateRegId(this.form);" required>
			  <p class="help-block" id="feedbackRegId">아이디를 입력해주세요.</p>
			  <iframe src="blink.html" id="checkDup" style="display:none;"></iframe>			  
			</div>						
			<div class="form-group">
			  <label>이름</label>
			  <input type="text" class="form-control" name="seller_name" required>
			</div>
			<div class="form-group" id="divSellerPw">
			  <label>비밀번호</label>
			  <input type="password" class="form-control" name="seller_pw" placeholder="4~20자로 입력해주세요." name="seller_pw" onkeyup="sellerPw();"required>
			  <p class="help-block" id="feedbackSellerPw">비밀번호를 입력해주세요.</p>
			</div>
			<div class="form-group" id="divConfirmPw">
			  <label>비밀번호 확인</label>
			  <input type="password" class="form-control" name="confirm_pw" placeholder="비밀번호를 재입력 해주세요." onkeyup="confirmPw();" required>
			  <p class="help-block" id="feedbackConfirmPw">비밀번호를 동일하게 입력해주세요.</p>
			</div>			
			<div class="form-group">
			  <label>휴대폰</label>
			  <input type="text" class="form-control" placeholder="'-'를 제외하고 입력해주세요." name="seller_mobilenum" required>
			</div>
			<div class="form-group">
			  <label>이메일</label>
			  <input type="email" class="form-control" placeholder="you@jogiyo.com" name="seller_email" required>
			</div>					
			
        	<button id="btnSubmit" class="btn btn-lg btn-primary btn-block" type="submit">회원가입</button>
      	</form>
	</div>
	<!-- /.container -->


	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->	
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="dist/js/bootstrap.min.js"></script>

	<script type="text/javascript">
		// disable spaces in input except rest_name and rest_address
		$("input").not("#seller_rest_name, #seller_rest_address").on({
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
