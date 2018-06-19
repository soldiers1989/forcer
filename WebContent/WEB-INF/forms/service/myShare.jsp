<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的分享</title>
</head>
<style>
.no_content img{
    	position: absolute;
    	left: 50%;
    	top: 65%;
    	transform: translate(-50%,-50%)
    }
</style>
<body><div class="header2">
    <a href="FrmMyServices" class="prev"></a>
    <div class="head_title font18">我的分享</div>
    <!--<div class="more"><img src="../../img/1.jpg" alt=""></div>-->
</div>
<div class="main_content" id="my_share">
    <div id="mat"></div>
    <div class="my_data">
        <div class="my_data_img"><img alt="" src="${myInfo.items.imgUrl_ }"></div>
        <div class="my_data_name">${myInfo.items.name_ }</div>
    </div>
    <ul class="nav flexLayout mt_10">
        <li class="navActive">我的邀请(${shareNum}人)</li>
        <li class="tr font12 text-gray mr_10">所获分享积分：${shareNum * 10}积分</li>
    </ul>
    <div>
    	<c:if test="${empty shares }">
    		<div class="no_content">
    				<img alt="" src="${cdn }/img/zwsj.png" style="width: 2rem;">
    		</div>
    	</c:if>
    </div>
    <div class="invite_person my_shareList list" id="invite_person">
        <ul class="message_list">
            <c:forEach items="${shares }" var="share">
                <li>
                    <a href="#" class="flexLayout">
                        <div class="list_left">
                            <img alt="" src="${share.items.imgUrl_ }" class="mr_10">
                            <span>${share.items.name_ }</span>
                        </div>
                        <div class="list_right">
                            <div class="font14 text-gold">+${share.items.integral_ }积分</div>
                            <div class="font11"><fmt:formatDate value="${share.items.createTime_ }" pattern="yyyy-MM-dd HH:mm"/></div>
                        </div>
                    </a>
                </li>
            </c:forEach>
        </ul>
    </div>
    <%-- <div class="share_integral my_shareList" id="share_integral">
        <ul class="share_integral_list">
            <c:forEach items="${shares }" var="share">
                <li>
                    <img alt="" src="${share.items.imgUrl_ }">
                    <div class="share_integral_content">
                        <div class="share_integral_name flexLayout" >
                            <div class="font16">${share.items.name_ }safddfnalk</div>
                            <div class="font11"><fmt:formatDate value="${share.items.createTime_ }" pattern="yyyy-MM-dd HH:mm"/>sdnkasfdd</div>
                        </div>
                        <div class="share_integral_goods flexLayout">
                            <div>
                                <div class="font14">佳能750D单反相机</div>
                                <div class="font11 text-gray">消费金额：￥180</div>
                            </div>
                            <div class="font20 text-gold" style="line-height: .85rem;">+${share.items.integral_ }积分</div>
                        </div>
                    </div>
                </li>
            </c:forEach>
        </ul>
    </div> --%>
    <%-- <p><a href="FrmMyServices">返回</a></p>
    <p><img alt="" src="${myInfo.items.imgUrl_ }"></p>
    <p><img alt="" src="${myInfo.items.name_ }"></p>
    <div>
        <p>我的邀请（${shareNum}人）| 分享所获积分${shareNum * 10}积分</p>
        <c:forEach items="${shares }" var="share">
            <p>
                <img alt="" src="${share.items.imgUrl_ }">&nbsp;&nbsp;&nbsp;
                ${share.items.name_ }&nbsp;&nbsp;&nbsp;+${share.items.integral_ }积分
                <fmt:formatDate value="${share.items.createTime_ }" pattern="yyyy-MM-dd HH:mm"/>
            </p>
        </c:forEach>
    </div> --%>
</div>
<script type="text/javascript">
   /*  $("body").on("click",".nav li",function(){
        $(this).addClass("navActive").siblings().removeClass("navActive");
        $(".my_shareList").hide();
        $(".my_shareList").eq($(this).index()).show();
    }) */
</script>
</body>
</html>