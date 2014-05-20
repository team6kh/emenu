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
<link href="jogiyo.css" rel="stylesheet">
<link href="common/common-template.css" rel="stylesheet">

</head>

<body>
	
	<script type="text/javascript">
//		function locationURL() {
		
		if ( window.name == 'update' ) {
			alert('수정합니다.');
			window.opener.parent.location.href='updateRecipeForm.do?recipe_num=${recipe_num}&currentPage=${currentPage}';
		}		
		else if ( window.name == 'delete' ) 
		{
			alert('삭제되었습니다.');
			window.opener.parent.location.href='deleteRecipe.do?recipe_num=${recipe_num}&currentPage=${currentPage}';
		}
			
		window.close();
//		}
	</script>

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="dist/js/bootstrap.min.js"></script>
</body>
</html>