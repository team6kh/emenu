<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ page isELIgnored="false" %> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="">
		<meta name="author" content="huks">
		<link rel="shortcut icon" href="assets/ico/jogiyo.png">
		
		
		<!-- Bootstrap core CSS -->
		<link href="dist/css/bootstrap.min.css" rel="stylesheet">
		
		<!-- Custom styles for this template -->
		<link href="view/jogiyo.css" rel="stylesheet">
		<link href="view/common/common-template.css" rel="stylesheet">
		<title>상품 수정 페이지</title>
	
		<script type="text/javascript">
				
			fields = 1;

			function addInput(a, b, c) {
				if (fields != 16) {

					document.getElementById('text').innerHTML += "<div>옵션명"+ fields
												+ ".&nbsp&nbsp <input type='text' name='restopt_subject"+fields+"'  value='"+a+"'' /> <br/>"
												+ "옵션가"
												+ fields
												+ ".&nbsp&nbsp <input type='text' name='restopt_priceplus"+fields+"' value='"+b+"'/> 원<br/>"
												+ "&nbsp&nbsp 현재 업로드된 파일명 : "+c+"<br/> 재 업로드시 기존 파일은 삭제 됩니다. <input type='file' name='optupload"+fields+"' />"
												+ "<a href='#' onclick='removeInput(this.parentNode)' />옵션"+fields+"제거 <br/><hr></div>";
					fields += 1;
				} else {
					document.getElementById('stop').innerHTML += "&nbsp;&nbsp;&nbsp;&nbsp;<font color='#FF0000'>옵션은 최대 15개만 등록할 수 있습니다.</font><br/>";
					document.form.add.disabled = true;
				}
			}

			function removeInput(el) {
				if (fields > 0) {
					document.getElementById('stop').innerHTML = "";
					var parent = document.getElementById('text');
					parent.removeChild(el);
					fields -= 1;
				}
			}

			function validation() {
				var frm = document.getElementById("insertRestForm");

				if (frm.rest_subject.value == "") {
					alert("상품명을 입력해주세요.");
					return false;
				} else if (frm.mainphoto.value == "") {
					alert("매인사진을 업로드해주세요.");
					return false;
				} else if (frm.contentphoto.value == "") {
					alert("상세설명사진을 업로드해주세요.");
					return false;
				}
				return true;
			}

			function optvalidation() {
				var frm = document.getElementById("insertOptRestForm");

				if (frm.restopt_subject.value == "") {
					alert("옵션명을 입력해주세요.");
					return false;
				} else if (frm.restopt_priceplus.value == "") {
					alert("옵션가격을 입력해주세요.");
					return false;
				}
				return true;
			}
			
			
			
			
			var checkobj

		</script>
	</head>
  
	<body>
	
		<!-- header -->
		<%@ include file="/view/common/header.jsp"%>
		<!-- end of header -->
	
		<!-- container -->
		<div class="container">
		
			<table width="600" border="0" cellspacing="0" cellpadding="2" align="center">
				<tr><td colspan="2" ><br/></td></tr>
				<tr>
					<td align="center">
						<h2>상품 등록 페이지</h2><br/><br/><br/>
					</td>
				</tr>
			</table>
			
			
			<form name="updateRestForm" action="updateRest.action" method="post" enctype="multipart/form-data">
				<input type="hidden" name="rest_num" value="${rest_num}" />
				<input type="hidden" name="currentPage" value="${currentPage}" />
				
				
				<table width=75% border="0" cellspacing="0" cellpadding="0" align="center">
					<tr bgcolor="#777777">
						<td height="1" colspan="2"></td>
					</tr>
					
					<tr><td colspan="2" ><hr></td></tr>
					
					<tr align="center">
						<td align="right" ><font size=3><b>상품명</b></font>&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td align="left">
							<input type="text" name="rest_subject" value="${resultClass.rest_subject}"  />
						</td>
					</tr>
					<tr>
						<td height="1" colspan="2"></td>
					</tr>
					
					<tr><td colspan="2" ><br/></td></tr>
					
					<tr align="center">
						<td align="right">
							<input type="button"  name="add" value="옵션추가" onclick="addInput()"/>
							&nbsp;&nbsp;&nbsp;&nbsp;
						</td>
						<td align="left">
							<div id="stop"></div>
							<font color='#BDBDBD'>옵션명, 옵션가 정의 및 옵션사진을 업로드해주세요.</font>
						</td>
					</tr>
					
					<tr><td colspan="2" ><br/></td></tr>
					
					<tr align="center">
						<td align="right">
							&nbsp;&nbsp;&nbsp;&nbsp;
						</td>
						<td align="left">
							<div id="text">
								<!-- 옵션추가 클릭시 여기에 태그 추가 -->
								
								<!-- 아래는 기존 옵션 불러온 것 -->
								<c:forEach var="list" items="${list}">
									<script>
										addInput ('${list.restopt_subject}' , '${list.restopt_priceplus}', '${list.restopt_savname}');
									</script>
								</c:forEach>
							</div>
						</td>
					</tr>
					
					<tr><td colspan="2" ><br/></td></tr>
					
					
					<tr align="center">
						<td align="right"><font size=3><b>지역 카테고리</b></font>&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td align="left">
							<select name = "rest_localcategory">
								<option value = "11">서울 지역</option>
								<option value = "12">경기/인천</option>
								<option value = "13">부산/경남</option>
								<option value = "14">대구/경북</option>
								<option value = "15">대전/전북</option>
								<option value = "16">광주/전남</option>
								<option value = "16">그외 지역</option>
							</select>
						</td>
					</tr>
					
					<tr><td colspan="2" ><br/></td></tr>
					    
					<tr align="center">
						<td align="right"><font size=3><b>종류 카테고리</b></font>&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td align="left">
							<select name = "rest_typecategory">
								<option value = "21">한식</option>
								<option value = "22">양식</option>
								<option value = "23">중식</option>
								<option value = "24">일식</option>
								<option value = "25">기타</option>
							</select>
						</td>
					</tr>
					
					<tr><td colspan="2" ><br/></td></tr>
					
					
					<tr align="center">
						<td align="right">
							<font size=3><b>매인 사진 업로드</b></font>&nbsp;&nbsp;&nbsp;&nbsp;<br/><br/><br/>
						</td>
						<td align="left">
							<input type="file" name="upload1"/>
							<c:if test="${resultClass.rest_main_orgname != NULL}">
								&nbsp; * ${resultClass.rest_main_orgname} 재업로드시 기존파일은 삭제됩니다.
							</c:if>
							<font color="grey">상품이 매인리스트에 노출될 이미지를 업로드 해주세요. <br/> 최적 이미지 크기 125x125 </font>
						</td>
					</tr>
					
					<tr><td colspan="2" ><br/></td></tr>
					
					<tr align="center">
						<td align="right">
							<font size=3><b>상세 사진 업로드</b></font>&nbsp;&nbsp;&nbsp;&nbsp;<br/><br/><br/>
						</td>
						<td align="left">
							<input type="file" name="upload2"/>
							<c:if test="${resultClass.rest_content_orgname != NULL}">
								&nbsp; * ${resultClass.rest_content_orgname} 재업로드시 기존파일은 삭제됩니다.
							</c:if>
							<font color="grey">상품의 배경에 노출될 이미지를 업로드 해주세요. <br/> 최적 이미지 크기 1280x200 </font>
						</td>
					</tr>
					
					<tr><td colspan="2" ><br/></td></tr>
					<tr><td colspan="2" ><hr></td></tr>
					<tr><td colspan="2" ><br/></td></tr>
					
					<tr>
						<td align="right" colspan="2">
							<input name="submit" type="submit" value="상품 수정" />
							<input name="cancel" type="button" value="상품 수정 취소" onClick="javascript:location.href='readRest.action?rest_num=${rest_num}&currentPage=${currentPage}'" />
						</td>
					</tr>
					
					<tr><td colspan="2" ><br/></td></tr>
					<tr><td colspan="2" ><br/></td></tr>
				</table>
				
			</form>
				
		</div>
	</body>
</html>
