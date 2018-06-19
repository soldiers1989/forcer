 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../jspf/head1.jspf"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0">
    <link rel="stylesheet" href="${cnd }/files/common.css">
    <link rel="stylesheet" href="${cnd }/css/user.css">
    <title>我的订单</title>
    <style>
        .ui-loader{
            display: none;
        }
		#all_order .right_buyCommodity_message{
			height: auto;
		}
		.QR_code_img{
			position: fixed;
			left: 0;
			top: 0;
			width: 100%;
			height: 100%;
			z-index: 1000;
			display: none;
			
		}
		.QR_code_img img{
			position: absolute;
	        top: 50%;
	        left: 50%;
	        transform: translate(-50%,-50%);
		}
		.no_content img{
    	position: absolute;
    	left: 50%;
    	top: 50%;
    	transform: translate(-50%,-50%)
    }
    .no_content{
      height:7rem;
      text-align: center;
      padding: .51rem 0;
      background-image:url('../../img/zwsj.png');
      background-position:center  center;
      background-repeat: no-repeat;
    }
    </style>
</head>
<body>
<!-- <div class="header">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">一启享</div>
</div> -->
<div class="header2">
    <a href="FrmMore.userCenter" class="prev"></a>
    <div class="head_title font18">我的订单</div>
    <div class="more"><img src="${cnd }/img/search1.png" alt="" onclick="find('${userId_}');"></div>
</div>
<div class="main_content" id="myOrder">
    <div id="mat"></div>
    <div class="nav_bar_box" style="overflow: auto;">
        <ul class="nav_bar" id="nav_bar">
            <li id="allOrder" ><a href="FrmOrder_My.execute">全部</a></li>
            <li id="unDeliver" style="width: 19%;" ><a href="FrmOrder_My.execute?falg=1">待发货</a></li>
            <li id="onTheWay" style="width: 19%;"  class="navActive"><a href="FrmOrder_My.execute?falg=2">待收货/取件</a></li>
            <li id="inRend"><a href="FrmOrder_My.execute?falg=3">租用中</a></li>
            <li id="evaluate"><a href="FrmOrder_My.execute?falg=5">待评价</a></li>
            <li id="backMyMoney"><a href="FrmOrder_My.execute?falg=6">退款</a></li>
        </ul>
    </div>
  <c:if test="${empty orders }">
    	<div  class="no_content">
			<%-- <img alt="" src="${cdn}/img/zwsj.png" style="width: 3rem;"> --%>
    	 </div>
    </c:if>
<c:forEach  items="${orders}" var="order" >
 <!--全部-->

    <div id="all_order" class="order_list" style="display:block;">
        <div class="user_commodity_list">
            <div class="user_commodity_style border_b">
                <span class="mr_10">启享柜5485487</span>
                <span class="delivery_style">
                	<c:if test="${order.items.orderType_ == 1}">自取租赁</c:if>
					<c:if test="${order.items.orderType_ == 2}">寄送上门</c:if>
					<c:if test="${order.items.orderType_ == 3}">寄送到柜</c:if>
					<c:if test="${order.items.orderType_ == 4}">线上购买</c:if>
                </span>
                <span class="user_commodity_status text-danger fr font11">
                	<c:if test="${order.items.orderState_ == 1}">待发货</c:if>
					<c:if test="${order.items.orderState_ == 2}">待开箱</c:if>
					<c:if test="${order.items.orderState_ == 3}">待收货</c:if>
					<c:if test="${order.items.orderState_ == 4}">租用中</c:if>
					<c:if test="${order.items.orderState_ == 5}">归还中</c:if>
					<c:if test="${order.items.orderState_ == 6}">完成</c:if>
					<c:if test="${order.items.orderState_ == 8}">退款</c:if>
                </span>
            </div>
            <div class="right_buyCommodity_message">
	            <div class="flexLayout">
	                <div class="right_buyCommodity"><img src="${order.items.twoImgUrl_}" alt=""></div>
	                <div class="right_buyCommodity_details">
	                    <div class="right_buyCommodity_name font14">${order.items.proName_}</div>
	                    <div class="right_buyCommodity_color">
	                        <c:if test="${order.items.isDiscount_ == 0}">
                                <span class="font18 text-danger">￥${order.items.dayRentMoney_}</span>
                                <span class="font11 text-danger">/天</span>
                            </c:if>
                            <c:if test="${order.items.isDiscount_ == 1}">
                                <span class="font18 text-danger">￥${order.items.discountPrice_}</span>
                                <span class="font11 text-danger">/天</span>
                                <span class="line-th">${order.items.dayRentMoney_}/天</span><a>${flag }</a>
                            </c:if>
	                   		<%-- <span class="font18 text-danger">￥${order.items.dayRentMoney_}</span>
	                    	<span class="font11 text-danger">/天</span>
	                     	<span class="line-th">${order.items.discountPrice_}/天</span><a>${flag }</a> --%>
	                     </div>
	                    <div class="right_buyCommodity_price text-gold font10">
	                    	<span>押金：￥</span><span class="text-gold">${order.items.cashPledge_}</span>
	                    </div>
	                </div>
	            </div>
	            <c:if test="${order.items.orderState_ == 4}"> <!--租用中 -->
					<div class="tr text-gray font10 mt_10" style="line-height: .51rem;">
						<span>租用时间：</span><span>
							<fmt:formatDate value="${order.items.beginTime_}" pattern="yyyy-MM-dd HH:mm:ss"/>
						-
							<fmt:formatDate value="${order.items.returnTime_}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</span>
					</div>
					<div class="tr text-gold font10">
						<span id="djs">${order.items.difTime_}</span>
					</div>
				</c:if>
            </div>
            <div class="userOrder_operation" >
            	<c:if test="${order.items.orderType_ == 2}">
            		<c:if test="${order.items.orderState_ == 3 || order.items.orderState_  == 1 }">
            			<button onclick="refund('${order.items.orderId_}');" >退款</button>
            		</c:if>
            	</c:if>
	            <c:if test="${order.items.orderType_ == 1 || order.items.orderType_ == 3}"><!-- 自取租赁和寄送到柜 -->
	              	<c:if test="${order.items.orderState_ == 3}">
						<button onclick="getEWM('${order.items.zhuCode_}','${order.items.orderId_}');">待开箱</button>
					</c:if>
					<c:if test="${order.items.orderType_ == 3 && order.items.orderState_ == 2}">
						<button onclick="findLogistics('${order.items.orderId_}');" >查看物流</button>
					</c:if>
				</c:if>
				
				<c:if test="${order.items.orderState_ == 3}"><!-- 查看物流 -->
					<c:if test="${order.items.orderType_ == 2 || order.items.orderType_ == 3 }">
						<button onclick="findLogistics('${order.items.orderId_}');">查看物流</button>
					</c:if>
				</c:if>
				
				<c:if test="${order.items.orderState_ == 4}"> <!--租用中 -->
					<%-- <c:if test="${falg == 3}">
						<div>
							<span id="djs">${order.items.difTime_}</span>
						</div>
					</c:if>
					<li>
						<span>租用时间：</span><span>${order.items.beginTime_}-${order.items.returnTime_}</span>
					</li> --%>
					<button type="button" value="" onclick="gh('${order.items.orderId_}','报修');">报修归还</button>
					<button type="button" value="" onclick="gh('${order.items.orderId_}','无损');" >无损归还</button>
				</c:if>
				
				<c:if test="${order.items.orderState_ == 5}">
					<c:if test="${order.items.returnMethod_ == 0}">
						<button type="button" value="" onclick="getEWM('${order.items.zhuCode_}','${order.items.orderId_}','gx');">归还二维码</button>
					</c:if>
				</c:if>
				
				<c:if test="${order.items.orderState_ == 6}"><!-- 待评价 -->
					<button type="button" value="" onclick="goEvaluate('${order.items.orderId_}','${order.items.userId_}','${order.items.orderType_}');">去评价</button>
				</c:if>
				
				<button onclick="findxq('${order.items.orderId_}')">查看详情</button>
            </div>
        </div>    
   </div>

</c:forEach>

</div>
<div class="QR_code_img">
	<img alt=""  src="" id="img1">
<!-- 	<div>
		<input type="button" onclick="open();" value="开锁测试">
		<input type="button" onclick="down();" value="关箱测试">
	</div> -->
</div>
<script src="../../files/jquery-1.11.3.min.js"></script>
<script src="../../files/rem1.js"></script>
<script src="../../js/modal.js"></script>
<!-- <script src="../../files/jquery.mobile-1.4.5.min.js"></script> -->
<script type="text/javascript">
	function open(){
		 $.ajax({
			 url:"FrmOrderInterface.getOpen",
				type:'post',
				datatype:"text",
				success:function(data){
					if(data){
						alert("开锁成功");
						alert("用户正在取东西");
					}else{
						alert("开锁失败");
					}
				} 
		 })		
	}
	function down(){
		 $.ajax({
			 url:"FrmOrderInterface.getDown",
				type:'post',
				datatype:"text",
				success:function(data){
					if(data){
						alert("用户已关箱子");
						alert("用户取走东西");
					}else{
						alert("用户已关箱子失败");
					}
				} 
		 })		
	}
</script>
<script>
//    导航栏滑动
/* 每次刷新页面，设置导航栏的样式 */
 $(document).ready(function(){
	 var id;
	var flag = '${falg}';
	
	 if(flag == 1){
		id = "unDeliver";
	}else if(flag == 2){
		id = "onTheWay";
	}else if(flag == 3){
		id = "inRend";
	}else if(flag == 5){
		id = "evaluate";
	}else if(flag == null || flag == ""){
		id = "evaluate";
	}else{
		id = "allOrder";
	}
	 console.log(id);
	  $("#" + id).addClass("navActive").show();
	
     $("#" + id).siblings().removeClass("navActive");  
}); 

function findxq(orderId_){
	window.location.href="FrmOrder_My.findOrder?orderId="+orderId_;
}

/* function getEWM(zhuCode_,orderId_,type_){
window.location.href="FrmOrderInterface.getEWM?zhuCode_="+ zhuCode_ + "&orderId_="+ orderId_ + "&type_=" +type_;
} */

//待开箱
function getEWM(zhuCode_,orderId_,type_){
	$(".QR_code_img").show();
	$("#img1").attr("src","FrmOrderInterface.createQR?zhuCode_="+zhuCode_+ "&orderId_="+ orderId_ +"&type_="+ type_);
	setTimeout(function() {
		$(".QR_code_img").css("background-color","rgba(21,20,20,.35")
	},1000);
}

$("body").on('click',".QR_code_img",function(){
	$(this).hide();
})


$("body").on("swipeleft","#nav_bar",function(){//左滑显示隐藏按键
    $(this).animate({marginLeft:'-40%'},200);
});																																						
$("body").on("swiperight","#nav_bar",function(){//右滑恢复
    $(this).animate({marginLeft:'0'});
});

//    导航栏点击选中
$("#nav_bar").on("click","li",function(){//左滑显示隐藏按键
    $(this).addClass("navActive").siblings().removeClass("navActive");
    $(".order_list").hide();
    $(".order_list").eq($(this).index()).show();
});

//    有损归还弹窗
$("body").on("click",".destroy_return",function(){
    modalReturn();
});

//    无损归还弹窗
$("body").on("click",".lossless_return",function(){
    modalCancel("确认无损归还？");
});
$("body").on("click",".overdue_return",function(){
    modalCancel("您已经超出预租时间"+1+"天需支付"+20+"元/天，共计"+20+"元");
});
function goEvaluate(orderId_,userId_,orderType_){
	window.location.href="FrmOrder_My.goEvaluate?orderId_="+orderId_+"&userId_="+userId_+"&orderType_="+orderType_; 
}
function bxgh(){
	$("#bxgh").css("display","");
	$("#wsgh").css("display","none");
}
function qx(){
	$("#bxgh").css("display","none");
}
function kdgh(orderId){
	window.location.href="FrmOrder_My.goExpressReturn?orderId="+orderId;

}

function gh(orderId_,type){
	$("#bxgh").css("display","none");
	var msg = "确定"+type+"归还？\n\n请确认！"; 
	modalCancel(msg);
	$(".confirm1").on("click",function(){
		
	
	/*  if (confirm(msg)==true){  */
	 	 $.ajax({
				url:"FrmOrder_My.findOrder",
				type:'post',
				data:{"orderId":orderId_,"falg":"ajax"
				},
				datatype:"text",
				success:function(data){
					var str = eval('(' + data + ')');
					console.log(str);
					var order =  eval('(' + str.order + ')');
					var returnTime_ = Date.parse(new Date(order.returnTime_));
					var timestamp = Date.parse(new Date());
					var time = timestamp-returnTime_;
					if(time >= 0){
						var sumsec=time/1000;
						var day = parseInt(sumsec/(24*60*60));
						var hours = parseInt((sumsec-(day*24*60*60))/(60*60));
						var min = parseInt((sumsec-(day*24*60*60)-(hours*60*60))/60);
						var sec =sumsec%60;
						var str = "你已超出："+day+"天"+hours+"小时";
						var ms = str+"\n\n请确认！"; 
						if (confirm(ms)==true){ 
							window.location.href="FrmOrder_My.findOrder?type="+type+"&orderId="+orderId_+"&falg=goOverdue"; 
						}
					}
					if(time < 0){
						window.location.href="FrmOrder_My.findOrder?type="+type+"&orderId="+orderId_+"&falg=goOverdue"; 
					}
					
				},
				error:function(){
					alert("哎呀！系统异常稍后重试！");
				},	
			})	 
	 /* } */
	 
	})/* else{ 
	  return false; 
	 }  */
}
function findLogistics(orderId_){
	window.location.href="FrmOrder_My.findLogistics?orderId_="+orderId_; 
}
function find(userId_){
	window.location.href="FrmOrder_My.goOrderSearch?userId="+userId_; 
}

//退款
function refund(orderId_){
	window.location.href="FrmOrder_My.goRefund?orderId_="+orderId_; 
}
</script>
</body>
</html>