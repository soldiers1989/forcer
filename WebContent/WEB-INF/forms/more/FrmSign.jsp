<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../jspf/head1.jspf"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${cdn}/css/club/base.css">
<link rel="stylesheet" type="text/css" href="${cdn}/css/club/public.css">
<link rel="stylesheet" type="text/css" href="${cdn}/css/club/alert.css">
<link rel="stylesheet" type="text/css" href="${cdn}/css/club/data.css">

<%-- <link rel="stylesheet" type="text/css" href="${cdn}/css/my.css"/> --%>
<title>一启享</title>
<style type="text/css">
/* 弹窗样式 */
.mars{
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.6);
	position: fixed;
	top: 0;
	left:0;
	z-index: 1000;
	display: none;
}
.container{
	width: 80%;
	background: white;
	position: absolute;
	top: 50%;
	transform:translateY(-50%);
	left: 10%;
	z-index: 2;
	font-family: PingFang-SC-Medium;
	border-radius:.255rem;
}
.content{
	width:100%;
	font-size: .34rem;
	text-align: center;
	line-height: .51rem;
	word-break: break-all;
	font-family: PingFang-SC-Medium;
	color: #4f4f4f;padding: .425rem .255rem;
	margin:0;
	box-sizing: border-box;
	-webkit-box-sizing: border-box;
}
.confirm{
	width: 100%;
	font-size: .306rem;
	text-align: center;
	height:.765rem;
	line-height: .765rem;
	background: white;
	border-top:1px solid #ccc;
	color: #2f8bf7;
	cursor:pointer;
	border-radius: 0 0 3px 3px;
	-webkit-border-radius: 0 0 .255rem .255rem;
}
.confirm button{
	width: 100%;
	height: 100%;
	font-size: .306rem;
	font-weight: normal;
	font-stretch: normal;
	letter-spacing: 0px;
	color: #2f8bf7;
}
.sign_integral{
	font-size: .272rem;
	font-weight: normal;
	font-stretch: normal;
	letter-spacing: 0px;
	color: #999999;
}
.sign_integral .sign_num{
	font-family: PingFang-SC-Regular;
	font-style: italic;
	font-size: .34rem;
	font-weight: normal;
	letter-spacing: 2px;
	color: #e5002f;
}
.sign_hint{
	font-size: .221rem;
	font-weight: normal;
	font-stretch: normal;
	letter-spacing: 1px;
	color: #808080;
}
.sign_img img{
	width: 1.36rem;
	height: .969rem;
	margin-bottom: .34rem;
}
.operation_logo{
    padding: .17rem 0 .17rem .17rem;
    background-color: #f5f5f5;
}
.loadingbox .icon{/* /forcer/WebContent/admin/images/icon/loading.gif */
	background-image: url('${cdn}/admin/images/icon/loading.gif');
	-webkit-background-size: 4rem auto;
}
</style>
<script type="text/javascript">
//签到
function tijiao() {
    $(".loadingbox2").show();
	$.ajax({
		url : 'FrmMore.sign',
		dataType : 'json',
		type : 'post',
		cache : false,
		success : function(data) {
			if (data == false) {
				window.location.reload();
			} else {
				window.location.reload();
			}
		}
	}); 
}
//取消签到
function cancel() {
	$.ajax({
		url : ' FrmMore.concerSign',
		dataType : 'json',
		type : 'post',
		cache : false,
		success : function(data) {
			if (data == false) {
				window.location.reload();
			} else {
				window.location.reload();
			}
		}
	});
}
</script>
<script type="text/javascript">
     function showSign(){
    	 $(".mars").show();
    	 $("body").on("click",".confirm",function(){
    		 $(".mars").hide();
    		 window.location.href="FrmSign";
    	 })
     }
     
     
	function btn_sign(){
	  $.ajax({
		  url:"FrmMore.sign",
		  type:"post",
		  dataType:"json",
		  data:{},
		  async:false,
		  success:function(data){
			  if(data=="false"){
				  layer.msg("今天已经签到,请明天签到!");
			  }
			  if(data == "success"){
				  showSign();
			  }
			  $(".f-Sign").hide();
			  $(".heade").removeAttr("style");
		  },
		  error:function(data){
			  layer.msg("网络错误,请重试");
		  }
	  })
	 }
</script>
<script type="text/javascript">
function returnPage(){
    var browser = {
            versions : function() {
              var u = navigator.userAgent, app = navigator.appVersion;
              return {
                trident : u.indexOf('Trident') > -1, //IE内核
                presto : u.indexOf('Presto') > -1, //opera内核
                webKit : u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
                gecko : u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1,//火狐内核
                mobile : !!u.match(/AppleWebKit.*Mobile.*/), //是否为移动终端
                ios : !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
                android : u.indexOf('Android') > -1 || u.indexOf('Adr') > -1, //android终端
                iPhone : u.indexOf('iPhone') > -1, //是否为iPhone或者QQHD浏览器
                iPad : u.indexOf('iPad') > -1, //是否iPad
                webApp : u.indexOf('Safari') == -1, //是否web应该程序，没有头部与底部
                weixin : u.indexOf('MicroMessenger') > -1, //是否微信 （2015-01-22新增）
                qq : u.match(/\sQQ/i) == " qq" //是否QQ
              };
            }(),
            language : (navigator.browserLanguage || navigator.language)
                .toLowerCase()
          }
      if (browser.versions.ios) {
        window.webkit.messageHandlers.webViewApp.postMessage({
          "type":"backClick"
        }); 
      }else{
         JSTag.finshH5(); 
      }
}
</script>
</head>
<body>
<div style="display:none;" id="load-box" class="loadingbox loadbox loadingbox2">
<p class="cl-666 f14"><span class="icon">正在上传，请稍后</span></p></div>
<div class="header2">
    <a href="FrmMore.userCenter" onclick="returnPage()" class="prev"></a>
    <div class="head_title font18">每日签到</div>
    <a href="FrmMore.signExplain" class="more font15">签到说明</a>
</div>
<div class="heade sign_everyDay">
<div id="mat"></div>
 
   <!-- <span>
      <a href="javascript:history.go(-1)" class="pre">></a>  
         <label style="text-align:center;">每日签到</label>
         <label style="float:right;">积分规则</label>
    </span> -->
    <!--  <div class="parent_ paddingTop">
       <div class="child_ paddingTop">
           <a href="javascript:void(0);" onclick="btn_sign();" class="sign_btn">
           		<div class="immediately_sign font18">立即签到</div>
           		<div class="font11">送积分</div>
           </a>
       </div>
   </div> -->
    <div class="parent_ paddingTop" >
        <c:if test="${user.items.sign == 0}">
	       <div class="child_ paddingTop" style="line-height: 2.1rem;">
	           <a href="#">
					<span onclick="tijiao()" class="right_sign">签到</span>
					 <!--  <span class="cancle" style="display: none;" style="color: #1185fe;" onclick="cancel()">取消签到</sapn>  -->  
                </a>
	       </div>
		</c:if>
		<c:if test="${user.items.sign == 1}">
			<div class="child_ paddingTop" style="padding-top: .17rem;line-height: .425rem;">
	           <a href="#" class="right_sign" style="line-height: 0.34rem;padding-top: 0.255rem;">
	               <div><img src="../../img/sign1.png" alt=""></div>
					<!-- <span style="color: #1185fe;display: none;" onclick="tijiao()">签到</span>
				 	<span href="#"  onclick="cancel()" style="width: 26%;">取消签到</span> -->
					<span class="font15">今已签到</span>  
				</a>
	       </div>
		</c:if>
                   <!--  <span>签到</span> -->
   </div>
   <div>
       	<div class="operation_logo">今日签到人数：${sum } 已签到天数:${sumSign }积分奖励额${sumSign*10 }</div>
   </div>
   <div class="myMedalDayDate">
        <div class="account-box">
		    <h2 class="account-title">
		        <div class="clearfix">
		            <div class="f-btn-jian left"><i class="month-pre"></i></div><div class="left f-riqi"><span class="f-year">2017</span><span>年</span><span class="f-month">1</span><span>月</span></div><div class="f-btn-jia left"><i class="month-next"></i></div><!--一定不能换行   -->
		        </div>
		    </h2>
    <div class="f-rili-table">
       <div class="f-rili-head clearfix">
         <div class="f-rili-th">日</div>
         <div class="f-rili-th">一</div>
         <div class="f-rili-th">二</div>
         <div class="f-rili-th">三</div>
         <div class="f-rili-th">四</div>
         <div class="f-rili-th">五</div>
         <div class="f-rili-th">六</div>
         <div class="clear"></div>
       </div>
         <div class="f-tbody clearfix">
         </div>
      </div>
     </div>
   </div>
  </div>
  <%-- 
	<div class="mars">
		<form class="container" action="" method="post">
			<div class="content">
				<div class="sign_img"><img src="${cdn }/images/gift.png" ></div>
				<div class="sign_integral">
					<span>恭喜成功获得</span><span class="sign_num">2</span><span>积分</span>
				</div>
				<div class="sign_hint">明天记得继续来领积分喔！</div>
				<input type="hidden" name="integral_" class="integral_" id="integral_" value="2">
			</div>
				<div class="confirm">
				   <button type="button" id="btn_sign" >确定</button>
				</div>
		</form>
	</div> --%>
	
		<!-- <div class="f-Sign">
			<form class="pageform" action="" method="post">
				<div class="f-Sign-group">
 					<img src="" >
					<span>恭喜成功获得<span style='color:red;'>2</span>积分</span>
					<input type="hidden" name="integral_" class="integral_" id="integral_" value="2">
					<div class="f-Sign-group-inline">
					    <span>明天记得继续来领积分喔!</span>
					</div>
					<div class="f-Sign-submit">
					   <button id="btn" type="button">确定</button>
					</div>
				</div>
			</form>
		</div> -->
   
	
   <script type="text/javascript">
   $(function(){
	   //页面加载初始化年月
	   var mydate = new Date(); 
	   $(".f-year").html(mydate.getFullYear());
	   $(".f-month").html(mydate.getMonth() + 1);
	   showDate(mydate.getFullYear(),mydate.getMonth()+1);
	   
	   //日历上一月
	   $(".f-btn-jian").click(function(){
		   var mm = parseInt($(".f-month").html());
		   var yy = parseInt($(".f-year").html());
		   if(mm == 1){
			   //返回12月
			   $(".f-year").html(yy-1);
			   $(".f-month").html(12);
			   showDate(yy-1,12);
			   preMduguo(yy-1,12);
		   }else{
			   $(".f-month").html(mm-1);
			   showDate(yy,mm-1);
			   preMduguo(yy,mm-1);
		   }
		   showOrHide();
	   })
	   //日历下一月
	   $(".f-btn-jia").click(function(){
		   var mm = parseInt($(".f-month").html());
		   var yy = parseInt($(".f-year").html());
		   if(mm == 12){ //返回12月
			   $(".f-year").html(yy+1);
		       $(".f-month").html(1);
		       preMduguo(yy,mm-1);
		       showDate(yy, mm-1);
		   }else{//上一月
			   $(".f-month").html(mm+1);
		        showDate(yy,mm+1);
		        prveMduguo(yy,mm+1); 
		   }
		   showOrHide();
		   nowduguo();
	   })	   
	   //读取年月写入日历  重点算法!!!!!
	   function showDate(yyyy,mm){
		 var dd = new Date(parseInt(yyyy),parseInt(mm),0); //Wed Jan 31 2018 00:00:00 GMT+0800 (中国标准时间)
		 var daysCount = dd.getDate(); //获取本月天数
		 var mystr = ""; //写入代码
		 var icon = ""; //图标代码
		 var today = new Date().getDate(); //今天几号  5
		 var monthstart = new Date(parseInt(yyyy)+"/"+parseInt(mm) + "/1").getDay(); //本月1日周几
		 var lastMonth; //上一月天数
		 var nextMonth; //下一月天数
		 if(parseInt(mm) == 1){
			 lastMonth = new Date(parseInt(yyyy)-1,parseInt(12),0).getDate();
		 }else{
			 lastMonth = new Date(parseInt(yyyy),parseInt(mm)-1,0).getDate();
		 }
		 if(parseInt(mm) == 12){
			 nextMonth = new Date(parseInt(yyyy)+1,parseInt(1),0).getDate();
		 }else{
			 nextMonth = new Date(parseInt(yyyy),parseInt(mm)+1,0).getDate();
		 }
		 //计算上月空格数
		 for(var j = monthstart; j > 0; j --){
			 mystr += "<div class='f-td f-null f-lastMonth' style='color:#eee;'>"+(lastMonth-j+1)+"</div>";
		 }
		  //本月单元格
		 for(var i = 0 ; i < daysCount; i++){
			 //这里为一个单元格,添加内容在此
			 mystr += "<div class='f-td f-number'><span class='f-day'>" +(i+1)+"</span>"
			        +"<div class='f-yuan'></div>"
			        +"</div>";
		 }
		 
		 //计算下月空格数
		 for(var k = 0; k < 42-(daysCount+monthstart); k++){//表格保持等高6行42个单元格
			 mystr += "<div class='f-td f-null f-nextMounth' style='color:#eee;'>"+(k+1)+"</div>"; 
		 } 
		 
		 //写入日历
		 $(".f-rili-table .f-tbody").html(mystr);
		 // $(".f-rili-table .f-tbody").html();
		 //alert(mystr);
		 
		 //给今日加class
		 if(mydate.getFullYear() == yyyy){
			 if((mydate.getMonth() +1) == mm){
				 var today = mydate.getDate();
				 var lastNum = $("f-lastNum").length;
				 //$(".f-rili-table .f-td").eq(today+lastNum -1).addClass("f-today");
				 nowduguo();
			 }
		 }
	   };
	   showOrHide();
	   function showOrHide(){
		   var dataMonth = parseInt(mydate.getMonth()+1);
		   var nowDeta = parseInt(mydate.getDate());
		   var nowHtml = parseInt($(".f-month").html());
		   /* if(nowHtml < dataMonth){
			   $(".f-btn-jia").css('display','block');
		   }else{
			   $(".f-btn-jia").css('display','none');
		   } */
	   }
	   function strToDate(dateObj){
		   dateObj = dateObj.replace(/T/g, ' ').replace(/\.[\d]{3}Z/, '').replace(/(-)/g, '/')
		   dateObj = dateObj.slice(0, dateObj.indexOf("."))
		   return new Date(dateObj)
		 }
	   function nowduguo(){
		   var data = eval('${createTime_}');
		   for(var key in data){
			   var time = data[key].createTime_;
			  // var daKaTime = new Date(time);
			  var daKaTime = strToDate(time);
			   var timeY = parseInt(daKaTime.getFullYear());
			   var timeM = parseInt(daKaTime.getMonth() +1);
			   var timeD = parseInt(daKaTime.getDate());
			   var dataMonth = parseInt(mydate.getMonth() +1);
			   var nowDeta = parseInt(mydate.getDate());
			   var nowHtml = parseInt($(".f-month").html());
			   
			   if(nowHtml === timeM){
				   for(var i = nowDeta; i >= 0; i --){
					   if(timeD === i){
						   $('.f-number .f-day').each(function(i){
							   if(timeD === parseFloat($(this).html())){
								   /* $(this).siblings(".f-yuan").addClass('active'); */
								   $(this).parent().addClass('active');
							   }
						   })
					   }
				   }
			   }
		   }
	   };
	   function prveMduguo(yy,mmmm){
		   var data = eval('${createTime_}');
		   for(var key in data){
			   var time = data[key].createTime_;
			   var daKaTime= new Date(time);
			   var timeY = parseInt(dakaTime.getFullYear());
			   var timeM = parseInt(dakaTime.getMonth()+1);
			   var timeD = parseInt(dakaTime.getDate());
			   
			   var dataMonth = parseInt(mydate.getMonth());
			   //现在是哪一个月
			   var nowDeta = parseInt(mydate.getDate()); //今天是几号 用不上
			   //需要获得6月有多少天,遍历6月有几天打过卡获得这个月的第一天,最后1天不固定
			   var new_deta = new Date(yy,mmmm,1);
			   //console.log('new_deta '+new_deta);
			   //console.log('nowDeta ' + nowDeta);
			   var nowHtml = parseInt($(".f-month").html());//获取 内容是几月
			   //console.log(nowHtml);
			   if(nowHtml === timeM){//当月份相同时,判断是否存在相同的日期 从这个月的最后一天开始遍历,有相同的给他的兄弟元素加active
				   //alert(nowHtml === timeM);
			      for(var i = prveDeta; i >= 0 && i < 32; i++){
			    	
			    	  if(timeD === i){
			    		  $('.f-number .f-day').each(function(i){
			    			  if(timeD === parseFloat($(this).html())){
			    				  $(this).parent().addClass('active');
			    			  }
			    		  })
			    	  }
			      }
			   }
			   
		   }
	   }
   })
   </script>
</body>
<script type="text/javascript" src="${cdn}/js/box/wxljqdlogin.js"></script>
</html>
    