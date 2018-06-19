<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

	<div class="mid-box fl" id="mid-box">
		<div class="top pl_20 pr_20 mb_20">
			<span class="min-col f16">查看用户信息</span>
		</div>
		<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
			<div class="fl leftSide">
				<a href="javascript:window.history.go(-1);" class="min-col"
					style="padding: 4px 10px; background: #48b2bd; color: #fff; border-radius: 3px;">返回</a>
			</div>
			<div class="fr rightSide"></div>
            <div class="ckyh-titleMess">
                <div>
                    <span class="back_hint4">当前用户</span><input type="text" name="mobile_" value="${code_}">
                    <span class="back_hint6">最近登录时间</span><input type="text" name="smoney_" value="${loginTime_}">
                    <span class="back_hint6">在租订单数</span><input type="text" name="yajin_">
                    <span class="back_hint8">待处理购买订单数</span><input type="text" name="orderNum_">
                </div>
            </div>
		 <div class="ckyn_tab">
		<a  class="act"  href="FrmAdminExclusiveUser.detail?id_=${id_}" target="myFrameName">客户基本信息</a>

		<a href="FrmgetUser.userBalance?id_=${id_}&code_=${code_}" target="myFrameName">账户金额</a>
		<a href="FrmPersonalInfo.perLeaseOrders?code_=${code_}" target="myFrameName">租赁订单</a>
		<a href="FrmPersonalInfo.perBuyOrders?code_=${code_}" target="myFrameName">购买订单</a>
		<a href="FrmgetUser.userDonateOrder?id_=${id_}&code_=${code_}" target="myFrameName">捐赠订单</a>
		<a href="FrmPersonalInfo.perCustomerInvitation?code_=${code_}" target="myFrameName">客户邀请</a>
		<a href="FrmUserXinyong?code_=${code_}" target="myFrameName">征信维系</a>

		<%-- <a href="FrmgetUser.userBalance?id_=${id_}&code_=${code_}" target="myFrameName">账户金额</a>
		<a href="FrmAdminExclusiveUser.detail?id_=${id_}" target="myFrameName">租赁订单</a>
		<a href="FrmgetUser.detail?id_=${id_}" target="myFrameName">购买订单</a>
		<a href="FrmgetUser.userDonateOrder?id_=${id_}" target="myFrameName">捐赠订单</a>
		<a href="" target="myFrameName">客户邀请</a>
		<a href="FrmUserXinyong?code_=${code_}" target="myFrameName">征信维系</a> --%>

		<a href="FrmIndemnityInfo?mobile_=${code_}" target="myFrameName">赔付单信息</a><br/>
		<div class="easyui-panel tc mt_20">
		<iframe src="FrmAdminExclusiveUser.detail?id_=${id_}" style="width:100%" id="myFrameId" name="myFrameName" scrolling="no" frameborder="0" onload="changeFrameHeight()"></iframe> 
		</div>
	</div>
	</div>
</div>
<script type="text/javascript">
	function changeFrameHeight(){
	    var ifm= document.getElementById("myFrameId"); 
	    ifm.height=document.documentElement.clientHeight;
	}
	$(function(){
		$(".ckyn_tab a").on("click",function(){
			$(this).addClass("act").siblings().removeClass("act");
		})
		
	})
</script>
