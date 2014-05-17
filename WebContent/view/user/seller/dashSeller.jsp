<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ page isELIgnored="false" %> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
        <link href="/emenu/dist/css/bootstrap.min.css" rel="stylesheet">
        
        <!--  Datepicker CSS -->
        <link href="/emenu/assets/css/jquery-ui-1.10.4.custom.min.css" rel="stylesheet">
        
        
        <!-- Custom styles for this template -->
        <link href="/emenu/view/jogiyo.css" rel="stylesheet">
        <link href="/emenu/view/common/common-template.css" rel="stylesheet">
        <link href="/emenu/view/user/dashboard.css" rel="stylesheet">
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
        <!-- END of header -->
      
        <!-- container -->
		<div class="container-fluid">
		  <!-- row -->
	      <div class="row">
	        <!-- sidebar -->
	        <div class="col-sm-3 col-md-2 sidebar">
	          <ul class="nav nav-sidebar">
	            <li><a href="/emenu/user/get.do?user_type=${session_type}&user_id=${session_id}">회원정보</a></li>
	            <li class="active"><a href="/emenu/user/dashSeller.do?sesssion_id=${session_id}">판매목록</a></li>
	          </ul>
	        </div>
	        <!-- /.sidebar -->
	        <!-- main -->
	        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <!-- 상단 : 기간 검색조건 창 -->
            
                <div class="col-md-12" style="margin-top: 20px">
                <!--  기간 검색조건 폼  -->
                    <form name="searchDate" method="post" action="/emenu/user/dashSeller.do">
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
                                        <input type="text" class="form-control" id="startDate" name="startDate" value="${searchDTO.startDate}" required/> 
                                        <span class="input-group-addon">부터</span>  
                                    </div> 
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="endDate" name="endDate" value="${searchDTO.endDate}" required/>
                                        <span class="input-group-addon">까지</span>  
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="text-right" colspan="2"> 
                                        <button type="reset" class="btn btn-default">지우기</button>
                                        <button type="submit" class="btn btn-primary">검 색</button>
                                </td>
                            </tr>
                            </table>
                    </form>
                </div>
                <!-- /.상단 : 기간 검색  -->
            <!-- 중단 :  쿠폰 사용 요청 내역 -->
                <div class="col-md-12">
                <form method="post" action="/emenu/user/responseCPN.do" >
                    <div class="col-md-12">
                        <table class="table table-hover text-center">
                            <tr>
                                <th></th>
                                <th class="text-center">결제 번호</th>
                                <th class="text-center">주문 메뉴</th>
                                <th class="text-center">주문 가격</th>
                                <th class="text-center">쿠폰 번호</th>
                                <th class="text-center">구매자</th>
                                <th class="text-center">결제일</th>
                            </tr>
                            <c:forEach var="cpnDTO" items="${cpnRes}">
                                <tr>
                                    <td><input type="checkbox" name="requestPaid_num" value="${cpnDTO.paid_num}" /></td>
                                    <td>${cpnDTO.paid_num }</td>
                                    <td>${cpnDTO.paid_restopt_subject}</td>
                                    <td>${cpnDTO.paid_restopt_priceplus }</td>
                                    <td>${cpnDTO.paid_cpn }</td>
                                    <td>${cpnDTO.session_id }</td>
                                    <td><fmt:formatDate value="${cpnDTO.paid_reg_date }" pattern="yyyy-MM-dd hh:mm:ss" /></td>
                                 </tr> 
                            </c:forEach>
                        </table>
                    </div>
                    <div class="col-md-12 text-right">
                        <button type="submit" class="btn btn-primary">쿠폰사용 수락</button>
                    </div>
                </form>
                
                </div>
             <!-- /.중단 : 쿠폰 사용 요청 내역 -->   
             
            <!--  하단  -->
           	<!-- 하단 좌측 : 결제 내역 -->
                <div class="col-md-6">
                    <table class="table table-bordered table-hover">
                        <caption class="text-left">
                            <font size="3px"><B>결제 내역</B></font>
                            <font size="2px"> ( ${searchDTO.startDate } ~ ${searchDTO.endDate } )</font>        
                        </caption>
                        <tr>
                            <th class="text-center">결제코드</th>
                            <th class="text-center">메 뉴</th>
                            <th class="text-center">메뉴가격</th>
                            <th class="text-center">구 매 자</th>
                            <th class="text-center">주 문 일</th>
                        </tr>
                        <c:forEach var="paidDTO" items="${paidRes}">
                        <tr>
                            <td class="text-center">${paidDTO.paid_num}</td>
                            <td class="text-center">${paidDTO.paid_restopt_subject }</td>
                            <td class="text-center">${paidDTO.paid_restopt_subject}</td>
                            <td class="text-center">${paidDTO.session_id}</td>
                            <td class="text-center"><fmt:formatDate value="${paidDTO.paid_reg_date}" pattern="yyyy.MM.dd  HH:mm:ss" /></td>
                        </tr>
                        </c:forEach>
                    </table>
                </div>
                <!-- /.하단 좌측 : 결제 내역 -->
                <!-- 하단 우측 : 인기 메뉴 -->
                <div class="col-md-6">
                    <table class="table table-bordered table-hover">
                        <caption class="text-left">
                          	<font size="3px"><B> 인기 메뉴</B></font>  <font size="2px"> ( ${searchDTO.startDate } ~ ${searchDTO.endDate } ) </font>
                        </caption>
                        <tr>
                            <th class="text-center">메뉴명</th>
                            <th class="text-center">매출 건수</th>
                            <th class="text-center">매출 금액</th>
                        </tr>
                        <c:forEach var="menuDTO" items="${menuRes }">
                        <tr>
                            <td class="text-center">${menuDTO.paid_restopt_subject}</td>
                            <td class="text-center">${menuDTO.paid_sales_volume }</td>
                            <td class="text-center">${menuDTO.paid_sales_price }</td>
                        </tr>
                        </c:forEach>
                    </table>
                </div>
                <!-- /. 하단 우측 : 인기 메뉴 -->
            </div>
            </div>
        </div>
        <!-- /.container -->
    
        <!-- Bootstrap core JavaScript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
        <script src="/emenu/dist/js/bootstrap.min.js"></script>
        
         <!--  Datepicker JS -->
        <script type="text/javascript" src="/emenu/assets/js/jquery-ui-1.10.4.custom.min.js"></script>
        <script type="text/javascript" src="/emenu/assets/js/jquery.ui.datepicker-ko.js"></script>
        <script>
             $(function() {
              	$( "#startDate" ).datepicker({
              		changeYear: true,
                    showButtonPanel: true,   //달력아래 닫기 버튼 오늘가기 버튼 출력
                    dateFormat: "yy-mm-dd", //날짜 출력 형식
                    minDate : '-2y',
                    maxDate : '+0'   
              	});
            	$("#endDate").datepicker({   //달력 2개가 필요하기 때문에 추가
            		changeYear: true,
                    showButtonPanel: true,   
                    dateFormat: "yy-mm-dd", //날짜 출력 형식
                    minDate : '-2y',
                    maxDate : '+0'       
            	});
             });
 </script>        
    </body>
</html>