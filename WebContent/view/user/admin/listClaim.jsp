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
        
        <script type="text/javascript">
        	function validation() {
        		var article_num = document.getElementById("search_article_num").value;
        		if(article_num == "")
        			{
        				alert("검색할 글 번호를 입력하세요.");
        			}
        		else
        			{
        				document.getElementById("searchClaimForm").submit();
        			}
				
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
                        <li><a href="/emenu/user/admin/dashboard.do">dashAdmin</a></li>
                        <li class="active"><a href="/emenu/user/admin/listClaim.do">게시판 신고 내역</a></li>
                    </ul>
                </div>
                <!-- /.sidebar -->
            
                <!-- main -->
                <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                    <!-- searchClaimForm -->
                    <div style="margin-bottom: 30px">
                        <form action="searchClaim.do" method="post" id="searchClaimForm" class="form-inline">
                            <div class="form-group">
                                <label>게시판명</label>
                                    <select name="board_name" class="form-control">
                                            <option value="review">후기 게시판</option>
                                            <option value="recipe">레시피 게시판</option>
                                    </select>
                            </div>
                            <div class="form-group">
                                <label>글 번호</label>
                               <input type="number" name="article_num" id="search_article_num" class="form-control">
                            </div>
                            <button type="button" class="btn btn-success" onclick="return validation()">검 색</button>
                            </form>
                      </div>
                    <!-- /.searchClaimForm -->
                    <!--  신고내역 list -->
                    <div class="table-responsive text-center">
                        <table class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th> 신고 번호 </th>
                                    <th> 신고 분류 </th>
                                    <th> 상세 사유 </th>
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
                                        <td> ${claimDTO.claim_category}</td>
                                        <td> ${claimDTO.claim_reason} </td>
                                        <td> ${claimDTO.board_name} / ${claimDTO.article_num }</td>
                                        <td> ${claimDTO.article_writer } </td>
                                        <td> 
                                                <c:if test="${claimDTO.claim_result == 'admission' }">
                                                    삭제된 글입니다.
                                                </c:if>
                                                <c:if test="${claimDTO.claim_result != 'admission' }">
                                                    <button type="button" class="btn btn-default btn-block" 
                                                    onclick="javascript:open('${path}${claimDTO.article_viewUrl}','view_article',' location=no, height=450')">글 보기</button>
                                                </c:if>
                                        </td>
                                        <td> ${claimDTO.claimer } </td>
                                        <td><fmt:formatDate value="${claimDTO.claim_reg_date }" pattern="yyyy-MM-dd"/> </td>
                                        <td>
                                            <c:if test="${claimDTO.claim_result == 'receive' }">
                                                <form method="post" action="updateClaim.do">
                                                    <input type="hidden" name="claim_num" value="${claimDTO.claim_num}"/>
                                                    <input type="hidden" name="board_name" value="${claimDTO.board_name}"/>
                                                    <input type="hidden" name="article_num" value="${claimDTO.article_num}"/>
                                                    <input type="hidden" name="${claimDTO.board_name}_num" value="${claimDTO.article_num}"/>
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
                    <!-- /. 신고내역 list -->
                <!-- /.main -->
                <!-- paging -->
                <div class="text-center">
                    <ul class="pagination pagination-sm">
                        ${pagingHtml} 
                    </ul>
                </div>
                <!--  /. paging -->
                </div>
                <!-- /.main -->
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