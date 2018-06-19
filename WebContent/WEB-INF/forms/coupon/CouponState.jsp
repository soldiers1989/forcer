<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../jspf/head1.jspf"%>
    <%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>优惠券</title>
<style>
.yxq{
	border-bottom:1px solid #f5f5f5;
	line-height: .5rem;
}
</style>
</head>
<body>
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">代金劵</div>
</div>
<div class="main_content" id="myOrder">
    <div id="mat"></div>
    <ul class="nav_title flexLayout">
        <li class="navActive"><span>未使用</span></li>
        <li><span>已使用</span></li>
    </ul>
    <ul class='discount_coupon_list' style="display: block">
        <c:forEach items="${values }" var="value" varStatus="status">
            <c:if test="${value.items.use_ eq 0}">
                    <li class="flexLayout mt_10 no_use">
                        <div class="discount_content_left">
                            <div class="yxq">
                                <div class="font19">${value.items.couponname_ }</div>
                                <div class="font10 text-gray"><span>有效期：</span>
                                <fmt:formatDate value="${value.items.enddate_ }" type="both" pattern="yyyy-MM-dd" />-
                                <fmt:formatDate value="${value.items.enddate1_ }" type="both" pattern="yyyy-MM-dd" /></div>
                            </div>
                            <div class="font10 text-gray">${value.items.couponcontent_ }</div>
                        </div>
                        <div class="discount_content_right">
                            <div class="mb_10"><span class="font18">￥</span><span style="font-size: 0.597rem;">${value.items.Denomination_ }</span></div>
                            <c:if test="${value.items.type_ eq '全平台'}">
                           	 <div class="font13">全平台</div>
                            </c:if>
                            <c:if test="${value.items.type_ eq '租赁'}">
                           	 <div class="font13">租赁</div>
                            </c:if>
                            <c:if test="${value.items.type_ eq '购买'}">
                            	<div class="font13">购买</div>
                            </c:if>
                        </div>
                    </li>
            </c:if>
        </c:forEach>
    </ul>
    <ul class="discount_coupon_list">
        <c:forEach items="${values }" var="value" varStatus="status">
            <c:if test="${value.items.use_ eq 1}">
                <li class="flexLayout mt_10 old_use">
                    <div class="discount_content_left">
                        <div class="yxq">
                            <div class="font19">${value.items.couponname_ }</div>
                            <div class="font10 text-gray"><span>有效期：</span>
                            <fmt:formatDate value="${value.items.enddate1_ }" type="both" pattern="yyyy-MM-dd" /></div>-
                            <fmt:formatDate value="${value.items.enddate_ }" type="both" pattern="yyyy-MM-dd" /></div>
                        </div>
                        <div class="font10 text-gray">${value.items.couponcontent_ }</div>
                    </div>
                    <div class="discount_content_right">
                        <div class="mb_10"><span class="font18">￥</span><span style="font-size: 0.597rem;">${value.items.Denomination_ }</span></div>
                        <div class="font13">${value.items.type_ }</div>
                    </div>
                </li>
            </c:if>
        </c:forEach>
    </ul>
        
    
</div>

<%-- <c:forEach items="${values }" var="value" varStatus="status">
<p>${value.items.Denomination_ }
${value.items.enddate1_ }
${value.items.use_}</p>
</c:forEach> --%>
<script>
    //    导航栏点击选中
    $(".nav_title").on("click","li",function(){//左滑显示隐藏按键
        $(this).addClass("navActive").siblings().removeClass("navActive");
        $(".discount_coupon_list").hide();
        $(".discount_coupon_list").eq($(this).index()).show();
    });
</script>

</body>
</html>