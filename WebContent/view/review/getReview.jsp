<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="shortcut icon" href="/emenu/assets/ico/jogiyo.png">
        
        <!-- Bootstrap core CSS -->
        <link href="/emenu/dist/css/bootstrap.min.css" rel="stylesheet">
        
        <!-- Custom styles for this template -->
        <link href="/emenu/view/jogiyo.css" rel="stylesheet">
        <link href="/emenu/view/common/common-template.css" rel="stylesheet">
        <link href="/emenu/view/user/dashboard.css" rel="stylesheet">
        
        <!-- 별점 관련 css -->
        <link rel="stylesheet" href="assets/img/review/css/jquery.rating.css" />
        
        <title>eMenu</title>
    </head>
    
    <body>
        <!--  container -->
        <div class="container">
        
            <div class="col-xs-12 col-sm-12 col-md-12">
                <div class="table-responsive">
                    <table class="table">
                            <tr>
                                <td><strong>${reviewDTO.review_writer}</strong><em>&nbsp;|&nbsp;</em></td>
                                <td><fmt:formatDate value="${reviewDTO.review_reg_date}" pattern="yyyy-MM-dd" /><em>&nbsp;|&nbsp;</em></td>
                
                                <!-- 별점 -->
                                <td>
                                    <c:forEach var="ratingCnt" begin="1" end="5">
                                        <c:if test="${ratingCnt le reviewDTO.review_rating }">                                
                                            <span class="star-rating rater-0 star star-rating-applied star-rating-readonly star-rating-on" >
                                                <a title="${ratingCnt }">${ratingCnt }</a>
                                            </span>
                                        </c:if> 
                                        <c:if test="${ratingCnt gt reviewDTO.review_rating }">
                                            <span class="star-rating rater-0 star star-rating-applied star-rating-readonly">
                                            <a title="${ratingCnt }">${ratingCnt }</a>
                                        </span>                    
                                        </c:if>
                                    </c:forEach>
                                </td>
                        </tr>
                    </table>
                </div>
                
                <p>${reviewDTO.review_content}</p>
                
                    <!-- 리뷰글 첨부사진 : 첨부사진이 있을 때만 보이도록 -->
                    <c:if test="${!empty reviewDTO.review_file}">
                        <c:forTokens var="reviewFileNames" items="${reviewDTO.review_file}" delims="' '">
                            <c:forEach var="reviewFileName" items="${reviewFileNames}">
                                <div class="img-review-group">
                                    <img src="${reviewFile_Path}${reviewFileName}" style="display:block; width:300px">
                                </div>
                            </c:forEach>
                        </c:forTokens>
                    </c:if>
                <!-- /리뷰글 첨부사진 -->   
            </div>
                
        </div>
        <!-- /.container -->
        
        
        <!-- Bootstrap core JavaScript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
        <script src="/emenu/dist/js/bootstrap.min.js"></script>
        
        <!-- 별점 관련 js -->
        <script type="text/javascript" src="assets/img/review/js/jquery.rating.js"></script>
    
    </body>
</html>