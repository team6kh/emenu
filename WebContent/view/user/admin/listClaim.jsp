<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%-- <%@ page isELIgnored="false" %> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
        <link href="/emenu/view/user/dashboard.css" rel="stylesheet">
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
                        <li><a href="/emenu/user/admin/dashboard.do">dashAdmin</a></li>
                        <li class="active"><a href="/emenu/user/admin/listClaim.do">게시판 신고 내역</a></li>
                    </ul>
                </div>
                <!-- /.sidebar -->
            
                <!-- main -->
                <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th> 신고 번호 </th>
                                    <th> 신고 사유 </th>
                                    <th> 게시판/글번호 </th>
                                    <th> 글 작성자</th>
                                    <th> 글 보기 </th>
                                    <th> 신고자 </th>
                                    <th> 신고일 </th>
                                    <th> 신고 처리 </th>
                                </tr>
                                <c:forEach var="claimDTO" items="${claimRes}">
                                    <tr>
                                        <td> ${claimDTO.claim_num} </td>
                                        <td> ${claimDTO.claim_category} </td>
                                        <td> ${claimDTO.board_name} / ${claimDTO.article_num }</td>
                                        <td> ${claimDTO.article_writer } </td>
                                        <td> <button type="button" class="btn btn-default btn-block" 
                                                    onclick="javascript:open('${path}${claimDTO.article_viewUrl}','view_article',' location=no')">글 보기</button></td>
                                        <td> ${claimDTO.claimer } </td>
                                        <td><fmt:formatDate value="${claimDTO.claim_reg_date }" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
                                        <td>
                                            <c:if test="${claimDTO.claim_result == 'receive' }">
                                                <form method="post" action="updateClaim.do">
                                                    <input type="hidden" name="claim_num" value="${claimDTO.claim_num}"/>
                                                    <input type="hidden" name="board_name" value="${claimDTO.board_name}"/>
                                                    <input type="hidden" name="article_num" value="${claimDTO.article_num}"/>
                                                    <input type="hidden" name="article_delUrl" value="${claimDTO.article_delUrl}" />                                                    
                                                    <select name="claim_result">
                                                        <option value="rejection">신고 기각 </option>
                                                        <option value="admission">신고 인용 - 글 삭제</option>
                                                    </select>
                                                  <button type="submit" class="btn btn-danger btn-sm">확 인</button>  
                                                </form>
                                            </c:if>
                                            <c:if test="${claimDTO.claim_result != 'receive' }">${claimDTO.claim_result}</c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </thead>
                        </table>
                    </div>
                <!-- /.main -->
                <!-- paging -->
                <div class="text-center">
                    <ul class="pagination pagination-sm">
                        ${pagingHtml} 
                    </ul>
                </div>
                <!--  /. paging -->
            </div>
            <!--  /.row -->
        </div>
        <!-- /.container -->
        
        
        <!-- Bootstrap core JavaScript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
        <script src="/emenu/dist/js/bootstrap.min.js"></script>
    </body>
</html>