<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ page isELIgnored="false" %> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
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
		<title>상품 등록 페이지</title>

		<script type="text/javascript">

			fields = 1;

			function addInput() {
				if (fields != 16) {

					document.getElementById('text').innerHTML += "<div>옵션명"
							+ fields
							+ ".&nbsp&nbsp <input type='text' name='restopt_subject"+fields+"' value=''/> <br/>"
							+ "옵션가"
							+ fields
							+ ".&nbsp&nbsp <input type='text' name='restopt_priceplus"+fields+"' value=''/> 원<br/>"
							+ "&nbsp&nbsp <input type='file' name='optupload"+fields+"' />"
							+ "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp"
							+"<a href='#' onclick='removeInput(this.parentNode)' />옵션"+fields+"제거 <br/><hr></div>";
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

			function agreesubmit(el) {
				checkobj = el
				if (document.all || document.getElementById) {
					for (i = 0; i < checkobj.form.length; i++) {
						var tempobj = checkobj.form.elements[i]
						if (tempobj.type.toLowerCase() == "submit")
							tempobj.disabled = !checkobj.checked
					}
				}
			}

			function defaultagree(el) {
				if (!document.all && !document.getElementById) {
					if (window.checkobj && checkobj.checked)
						return true
					else {
						alert("약관에 동의 하지 않으면 상품을 등록할 수 없습니다.")
						return false
					}
				}
			}
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

			<!-- 최초 입력시에 -->
			<c:if test="${rest_num =='insert'}">
				<form name="insertRestForm" action="insertRest.do" method="post" enctype="multipart/form-data" onsubmit="return validation();">
					<!-- 임시 히든값 -->
					<input type="hidden" name="session_id" value="${sessionScope.session_id}" />
			</c:if>
			
			<!-- 수정 입력시에 -->
			<c:if test="${rest_num == 'update'}">
				<form name="updateRestForm" action="updateRest.action" method="post" enctype="multipart/form-data">
					<input type="rest_num" name="session_id" value="${resultClass.rest_num}" />
					<input type="currentPage" name="session_id" value="${currentPage}" />
					<input type="old_file1" name="session_id" value="${resultClass.file_savname1}" />
					<input type="old_file2" name="session_id" value="${resultClass.file_savname2}" />
			</c:if>

					<table width=75% border="0" cellspacing="0" cellpadding="0" align="center">
						<tr bgcolor="#777777">
							<td height="1" colspan="2"></td>
						</tr>
						<tr>
							<td colspan="2">
								<textarea cols=150 rows=16>
조기요(jogiyo) 상품등록 약관

조기요에서는 판매 관계법령에 따른 
관련 범죄 예방을 통해 올바른 컨텐츠 판매문화가 이루어 질 수 있도록 노력하고 있사오니 다음사항에 대하여 협조해주시기 바랍니다.

1.조기요에는 판매자님이 저작권을 가지고 있는 파일(이미지)이나 저작권자의 배포 및 전송 동의를 받은 파일(이미지)을 등록할 수 있습니다.
2.법에 저촉되거나 음식류 외 상품은 등록할 수 없으며 이를 판매, 배포할 시에는 관련법 등의 의해 처벌 받을 수 있습니다.
3.타인의 저작권을 침해하는 자료를 무단배포 시 저작권법 등 관련법에 의해 처벌 받을 수 있습니다.
4.조기요에서 판매하는 컨텐츠에 대한 민형사상의 책임은 등록한 회원님에게 있으며, 회사(조기요)는 이에 대해 일체의 책임을 지지 않습니다.
5.판매는 조기요에서 허용하는 형태로 진행 되어야하며 이에 부합하지 않을 경우 컨텐츠 판매가 취소될 수 있습니다.

▶ 조기요는 관련 법률에 의거하여 위 내용에 해당하는 사실이 접수되어 적발될 시 해당고객에게 사전 공지없이관련 자료 삭제 및 이용정지 가 될 수 있습니다.
▶ 특히 관련성이 없는 상품등록이나 광고글에 대해서는 회원 탈퇴를 원칙 으로 처리되니 이점 유의하시기 바랍니다
								</textarea>
							</td>
						</tr>
						<tr>
							<td colspan="2"  align="right">
								<br/>
								<input name="agreecheck" type="checkbox" onClick="agreesubmit(this)"> <b>예, 위 약관에 동의 합니다</b>
							</td>
						</tr>

						<tr><td colspan="2" ><hr></td></tr>

						<tr align="center">
							<td align="right" ><font size=3><b>상품명</b></font>&nbsp;&nbsp;&nbsp;&nbsp;</td>
							<td align="left">
								<input type="text" name="rest_subject"  value="${resultClass.rest_subject}" maxlength="50"/>
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
								<input type="file" name="upload1"  />
								<c:if test="resultClass.file_orgname1 != NULL">
									&nbsp; *${resultClass.file_orgname1} 재업로드시 기존파일은 삭제됩니다.
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
								<input type="file" name="upload2"  />
								<c:if test="resultClass.file_orgname2 != NULL">
									&nbsp; * ${resultClass.file_orgname2} 재업로드시 기존파일은 삭제됩니다.
								</c:if>
								<font color="grey">상품의 배경에 노출될 이미지를 업로드 해주세요. <br/> 최적 이미지 크기 1280x200 </font>
							</td>
						</tr>

						<tr><td colspan="2" ><br/></td></tr>
						<tr><td colspan="2" ><hr></td></tr>
						<tr><td colspan="2" ><br/></td></tr>

						<tr>
							<td align="right" colspan="2">
								<input name="submit" type="submit" value="상품 등록" disabled/>
								<input name="cancel" type="button" value="상품 등록 취소" onClick="javascript:location.href='/emenu/listRest.do?rest_localcategory=1&rest_typecategory=1'" />
							</td>
						</tr>

						<tr><td colspan="2" ><br/></td></tr>
						<tr><td colspan="2" ><br/></td></tr>
					</table>
				</form>
		</div>
	</body>
</html>