<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>交易明细</title>
</head>
<style>
 	.no_content img{
    	position: absolute;
    	left: 50%;
    	top: 50%;
    	transform: translate(-50%,-50%)
    }
</style>
<body>
<div class="header2">
    <a href="FrmMyWallet" class="prev"></a>
    <div class="head_title font18">交易明细</div>
    <!-- <div class="font15 text-gold more">筛选</div> -->
</div>

<div class="main_content" id="deal_details">
    <div id="mat"></div>
    <c:if test="${empty details }">
    	<div  class="no_content">
			<img alt="" src="${cdn}/img/zwsj.png" style="width: 4rem;">
    	 </div>
    </c:if>
    <ul class="dealDetails_list">
        <c:forEach items="${details }" var="detail">
        	<c:if test="${detail.items.amount_ != 0}">
            <c:if test="${detail.items.opeType_ == 'A' }">
                <li>
                    <div class="dealDetails_hint flexLayout">
                        <div class="list_left"> 
                            <span class="font16">转出至</span>
                            <c:if test="${detail.items.platform_ == '0' }">
                                <span class="font16">微信</span>
                            </c:if>
                            <c:if test="${detail.items.platform_ == '1' }">
                                <span class="font16">支付宝</span>
                            </c:if>
                        </div>
                        <div class="list_right font18">-<fmt:formatNumber value="${detail.items.amount_ }" pattern=".00"/></div>
                    </div>
                    <div class="dealDetails_hint flexLayout">
                        <div class="list_left">
                            <span class="font14">余额：</span>
                            <span class="font14"><fmt:formatNumber value="${detail.items.userNowMoney_}" pattern=".00"/></span>
                        </div>
                        <div class="list_right font11"><fmt:formatDate value="${detail.items.createTime_ }" pattern="yyyy-MM-dd HH:mm"/></div>
                    </div>
                </li>
            </c:if>
            <c:if test="${detail.items.opeType_ == 'B' }">
                <li>
                    <div class="dealDetails_hint flexLayout">
                        <div class="list_left"> 
                            <span class="font16">单笔转入</span>
                        </div>
                        <div class="list_right text-gold font18">+<fmt:formatNumber value="${detail.items.amount_ }" pattern=".00"/></div>
                    </div>
                    <div class="dealDetails_hint flexLayout">
                        <div class="list_left">
                            <span class="font14">余额：</span>
                            <span class="font14"><fmt:formatNumber value="${detail.items.userNowMoney_}" pattern=".00"/></span>
                        </div>
                        <div class="list_right font11"><fmt:formatDate value="${detail.items.createTime_ }" pattern="yyyy-MM-dd HH:mm"/></div>
                    </div>
                </li>
            </c:if>
            <c:if test="${detail.items.opeType_ == 'C' }">
                <li>
                    <div class="dealDetails_hint flexLayout">
                        <div class="list_left"> 
                            <span class="font16">付款</span>
                        </div>
                        <div class="list_right font18"><fmt:formatNumber value="${detail.items.amount_ }" pattern=".00"/></div>
                    </div>
                    <div class="dealDetails_hint flexLayout">
                        <div class="list_left">
                            <span class="font14">余额：</span>
                            <span class="font14"><fmt:formatNumber value="${detail.items.userNowMoney_}" pattern=".00"/></span>
                        </div>
                        <div class="list_right font11"><fmt:formatDate value="${detail.items.createTime_ }" pattern="yyyy-MM-dd HH:mm"/></div>
                    </div>
                </li>
            </c:if>
            <c:if test="${detail.items.opeType_ == 'D' }">
                <li>
                    <div class="dealDetails_hint flexLayout">
                        <div class="list_left"> 
                            <span class="font16">退款</span>
                        </div>
                        <div class="list_right text-gold font18">+<fmt:formatNumber value="${detail.items.amount_ }" pattern=".00"/></div>
                    </div>
                    <div class="dealDetails_hint flexLayout">
                        <div class="list_left">
                            <span class="font14">余额：</span>
                            <span class="font14"><fmt:formatNumber value="${detail.items.userNowMoney_}" pattern=".00"/></span>
                        </div>
                        <div class="list_right font11"><fmt:formatDate value="${detail.items.createTime_ }" pattern="yyyy-MM-dd HH:mm"/></div>
                    </div>
                </li>
            </c:if>
            </c:if>
        </c:forEach>
    </ul>
</div>
<%-- <p><a href="FrmMyWallet">返回</a></p>
<div>
<c:forEach items="${details }" var="detail">
    <c:if test="${detail.items.opeType_ == 'A' }">
        转出至<c:if test="${detail.items.platform_ == '0' }">
        微信
        </c:if>
        <c:if test="${detail.items.platform_ == '1' }">
        支付宝
        </c:if>&nbsp;&nbsp;&nbsp;-${detail.items.amount_ }
        <p>
            <fmt:formatDate value="${detail.items.createTime_ }" pattern="yyyy-MM-dd HH:mm"/>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            ${detail.items.overMoney_ }
        </p>
    </c:if>
    <c:if test="${detail.items.opeType_ == 'B' }">
        转入&nbsp;&nbsp;&nbsp;+${detail.items.amount_ }
        <p>
            <fmt:formatDate value="${detail.items.createTime_ }" pattern="yyyy-MM-dd HH:mm"/>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            ${detail.items.overMoney_ }
        </p>
    </c:if>
    <c:if test="${detail.items.opeType_ == 'C' }">
        付款&nbsp;&nbsp;&nbsp;-${detail.items.amount_ }
        <p>
            <fmt:formatDate value="${detail.items.createTime_ }" pattern="yyyy-MM-dd HH:mm"/>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            ${detail.items.overMoney_ }
        </p>
    </c:if>
    <c:if test="${detail.items.opeType_ == 'D' }">
        退款&nbsp;&nbsp;&nbsp;+${detail.items.amount_ }
        <p>
            <fmt:formatDate value="${detail.items.createTime_ }" pattern="yyyy-MM-dd HH:mm"/>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            ${detail.items.overMoney_ }
        </p>
    </c:if>
</c:forEach>
</div> --%>
</body>
</html>