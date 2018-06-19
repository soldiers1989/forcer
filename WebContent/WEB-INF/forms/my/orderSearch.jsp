 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单搜索</title>
<style>
.no_result{
      height:7rem;
      text-align: center;
      padding: .51rem 0;
      background-image:url('../../img/zwsj.png');
      background-position:center  center;
      background-repeat: no-repeat;
    }
</style>
</head>
<script type="text/javascript">
    
</script>
<body>
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">订单搜索</div>
</div>
<div class="main_content" id="myOrder_search">
    <div id="mat"></div>
    <div class="order_search">
        <input type="text" id="order_search" placeholder="请输入关键词，商品名称或订单号">
        <input type="hidden" id="userId_" name="userId" value="${userId}" >
        <input type="button" value="搜索" onclick="search();" class="searchBtn">
    </div>
     <c:if test="${ empty orders}"><div class="no_result"></div></c:if>
    <c:if test="${not empty orders}">
    <c:forEach  items="${orders}" var="order" >
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
                    <c:if test="${order.items.orderState_ == 7}">退款</c:if>
                </span>
            </div>
            <div class="right_buyCommodity_message" style="height: auto;">
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
                             <span class="font18 text-danger">￥${order.items.dayRentMoney_}</span>
                             <span class="font11 text-danger">/天</span>
                             <span class="line-th">${order.items.discountPrice_}/天</span><a>${flag }</a>
                         </div>
                        <div class="right_buyCommodity_price text-gold font10">
                            <span>押金：￥</span><span class="text-gold">${order.items.cashPledge_}</span>
                        </div>
                    </div>
                </div>
                <c:if test="${order.items.orderState_ == 4}"> <!--租用中 -->
                    <div class="tr pr_10 text-gray font10 mt_10" style="line-height: .51rem;">
                        <span>租用时间：</span><span>${order.items.beginTime_}-${order.items.returnTime_}</span>
                    </div>
                    <div class="tr pr_10 text-gold font10">
                        <span id="djs">${order.items.difTime_}</span>
                    </div>
                </c:if>
            </div>
            <div class="userOrder_operation" >
              <c:if test="${order.items.orderType_ == 1 || order.items.orderType_ == 3}"><!-- 自取租赁和寄送到柜 -->
                  <c:if test="${order.items.orderState_ == 3}">
                    <button onclick="getEWM('${order.items.zhuCode_}');">待开箱</button>
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
                <button type="button" value="" onclick="gh('${order.items.orderId_}','报修');">报修归还</button>
                <button type="button" value="" onclick="gh('${order.items.orderId_}','无损');" >无损归还</button>
            </c:if>
            
            <c:if test="${order.items.orderState_ == 5}">
                <c:if test="${order.items.returnMethod_ == 0}">
                    <button type="button" value="" >归还二维码</button>
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
	</c:if>
</div>
    <%-- <li>
        <input type="text" style="width: 50%;height: 20px;" id="search" placeholder="请输入关键词，商品名称或订单号" id="search">
        <input type="button" value="搜索" onclick="search();">
    </li>
    <div id="all" >
        <c:forEach  items="${orders}" var="order" >
            <li>
                <c:if test="${order.items.orderType_ == 1}">自取租赁</c:if>
                <c:if test="${order.items.orderType_ == 2}">寄送上门</c:if>
                <c:if test="${order.items.orderType_ == 3}">寄送到柜</c:if>
                <c:if test="${order.items.orderType_ == 4}">线上购买</c:if>
            </li>
            <li>
                <c:if test="${order.items.orderState_ == 1}">待发货</c:if>
                <c:if test="${order.items.orderState_ == 2}">待开箱</c:if>
                <c:if test="${order.items.orderState_ == 3}">待收货</c:if>
                <c:if test="${order.items.orderState_ == 4}">租用中</c:if>
                <c:if test="${order.items.orderState_ == 5}">待归还</c:if>
                <c:if test="${order.items.orderState_ == 6}">完成</c:if>
                <c:if test="${order.items.orderState_ == 7}">退款</c:if>
            </li>
            <div>
                <img  src="${order.items.twoImgUrl_}">
            </div>
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
            <c:if test="${order.items.orderState_ == 4}"> <!--租用中 -->
                <c:if test="${falg == 3}">
                    <div>
                        倒计时：<span id="djs">${order.items.difTime_}</span>
                    </div>
                </c:if>
                <li>
                    <span>租用时间：</span><span>${order.items.beginTime_}-${order.items.returnTime_}</span>
                </li>
                <li>
                    <input type="button" value="报修归还" onclick="bxgh();">
                    <input type="button" value="无损归还" onclick="wxgh();">
                </li>
                <div style="display: none" id="bxgh">
                    <form action="FrmOrder_My.upOrderRepair">
                        <li>
                            报修类型：
                            <input  type="radio" value="0"  id="repairType0" name="repairType_" />自己责任
                            <input  type="radio" value="1"  id="repairType1" name="repairType_" />他人责任
                        </li>
                        <li>
                            归还方式：
                            <input  type="radio" value="1" id="returnMethod1" name="returnMethod_" onclick="kdgh(this);"/>快递归还
                            <input  type="radio" value="0" id="returnMethod0" name="returnMethod_" />箱柜归还
                        </li>
                        <li>
                            <input type="button" onclick="qx();" value="取消">
                            <input type="hidden" name="orderId_" value="${order.items.orderId_}">
                            <input type="hidden" name="returnType_" value="1" />
                            <input type="submit"  value="确定">
                        </li>
                    </form>
                </div>
            </c:if>
            <c:if test="${order.items.orderState_ == 5}"><!-- 待归还 -->
                <li>
                    <span>租用时间：</span><span>${order.items.beginTime_}-${order.items.returnTime_}</span>
                </li>
                <li>
                    <input type="button" value="报修归还" onclick="bxgh();" />
                    <input type="button" value="无损归还" onclick="wsgh('${order.items.orderId_}');" />
                </li>
                <div style="display: none" id="bxgh">
                    <form action="FrmOrder_My.upOrderRepair">
                        <li>
                            报修类型：
                            <input  type="radio" value="0"  id="repairType0" name="repairType_" />自己责任
                            <input  type="radio" value="1"  id="repairType1" name="repairType_" />他人责任
                        </li>
                        <li>
                            归还方式：
                            <input  type="radio" value="1" id="returnMethod1" name="returnMethod_" onclick="kdgh(this);"/>快递归还
                            <input  type="radio" value="0" id="returnMethod0" name="returnMethod_" />箱柜归还
                        </li>
                        <li>
                            <input type="button" onclick="qx();" value="取消">
                            <input type="hidden" name="orderId_" value="${order.items.orderId_}">
                            <input type="hidden" name="returnType_" value="1" />
                            <input type="submit"  value="确定">
                        </li>
                    </form>
                </div>
            </c:if>
            <c:if test="${order.items.orderState_ == 6}"><!-- 待评价 -->
                <input type="button" value="去评价" onclick="goEvaluate('${order.items.orderId_}','${order.items.userId_}','${order.items.orderType_}');">
            </c:if>
            <a href="FrmOrder_My.findOrder?orderId=${order.items.orderId_}">查看详情</a>
        </c:forEach>
    </div>
    <div id="sear">
    
    </div>
     --%>
</body>
<script type="text/javascript">
function findxq(orderId_){
    window.location.href="FrmOrder_My.findOrder?orderId="+orderId_;
}
function getEWM(zhuCode_){
    window.location.href="FrmOrderInterface.getEWM?zhuCode_="+zhuCode_;
}
//有损归还弹窗
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
     if (confirm(msg)==true){ 
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
                    alert("哎呀！系统异常请稍后重试！");
                },    
            })     
     }else{ 
      return false; 
     } 
}
function findLogistics(orderId_){
    window.location.href="FrmOrder_My.findLogistics?orderId_="+orderId_; 
}
function find(userId_){
    window.location.href="FrmOrder_My.goOrderSearch?userId="+userId_; 
}
function search() {
    var value = $("#order_search").val();
    console.log(value);
    if(value == "" || value == null){
        alert("请填写你想输入的内容");
    }
    var userId_ = $("#userId_").val();
    window.location.href="FrmOrder_My.orderSearch?userId=${userId}&da="+value;
    /* if(value != "" && value != null){
        var obj = new AjaxObj();
        var userId = '${userId}';
        obj.ajax(value,userId);
    } */
     
}
/* function AjaxObj(){
        this.ajax = function(da,userId){
              $.ajax({
                    url : 'FrmOrder_My.orderSearch',
                    data : {
                        "da" : da,
                        "userId" : userId
                    },
                    type: "GET",
                    dataType: "json",
                    contentType: false, //必须
                    success: function (value) {
                         var datas = eval('(' + value.orders + ')');
                         var str = "";
                         for(var i=0;i<datas.length;i++){
                             var data = datas[i];
                             var orderType_;
                            switch (data.orderType_) {
                                case "1":
                                    orderType_="自取租赁"
                                    break;
                                case "2":
                                    orderType_="寄送上门"
                                    break;
                                case "3":
                                    orderType_="寄送到柜"
                                    break;
                                case "4":
                                    orderType_="线上购买"
                                    break;
                                default:
                                    break;
                            }
                            var orderState_;
                            switch (data.orderState_) {
                                case "1":
                                    orderState_="待发货"
                                    break;
                                case "2":
                                    orderState_="待开箱"
                                    break;
                                case "3":
                                    orderState_="待收货"
                                    break;
                                case "4":
                                    orderState_="租用中"
                                    break;
                                case "5":
                                    orderState_="归还"
                                case "6":
                                    orderState_="完成"
                                case "7":
                                    orderState_="退款"
                                default:
                                    break;
                            }
                            str +="<li>"+orderType_ +"</li><li>"+orderState_+"</li><a href='FrmOrder_My.findOrder?orderId="+data.orderId_+"'"+">查看详情</a>"
                         }
                         $("#sear").html(str);
                    }
                })
        } 
    }*/
</script>
</html>