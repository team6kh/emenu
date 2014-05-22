<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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

<title>eMenu</title>
</head>

<body>
    <div class="container">
        <div class="col-xs-12">
            <h3>신고하기</h3>
            <div class="col-xs-12 text-center">
                <form action="${actionUrl}" method="post">
                    <input type="hidden" name="article_num" value="${article_num}"/>
                    <input type="hidden" name="claimer" value="${sessionScope.session_id }"/>
                    <div class="table-responsive">
                    <table class="table">
                        <tr class="warning">
                            <td colspan="2">
                        저희 <strong>eMenu</strong> 사이트에 대한 관심에 감사드립니다. <br/>
                        허위 또는 악의적인 신고로 파악될 시에는 <strong>eMenu</strong> 사이트 내에서의 활동이 제한될 수 있습니다. <br/>
                        이를 유의하시고 신중하게 신고해주시기 바랍니다. <br/>   
                          </td>
                        </tr>
                        <tr>
                            <td> 신고 사유 </td>
                            <td class="text-left">
                                <input type="radio" name="claim_category" value="명예훼손성"/> 욕설 및 인신공격 등 명예훼손성 게시물 <br/>
                                <input type="radio" name="claim_category" value="불법및홍보게시물"/> 불법정보 및  지나친 홍보성 게시물 <br/>
                                <input type="radio" name="claim_category" value="청소년유해게시물"/> 음란성 및 선정성 등 청소년유해정보 게시물 <br/>
                                <input type="radio" name="claim_category" value="기타"/> 기타 <br/>
                                <textarea rows="4"  name="claim_reason" class="form-control" placeholder="이외의 신고 사유는 기타를 선택하시고 300 자 이내로 신고 사유를 적어주세요. 저작권 침해 신고 시에는 저작권을 침해 당한 원본게시물 주소도 함께 적어주시면 더욱 빠른 처리가 가능합니다." maxlength="400"></textarea>
                            </td>
                       </tr>
                       <tr>
                            <td colspan="2">
                                 <button type="submit" class="btn btn-danger">신고하기</button>
                                 <button type="button" class="btn btn-default" onclick="javascript:self.close()">취 소</button>
                            </td>
                       </tr>
                    </table>
                    </div>
            </form>
        </div>
    </div>
    </div>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script src="/emenu/dist/js/bootstrap.min.js"></script>
</body>
</html>