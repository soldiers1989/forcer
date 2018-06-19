<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
     <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${cdn }/css/order.css">
<title>一启享</title>
<style>
.indmnityDetail .indmnityMess{
	width:75%;
	line-height:.35rem;
}
.indmnityDetail .indmnityImg{
	position:relative;
}
.indmnityDetail .indmnityImg .box{
	position:absolute;
	width: 1.5rem;
	height: 0.324rem;
	background-color: rgba(0, 0, 0, 0.3);
	opacity: 0.3;
	bottom:.2rem;
	color:#fff;
	line-height:.324rem;
	text-align:center;
}
ul li{
	height:.4rem;
	line-height:.4rem;
	
}
.historyOrder_img{
	height:auto;
}
.indmnity:last-child{
	padding-bottom:.4rem;
}
</style>
</head>
<body>
<div class="header2">
    <a href="javascript:history.back(-1)" class="prev"></a>
    <div class="head_title font18">赔付单详情</div>   
</div>
<div class="main_content" id="idea_feedback">
    <div id="mat"></div>
	<div class="transactionNumber">交易单号：<span>${details.items.orderId_ }</span></div>
	<!-- 物品信息 -->
 	<div class="indmnity margin-t" >
    	<div class="indmnityTitle border_b">
    		<span class="addr">${details.items.communityName_ }</span>
    		<!-- <span class="way">自取租赁</span> -->
    		<c:if test="${details.items.orderType_  == '1'}">
				<span class="way">自取租赁</span>
			</c:if>
			<c:if test="${details.items.orderType_  == '2'}">
				<span class="way">寄送上门 </span>
			</c:if>
			<c:if test="${details.items.orderType_  == '3'}">
				<span class="way">寄送到柜</span>
	 		</c:if>
    	</div>
	    <div class="indmnityDetail flexLayout">
	    	<div class="indmnityImg"><img src="${details.items.proZsImges_ }"><div class="box font137">${details.items.communityName_ }</div></div>
	    	<div class="indmnityMess">
	    		<div class="font14">${details.items.name_ }</div>
	    		<div class="mon"><span class="font15">${details.items.dayRentMoney_ }/天</span></div>
	    		<div class="yajin">押金<span>￥${details.items.cashPledge_ }</span></div>
	    	</div>
	    	<%-- <div class="indmnityMore"><img alt="" src="${cdn }/img/right.png"></div> --%>
	    </div>
   </div>
 	<!-- 租用时间 -->
 	<div class="indmnityRent">
 		<div class="indmnityRentTime">
 			<span>租用日期：</span>
 			<fmt:formatDate value="${details.items.beginTime_ }" pattern="yyyy-MM-dd"/>-
 		 	<fmt:formatDate value="${details.items.returnOverTime_ }" pattern="yyyy-MM-dd"/>
 			<span>共${details.items.time }日</span>
 			<span class="fr">总租金：￥${details.items.dayRentMoney_  * details.items.time}</span>
 		</div>
 		<div class="indmnityRentMon" style="margin-top: .2rem;">
 			<span>合计：</span><span class="fonta07" >￥${details.items.cashPledge_ + (details.items.dayRentMoney_  * details.items.time) -details.items.coupon_   - details.items.reliefDeposit_}</span>
 			<span class="font12 font666">(含押金：￥${details.items.cashPledge_ })</span>
 			<span class="fr fontc90 font11">赔付总金额:${details.items.pay_ }</span>
 		</div>
 	</div>
 	<!-- 赔偿说明 -->
 	<div class="indmnityRent">
 		<div class="font15 mb_10">赔偿说明</div>
 		<div class="font13 font666">${details.items.payDesc_ }</div>
 	</div>
 	<!-- 图片信息 -->
 	<div class="indmnityRent">
 		<div class="font15 mb_10">图片信息</div>
 		<div class="font13 font666">
 			<%-- <img alt="" src="${cdn }/img/1.jpg" class="rentImg"> --%>
	 		<c:if test="${details.items.payImg_  != null}">
	 		 	<img alt="" src="${details.items.payImg_ }" class="rentImg">
	 		</c:if>
	 		<c:if test="${details.items.payImg_  == null}">
	 		 	暂无图片
	 		</c:if> 
 		</div>
 	</div>
 	<!-- 历史运维检修记录 -->
 	<div class="transactionNumber">历史运维检修记录：<span>${details.items.orderId_ }</span></div>
 	<c:forEach items="${orders}" var="order" >
        <div class="indmnity margin-t border_b">
            <ul class=" ">
                <li class="flexLayout">
                    <div class="">
                        <span class="font13 text-666">历史订单号：</span>
                        <span class="font13">${order.items.orderId_}</span>
                       <%--  <c:if test="${order.items.orderType_ == 1}"><span class="delivery_style">自取租赁</span></c:if>
                        <c:if test="${order.items.orderType_ == 2}"><span class="delivery_style">寄送上门</span></c:if>
                        <c:if test="${order.items.orderType_ == 3}"><span class="delivery_style">寄送到柜</span></c:if>
                        <c:if test="${order.items.orderType_ == 4}"><span class="delivery_style">线上购买</span></c:if> --%>
                    </div>
                </li>    
                <li class="flexLayout">
                    <div class="">
                        <span class="font13 text-666">租赁用户：</span>
                        <span class="font13">${order.items.receiver_}</span>
                    </div>
                </li>
                <li class="">
                    <div >
                        <span class="font13 text-666">租赁时间：</span>
                        <span class="font13">
                            <fmt:formatDate value="${order.items.beginTime_}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            <span>-</span>
                            <fmt:formatDate value="${order.items.returnOverTime_}" pattern="yyyy-MM-dd HH:mm:ss"/>
                        </span>
                    </div>
                </li>
                <li class="">
                    <div class="">
                        <span class="font13 text-666">归还类型：</span>
                        <c:if test="${order.items.returnType_ == 0}">
                            <span class="font13">无损归还 - </span>
                        </c:if>
                        <c:if test="${order.items.returnType_ == 1}">
                            <span class="font13">报修归还 - </span>
                        </c:if>
                        <c:if test="${order.items.returnMethod_ == 0}">
                            <span class="font13">箱子归还</span>
                        </c:if>
                        <c:if test="${order.items.returnMethod_ == 1}">
                            <span class="font13">快递归还</span>
                        </c:if>
                    </div>
                </li>
                <li class="flexLayout">
                    <div class="">
                        <span class="font13 text-666">检修说明：</span>
                        <span class="font13">${order.items.leaveMess_}</span>
                    </div>
                </li>
                 <li>
                    <div style="width: auto;">
                        <span class="font13 text-666">检修人：</span>
                        <span class="font13">${order.items.name_}</span>
                    </div>
                 </li>
                <li class="historyOrder_img">
                    <div class="font13 text-666" style=""></div>
                    <div class="historyImg_show">
                    <%--  <img alt="" src="${cdn}/img/1.jpg"> --%>
                        <c:forEach items="${order.items.imgPath_}" var="img" >
                           <img alt="" src="${img}">
                            <%-- <img alt="" src="${img}">
                            <img alt="" src="${img}"> --%>
                        </c:forEach>
                    </div>
                </li>
                <li>                  
                    <div class="fr">
                        <span class="font13 text-666">检修时间：</span>
                        <span class="font13"><fmt:formatDate value="${order.items.OpenBoxTime_}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                    </div>
                </li>
            </ul>
        </div>
    </c:forEach>
</div>
 	
 	
 	
 	<%-- <h2>赔付单详情</h2>
 	<p>交易单号:${details.items.orderId_ }</p>
 	<p>${details.items.communityName_ }${details.items.name_ }</p>
 	<p> 
 	  <c:if test="${details.items.orderType_  == '1'}">
		自取租赁
	  </c:if>
	  <c:if test="${details.items.orderType_  == '2'}">
		寄送上门 
	  </c:if>
	  <c:if test="${details.items.orderType_  == '3'}">
		寄送到柜
	  </c:if>
 	</p>
 	<p>
 		<img alt="" src="${details.items.proZsImges_ }" style="width:150px;">
 	</p>
 	<p>${details.items.proName_ }</p>
 	<p>${details.items.dayRentMoney_ }/天</p>
 	<p>押金：￥${details.items.cashPledge_ }</p>
 	<p>租用日期:
 		<fmt:formatDate value="${details.items.beginTime_ }" pattern="yyyy-MM-dd"/>
 		至
 		<fmt:formatDate value="${details.items.returnOverTime_ }" pattern="yyyy-MM-dd"/>
 		<span>共${details.items.time }日</span>
 		<span>总租金:￥${details.items.dayRentMoney_  * details.items.time}</span>
 	</p>
 	<p>总计：￥${details.items.cashPledge_ + (details.items.dayRentMoney_  * details.items.time) -details.items.coupon_   - details.items.reliefDeposit_}</p>
 	<p>赔付总金额:${details.items.pay_ }</p>
 	<p>赔偿说明:${details.items.payDesc_ }</p>
 	<p>
 		<span>图片信息:</span>
 		<c:if test="${details.items.payImg_  != null}">
 		 	<img alt="" src="${details.items.payImg_ }">
 		</c:if>
 		<c:if test="${details.items.payImg_  == null}">
 		 	暂无图片
 		</c:if>
 	</p>
 	<div>
 		<h3>历史运维检修记录</h3>
 		<c:forEach items="${orders}" var="order" >
        <div class="list mb_10">
            <ul class="message_list">
                <li class="flexLayout">
                    <div class="">
                        <span class="font13 text-666">历史订单号：</span>
                        <span class="font13">${order.items.orderId_}</span>
                        <c:if test="${order.items.orderType_ == 1}"><span class="delivery_style">自取租赁</span></c:if>
                        <c:if test="${order.items.orderType_ == 2}"><span class="delivery_style">寄送上门</span></c:if>
                        <c:if test="${order.items.orderType_ == 3}"><span class="delivery_style">寄送到柜</span></c:if>
                        <c:if test="${order.items.orderType_ == 4}"><span class="delivery_style">线上购买</span></c:if>
                    </div>
                </li>    
                <li class="flexLayout">
                    <div class="">
                        <span class="font13 text-666">租凭用户：</span>
                        <span class="font13">${order.items.receiver_}</span>
                    </div>
                </li>
                <li class="">
                    <div >
                        <span class="font13 text-666">租凭时间：</span>
                        <span class="font13">
                            <fmt:formatDate value="${order.items.beginTime_}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            <span>-</span>
                            <fmt:formatDate value="${order.items.returnOverTime_}" pattern="yyyy-MM-dd HH:mm:ss"/>
                        </span>
                    </div>
                </li>
                <li class="">
                    <div class="">
                        <span class="font13 text-666">归还类型：</span>
                        <c:if test="${order.items.returnType_ == 0}">
                            <span class="font13">无损归还 - </span>
                        </c:if>
                        <c:if test="${order.items.returnType_ == 1}">
                            <span class="font13">报修归还 - </span>
                        </c:if>
                        <c:if test="${order.items.returnMethod_ == 0}">
                            <span class="font13">箱子归还</span>
                        </c:if>
                        <c:if test="${order.items.returnMethod_ == 1}">
                            <span class="font13">快递归还</span>
                        </c:if>
                    </div>
                </li>
                <li class="flexLayout">
                    <div class="">
                        <span class="font13 text-666">检修说明：</span>
                        <span class="font13">${order.items.leaveMess_}</span>
                    </div>
                </li>
                <li class="historyOrder_img">
                    <div class="font13 text-666" style="line-height: .75rem;height: 1.75rem">检修图片</div>
                    <div class="historyImg_show pb_10 flexLayout">
                        <c:forEach items="${order.items.imgPath_}" var="img" >
                            <img alt="" src="${img}" style="width:160px;">
                            <img alt="" src="${img}">
                            <img alt="" src="${img}">
                        </c:forEach>
                    </div>
                </li>
                <li class="flexLayout">
                    <div style="width: auto;">
                        <span class="font13 text-666">检修人：</span>
                        <span class="font13">${order.items.name_}</span>
                    </div>
                    <div style="width: auto;">
                        <span class="font13 text-666">检修时间：</span>
                        <span class="font13"><fmt:formatDate value="${order.items.OpenBoxTime_}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                    </div>
                </li>
            </ul>
        </div>
    </c:forEach>
 	</div>
 	<div>
 		<a href="FrmIndemnity">返回</a>
 	</div> --%>
</body>
</html>