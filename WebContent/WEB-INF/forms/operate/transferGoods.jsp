 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../jspf/head1.jspf"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>立即调货</title>

</head>
<body>
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">立即调货</div>
</div>
<div class="main-contnet" id="rightAway_maintain">
    <div id="mat"></div>
    <div class="list mb_10">
        <ul class="message_list">
            <li class="flexLayout">
                <div class="list_left">
                    <span class="font13 text-666">物品名称：</span>
                </div>
                <div class="list_right">
                    <span class="font13">${pro.items.proName_ }</span>
                </div>
            </li>    
            <li class="flexLayout">
                <div class="list_left">
                    <span class="font13 text-666">识别码：</span>
                </div>
                <div class="list_right">
                    <span class="font13">${zhuCode_ }</span>
                </div>
            </li>
            <li class="">
                <div >
                    <span class="font13 text-666">状态：</span>
                    <span class="font13">开箱</span>
                </div>
            </li>
            <li class="">
                <div class="">
                    <span class="font13 text-666">本次调货订单编号：</span>
                    <span class="font13">${ord.items.orderId_}</span>
                </div>
            </li>
            <li class="">
                <div >
                    <span class="font13 text-666">历史租凭情况：</span>
                    <span class="font13">${ord.items.manCount_}人/${ord.items.orderCount_}次</span>
                </div>
            </li>
            <li class="">
                <div >
                    <span class="font13 text-666">累计租借时长：</span>
                    <span class="font13">${ord.items.sumTime_}天</span>
                </div>
            </li>
            <li class="flexLayout">
                <div class="list_left">
                    <span class="font13 text-666">历史检查维护：</span>
                    <c:if test="${empty ope.items.count_ }">
                        <span class="font13">暂无记录</span>
                    </c:if>
                    <c:if test="${not empty ope.items.count_ }">
                        <span class="font13">${ope.items.count_ }次</span>
                    </c:if>
                </div>
                <div class="list_right">
                    <span class="font13 text-666">历史折损率：</span>
                    <span class="font13">${ord.items.scrapState_}%</span>
                </div>
            </li>
        </ul>
    </div>
   <form action="FrmProDetails.addTransfer" method="post" id="form1" class="list" style="padding-left: 0">
        <ul class="message_list pl_10">
            <li class="flexLayout">
                <div class="list_left">
                    <span class="font13 text-666">本次补货定义折损率：</span>
                </div>
                <div class="list_right">
                    <input type="text" name="nowLoss_" value="50" class="derating_rate">%
                </div>
            </li>
            <li class="flexLayout">
                <div class="list_left">
                    <span class="font13 text-666">本次订单开锁次数：</span>
                </div>
                <div class="list_right">
                    <span class="font13">${ord.items.openCount_}次</span>
                </div>
            </li>
            <li class="flexLayout">
                <div class="list_left">
                    <span class="font13 text-666">物品上次订单归还时间：</span>
                </div>
                <div class="list_right font13">
                    <fmt:formatDate value="${ord.items.returnOverTime_}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </div>
            </li>
            <li class="flexLayout">
                <div class="list_left">
                    <span class="font13 text-666">订单上次联系人电话：</span>
                </div>
                <div class="list_right">
                    <span class="font13">${ord.items.recPhone_}</span>
                </div>
            </li>
            <li class="flexLayout">
                <div class="list_left">
                    <span class="font13 text-666">物品上次归还前是否有运维：</span>
                </div>
                <div class="list_right">
                    <c:if test="${empty ord.items.operateState_ }">
                        <span class="font13">无</span>
                    </c:if>
                    <c:if test="${ord.items.operateState_ == '0'}">
                        <span class="font13">无</span>
                    </c:if>
                    <c:if test="${ord.items.operateState_ eq '1'}">
                        <span class="font13">有</span>
                    </c:if>
                </div>
            </li>
            <li class="flexLayout">
                <div class="list_left">
                    <span class="font13 text-666">本次运维开箱时间：</span>
                </div>
                <div class="list_right">
                    <span class="font13"><input type="datetime-local" name="OpenBoxTime_" value="" readonly="readonly" class="tr border_0 date_bg"></span>
                </div>
            </li>
            <li class="flexLayout">
                <div class="list_left">
                    <span class="font13 text-666">本次运维关箱时间：</span>
                </div>
                <div class="list_right">
                    <span class="font13"><input type="datetime-local" name="closeBoxTime_" value="" readonly="readonly" class="tr border_0 date_bg"></span>
                </div>
            </li>
            <li>
                <a href="FrmProDetails.goOrder?zhuCode_=${ord.items.zhuCode_}" class="flexLayout">
                    <div class="list_left">
                        <span class="font13 text-666">此商品租借历史：</span>
                    </div>
                    <div class="list_right">
                        <span class="font13"><img alt="" src="${cdn }/img/rightArrows.png"> </span>
                    </div>
                </a>
            </li>
        </ul>
        <div class="maintenance_description"><span class="font13 text-666">运维描述：</span></div>
        <div class="textarea_box pb_15"><textarea placeholder="已沟通上次归还人，大致描述使用情况" name="leaveMess_" value="" class="textarea"></textarea></div>
        <input type="hidden" name="orderId_"  value="${ord.items.orderId_}">
        <input type="hidden" name="zhuCode_"  value="${zhuCode_}">
        <input type="hidden" name="falg" value="dh">
        <div id="foot_mat"></div>
        <div class="flexLayout rightAway_maintainOperation">
            <input type="button" value="重新开锁" class="border_r border_t">
            <input type="button" value="刷新状态" class="border_t">
            <input type="submit" value="确认提交">
        </div>
    </form>
</div>
    <%-- <div>
        <span>物品名称：${pro.items.proName_ }</span><br> 
        <span>识别码：${zhuCode_ }</span><br> 
        <span>   状态：开箱</span><br>
        <span>本次调货订单编号：${ord.items.orderId_}</span><br>
        <span>历史租凭情况：${ord.items.manCount_}人/${ord.items.orderCount_}次</span><br>
        <span>累计租借时长：${ord.items.sumTime_}天</span><br>
        <span>历史检查维护：
            <c:if test="${empty ope.items.count_ }">
                暂无记录
            </c:if>
            <c:if test="${not empty ope.items.count_ }">
                ${ope.items.count_ }次
            </c:if>
        </span><br>
        <span>历史折损率：${ord.items.scrapState_}%</span><br>
    </div>
    <div>
        <form action="FrmProDetails.addTransfer"   method="post" id="form1">
            <span>本次补货定义折损率：<input type="text" name="nowLoss_" value="">%</span><br>
            <span>本次订单开锁次数：${ord.items.openCount_}次</span><br>
            <span>物品上次订单归还时间：
                <fmt:formatDate value="${ord.items.returnOverTime_}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </span><br>
            <span>订单上次联系人电话：${ord.items.recPhone_}</span><br>
            <span>物品上次归还前是否有运维：
                <c:if test="${empty ord.items.operateState_ }">
                        无
                </c:if>
                <c:if test="${ord.items.operateState_ == '0'}">
                    无
                </c:if>
                <c:if test="${ord.items.operateState_ eq '1'}">
                    有
                </c:if>
            </span><br>
            <span>本次运维开箱时间：<input type="datetime-local" name="OpenBoxTime_" value=""></span><br>
            <span>本次运维关箱时间：<input type="datetime-local" name="closeBoxTime_" value=""></span><br>
            <span>运维描述：</span><br>
            <textarea placeholder="已沟通上次归还人，大致描述使用情况" name="leaveMess_" value=""></textarea><br>
            <input type="hidden" name="orderId_"  value="${ord.items.orderId_}">
            <input type="hidden" name="zhuCode_"  value="${zhuCode_}">
            <input type="hidden" name="falg" value="dh">
            <input type="submit" value="确认提交">
        </form>
    </div>     --%>
</body>
<script type="text/javascript">

</script>
</html>