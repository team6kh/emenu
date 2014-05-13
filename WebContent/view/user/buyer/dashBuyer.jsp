<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<meta name="author" content="huks">
<link rel="shortcut icon" href="assets/ico/jogiyo.png">

<title>JOGIYO</title>

<!-- Bootstrap core CSS -->
<link href="dist/css/bootstrap.min.css" rel="stylesheet">

<!--  Datepicker CSS -->
<link href="assets/css/jquery-ui-1.10.4.custom.min.css" rel="stylesheet">


<!-- Custom styles for this template -->
<link href="view/jogiyo.css" rel="stylesheet">
<link href="view/user/dashboard.css" rel="stylesheet">


<script type="text/javascript">
       			// 오늘 버튼 눌렀을 때 날짜 설정
		       function setToday() {
		    	   var now = new Date();

		           var day = ("0" + now.getDate()).slice(-2);
		           var month = ("0" + (now.getMonth() + 1)).slice(-2);
		           var today = now.getFullYear()+"-"+(month)+"-"+(day) ;
		           $('#startDate').val(today);
              	   $('#endDate').val(today);

				}
       			// 이번 주 버튼 눌렀을 때 날짜 설정
		       function setThisWeek() {
		    	   var now = new Date();


		           var oneWeekAgo = new Date();
		           oneWeekAgo.setDate(now.getDate() - 7);

		           var day = ("0" + oneWeekAgo.getDate()).slice(-2);
		           var month = ("0" + (oneWeekAgo.getMonth() + 1)).slice(-2);

		           var week = oneWeekAgo.getFullYear() + "-" + (month) + "-" + (day);

		           $('#startDate').val(week);
		           setEndDate();

				}
		       // 이번 달 버튼 눌렀을 때 날짜 설정
		       function setThisMon() {
		    	   var now = new Date();
		           var oneMonthAgo = new Date();
		           oneMonthAgo.setMonth(now.getMonth() -1);


		           var day = ("0" + oneMonthAgo.getDate()).slice(-2);
		           var month = ("0" + (oneMonthAgo.getMonth() + 1)).slice(-2);

		           var oneMon = oneMonthAgo.getFullYear() + "-" + (month) + "-" + (day);

		           $('#startDate').val(oneMon);
		           setEndDate();
				}
		       // 최근 6개월 버튼 눌렀을 때 날짜 설정
		       function setLastSixMon() {
		    	   var now = new Date();
		           var sixMonthAgo = new Date();
		           sixMonthAgo.setMonth(now.getMonth() - 6);


		           var day = ("0" + sixMonthAgo.getDate()).slice(-2);
		           var month = ("0" + (sixMonthAgo.getMonth() + 1)).slice(-2);

		           var sixMon = sixMonthAgo.getFullYear() + "-" + (month) + "-" + (day);

		           $('#startDate').val(sixMon);
		           setEndDate();
				}
		       // 마지막 날짜 값 설정
		       function setEndDate() {
		    	   var now = new Date();

		           var day = ("0" + now.getDate()).slice(-2);
		           var month = ("0" + (now.getMonth() + 1)).slice(-2);
		           var today = now.getFullYear()+"-"+(month)+"-"+(day) ;

		           $('#endDate').val(today);

			}


       </script> 
         
</head>

<body>
	<!-- header -->
	<%@ include file="/view/common/header.jsp"%>
	<!-- /.header -->

	<!-- container -->
	<div class="container-fluid">
		<!-- row -->
		<div class="row">

			<!-- sidebar -->
			<div class="col-sm-3 col-md-2 sidebar">
				<ul class="nav nav-sidebar">
					<li><a href="readUser.action?user_type=${session_type}&user_id=${session_id}">회원정보</a></li>
					<li class="active"><a href="dashBuyer.action?session_id=${session_id}">구매목록</a></li>
					<li><a href="listMyRecipe.action?session_id=${session_id}">마이 레시피</a></li>
					<li><a href="listMyQna.action?session_id=${session_id}">마이 문의하기</a></li>
				</ul>
			</div>
			<!-- /.sidebar -->

			<!-- main -->
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

				<!-- 여기에 작성해주시면 됩니다. -->
				<!-- col-md-12 -->
				<div class="col-md-12" style="margin-top: 20px">
                
                	<!--  기간 검색조건 폼  -->
                    <form name="searchDate" method="post" action="listMyCoupon.action">
                          <table class="table" >
                            <tr>
                                <th colspan="2">  기간별 검색 </th>
                            </tr>
                            <tr>
                                <td class="text-center" colspan="2">
                                        <button type="button" class="btn btn-default" name="todayStats" onclick="setToday()" >오늘</button> &nbsp;
                                        <button type="button" class="btn btn-default" name="weekStats" onclick="setThisWeek()" >이번 주</button> &nbsp;   
                                        <button type="button" class="btn btn-default" name="monthStats" onclick="setThisMon()">이번 달</button> &nbsp;
                                        <button type="button" class="btn btn-default" name="mon6Stats" onclick="setLastSixMon()">최근 6개월</button> &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="input-group">
                                    	<!-- 크롬에서는 date type을 지원한다. -->
                                        <input type="text" class="form-control" id="startDate" name="startDate" value="${searchDTO.startDate}"/> 
                                        <span class="input-group-addon">부터</span>  
                                    </div> 
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="endDate" name="endDate" value="${searchDTO.endDate}"/>
                                        <span class="input-group-addon">까지</span>  
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="text-right" colspan="2"> 
                                	<input type="hidden" name="session_id" value="${session_id}" />
                                        <button type="reset" class="btn btn-default">지우기</button>
                                        <button type="submit" class="btn btn-primary">검 색</button>
                                </td>
                            </tr>
                            </table>
                    </form>
                    <!-- /.기간 검색조건 폼  -->
				
					<!-- 테이블 div-->
					<div>
						<table class="table table-stiped text-center">
							<tr align="center" bgcolor="">
								<td><strong>번호</strong></td>
								<td><strong>매장</strong></td>
								<td><strong>품목</strong></td>
								<td><strong>가격</strong></td>
								<!-- <td><strong>품목이미지</strong></td> -->
								<td><strong>쿠폰</strong></td>
								<!--<td><strong>사용식별코드</strong></td> -->
								<td><strong>사용현황</strong></td>
								<!-- <td><strong>구매자</strong></td> -->
								<td><strong>구매날짜</strong></td>
							</tr>
							
							<c:forEach var="list" items="${list}">
								<tr>
									<td>${list.paid_num} </td>
									<td>${list.paid_rest_subject} </td>
									<td>${list.paid_restopt_subject} </td>
									<td>${list.paid_restopt_priceplus}&nbsp;원 </td>
									<!-- <td>이미지 사진뜨는곳. </td> -->
									<td>${list.paid_cpn} </td>
									<!-- <td>${list.paid_cpn_used} </td> -->
									<!-- 사용요청 -->
									<c:if test="${list.paid_cpn_used eq 0 }">
									<td><a href="requestCpn.action?paid_num=${list.paid_num}&session_id=${session_id}" class="btn btn-primary">사용요청</a></td>
									</c:if>
									<!-- 요청대기 -->	
									<c:if test="${list.paid_cpn_used eq 1 }">
									<td><button class="btn btn-warning">요청대기</button></td>
									</c:if>
									<!-- 사용완료 -->	
									<c:if test="${list.paid_cpn_used eq 2 }">
									<td><button class="btn btn-danger">사용완료</button></td>
									</c:if>									
									<!-- <td>${list.session_id} </td> -->
									<td><fmt:formatDate value="${list.paid_reg_date}" pattern="yyyy-MM-dd hh:mm:ss" /></td>
								</tr>
							</c:forEach>
	
							<%-- 
							<s:iterator value="list" status="stat">
								<s:url id="viewURL" action="readRecipe">
									<s:param name="paid_num">
										<s:property value="paid_num" />
									</s:param>
									<s:param name="currentPage">
										<s:property value="currentPage" />
									</s:param>
								</s:url>
	
								<tr bgcolor="#FFFFFF" align="center">
									<td><s:property value="list.paid_num" /></td>
									<td align="center">&nbsp;<s:a href="%{viewURL}"><s:property value="list.paid_rest_subject" /></s:a></td>
									<td align="center"><s:property value="list.paid_restopt_subject" /></td>
									<td align="center"><s:property value="list.paid_restopt_priceplus" /></td>
									<td align="center"><s:property value="list.paid_restopt_destfile1" /></td>
									<td align="center"><s:property value="list.paid_cpn" /></td>
									<td align="center"><s:property value="list.paid_cpn_used" /></td>
									<td align="center"><s:property value="list.session_id" /></td>
									<td align="center"><s:property value="list.paid_reg_date" /></td>
								</tr>
							</s:iterator> --%>
	
							<s:if test="list.size() <= 0">
	
								<tr bgcolor="#FFFFFF" align="center">
									<td colspan="10">등록된 게시물이 없습니다.</td>
								</tr>
								<tr bgcolor="#777777">
									<td height="1" colspan="10"></td>
								</tr>
	
							</s:if>
						</table>
					</div>
					<!-- /.테이블 div -->
				</div>
				<!-- /.col-md-12 -->

				<!-- 페이징 -->
				<div class="text-center">
					<ul class="pagination pagination-sm">
						<s:property value="pagingHtml" escape="false" />
					</ul>
				</div>
				<!-- /페이징 -->

				<!-- 버튼 -->
				<!-- /버튼 -->

			</div>
			<!-- /.main -->
		</div>
		<!-- /.row	-->
	</div>
	<!-- /.container -->

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="dist/js/bootstrap.min.js"></script>
    <!--  Datepicker JS -->
        <script type="text/javascript" src="assets/js/jquery-ui-1.10.4.custom.min.js"></script>
        <script type="text/javascript" src="assets/js/jquery.ui.datepicker-ko.js"></script>
        <script>
             $(function() {
                $( "#startDate" ).datepicker({
                    changeYear: true,
                    showButtonPanel: true,   //달력아래 닫기 버튼 오늘가기 버튼 출력
                    dateFormat: "yy-mm-dd", //날짜 출력 형식
                    maxDate : '+0'   
                });
                $("#endDate").datepicker({   //달력 2개가 필요하기 때문에 추가
                    changeYear: true,
                    showButtonPanel: true,   
                    dateFormat: "yy-mm-dd", //날짜 출력 형식
                    maxDate : '+0'       
                });
             });
 </script>        
</body>
</html>
