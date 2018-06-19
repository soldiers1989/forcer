 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../jspf/head1.jspf"%>
    <%@include file="../ui/head1.jspf"%>
	<%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<title>寄送上门</title>
<script type="text/javascript">

</script>
</head>
<body style="background-color:#ffffff">
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">订单管理</span>
    </div>
     <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	    <div class="fl leftSide">
	    	 <a href="javascript:window.history.go(-1);" class="min-col"
			style="padding: 4px 10px; background: #48b2bd; color: #fff; border-radius: 3px;">返回</a>
	    </div>
	    <div class="fr rightSide">
	    </div>
	</div>
	<div class="easyui-panel tc mt_20">
<%-- 
<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">供应商编号（序号）：</label>
			<input type="text" name="supplyId_" placeholder="请输入供应商编号" value="${value.items.supplyId_}">
		</div>
 --%>
	<form action="FrmDeliveryGoHome.entryLogistics">
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">当前租凭订单号：</label>
			<span >${value.items.orderId_}</span>
		</div>	
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">当前订单物品名称：</label>
			<span >${value.items.proName_}</span>
		</div>	
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">一级分类名称：</label>
			<span >${value.items.fristName_}</span>
		</div>	
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">二级分类名称：</label>
			<span >${value.items.twoName_}</span>
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">当前订单物品关联情况： </label>
			<span >售卖：${value.items.sellTot_}个</span><span>租赁：${value.items.leasesTot_}个</span>
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">当前订单借出物流公司：</label>
			<select name="recLogisticsName" id="recLogisticsName" style="width:300px;">
				<option>请选择</option>
				<option>顺丰</option>
				<option>申通</option>
				<option>中通</option>
				<option>百世快递</option>
				<option>圆通</option>
				<option>韵达</option>
				<option>邮政平邮</option>
				<option>EMS</option>
				<option>天天</option>
				<option>京东</option>
				<option>全峰</option>
				<option>国通</option>
				<option>广通</option>
				<option>优速</option>
				<option>德邦</option>
				<option>八达通</option>
				<option>快捷</option>
				<option>亚马逊</option>
				<option>宅急送</option>
				<option>安捷快递</option>
				<option>百世快运</option>
				<option>广东邮政</option>
				<option>汇丰物流</option>
				<option>速尔快递</option>
				<option>运通快递</option>
			</select>
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">当前借出主电子条码： </label>
			<input id="zhuCode_" name="zhuCode_" type="text" value="${value.items.zhuCode_}">
		</div>
		<div id="fsxx" style="display: none"></div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">当前订单借出物流单号 </label>
			<input type="text" name="recLogisticsId">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">寄出时间</label>
			<input type="datetime-local" name="recUpTime">
		</div>
		<input type="hidden" name="orderId" value="${value.items.orderId_}" />
		<input type="hidden" name="proId" value="${value.items.proId_}" />
		<div class="group-box" id="component4" style="margin-left:30%">
			<input type="submit" value="提交" style="margin-top:10px;"/>		
		</div>			
		<%--  <li>当前租凭订单号：<span>${value.items.orderId_}</span></li>
		<li>当前订单物品名称：<span>${value.items.proName_}</span></li>
		<li>
			一级分类名称：<span>${value.items.fristName_}</span>       
			 二级分类名称：<span>${value.items.twoName_}</span>
		</li>
		<li>
			当前订单物品关联情况 
			<span>售卖：${value.items.sellTot_}个</span>
			<span>租赁：${value.items.leasesTot_}个</span>
		</li>
		<li>当前订单借出物流公司
			<select name="recLogisticsName" id="recLogisticsName">
				<option>请选择</option>
				<option>顺丰</option>
				<option>申通</option>
				<option>中通</option>
				<option>百世快递</option>
				<option>圆通</option>
				<option>韵达</option>
				<option>邮政平邮</option>
				<option>EMS</option>
				<option>天天</option>
				<option>京东</option>
				<option>全峰</option>
				<option>国通</option>
				<option>广通</option>
				<option>优速</option>
				<option>德邦</option>
				<option>八达通</option>
				<option>快捷</option>
				<option>亚马逊</option>
				<option>宅急送</option>
				<option>安捷快递</option>
				<option>百世快运</option>
				<option>广东邮政</option>
				<option>汇丰物流</option>
				<option>速尔快递</option>
				<option>运通快递</option>
			</select>
		</li>
		<li>
			当前借出主电子条码：
			<input id="zhuCode_" name="zhuCode_" type="text" value="${value.items.zhuCode_}">
		</li>
		<li id="fsxx" style="display: none">
		</li>
		<li>
			当前订单借出物流单号<input type="text" name="recLogisticsId">
		</li>
		<li>
			寄出时间<input type="datetime-local" name="recUpTime">
		</li>
		<input type="hidden" name="orderId" value="${value.items.orderId_}" />
		<input type="hidden" name="proId" value="${value.items.proId_}" />
		<input type="submit" value="提交" />  --%>
	</form>
		
	</div>
</body>
<script type="text/javascript">
$(function(){
	$.ajax({
	 	url:"FrmDeliveryGoHome.findCixx",
		type:'post',
		data:{"zhuCode_":'${value.items.zhuCode_}'},
		datatype:"json",
		success:function(data){
			if(data != null && data != ""){
				$("#fsxx").html("");
				$("#fsxx").css("display","");
				var str = eval('(' + data + ')');
				var cis = eval('(' + str.ciCodes + ')');
				var str ="<span>该物品附属配件电子条码："
				console.log(cis);
				for(var i=0;i<cis.length;i++){
					var ci = cis[i];
					var num = ci.num_;
					console.log(num);
					if(num == 0){
						alert("该商品不是在柜状态");
						$("#fsxx").css("display","none");
						return;
					}
					var ciCodeName_ = ci.ciCodeName_;
					var ciCode_=ci.ciCode_;
					str +="<li><span>"+ciCode_+"</span><span>"+ciCodeName_+"</span></li>";
				}
				str +="</span>"
				$("#fsxx").html(str);
			}
		}
 	})
})
/* $(function(){
	alert('${value.items.proId_}');
	var zhuCode_ = $("#zhuCode_").val();
	 $.ajax({
			url:"FrmDeliveryGoHome.findzhuCode",
			type:'post',
			data:{"zhuCode_":zhuCode_,"proId_":'${value.items.proId_}'},
			datatype:"json",
			success:function(data){
				if(data != "" && data != null){
					var str = eval('(' + data + ')');
					var aJaxZhuCode = str.zhuCode;
					var str2 = eval('(' + aJaxZhuCode + ')');
					if(str2.zhuCode_ == zhuCode_){
						$.ajax({
						 	url:"FrmDeliveryGoHome.findCixx",
							type:'post',
							data:{"zhuCode_":zhuCode_},
							datatype:"json",
							success:function(data){
								if(data != null && data != ""){
									$("#fsxx").html("");
									$("#fsxx").css("display","");
									var str = eval('(' + data + ')');
									var cis = eval('(' + str.ciCodes + ')');
									var str ="<span>该物品附属配件电子条码："
									for(var i=0;i<cis.length;i++){
										var ci = cis[i];
										var num = ci.num_;
										if(num == 0){
											alert("该商品不是在库状态");
											$("#fsxx").css("display","none");
											return;
										}
										var ciCodeName_ = ci.ciCodeName_;
										var ciCode_=ci.ciCode_;
										str +="<li><span>"+ciCode_+"</span><span>"+ciCodeName_+"</span></li>";
									}
									str +="</span>"
									$("#fsxx").html(str);
								}
							}
					 })
					}
				}
			}
	 })
			
}) */
	/* $(function(){
		 $.ajax({
			 url:"FrmDeliveryGoHome.findzhuCode",
				type:'post',
				data:{"proId_":'${value.items.proId_}'},
				datatype:"json",
				success:function(data){
					console.log(data);
					if(data != null && data != ""){
						var str = eval('(' + data + ')');
						var zhuCodes = eval('(' + str.zhuCodes + ')');
						var str ="<option>请选择</option>";
						for(var i=0;i<zhuCodes.length;i++){
							var zhuCode = zhuCodes[i];
							str +="<option>"+zhuCode.zhuCode_+"</option>";
						}
						$("#zhuCode_").html(str);
					}
				}
		 })
			 	
	}) */
	$('#zhuCode_').bind('input', function () {
		
	}) 
	
</script>
</html>