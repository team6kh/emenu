<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ page isELIgnored="false" %> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<link rel="shortcut icon" href="assets/ico/jogiyo.png">

<title>eMenu</title>

<!-- Bootstrap core CSS -->
<link href="dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="view/jogiyo.css" rel="stylesheet">
<link href="view/common/common-template.css" rel="stylesheet">

<!-- Unify -->        
<!-- CSS Implementing Plugins -->    
<link rel="stylesheet" href="assets/plugins/font-awesome/css/font-awesome.css" />
<link rel="stylesheet" href="assets/plugins/flexslider/flexslider.css" type="text/css" media="screen" />    	
<link rel="stylesheet" href="assets/plugins/parallax-slider/css/parallax-slider.css" type="text/css" />

<!-- 별점 관련 css -->
<link rel="stylesheet" href="assets/img/review/css/jquery.rating.css" />


<!-- 커스텀 CSS -->
<style type="text/css">
	#map_canvas {
		height: 200px
	}
	#cartFrame {
		height: 450px
	}

	.da-slider {
		background: transparent;	
		height: 200px;			
	}
	.da-slider h2 {
		margin-left: 15%;
		top: 25px;		
	}
	.da-slider p {
		font-size: 27px;
		margin-left: 20%;
		top: 125px;		
	}
	.da-slider .da-img {		
		line-height: 200px;
		margin-left: -22%;
		top: 0px;
	}
	.da-arrows span {
		top: 40%;
	}
</style>

<!-- 구글맵 스크립트 -->
<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=true"></script>
<script type="text/javascript">
	var map;
	var infowindow = new google.maps.InfoWindow();
	var marker = [];
	var geocoder;
	var geocodemarker = [];

	var GreenIcon = new google.maps.MarkerImage(
			"http://labs.google.com/ridefinder/images/mm_20_green.png",
			new google.maps.Size(12, 20), new google.maps.Point(0, 0),
			new google.maps.Point(6, 20));

	function initialize() {
		var latlng = new google.maps.LatLng(37.5240220, 126.9265940);
		var myOptions = {
			zoom : 15,
			center : latlng,
			mapTypeId : google.maps.MapTypeId.ROADMAP
		};

		map = new google.maps.Map(document.getElementById("map_canvas"),
				myOptions);
		geocoder = new google.maps.Geocoder();
		google.maps.event.addListener(map, 'click', codeCoordinate);
		codeAddress();
	}

	function Setmarker(latLng) {
		if (marker.length > 0) {
			marker[0].setMap(null);
		}
		// marker.length는 marker라는 배열의 원소의 개수입니다.
		// 만약 이 개수가 0이 아니라면 marker를 map에 표시되지 않게 합니다.
		// 이는 다른 지점을 클릭할 때 기존의 마커를 제거하기 위함입니다.
		marker = [];
		marker.length = 0;
		// marker를 빈 배열로 만들고, marker 배열의 개수를 0개로 만들어 marker 배열을 초기화
		marker.push(new google.maps.Marker({
			position : latLng,
			map : map
		}));
		// marker 배열에 새 marker object를 push 함수로 추가
	}

	function codeAddress(event) {
		if (geocodemarker.length > 0) {
			for (var i = 0; i < geocodemarker.length; i++) {
				geocodemarker[i].setMap(null);
			}

			geocodemarker = [];
			geocodemarker.length = 0;
		}

		var address = document.getElementById("rest_writer_address").value;

		geocoder.geocode({
			'address' : address
		}, function(results, status) {
			if (status == google.maps.GeocoderStatus.OK) {
				for (var i = 0; i < results.length; i++) {
					map.setCenter(results[i].geometry.location);
					geocodemarker.push(new google.maps.Marker({
						center : results[i].geometry.location,
						position : results[i].geometry.location,
						icon : GreenIcon,
						map : map
					}));
				}
			} else {
				alert("Geocode was not successful for the following reason: "
						+ status);
			}
		});
	}

	function codeCoordinate(event) {
		Setmarker(event.latLng);
		geocoder.geocode({
			'latLng' : event.latLng
		}, function(results, status) {
			if (status == google.maps.GeocoderStatus.OK) {
				if (results[1]) {
					infowindow.setContent(results[1].formatted_address);
					infowindow.open(map, marker[0]);
				}
			}
		});
	}

	function insertCart(form) {
		alert("장바구니에 담겼습니다.");
		var rest_num = document.getElementById("rest_num").value;
		var rest_subject = document.getElementById("rest_subject").value;
		var session_id = document.getElementById("session_id").value;
		var restopt_num = form.restopt_num.value;
		var restopt_destFile1 = form.restopt_destFile1.value;
		var restopt_subject = form.restopt_subject.value;
		var restopt_priceplus = form.restopt_priceplus.value;

		var url = "insertCart.do?cart_rest_num="+rest_num+"&cart_rest_subject="+rest_subject+"&cart_restopt_destFile1="+restopt_destFile1+"&cart_restopt_num="+restopt_num+"&cart_restopt_subject="+restopt_subject+"&cart_restopt_priceplus="+restopt_priceplus+"&session_id="+session_id;
		document.getElementById("cartFrame").contentWindow.location.href=url;
		return false;
	}

	function reviewForm() {
		var reviewform = document.insertReviewForm;
		if (reviewform.style.display == "none") {
			reviewform.style.display = "block";
		} else {
			reviewform.style.display = "none";
		}
	}

	function btnInsert() {
		var reviewForm = document.insertReviewForm;
		var btnInsert = document.getElementById("btnInsert");
		var btnSubmit = document.getElementById("btnSubmit");
		reviewForm.style.display = "block";
		btnInsert.style.display = "none";
		btnSubmit.style.display = "block";

	}

	function btnCancel() {		
		var reviewForm = document.insertReviewForm;
		var btnInsert = document.getElementById("btnInsert");
		var btnSubmit = document.getElementById("btnSubmit");
		reviewForm.style.display = "none";
		btnInsert.style.display = "block";
		btnSubmit.style.display = "none";
	}

	function btnSubmit() {
		var reviewForm = document.insertReviewForm;
		reviewForm.submit();
	}
	
	function updateRV_form(review_num) {
		var readRV = document.getElementById("readRV_" + review_num);
		var updateRV = document.getElementById("updateRV_" + review_num);
		
		readRV.style.display = "none";
		updateRV.style.display="block";
		
	}
	
	function cancelUpdateRV(review_num) {
		var readRV = document.getElementById("readRV_" + review_num);
		var updateRV = document.getElementById("updateRV_" + review_num);
		
		readRV.style.display = "block";
		updateRV.style.display="none";
		
		
	}
</script>

<script language="Javascript1.2">
	function printWindow(){
	    browserVersion = parseInt(navigator.appVersion)
	        if (browserVersion >= 4) window.print()
	}
</script>

</head>

<body onload="initialize()">

<!-- header -->
<%@ include file="/view/common/header.jsp"%>
<!-- /.header -->

<!--=== Slider ===-->
<div class="slider-inner">
    <div id="da-slider" class="da-slider" style="background: transparent;">
    <!-- <div id="da-slider" class="da-slider" style="background: transparent url(${resultClass.rest_destFile2}) repeat 0% 0%;"> -->
        <!-- 메인 슬라이드 -->
        <div class="da-slide">
            <h2><i>${resultClass.rest_subject}</i></h2>
            <div class="da-img"><img src="${resultClass.rest_destFile1}" alt="" /></div>
            <!-- 이미지 height를 맞추고 싶으면 style="height: 200px" 추가 -->
        </div>
        <!-- 슬라이드 메뉴 리스트 -->
        <c:forEach var="list" items="${list1}">
        <div class="da-slide">
            <h2><i>${list.restopt_subject}</i></h2>
            <p><i>${list.restopt_priceplus} 원</i></p>
            <div class="da-img"><img src="${list.restopt_destFile1}" alt="" /></div>
        </div>        
        </c:forEach>
        <!-- 화살표 -->
        <nav class="da-arrows">
            <span class="da-arrows-prev"></span>
            <span class="da-arrows-next"></span>		
        </nav>
    </div><!--/.da-slider-->
</div><!--/.slider-->
<!--=== End Slider ===-->

<!--=== Content Part ===-->
<div class="container">	
	<br />	
	<!-- 메뉴 리스트 col-md-9-->
	<div class="col-md-9">
		<!-- 메뉴 리스트 page-header -->
	    <div class="page-header">
	    	<!-- 판매자일 시 -->
	    	<c:if test="${sessionScope.session_type=='buyer'}">
	    		<h2><strong>메뉴 리스트</strong> <small>장바구니에 담아 구매해주세요.</small></h2>
	    	</c:if>
	    	<!-- 판매자가 아닐 시 -->
	    	<c:if test="${sessionScope.session_type!='buyer'}">
	    		<h2><strong>메뉴 리스트</strong> <small>구매하시려면 구매자로 로그인해주세요.</small></h2>
	    	</c:if>			
			<input type="hidden" id="rest_num" name="rest_num" value="${resultClass.rest_num}" />
			<input type="hidden" id="rest_subject" name="rest_subject" value="${resultClass.rest_subject}" />
			<input type="hidden" id="session_id" name="session_id" value="${sessionScope.session_id}" />
			<input type="hidden" id="rest_writer_address" name="rest_writer_address" value="${resultClass.rest_writer_address}" />

			<!-- 글 작성자와 현재 로그인한 세션이 일치할 경우, 수정 및 삭제 버튼을 출력 시킴 -->
			<c:if test="${sessionScope.session_id==resultClass.rest_writer_id}">
				<div class="forSeller" align="right">
					<a href="updateRestForm.do?rest_num=${resultClass.rest_num}&currentPage=${currentPage}&session_id=${sessionScope.session_id}" class="btn btn-success">수정</a>
					<a href="deleteRest.do?rest_num=${resultClass.rest_num}&session_id=${sessionScope.session_id}" class="btn btn-danger">삭제</a>
				</div>
			</c:if>	
		</div>

		<c:forEach var="list" items="${list1}">
		<form class="col-sm-4 col-md-4" id="cartForm" name="test">					
	    	<div class="thumbnail">
	    		<!-- 옵션 -->
      			<img src="${list.restopt_destFile1}"  alt="N/A" style="min-height:125px;height:125px;">
      			
	      		<input type="hidden" id="restopt_destFile1" name="restopt_destFile1" value="${list.restopt_destFile1}" />
	      		<div class="caption" align="center">
	        		<font color="green"><b>${list.restopt_subject}</b></font> <br/>
	        		${list.restopt_priceplus} 원
	        		<input type="hidden" id="restopt_num" name="restopt_num" value="${list.restopt_num}" />
	        		<input type="hidden" id="restopt_subject" name="restopt_subject" value="${list.restopt_subject}" />
	        		<input type="hidden" id="restopt_priceplus" name="restopt_priceplus" value="${list.restopt_priceplus}" />
	      		</div>

	      		<!-- 장바구니 담기 버튼 -->
	      		<div class="text-center">
	      			<c:if test="${sessionScope.session_type=='buyer'}">
	      				<button type="button" class="btn btn-default" onclick="insertCart(this.form)">
							<span class="glyphicon glyphicon-shopping-cart"></span> 장바구니 담기
						</button>
					</c:if>
	      		</div>

	    	</div>
	     </form>		      			      	
		</c:forEach>
	</div>
	<!-- /메뉴 리스트 col-md-9 -->

	<!-- 업소상세정보 col-md-3 -->
	<div class="col-md-3">
		<div class="page-header">
		  <h2><strong>업소상세정보</strong></h2>
		</div>

				<span class="glyphicon glyphicon-user"></span>	
				${resultClass.rest_writer_name} <br/>

				<span class="glyphicon glyphicon-phone-alt"></span>
				 ${resultClass.rest_writer_telnum}<br/>

				<span class="glyphicon glyphicon-earphone"></span>	
				${resultClass.rest_writer_mobilenum}<br/>

				<span class="glyphicon glyphicon-map-marker"></span>
				${resultClass.rest_writer_address} <br/>

				<span class="glyphicon glyphicon-envelope"></span>
				<a href="/emenu/email/customerService.do?rest_writer_email=${resultClass.rest_writer_email}&rest_num=${rest_num}&currentPage=${currentPage}" >${resultClass.rest_writer_email}</a> <br/>

				<span class="glyphicon glyphicon-print"></span>
				<a href="javascript:printWindow()">프린트하기</a> <br/><br/>

		<div id="map_canvas" class="map"></div>

		<!-- 장바구니 col-md-3 -->
		<c:if test="${sessionScope.session_type == 'buyer'}">
			<div class="page-header">
				<h2><strong>장바구니</strong></small></h2>
			</div>
			<!-- iframe -->
			<iframe id="cartFrame" src="listCart.do?rest_num=${rest_num}&rest_subject=${resultClass.rest_subject}&session_id=${sessionScope.session_id}" frameborder="0" style="overflow:hidden;height:500px;width:100%" height="100%" width="100%"></iframe>
		</c:if>	
		<!-- /장바구니 col-md-3 -->
	</div>
	<!-- /업소상세정보 col-md-3 -->

	<!-- 리뷰 쓰기 col-md-12 -->
	<div class="col-md-12">

		<!-- 리뷰 쓰기 page-header -->
	    <div class="page-header">
			<h1>리뷰 쓰기</h1>
		</div>

		<!-- 리뷰 쓰기 권한에 관한 조건문 : 필요한 값 - 회원이 이 식당에서 주문한 적이 있는지 없는지에 대한 논리값 -->
		<!-- 일단 로그인한 회원만 리뷰 글 쓰기 가능  -->

		<c:if test="${sessionScope.session_type ne 'buyer'}">
			글을 쓰시려면 구매자로 로그인을 하세요
		</c:if>

		<c:if test="${sessionScope.session_type eq 'buyer'}">

			<div class="text-center">
				<form name="insertReviewForm" method="post" action="insertReviewPro.do" enctype="multipart/form-data" style="display: none">
					<table class="table table-striped">
						<tr>
							<th>별점</th>
							<td class="text-center">
								<input type="radio" name="review_rating" class="star" value="1" />
								<input type="radio" name="review_rating" class="star" value="2" />
								<input type="radio" name="review_rating" class="star" value="3" />
								<input type="radio" name="review_rating" class="star" value="4"  checked="checked"/>
								<input type="radio" name="review_rating" class="star" value="5" />
							</td>
						</tr>

						<!--  리뷰 content -->
						<tr>
							<td class="text-center" colspan="2">
								<textarea class="form-control" name="review_content" rows="5" required></textarea></td>
						</tr>					

						<!--  이미지 파일 첨부 : 첨부 개수 제한/ 용량 제한 필요  -->
						<tr>
							<td class="text-center" colspan="2">
                            <label> gif, jpg, jpeg, png 확장자인 이미지 파일만 업로드 가능합니다.    </label>
							<input type="file" class="multi" maxlength="2" name="review_files" accept="gif|jpg|png|jpeg" multiple="multiple" />
                            </td>
						</tr>

					</table>

					<!-- 보내줘야 할 파라미터 : 식당코드(식당 테이블) / 구매자(= 회원 = 글 작성자) 정보 -->
					<input type="hidden" name="review_rest_currentPage" value="${currentPage}" />
					<input type="hidden" name="review_rest" value="${rest_num}" />
					<input type="hidden" name="rest_num" value="${rest_num}" />
					<input type="hidden" name="ccp" value="${ccp}" /> 
					<input type="hidden" name="review_writer" value="${sessionScope.session_id }" />

				</form>
			</div>

			<!-- 리뷰 쓰기 버튼 -->
			<div class="text-right" id="btnInsert" style="display:block;">				
				<button class="btn btn-primary" name="btnWriteReview" onclick="return btnInsert()">리뷰 쓰기</button>
			</div>

			<!-- 리뷰 등록 버튼 -->
			<div class="text-right" id="btnSubmit" style="display:none">
				<button class="btn btn-default" name="btnSubmitReview" onclick="return btnCancel()">취소</button>				
				<button class="btn btn-primary" name="btnSubmitReview" onclick="return btnSubmit()">리뷰 등록</button>
			</div>			

		</c:if>
	</div>
	<!-- /리뷰 쓰기 col-md-12 -->

	<!-- 리뷰 보기  col-md-12 -->
	<div class="col-md-12">

		<!-- 리뷰 보기 page-header -->
	    <div class="page-header">
		  <h1>리뷰 보기</h1>
		</div>

		<!-- 리뷰 보기 -->
		<c:forEach var="reviewDTO" items="${reviewRes}">

			<!-- media -->
			<div class="media" id="readRV_${reviewDTO.review_num}">
				<!-- 일반적으로 아바타 아이콘. 우리는 없다 그런거. -->
				<a class="pull-left" href="javascript:return false;">
					<!-- <span class="glyphicon glyphicon-user"></span>  -->
					<!-- <img class="media-object" src="..." alt="...">  -->
				</a>
				<!-- 리뷰 바디 -->
				<div class="media-body">
					<div class="media-heading">
					<table>
							<tr>
								<td><strong>${reviewDTO.review_writer}</strong><em>&nbsp;|&nbsp;</em></td>
								<td><fmt:formatDate value="${reviewDTO.review_reg_date}" pattern="yyyy-MM-dd" /><em>&nbsp;|&nbsp;</em></td>

									<!-- 별점 -->
								<td>
									<c:forEach var="ratingCnt" begin="1" end="5">
			        						<c:if test="${ratingCnt le reviewDTO.review_rating }">                                
			                                    <span class="star-rating rater-0 star star-rating-applied star-rating-readonly star-rating-on" >
			                                        <a title="${ratingCnt }">${ratingCnt }</a>
			                                     </span>
			                                 </c:if> 
			                                 <c:if test="${ratingCnt gt reviewDTO.review_rating }">
			                                     <span class="star-rating rater-0 star star-rating-applied star-rating-readonly">
			                                        <a title="${ratingCnt }">${ratingCnt }</a>
			                                     </span>                    
			                                 </c:if>
			    						</c:forEach>
			    					</td>

									<!-- 작성자 = 수정, 삭제 / 작성자가 아닌 회원 = 신고하기 -->
									<td>
                                        &nbsp;&nbsp;&nbsp;&nbsp;
										<c:if test="${reviewDTO.review_writer == sessionScope.session_id}">
											<button class="btn btn-default" onclick="return updateRV_form('${reviewDTO.review_num}')">수정</button>
                                            <button class="btn btn-default" onclick="javascript:open('deleteReviewForm.do?rest_num=${rest_num}&review_rest_currentPage=${currentPage}&ccp=${ccp}&review_num=${reviewDTO.review_num}','confirm','toolbar=no, location=no, status= no, menubar=no, scrollbars=no, resizeable=no, width=300, height=135')">삭제</button>
										</c:if>
                                        <c:if test="${(sessionScope.session_id != null) && (sessionScope.session_id != reviewDTO.review_writer)}">
                                            <button type="button" class="btn btn-default" onclick="javascript:open('reportReviewForm.do?review_num=${reviewDTO.review_num}','confirm','toolbar=no, location=no, status= no, menubar=no, scrollbars=no, resizeable=no, width=800, height=450')">신고하기</button>
                                        </c:if>
									</td>
							</tr>
						</table>
					</div>

					<!-- 리뷰 글 -->
					<p>${reviewDTO.review_content}</p>

					<!-- 리뷰글 첨부사진 : 첨부사진이 있을 때만 보이도록 -->
					<c:if test="${!empty reviewDTO.review_file}">
						<c:forTokens var="reviewFileNames" items="${reviewDTO.review_file }" delims="' '">
							<c:forEach var="reviewFileName" items="${reviewFileNames}">
								<div class="img-review-group">
									<img src="${reviewFile_Path}${reviewFileName}" style="display:block; width:300px">
								</div>
							</c:forEach>
						</c:forTokens>
					</c:if>
					<!-- /리뷰글 첨부사진 : 첨부사진이 있을 때만 보이도록 -->					

				</div>
				<!-- /리뷰 바디 -->
			</div>
			<!-- /media -->
			
			<!-- 리뷰 수정 폼(review) -->
			<div id="updateRV_${reviewDTO.review_num }" style="display:none; margin: 20px">
				
					<form method="post" name="updateReviewForm" id="updateReviewForm" action="updateReviewPro.do" enctype="multipart/form-data" >
				
						<input type="hidden" name="rest_num" value="${rest_num}" />
						<input type="hidden"  name="review_rest_currentPage" value="${currentPage}" />
						<input type="hidden"  name="ccp" value="${ccp}" /> 
						<input type="hidden"  name="review_num" value="${reviewDTO.review_num}" />
						
						<div class="page-header">
		 					 <h1>리뷰 수정하기</h1>
						</div>
						<!-- 별점(review_rating) : radio 타입으로 -->
						<div class="form-group text-center">
							<table>
							<tr>
								<td><label>별점 &nbsp;&nbsp;&nbsp;</label></td>
								<td>
									<c:forEach var="cnt" begin="1" end="5">
										<c:if test="${cnt eq reviewDTO.review_rating}">
											<input type="radio" class="star" name="review_rating" value="${cnt}" checked="checked" />
										</c:if>
										<c:if test="${cnt ne reviewDTO.review_rating}">
											<input type="radio" class="star" name="review_rating" value="${cnt}" />
										</c:if>					
				                    </c:forEach>
				                 </td>
		                    </table>
		                 </div>        
		      
						<!-- 리뷰 content -->
						<div class="form-group text-center">
							<textarea class="form-control" name="review_content" rows="5" required>${reviewDTO.review_content}</textarea>
						</div>
				
						<!-- 이미지 파일 첨부 -->
							<div class="form-group text-center">
							 	<label> 새로 파일을 첨부하시면 기존에 첨부하신 파일은 삭제됩니다. <br/>
							 				  gif, jpg, jpeg, png 확장자인 이미지 파일만 업로드 가능합니다.	 </label>
			                    <input type="file" name="review_files" class="multi" maxlength="2" accept="gif|jpg|png|jpeg" multiple="multiple"/>        
							</div>
							<!-- 리뷰 작성 완료 버튼 -->
								<div class="form-group text-right">
									<button type="button" class="btn btn-default" onclick="cancelUpdateRV('${reviewDTO.review_num}')">취소</button> 
									<button type="submit" class="btn btn-primary" >수정 완료</button>
														
								</div>
					</form>
			
			</div>
			<!--  리뷰 수정 폼 끝 -->
		</c:forEach>

		<div class="text-center">
			<ul class="pagination pagination-sm">
				${pagingHtml}
			</ul>
		</div>

		<!-- /리뷰 보기 -->		

	</div>
	<!-- /리뷰 보기 col-md-12 -->

</div><!--/container-->		
<!-- End Content Part -->

<!-- Bootstrap core JavaScript
   ================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<!--  수정해도 괜찮음? -->
<script type="text/javascript" src="assets/js/jquery-1.8.2.min.js"></script>
<%-- <script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>--%>
<script src="dist/js/bootstrap.min.js"></script>

<!-- Unify -->
<!-- JS Global Compulsory -->			

<script type="text/javascript" src="assets/js/modernizr.custom.js"></script>		
<script type="text/javascript" src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>	
<!-- JS Implementing Plugins -->           
<script type="text/javascript" src="assets/plugins/flexslider/jquery.flexslider-min.js"></script>
<script type="text/javascript" src="assets/plugins/parallax-slider/js/modernizr.js"></script>
<script type="text/javascript" src="assets/plugins/parallax-slider/js/jquery.cslider.js"></script> 
<script type="text/javascript" src="assets/plugins/back-to-top.js"></script>
<!-- JS Page Level -->           
<script type="text/javascript" src="assets/js/app.js"></script>
<script type="text/javascript" src="assets/js/pages/index.js"></script>
<script type="text/javascript">
    jQuery(document).ready(function() {
      	App.init();
        App.initSliders();
        Index.initParallaxSlider();
    });
</script>

<!-- 별점 관련 js -->
<script type="text/javascript" src="assets/img/review/js/jquery.rating.js"></script>
<!-- 파일업로드 관련 js -->
<script type="text/javascript" src="assets/img/review/js/jquery.form.js"></script>
<script type="text/javascript" src="assets/img/review/js/jquery.MultiFile.js"></script>





<!--[if lt IE 9]>
    <script src="assets/js/respond.js"></script>
<![endif]-->
<script type="text/javascript">
	var _gaq = _gaq || [];
	_gaq.push([ '_setAccount', 'UA-29166220-1' ]);
	_gaq.push([ '_setDomainName', 'htmlstream.com' ]);
	_gaq.push([ '_trackPageview' ]);

	(function() {
		var ga = document.createElement('script');
		ga.type = 'text/javascript';
		ga.async = true;
		ga.src = ('https:' == document.location.protocol ? 'https://ssl'
				: 'http://www')
				+ '.google-analytics.com/ga.js';
		var s = document.getElementsByTagName('script')[0];
		s.parentNode.insertBefore(ga, s);
	})();
</script>

</body>
</html>