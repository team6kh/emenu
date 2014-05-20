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
<link rel="shortcut icon" href="assets/ico/jogiyo.png">

<title>eMenu</title>

<script type="text/javascript">
	function closeAlert() {
		self.close();
		//window.location.reload(true);
	}
</script>

</head>

<body>

	<form method="post"  onsubmit="confirm()" >
		<table class="table table-striped table-forum" align="center">
			<tr>
				<td align="center">
					장바구니를 비웠습니다<br/>
					<input type="button" value="확인" onclick="closeAlert()">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>