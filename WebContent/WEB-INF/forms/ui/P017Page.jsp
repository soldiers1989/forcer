<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="head1.jspf"%>
<script type="text/javascript">
	window.localStorage.removeItem("menu-bx");
</script>
<script type="text/javascript" src="${cdn}/admin/js/echarts.min.js"></script>
<%@include file="head2.jspf" %> 
<style>
.replace{
	cursor: pointer!important;
}
.mesg-tilbox{
	font-size: 0;
}
.mesg-tilbox span{
	display: inline-block;
	width: 33.3333%;
	font-size: 14px;
	text-indent: 35px;
}
</style>

<!--中间内容-->
<div class="mid-box fl" id="mid-box">
    <div class="mid-bx">
        <div class="from-box fl mt_20">
            <div class=" lf_box" style="height:416px;">
                <div class="ui-bd-b ml_20">
                    <span class="button">用户动态</span>
                </div>
                <div class="ml_20 mt_20 mr_20 tip-box">
                    <span class="nums pr_20 pb_10">今天新增注册用户数：<b class="min-col">${userMap.registAdd }</b></span>
                    <span class="nums pr_20 pb_10">今天绑定卡数：<b class="min-col">${userMap.bindAdd }</b></span>
                    <span class="nums pr_20 pb_10">今天登录用户数：<b class="min-col">${userMap.loginAdd }</b></span>
                    <span class="nums pr_20 pb_10">今天解绑卡数：<b class="min-col">${userMap.unbindAdd }</b></span>
                </div>
                <div id="main_user" style="width: 100%"></div>
            </div>

            <div class=" lf_box">
                <div class="ui-bd-b ml_20">
                    <span class="button">消息统计</span>
                </div>
                <div class="ml_20 mt_20 mr_20 tip-box">
                    <span class="nums pr_20 pb_10">今日推送数：<b class="min-col">${msgMap.pushAdd }</b></span>
                    <span class="nums pr_20 pb_10">用户点击数：<b class="min-col">${msgMap.clickAdd }</b></span>
                </div>
                <div id="main_mesg" style="width: 100%"></div>
            </div>
           
        </div>
        <div class="from-box fr mt_20">
            <div class="rg_box" style="height:416px;">
                <div class="ui-bd-b">
                    <span class="button">消息留言</span>
                </div>
                <div class="mesg-tilbox mt_10 km-md km-pd">
                	<span>日期</span>
                	<span>账户</span>
                	<span>留言内容</span>
                </div>
                <div class="newmesg-list pt_10 pb_10">
                    <ul>
                    <c:forEach items="${leaveMsgs }" var="msg">
                        <li>
                            <a href="FrmLeaveMessage.reply?UID_=${msg.items.UID_ }">
                            	<span><fmt:formatDate value="${msg.items.createTime_}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                <span class="min-col pr_20 pl_20 text-oven" style="  display: inline-block;width:100px;vertical-align: middle;"> ${msg.items.userCode_ }</span>
                                ${msg.items.content_ }
                            </a>
                        </li>
                    </c:forEach> 
                    </ul>
                </div>
            </div>
            
            <%-- <div class=" rg_box">
                <div class="ui-bd-b ml_20">
                    <span class="button">挂号统计</span>
                    <span class="button fr replace"  onclick="tabOrder('${orderHistory}','${orderToday}')">刷新</span>
                </div>
                <div class="ml_20 mt_20 mr_20 tip-box">
                    <span class="nums pr_20 pb_10">今天挂号数量:<b class="min-col">${orderNum }</b>人</span>
                    <span class="nums pr_20 pb_10">费用总额:<b class="min-col">${orderAmount }</b>人</span>
                </div>
                <div id="main_all" style="width: 100%"></div>
            </div> --%>
        </div>
    </div>
</div>
<script type="text/javascript" src="${cdn }/admin/js/P017page.js"></script>
<script type="text/javascript" src="${cdn }/js/Umeng.js"></script>
<script>
$(function(){
    tabUser('${userHistory}','${userToday}');
    tabMesg('${msgHistory}','${msgToday}');
    tabOrder('${orderHistory}','${orderToday}');
    MobclickAgent.profileSignInWithPUID('${userCode}');//统计用户

	$(".replace").on("click", function(){
    	window.location.reload();
    })
})   
/* 加载完毕  首页当前菜单显示高亮*/
window.onload = function(){
	var menbox = $("#men-bx");
	menbox.find("span.item").removeClass("curr");
	menbox.find("ul.menu-next").hide().find("a.two").removeClass("curr");
	menbox.find(".menus:eq(0)").find("span.item").addClass("curr"); 
}
</script>
<%@include file="footer.jspf"%>