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
	
	
	<title>JOGIYO</title>
	
	<!-- Bootstrap core CSS -->
	<link href="/emenu/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Custom styles for this template -->
	<link href="/emenu/view/jogiyo.css" rel="stylesheet">
	<link href="/emenu/view/common/common-template.css" rel="stylesheet">

	<style type="text/css">
	.progress {
		width: 1px;
		height: 14px;
		color: white;
		font-size: 12px;
		overflow: hidden;
		background-color: navy; /*바의 배경색상*/
		padding-left: 5px;
	}
	</style>

	<script type="text/JavaScript">
		function textCounter(field, counter, maxlimit, linecounter) {
			var fieldWidth = parseInt(field.offsetWidth);
			var charcnt = field.value.length;

			if (charcnt > maxlimit) {
				field.value = field.value.substring(0, maxlimit);
			}else {
				var percentage = parseInt(100 - ((maxlimit - charcnt) * 100)
						/ maxlimit);
				document.getElementById(counter).style.width = parseInt((fieldWidth * percentage) / 100)
						+ "px";
				document.getElementById(counter).innerHTML = "Limit: "
						+ percentage + "%"
				setcolor(document.getElementById(counter), percentage,
						"background-color");
			}
		}

		function setcolor(obj, percentage, prop) {
			obj.style[prop] = "rgb(80%," + (100 - percentage) + "%,"
					+ (100 - percentage) + "%)";
		}
	</script>
			
	
	<style type="text/css">
		html {
			height: 100%
		}
		body {
			height: 100%;
			margin: 3% 0% 0% 1.5%;
			padding: 0
		}
	</style>
	
	<script type="text/javascript">
		function btnSubmit() {
			var sendMail = document.sendMail;
			sendMail.submit();
		}
	
		//Created by: Paul Tuckey | http://tuckey.org/ */
		function countLines(strtocount, cols) {
			var hard_lines = 1;
			var last = 0;
			while (true) {
				last = strtocount.indexOf("\n", last + 1);
				hard_lines++;
				if (last == -1)
					break;
			}
			var soft_lines = Math.round(strtocount.length / (cols - 1));
			var hard = eval("hard_lines  " + unescape("%3e") + "soft_lines;");
			if (hard)
				soft_lines = hard_lines;
			return soft_lines;
		}
		function cleanForm() {
			var the_form = document.forms[0];
			for ( var x in the_form) {
				if (!the_form[x])
					continue;
				if (typeof the_form[x].rows != "number")
					continue;
				the_form[x].rows = countLines(the_form[x].value, the_form[x].cols) + 1;
			}
			setTimeout("cleanForm();", 0);
		}
	
		// Multiple onload function created by: Simon Willison
		// http://simon.incutio.com/archive/2004/05/26/addLoadEvent
		function addLoadEvent(func) {
			var oldonload = window.onload;
			if (typeof window.onload != 'function') {
				window.onload = func;
			} else {
				window.onload = function() {
					if (oldonload) {
						oldonload();
					}
					func();
				}
			}
		}
	
		addLoadEvent(function() {
			cleanForm();
		});
	</script>
</head>

<body>
	<!-- header -->
	<%@ include file="/view/common/header.jsp"%>
	<!-- end of header -->
	
	<!-- container -->
	<div class="container">
		
		<div class="col-md-12">
			<br/><br/>
			<h3>문의하기</h3>
			<img src="/emenu/assets/img/common/Jogiyo_main.png" width="250px" height="100px">
		</div>
		
		<div class="col-md-12" align="center">
			<font color=green size=5 ><b>판매자에게 메일을 보낼 수 있습니다.</b></font><br/><br/>
		</div>
		
		<div class="col-md-12 well">
			<form id="sendMail" action="/emenu/email/customerServiceSend.do"> 
				<input type="hidden" name="rest_writer_email" value="${rest_writer_email}" />
				<input type="hidden" name="session_id" value="${sessionScope.session_id}" />
				
				<table align="center">
					<tr>
						<td>
							<font size=3><b>이메일</b></font><br/>
							<font size=2 color=gray>답장받으실 이메일 주소를 입력하세요</font>
						</td>
					</tr>
					<tr align="center">
						<td align="left"><input type=text name= "email" ></input></td>
					</tr>
					<tr>
						<td>
							<font size=3><b>문의사항</b></font> <br/>
							<font size=2 color=gray>글자 수는 최대 200자까지 입력 가능합니다.</font>
						</td>
					</tr>
					<tr align="center">
						<td align="left">
							<textarea cols="70" rows="7" name="content" style="overflow:hidden;" id="maxcharfield" onKeyDown="textCounter(this,'progressbar1',200)" 
																onKeyUp="textCounter(this,'progressbar1',200)" 
																onFocus="textCounter(this,'progressbar1',200)" >
							</textarea><br />
							<div id="progressbar1" class="progress"></div>
							<script>textCounter(document.getElementById("maxcharfield"),"progressbar1",200)</script>
	                    </td>
					</tr>
					<tr><td><br/><td></tr>
					<tr><td><br/><td></tr>
					<tr align="center">
						<td></td>
						<td>
							<button class="btn btn-primary" name="btnSubmit" onclick="return btnSubmit()">문의메일 보내기</button>
							<a href="readRest.do?rest_num=${rest_num}&currentPage=${currentPage}" class="btn btn-danger">취소</a>
						</td>
					</tr> 
				</table>
			</form>
			
		</div>
		
	</div>
	<!-- end of container -->
				
	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="dist/js/bootstrap.min.js"></script>

</body>	