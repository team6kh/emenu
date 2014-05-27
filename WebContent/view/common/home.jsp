<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ page isELIgnored="false" %> --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="huks">
<link rel="shortcut icon" href="/emenu/assets/ico/jogiyo.png">

<title>eMenu</title>

<!-- Bootstrap core CSS -->
<link href="/emenu/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="/emenu/view/jogiyo.css" rel="stylesheet">
<link href="/emenu/view/common/common-template.css" rel="stylesheet">
<link href="/emenu/view/common/home.css" rel="stylesheet">

<!-- masonry -->
<link rel="stylesheet" type="text/css" href="assets/plugins/masonry/css/component.css" />
<script src="/emenu/assets/plugins/masonry/js/modernizr.custom.js"></script>
<!-- /.masonry -->

<style type="text/css">
.masonry {
	overflow: hidden;
	position: relative;
}

.masonry:hover .hoverdetail {
	bottom: 0;
}

.hoverdetail {
	padding: 10px;
	width: 100%;
	background-color: #000000;
	color: #ffffff;
	opacity: .7;
	position: absolute;
	bottom: -100px;
}

.grayscale {
	filter: url(/emenu/view/common/filters.svg#grayscale);
	/* Firefox 3.5+ */
	filter: gray; /* IE6-9 */
	-webkit-filter: grayscale(1);
	/* Google Chrome, Safari 6+ & Opera 15+ */
}

.grayscale:hover {
	filter: none;
	-webkit-filter: grayscale(0);
}

.filter {
	padding: 5px;
	border: 5px solid #b6991c;
	background-color: #debb27;
}

.cart {
	background-image: url('/emenu/assets/img/common/home_random_menu.png');
}

.cart:hover {
	color: #000000;
}

</style>

</head>

<body>

	<%@ include file="/view/common/header.jsp"%>

	<div class="container">
		<!-- Home Dashboard -->
		<div class="home-template">
		
			<!-- masonry -->
			<ul class="grid effect-2" id="grid">				
				<c:if test="${fn:length(listCart) ne 0}">
					<!-- 장바구니 image -->
					<li>
						<div class="masonry cart">
							<a href="/emenu/cartboard.do">
								<img								
									src="/emenu/assets/img/common/home_cart.png"
									onmouseover="this.src='/emenu/assets/img/common/home_cart_hover.png'"
									onmouseout="this.src='/emenu/assets/img/common/home_cart.png'"
									alt="N/A">
							</a>
						</div>
					</li>
					<!-- end 장바구니 image-->
					<c:forEach var="listCart" items="${listCart}">
						<li>
							<div class="masonry">
								<a href="/emenu/readRest.do?rest_num=${listCart.cart_rest_num}">
								<img class="filter" src="/emenu/${listCart.cart_restopt_destFile1}" alt="N/A"></a>
								<div class='hoverdetail'>${listCart.cart_restopt_subject}</div>
							</div>
						</li>
					</c:forEach>					
				</c:if>
				<!-- randomMenu image -->
				<li>
					<div class="masonry">
						<a href="/emenu/home.do">
							<img								
								src="/emenu/assets/img/common/home_random_menu.png"
								onmouseover="this.src='/emenu/assets/img/common/home_random_menu_hover.png'"
								onmouseout="this.src='/emenu/assets/img/common/home_random_menu.png'"
								alt="N/A">
						</a>
					</div>
				</li>
				<!-- end randomMenu image-->
				<c:forEach var="listRestOpt" items="${listRestOpt}">
					<li>
						<div class="masonry">
							<a href="/emenu/readRest.do?rest_num=${listRestOpt.restopt_rest_num}">
							<img src="${listRestOpt.restopt_destFile1}" alt="N/A"></a>
							<div class='hoverdetail'>${listRestOpt.restopt_subject}</div>
						</div>
					</li>
				</c:forEach>	
			</ul>			
			<!-- /.masonry -->
			
			<!-- 
			<div class="jumbotron">
				<h1>안녕하세요?</h1>
				<p>조기요에는 ${countRestopt}개의 메뉴와 ${countBuyer+countSeller}명의 회원, ${countPaid}번의 결재, ${countReview+countRecipe+countNotice+countQna}개의 글이 있습니다.</p>
				<p><a class="btn btn-default btn-lg" role="button">지금 가입하세요!</a></p>
			</div>  -->

		</div>
		<!-- /.Home Dashboard -->

	</div>
	<!-- /.container -->
	

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="/emenu/dist/js/bootstrap.min.js"></script>
	
	<!-- masonry -->
	<script src="/emenu/assets/plugins/masonry/js/masonry.pkgd.min.js"></script>
	<script src="/emenu/assets/plugins/masonry/js/imagesloaded.js"></script>
	<script src="/emenu/assets/plugins/masonry/js/classie.js"></script>
	<script src="/emenu/assets/plugins/masonry/js/AnimOnScroll.js"></script>
	<script>
		new AnimOnScroll( document.getElementById( 'grid' ), {
			minDuration : 0.4,
			maxDuration : 0.7,
			viewportFactor : 0.5
		} );
	</script>
	<!-- /.masonry -->
</body>
</html>