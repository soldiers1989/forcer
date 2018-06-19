 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${cdn }/js/mobiscroll/mobiscroll-2.13.2.full.min.css"/>
<script src="${cdn }/js/mobiscroll/mobiscroll-2.13.2.full.min.js"></script>
<script src="${cdn }/js/mobi.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript" src="${cdn}/js/orderJs/weixinPay.js"></script>
<title>超期支付</title>
<style>
.paymentAddr{
	height: 1.271rem;
	width:100%;
	background-color:#fff;
	padding:.1rem .247rem 0;
	box-sizing:border-box;
	
}
.paymentAddr .paymentAddress{
	color: #808080;
	font-size: 0.222rem;
}
.paymentAddr .paymentName{
	color: #333333;
	font-size: 0.273rem;
	line-height:.5rem;
}
.paymentGoods{
	width: 100%;
	margin:.2rem 0;
	height: 1.681rem;
	background-color: #ffffff;
}
.paymentGoods .paymentImg{
	width:30%;
	text-align:center;
}
.paymentGoods .paymentImg img{
	width: 1.57rem;
	height: 1.297rem;
	background-color: #ffffff;
	border: solid 0.009rem #e6e6e6;
	margin-top:.192rem;
}
.paymentGoods .paymentDetail{
	width:70%;
	height:100%;
	padding:.256rem 0;
	box-sizing:border-box;
	line-height:.35rem;
}
.paymentGoods .paymentDetail .paymentDetail_name{
	color: #333333;
	font-size: 0.239rem;
	overflow: hidden; 
	text-overflow:ellipsis;
	 white-space: nowrap;
	 
}
.paymentGoods .paymentDetail .paymentDetail_money .jianmian{
	font-size: 0.188rem;
	color: #999999;
	margin-left:.256rem;
}
.paymentGoods .paymentDetail .paymentDetail_money{
	font-size: 0.307rem;
	color: #c90d00;	
}

.paymentGoods .paymentDetail .paymentDetail_deposit{
	color: #a0791a;
	font-size: 0.171rem;
}
.paymentRent{
	width:100%;
	padding:.23rem;
	box-sizing:border-box;
	background-color:#fff;
	color: #333333;
}
.paymentRent .returnWay{
	width:100%;
	height:.6rem;
}
.paymentRent_list li{
	line-height: .5rem;
    font-size: .222rem;
    border-bottom: 1px solid #f5f5f5;
}
#Logistics {
	padding-bottom: .2rem;
}
 #Logistics  input{
	width: 4.6rem;
    height: .4rem;
    font-size: .222rem;
    margin-right: .2rem;
    border:none;
    padding:.2rem;
    box-sizing:border-box;
}
 #Logistics  .subPayBtn{
	width:1rem;
	height:.58rem;
	font-size:.222rem;
	color:#fff;
	border:none;
    background-color: #88213d;
    margin-left: -.1rem;
}
.paySubmitBtn{
	/* text-align:center;
	margin-top:2rem; */
	    position: fixed;
    bottom: 2rem;
    left: .6rem;
}
.paySubmitBtn input{
	width: 5.254rem;
    height: 0.712rem;
    background-color: #88213d;
    border-radius: 0.339rem;
    color: white;
    font-size: 0.305rem;
    border: none;
    text-align:center;
}
</style>
<script type="text/javascript">
$(function(){
	var type = '${type}';
	if(type=="报修"){
		$("#repair").css("display","");
		$("#returnType_").val(1);
		$(".head_title").text("报修归还");
	}
	if(type=="无损"){
		$("#returnType_").val(0);
		$(".head_title").text("无损归还");
	}
})
</script>
</head>
<body>
<div class="header2">
    <a href="FrmMore.userCenter" class="prev"></a>
    <div class="head_title font18">我的订单</div>
   <%--  <div class="more"><img src="${cnd }/img/search1.png" alt="" onclick="find('${userId_}');"></div> --%>
</div>
<div class="main_content" id="myOrder">
    <div id="mat"></div>
    <!-- 地址信息 -->
    <div class="paymentAddr">
    	<div class="paymentName"><span>一启享</span><span>15147874521</span></div>
    	<div class="paymentAddress">归还地址：<span>广东深圳市宝安华盛辉大厦一启享公司</span></div>
    </div>
    <!-- 商品信息 -->
    <div class="paymentGoods flexLayout">
    	<div class="paymentImg"><img alt="" src="${order.items.twoImgUrl_}"></div>
    	<div class="paymentDetail">
    		<div class="paymentDetail_name">${order.items.proName_}</div>
    		<div class="paymentDetail_money">
    			<span>
    				<c:if test="${order.items.isDiscount_ == 0}">${order.items.dayRentMoney_}/天</c:if>
    				<c:if test="${order.items.isDiscount_ == 1}">${order.items.discountPrice_}/天</c:if>
    			</span>
    			<!-- <span class="jianmian">￥21/天</span> -->
    		</div>
    		<div class="paymentDetail_deposit"><span>押金：￥${order.items.cashPledge_}</span></div>
    	</div>
    </div>
    <!-- 租赁信息 -->
    <form action="FrmOrder_My.upOrderRepair" id="tj">
    <div class="paymentRent">
    	<div class="returnWay"><span>归还方式：</span>
	    		<span >
	    			<input  type="radio" value="1" id="returnMethod1" name="returnMethod_" onclick="kdgh();"/>快递归还
					<input  type="radio" value="0" id="returnMethod0" name="returnMethod_" onclick="xzgh();" style="margin-left:.2rem;"/>箱柜归还
				</span>
		</div>
		
    	<ul class="paymentRent_list">
    	<li style="display: none" id="Logistics">
			<div>快递名称<input type="text" name="returnLogisticsName_"  placeholder="请填写物流名称" /></div>
			<div>物流单号<input type="text" name="retuenLogisticsId_"  placeholder="请填写物流单号" /></div>
			</li>
			<li style="display: none" id="repair">
				报修类型：
				<input  type="radio" value="0"  id="repairType0" name="repairType_" />自己责任
				<input  type="radio" value="1"  id="repairType1" name="repairType_" style="margin-left:.2rem;"/>他人责任
			</li>
			
			<li>起租时间：<span>${order.items.beginTime_}</span></li>
			<li>
				应还时间：<span id="returnTime_">${order.items.returnTime_}</span>
			</li>
			<li>实际归还时间：<span id="overdue"></span></li>
			<li  style=" border-bottom: none;"><span id="overdueTime"></span></li>
			<li style=" border-bottom: none;">
				<span id="overdueMoney"></span>
				<input type="hidden" name="overdueMoney" id="dueMoney">
			</li>
			
			<input type="hidden" name="returnType_" id="returnType_" />
			<input type="hidden" name="overdueDay_" id="overdueDay_" />
			<input type="hidden" name="sumOverMoney_" id="sumOverMoney_" />
			<input type="hidden" name="orderId_" id="orderId_" value="${order.items.orderId_}"/>
			<input type="hidden" name="userId" id="userId" value="${order.items.userId_}"/>
			<!-- <input type="button" value="提交" onclick="goPay();"> -->
		
			
			
    	</ul>
    </div>
    <div class="paySubmitBtn"><input type="button" value="提交" onclick="goPay();"></div>
    </form>
	<%-- <div>
		<img  src="${order.items.twoImgUrl_}">
		<li>
			<span>${order.items.proName_}</span>
		</li>
		<li>
			<span>
				<c:if test="${order.items.isDiscount_ == 0}">${order.items.dayRentMoney_}</c:if>
				<c:if test="${order.items.isDiscount_ == 1}">${order.items.discountPrice_}</c:if>
				元/天
			</span>
		</li>
		<li>押金：
			<span>${order.items.cashPledge_} 元</span>
		</li>
	</div>
	<form action="FrmOrder_My.upOrderRepair" id="tj">
		<li>
			归还方式：
			<input  type="radio" value="1" id="returnMethod1" name="returnMethod_" onclick="kdgh();"/>快递归还
			<input  type="radio" value="0" id="returnMethod0" name="returnMethod_" onclick="xzgh();"/>箱柜归还
		</li>
		<li style="display: none" id="Logistics">
			物流名称:<input type="text" name="returnLogisticsName_"  placeholder="请填写物流名称" />
			物流单号:<input type="text" name="retuenLogisticsId_"  placeholder="请填写物流单号" />
		</li>
		<li style="display: none" id="repair">
			报修类型：
			<input  type="radio" value="0"  id="repairType0" name="repairType_" />自己责任
			<input  type="radio" value="1"  id="repairType1" name="repairType_" />他人责任
		</li>
		
		<li>起租时间:<span>${order.items.beginTime_}</span></li>
		<li>
			应还时间:<span id="returnTime_">${order.items.returnTime_}</span>
		</li>
		<li>实际归还时间:<span id="overdue"></span></li>
		<li ><span id="overdueTime"></span></li>
		<li>
			<span id="overdueMoney"></span>
			<input type="hidden" name="overdueMoney" id="dueMoney">
		</li>
		
		</li>
		<input type="hidden" name="returnType_" id="returnType_" />
		<input type="hidden" name="overdueDay_" id="overdueDay_" />
		<input type="hidden" name="sumOverMoney_" id="sumOverMoney_" />
		<input type="hidden" name="orderId_" id="orderId_" value="${order.items.orderId_}"/>
		<input type="hidden" name="userId" id="userId" value="${order.items.userId_}"/>
		<input type="button" value="提交" onclick="goPay();">
	</form> --%>
	
	
	<%-- <div>
		<img  src="${order.items.twoImgUrl_}">
		<li>
			<span>${order.items.proName_}</span>
		</li>
		<li>
			<span>
				<c:if test="${order.items.isDiscount_ == 0}">
					${order.items.dayRentMoney_}
				</c:if>
				<c:if test="${order.items.isDiscount_ == 1}">
					${order.items.discountPrice_}
				</c:if>
				元/天
			</span>
		</li>
		<li>押金：
			<span>${order.items.cashPledge_} 元</span>
		</li>
	</div>
	<form action="FrmOrder_My.upOrderRepair" id="tj">
		<li>
			归还方式：
			<input  type="radio" value="1" id="returnMethod1" name="returnMethod_" onclick="kdgh();"/>快递归还
			<input  type="radio" value="0" id="returnMethod0" name="returnMethod_" onclick="xzgh();"/>箱柜归还
		</li>
		<li style="display: none" id="Logistics">
			物流名称:<input type="text" name="returnLogisticsName_"  placeholder="请填写物流名称" />
			物流单号:<input type="text" name="retuenLogisticsId_"  placeholder="请填写物流单号" />
		</li>
		<li style="display: none" id="repair">
			报修类型：
			<input  type="radio" value="0"  id="repairType0" name="repairType_" />自己责任
			<input  type="radio" value="1"  id="repairType1" name="repairType_" />他人责任
		</li>
		
		<li>起租时间:<span>${order.items.beginTime_}</span></li>
		<li>
			应还时间:<span id="returnTime_">${order.items.returnTime_}</span>
		</li>
		<li>实际归还时间:<span id="overdue"></span></li>
		<li ><span id="overdueTime"></span></li>
		<li>
			<span id="overdueMoney"></span>
			<input type="hidden" name="overdueMoney" id="dueMoney">
		</li>
		
		</li>
		<input type="hidden" name="returnType_" id="returnType_" />
		<input type="hidden" name="overdueDay_" id="overdueDay_" />
		<input type="hidden" name="sumOverMoney_" id="sumOverMoney_" />
		<input type="hidden" name="orderId_" id="orderId_" value="${order.items.orderId_}"/>
		<input type="hidden" name="userId" id="userId" value="${order.items.userId_}"/>
		<input type="button" value="提交" onclick="goPay();">
	</form> --%>
			
	
</body>
<script type="text/javascript">
	function goPay(){
		var dueMoney = $("#dueMoney").val();
		if(dueMoney != "" && dueMoney != null){
			$("#sumOverMoney_").val(dueMoney);
			var str = "亲,您需支付"+dueMoney+"元,确定支付吗？"
			console.log("${order.items.orderId_}");
			if (confirm(str)==true){
				 mods("请选择支付方式",dueMoney);
			}
		}else{
			$("#tj").submit();
		}
	
	}
	
	function mods(content,sumMoney){
	    var oDiv=document.createElement("div");
	    oDiv.className="mars1";
	    oDiv.innerHTML=
	        "<div id='container1'>"+
	        "<p id='content1'>"+content+"</p>"+
	        "<div class='flex'>"+
	        "<div class='cancel1 modalBtn'>零钱支付</div>"+
	        "<div class='confirm1 modalBtn'>微信支付</div>"+
	        "</div>"+
	        "</div>";
	    var oStyle=document.createElement("style");
	    oStyle.innerHTML=
	        ".mars1{"+"width: 100%;height: 100%;background-color: rgba(0, 0, 0, 0.6);position: fixed;top: 0;left:0;z-index: 1000;"+"}"+
	        "#container1{"+"width: 80%;background: white;position: absolute;top: 50%;transform:translateY(-50%);left: 10%;z-index: 2;font-family: PingFang-SC-Medium;border-radius:3px;-webkit-border-radius:3px;margin: 0;"+"}"+
	        "#content1{"+"width:100%;font-size: .34rem;text-align: center;line-height: .51rem;word-break: break-all;font-family: PingFang-SC-Medium;color: #4f4f4f;padding: .68rem .255rem;margin:0;box-sizing: border-box;-webkit-box-sizing: border-box;border-bottom:1px solid #ccc;"+"}"+
	        ".flex{"+"display:flex;width:100%;font-size: .315rem;height:.765rem;line-height: .765rem;"+"}"+
	        ".modalBtn{"+" width: 50%;text-align: center;height:.765rem;line-height: .765rem;background: white;color: #a0791a;cursor:pointer;"+"}"+
	        ".confirm1{"+"border-radius:0 0 3px 0;-webkit-border-radius:0 0 3px 0;"+"}"+
	        ".cancel1{"+"border-right: 1px solid #ccc;border-radius:0 0 0 3px;-webkit-border-radius:0 0 0 3px;"+"}";
	    document.getElementsByTagName('html')[0].getElementsByTagName('head')[0].appendChild(oStyle);
	    document.body.insertBefore(oDiv,document.body.children[0]);

	    $("body").on("click",".confirm1",function(){
	    	wxzf(sumMoney);
	        $(".mars1").hide();
	        
	    });
	    $("body").on("click",".cancel1",function(){
	    	lqPay(sumMoney);
	        $(".mars1").hide();
	    });
	};
	function wxzf(sumMoney){
		if(sumMoney == "" || sumMoney == null || sumMoney<0){
			 alert("暂无获取支付金额，请确认");
	            return;
		}
		 weixintyzf2(sumMoney, "微信支付");
	}
	function lqPay(sumMoney){
		 $.ajax({
			 url:"FrmOrder_Lease.payment",
				type:'post',
				data:{"sumMoney":sumMoney,
					  "orderId_":"${order.items.orderId_}"},
				datatype:"json",
				success:function(data){
					var str = eval('(' + data + ')');
					alert(str);
					var consumeId_ = str.consumeId_;
					if(consumeId_ == "" || consumeId_ == null){
						alert("账户余额不足！请先充值");
						return ;
					}
					if(consumeId_ != "" && consumeId_ != null){
						$("#tj").submit();
					}
				},
				error:function(){
					alert("系统异常稍后重试！");
				}
		 })	
	}
	
	function kdgh(){
		$("#Logistics").css("display","")
	}
	function xzgh(){
		$("#Logistics").css("display","none")
	}
	$(function(){
		var today = new Date();  
		var submitTime = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();   
		$("#overdue").html(submitTime);
		var returnTime_ = Date.parse(new Date('${order.items.returnTime_}'));
		var timestamp = Date.parse(new Date());
		var time = timestamp-returnTime_;
		if(time >= 0){
			var sumsec=time/1000;
			var day = parseInt(sumsec/(24*60*60));
			var hours = parseInt((sumsec-(day*24*60*60))/(60*60));
			var min = parseInt((sumsec-(day*24*60*60)-(hours*60*60))/60);
			var sec =sumsec%60;
			var str = "超过期时间:"+day+"天"+hours+"小时"+min+"分钟"+sec+"秒"
			var overdueMoney ="";
			if(hours>0 || hours>0 || min>0 || sec>0){
				var overdueDay = day+1;
				$("#overdueDay_").val(overdueDay);
				var isDiscount_ = '${order.items.isDiscount_}';
				if(isDiscount_ == 0){
					overdueMoney = parseInt('${order.items.dayRentMoney_}')*overdueDay;
					
				}
				if(isDiscount_ == 1){
					overdueMoney = parseInt('${order.items.discountPrice_}')*overdueDay;
					
				}
			}
			if(overdueMoney != ""){
				$("#overdueMoney").html("超期费用为:"+overdueMoney+"元");
				$("#dueMoney").val(overdueMoney);
			}
			$("#overdueTime").html(str);
		}
		if(time < 0){
			time = returnTime_-timestamp;
			var sumsec=time/1000;
			var day = parseInt(sumsec/(24*60*60));
			var hours = parseInt((sumsec-(day*24*60*60))/(60*60));
			var min = parseInt((sumsec-(day*24*60*60)-(hours*60*60))/60);
			var sec =sumsec%60;
			var str = "距归还时间："+day+"天"+hours+"小时";
			$("#overdueTime").html(str);
		}
		
	})
	/* function submit(){
		window.location.href="FrmOrder_My.findOrder?orderId="+orderId_+"&falg=goOverdue"; 
	} */
	
</script>
</html>