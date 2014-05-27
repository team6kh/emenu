<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
<style type="text/css">

.dropdown:hover .dropdown-menu {
	display: block;
}
.btn-link {
	color: #fff;
}
.btn-link:hover, .btn-link:focus {
	color: #fff;
	text-decoration: line;
}

.noline:hover, .noline:focus {
	text-decoration: blink;
}

#dhtmlgoodies_leftPanel{    /* Styling the help panel */

    background-color:#474747;    /* Noti-background color */
    color:#FFF;    /* White text color */
    font-family: verdana;    /* Which font to use */

    /* You shouldn't change these 5 options unless you need to */
    height:100%;
    left:0px;
    z-index:10;
    position:absolute;
    display:none;
    overflow:hidden;
}

#dhtmlgoodies_leftPanel #leftPanelContent{
    padding:0px;
}
#dhtmlgoodies_leftPanel .closeLink{ /* Layout of close link */
    padding-left:2px;
    padding-right:2px;
    background-color:#FFF;
    position:absolute;
    top:2px;
    right:2px;
    border:1px solid #000;
    color:#000;
    font-size:0.8em;
}
#dhtmlgoodies_leftPanel .closeLink:hover{    /* Close link text  - mouseover effect*/
    color:#FFF;
    background-color:#000;
}

</style>


<script type="text/javascript">

/************************************************************************************************************
(C) www.dhtmlgoodies.com, October 2005

Version 1.2: Updated, November 12th. 2005

This is a script from www.dhtmlgoodies.com. You will find this and a lot of other scripts at our website.

Terms of use:
You are free to use this script as long as the copyright message is kept intact. However, you may not
redistribute, sell or repost it without our permission.

Thank you!

www.dhtmlgoodies.com
Alf Magne Kalleland

************************************************************************************************************/
var panelWidth = 130;    // Width of help panel
var slideSpeed = 15;        // Higher = quicker slide
var slideTimer = 10;    // Lower = quicker slide
var slideActive = true;    // Slide active ?
var initBodyMargin = 0;    // Left or top margin of your <body> tag (left if panel is at the left, top if panel is on the top)
var pushMainContentOnSlide = false;    // Push your main content to the right when sliding
var panelPosition = 0;     // 0 = left , 1 = top

/*    Don't change these values */
var slideLeftPanelObj=false;
var slideInProgress = false;
var startScrollPos = false;
var panelVisible = false;
function initSlideLeftPanel(expandOnly)
{
    if(slideInProgress)return;
    if(!slideLeftPanelObj){
        if(document.getElementById('dhtmlgoodies_leftPanel')){    // Object exists in HTML code?
            slideLeftPanelObj = document.getElementById('dhtmlgoodies_leftPanel');
            if(panelPosition == 1)slideLeftPanelObj.style.width = '100%';
        }else{    // Object doesn't exist -> Create <div> dynamically
            slideLeftPanelObj = document.createElement('DIV');
            slideLeftPanelObj.id = 'dhtmlgoodies_leftPanel';
            slideLeftPanelObj.style.display='none';
            document.body.appendChild(slideLeftPanelObj);
        }

        if(panelPosition == 1){
            slideLeftPanelObj.style.top = "-" + panelWidth + 'px';
            slideLeftPanelObj.style.left = '0px';
            slideLeftPanelObj.style.height = panelWidth + 'px';
        }else{
            slideLeftPanelObj.style.left = "-" + panelWidth + 'px';
            slideLeftPanelObj.style.top = '0px';
            slideLeftPanelObj.style.width = panelWidth + 'px';
        }


        if(!document.all || navigator.userAgent.indexOf('Opera')>=0)slideLeftPanelObj.style.position = 'fixed';;
    }

    if(panelPosition == 0){
        if(document.documentElement.clientHeight){
            slideLeftPanelObj.style.height = document.documentElement.clientHeight + 'px';
        }else if(document.body.clientHeight){
            slideLeftPanelObj.style.height = document.body.clientHeight + 'px';
        }
        var leftPos = slideLeftPanelObj.style.left.replace(/[^0-9\-]/g,'')/1;
    }else{
        if(document.documentElement.clientWidth){
            slideLeftPanelObj.style.width = document.documentElement.clientWidth + 'px';
        }else if(document.body.clientHeight){
            slideLeftPanelObj.style.width = document.body.clientWidth + 'px';
        }
        var leftPos = slideLeftPanelObj.style.top.replace(/[^0-9\-]/g,'')/1;


    }
    slideLeftPanelObj.style.display='block';

    if(panelPosition==1)
        startScrollPos = Math.max(document.body.scrollTop,document.documentElement.scrollTop);
    else
        startScrollPos = Math.max(document.body.scrollLeft,document.documentElement.scrollLeft);
    if(leftPos<(0+startScrollPos)){
        if(slideActive){
            slideLeftPanel(slideSpeed);

        }else{
            document.body.style.marginLeft = panelWidth + 'px';
            slideLeftPanelObj.style.left = '0px';
        }
    }else{
        if(expandOnly)return;
        if(slideActive){
            slideLeftPanel(slideSpeed*-1);
        }else{
            if(panelPosition == 0){
                if(pushMainContentOnSlide)document.body.style.marginLeft =  initBodyMargin + 'px';
                slideLeftPanelObj.style.left = (panelWidth*-1) + 'px';
            }else{
                if(pushMainContentOnSlide)document.body.style.marginTop =  initBodyMargin + 'px';
                slideLeftPanelObj.style.top = (panelWidth*-1) + 'px';
            }
        }
    }

    if(navigator.userAgent.indexOf('MSIE')>=0 && navigator.userAgent.indexOf('Opera')<0){
        window.onscroll = repositionHelpDiv;

        repositionHelpDiv();
    }
    window.onresize = resizeLeftPanel;

}

function resizeLeftPanel()
{
    if(panelPosition == 0){
        if(document.documentElement.clientHeight){
            slideLeftPanelObj.style.height = document.documentElement.clientHeight + 'px';
        }else if(document.body.clientHeight){
            slideLeftPanelObj.style.height = document.body.clientHeight + 'px';
        }
    }else{
        if(document.documentElement.clientWidth){
            slideLeftPanelObj.style.width = document.documentElement.clientWidth + 'px';
        }else if(document.body.clientWidth){
            slideLeftPanelObj.style.width = document.body.clientWidth + 'px';
        }
    }
}

function slideLeftPanel(slideSpeed){
    slideInProgress =true;
    var scrollValue = 0;
    if(panelPosition==1)
        var leftPos = slideLeftPanelObj.style.top.replace(/[^0-9\-]/g,'')/1;
    else
        var leftPos = slideLeftPanelObj.style.left.replace(/[^0-9\-]/g,'')/1;

    leftPos+=slideSpeed;
    okToSlide = true;
    if(slideSpeed<0){
        if(leftPos < ((panelWidth*-1) + startScrollPos)){
            leftPos = (panelWidth*-1) + startScrollPos;
            okToSlide=false;
        }
    }
    if(slideSpeed>0){
        if(leftPos > (0 + startScrollPos)){
            leftPos = 0 + startScrollPos;
            okToSlide = false;
        }
    }


    if(panelPosition==0){
        slideLeftPanelObj.style.left = leftPos + startScrollPos + 'px';
        if(pushMainContentOnSlide)document.body.style.marginLeft = leftPos - startScrollPos + panelWidth + 'px';
    }else{
        slideLeftPanelObj.style.top = leftPos + 'px';
        if(pushMainContentOnSlide)document.body.style.marginTop = leftPos - startScrollPos + panelWidth + 'px';

    }
    if(okToSlide)setTimeout('slideLeftPanel(' + slideSpeed + ')',slideTimer); else {
        slideInProgress = false;
        if(slideSpeed>0)panelVisible=true; else panelVisible = false;
    }

}


function repositionHelpDiv()
{
    if(panelPosition==0){
        var maxValue = Math.max(document.body.scrollTop,document.documentElement.scrollTop);
        slideLeftPanelObj.style.top = maxValue;
    }else{
        var maxValue = Math.max(document.body.scrollLeft,document.documentElement.scrollLeft);
        slideLeftPanelObj.style.left = maxValue;
        var maxTop = Math.max(document.body.scrollTop,document.documentElement.scrollTop);
        if(!slideInProgress)slideLeftPanelObj.style.top = (maxTop - (panelVisible?0:panelWidth)) + 'px';
    }
}

function cancelEvent()
{
    return false;
}
function keyboardShowLeftPanel()
{
        initSlideLeftPanel();
        return false;

}

function leftPanelKeyboardEvent(e)
{
    if(document.all)return;

    if(e.keyCode==112){
        initSlideLeftPanel();
        return false;
    }
}

function setLeftPanelContent(text)
{
    document.getElementById('leftPanelContent').innerHTML = text;
    initSlideLeftPanel(true);

}
if(!document.all)document.documentElement.onkeypress = leftPanelKeyboardEvent;
document.documentElement.onhelp  = keyboardShowLeftPanel;

</script>


</head>

<div class="navbar navbar-inverse navbar-fixed-top">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="/emenu/home.do"><font face="Comic Sans MS">e</font><b>Menu</b></a>
		</div>
		<div class="navbar-collapse collapse">
			<ul class="nav navbar-nav">
				<li class="dropdown">
	              <a href="/emenu/listRest.do?rest_localcategory=1&rest_typecategory=1" class="dropdown-toggle disabled" data-toggle="dropdown">지역별<b class="caret"></b></a>
	              <ul class="dropdown-menu">
	                <li><a href="/emenu/listRest.do?rest_localcategory=11&rest_typecategory=0">서울특별시</a></li>
	                <li><a href="/emenu/listRest.do?rest_localcategory=12&rest_typecategory=0">경기/인천</a></li>
	                <li><a href="/emenu/listRest.do?rest_localcategory=13&rest_typecategory=0">부산/경남</a></li>
	                <li><a href="/emenu/listRest.do?rest_localcategory=14&rest_typecategory=0">대구/경북</a></li>
	                <li><a href="/emenu/listRest.do?rest_localcategory=15&rest_typecategory=0">대전/전북</a></li>
	                <li><a href="/emenu/listRest.do?rest_localcategory=16&rest_typecategory=0">광주/전남</a></li>
	                <li><a href="/emenu/listRest.do?rest_localcategory=17&rest_typecategory=0">그 외 지역</a></li>
	              </ul>
	            </li>
	            <li class="dropdown">
	              <a href="/emenu/listRest.do?rest_localcategory=2&rest_typecategory=2" class="dropdown-toggle disabled" data-toggle="dropdown">종류별<b class="caret"></b></a>
	              <ul class="dropdown-menu">
	                <li><a href="/emenu/listRest.do?rest_localcategory=0&rest_typecategory=21">한식</a></li>
	                <li><a href="/emenu/listRest.do?rest_localcategory=0&rest_typecategory=22">양식</a></li>
	                <li><a href="/emenu/listRest.do?rest_localcategory=0&rest_typecategory=23">중식</a></li>
	                <li><a href="/emenu/listRest.do?rest_localcategory=0&rest_typecategory=24">일식</a></li>
	                <li><a href="/emenu/listRest.do?rest_localcategory=0&rest_typecategory=25">기타</a></li>
	              </ul>
	            </li>

				<!-- <li><a href="listReview.do">후기</a></li>  -->
				<li><a href="/emenu/listRecipe.do">레시피</a></li>
				<li><a href="/emenu/listNotice.do">공지사항</a></li>
				<li><a href="/emenu/listQna.do">문의하기</a></li>

				<!-- 테스트 메뉴 삭제하였습니다. -->
			</ul>
			<c:choose>
				<%-- 로그인 전 --%>
				<c:when test="${empty session_id}">
					<form class="navbar-form navbar-right">						
						<a href="/emenu/user/register/form.do" class="btn btn-default">회원가입</a>
						<button type="button" class="btn btn-primary" onclick="loginForm(this.form)">로그인</button>
					</form>					
				</c:when>
				<%-- 로그인 후 --%>
				<c:when test="${not empty session_id}">
					<form class="navbar-form navbar-right" action="/emenu/user/logout.do" method="post" style="margin-top: 0px; margin-bottom: 0px;">
						<a href="/emenu/user/get.do?user_type=${session_type}&user_id=${session_id}" class="btn btn-link" style="margin-top:8px; margin-bottm:8px;">${session_name} (${session_id}) 님 환영합니다.</a>
							
						<c:if test="${session_type == 'buyer'}" >
							<ul class="nav navbar-nav">
								<li>
									<a href="/emenu/user/buyer/dashboard.do?session_id=${session_id}"> 
										<span class="glyphicon glyphicon-bell"></span>
										<span class="badge">${session_cpn}</span>
									</a>
								</li>
							</ul>
						</c:if>
						
						<c:if test="${session_type == 'seller'}" >
							<ul class="nav navbar-nav">
								<li>
									<a href="/emenu/user/dashSeller.do?sesssion_id=${session_id}" class="btn btn-link noline" style="margin-top:8px; margin-bottm:8px;"> 
										<span class="glyphicon glyphicon-bell"></span>
										<span class="badge">${session_cpn}</span>
									</a>
								</li>
							</ul>	
						</c:if>
						
						<button type="submit" class="btn btn-warning" style="margin-top:8px; margin-bottm:8px;">로그아웃</button>
					</form>
				</c:when>				
			</c:choose>
		</div>
		<!--/.nav-collapse -->
	</div>
</div>

<script>
	// 왜 스크립트로 해야지 로그인 폼으로 넘어가는지 모르겠음...
	function loginForm(form) {
		form.action = "/emenu/user/login/form.do";
		form.submit();
	}
</script>