<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en" class="no-js">
	<head>
		<meta charset="UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
		<link rel="shortcut icon" href="../favicon.ico"> 
		<link rel="stylesheet" type="text/css" href="slider/css/style.css" />
		<script src="slider/js/modernizr.custom.63321.js"></script>
	</head>
	
	
	<body>
		<div class="container">	
			
			<header class="clearfix">
			</header>
			<div class="main">
				<div id="mi-slider" class="mi-slider">
					<ul>
						<li><a href="#"><img src="${ko1}" alt="img01"><h4>Boots</h4></a></li>
						<li><a href="#"><img src="${ko2}" alt="img02"><h4>Oxfords</h4></a></li>
						<li><a href="#"><img src="${ko3}" alt="img03"><h4>Loafers</h4></a></li>
						<li><a href="#"><img src="${ko4}" alt="img04"><h4>Sneakers</h4></a></li>
					</ul>
					<ul>
						<li><a href="#"><img src="${ko1}" alt="img05"><h4>Belts</h4></a></li>
						<li><a href="#"><img src="${ko1}" alt="img06"><h4>Hats &amp; Caps</h4></a></li>
						<li><a href="#"><img src="${ko1}" alt="img07"><h4>Sunglasses</h4></a></li>
						<li><a href="#"><img src="${ko1}" alt="img08"><h4>Scarves</h4></a></li>
					</ul>
					<ul>
						<li><a href="#"><img src="${ko1}" alt="img09"><h4>Casual</h4></a></li>
						<li><a href="#"><img src="${ko1}" alt="img10"><h4>Luxury</h4></a></li>
						<li><a href="#"><img src="${ko1}" alt="img11"><h4>Sport</h4></a></li>
						<li><a href="#"><img src="${ko1}" alt="img11"><h4>Sport</h4></a></li>
					</ul>
					<ul>
						<li><a href="#"><img src="${ko1}" alt="img12"><h4>Carry-Ons</h4></a></li>
						<li><a href="#"><img src="${ko1}" alt="img13"><h4>Duffel Bags</h4></a></li>
						<li><a href="#"><img src="${ko1}" alt="img14"><h4>Laptop Bags</h4></a></li>
						<li><a href="#"><img src="${ko1}" alt="img15"><h4>Briefcases</h4></a></li>
					</ul>
					<ul>
						<li><a href="#"><img src="${ko1}" alt="img12"><h4>Carry-Ons</h4></a></li>
						<li><a href="#"><img src="${ko1}" alt="img13"><h4>Duffel Bags</h4></a></li>
						<li><a href="#"><img src="${ko1}" alt="img14"><h4>Laptop Bags</h4></a></li>
						<li><a href="#"><img src="${ko1}" alt="img15"><h4>Briefcases</h4></a></li>
					</ul>
					<nav>
						<a href="#">Shoes</a>
						<a href="#">Accessories</a>
						<a href="#">Watches</a>
						<a href="#">Bags</a>
						<a href="#">test</a>
					</nav>
				</div>
			</div>
		</div><!-- /container -->
		
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
		<script src="slider/js/jquery.catslider.js"></script>
		<script>
			$(function() {

				$( '#mi-slider' ).catslider();

			});
		</script>
	</body>
</html>