 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../jspf/head1.jspf"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${cdn}/layui/layui.js"></script>
<title>立即运维</title>
<style>
	.time{
		border:none;
		height:90%;
		width:100%;
		color: #222222;
		font-size:.221rem;
		text-align:right;
		/* border-bottom:1px solid #e6e6e6 !important; */
	}
	#laydate_box{
		position:absolute !important;
		left:1rem !important;
	}
</style>
</head>
<script type="text/javascript">
  layui.use('laydate', function(){
      var laydate = layui.laydate; 
    });
</script>
<script type="text/javascript">
$(function(){
$('#sub').on('click', function() {
    var OpenBoxTime_=$('#OpenBoxTime_').val();
    var closeBoxTime_=$('#closeBoxTime_').val();
    var upload1 = $("#upload1").val();
  if(OpenBoxTime_ == null ||  OpenBoxTime_=="" || closeBoxTime_ == null || closeBoxTime_ == ""){
	  alert("开箱或关箱时间不可为空");
	    return false;
  }
  if(closeBoxTime_<OpenBoxTime_){ 
    alert("关箱时间必须大于关箱时间");
    return false;
    }
  if(upload1 == null ||  upload1 == "" ){
	  alert("请上传图片！");
	  return false;
  }
 
    });
})
</script>
<!-- <script type="text/javascript">
	function check(){
		  var OpenBoxTime_=$('#OpenBoxTime_').val();
		    var closeBoxTime_=$('#closeBoxTime_').val();
		  if(OpenBoxTime_ != null && OpenBoxTime_!=""){
		  if(closeBoxTime_<OpenBoxTime_){ 
		    alert("关箱时间必须大于关箱时间");
		    return false;
		    }
		  }
	}
</script> -->
<body>
<%-- <<<<<<< HEAD
	<div>
		<span>物品名称：${pro.items.proName_ }</span>  <span>   识别码：${zhuCode_ }</span><br>
		<span>箱子编号：${pro.items.setBoxId_ }</span><span>   状态：开箱</span><br>
		<span>本次运维订单编号：${ord.items.orderId_}</span><br>
		<span>累计租借时长：${ord.items.sumTime_}天</span><br>
		<span>历史检查维护：
			<c:if test="${empty ope.items.count_ }">
				暂无记录
			</c:if>
			<c:if test="${not empty ope.items.count_ }">
				${ope.items.count_ }
			</c:if>
		</span><span>历史折损率：${ord.items.scrapState_}</span>
	</div>
	<div>
		<form action="FrmProDetails.addOperate"  enctype="multipart/form-data" method="post" id="form1">
			<span>本次运维定义折损率：<input type="text" name="nowLoss_" value="">%</span><br>
			<span>本次订单开锁次数：${ord.items.openCount_}次</span><br>
			<span>物品上次订单归还时间：
				<fmt:formatDate value="${ord.items.returnOverTime_}" pattern="yyyy-MM-dd HH:mm:ss"/>
			</span><br>
			<span>订单上次联系人电话：${ord.items.recPhone_}</span><br>
			<span>物品上次归还前是否有运维：
			
				<c:if test="${empty ord.items.operateState_ }">
						无
				</c:if>
				<c:if test="${ord.items.operateState_ == 0}">
					无
				</c:if>
				<c:if test="${ord.items.operateState_ == 1}">
					有
				</c:if>
			</span><br>
			<span>本次运维开箱时间：<input type="datetime-local" name="OpenBoxTime_" value=""></span><br>
			<span>本次运维关箱时间：<input type="datetime-local" name="closeBoxTime_" value=""></span><br>
			<a href="FrmProDetails.goOrder?zhuCode_=${ord.items.zhuCode_}">此商品租借历史 ----------------></a><br>
			<span>运维描述：</span><br>
			<textarea placeholder="已沟通上次归还人，大致描述使用情况" name="leaveMess_" value=""></textarea>
			<div class="group-box">
				<label class="fl">上传图片：</label>
				<div class="fileBox">
					<div class="upFileBox">
						<img style="width: 50px;height: 50px;display:none;"  class="img"> <input type="file"
							onchange="getImgURL(this)" id="imgUrlFile" class="fileInput"
							accept="pdf/gif/png" name="upload1"> 
							<input type="hidden" name="" value="" class="urlImg" id="upload1"> 
							<span class="removeBut"  style="display: none;">X</span>
					</div>
				</div>
			</div>
			<input type="hidden" name="orderId_"  value="${ord.items.orderId_}">
			<input type="hidden" name="zhuCode_"  value="${zhuCode_}">
			<input type="submit" value="确认提交">
		</form>
	</div>	
======= --%>
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">立即运维</div>
</div>
<div class="main-contnet" id="rightAway_maintain">
    <div id="mat"></div>
    <div class="list mb_10">
        <ul class="message_list">
            <li class="flexLayout">
                <div class="list_left">
                    <span class="font13 text-666">物品名称：</span>
                    <span class="font13">${pro.items.proName_ }</span>
                </div>
                <div class="list_right">
                    <span class="font13 text-666">识别码：</span>
                    <span class="font13">${zhuCode_ }</span>
                </div>
            </li>    
            <li class="flexLayout">
                <div class="list_left">
                    <span class="font13 text-666">箱子编号：</span>
                    <span class="font13">${pro.items.boxId_ }</span>
                </div>
                <div class="list_right">
                    <span class="font13 text-666">状态：</span>
                    <span class="font13">开箱</span>
                </div>
            </li>
            <li class="">
                <div >
                    <span class="font13 text-666">本次运维订单编号：</span>
                    <span class="font13">${ord.items.orderId_}</span>
                </div>
            </li>
            <li class="">
                <div class="">
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
                        <span class="font13">${ope.items.count_ }</span>
                    </c:if>
                </div>
                <div class="list_right">
                    <span class="font13 text-666">历史折损率：</span>
                    <span class="font13">${ord.items.scrapState_}</span>
                </div>
            </li>
        </ul>
    </div>
    <form action="FrmProDetails.addOperate" enctype="multipart/form-data" method="post" id="form1" class="list" style="padding-left: 0" onsubmit="return check();">
       <input type="hidden" value="${cid_ }" name="cid_">
        <ul class="message_list pl_10">
            <li class="flexLayout">
                <div class="list_left">
                    <span class="font13 text-666">本次运维定义折损率：</span>
                </div>
                <div class="list_right">
                    <input type="text" name="nowLoss_" value="50" class="derating_rate font13">%
                </div>
            </li>
            <li class="flexLayout">
                <div class="list_left">
                    <span class="font13 text-666">本次订单开锁次数：</span>
                </div>
                <div class="list_right">
                    <span class="font13">${ord.items.openCount_}&nbsp;次</span>
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
                    <c:if test="${ord.items.operateState_ == 0}">
                        <span class="font13">无</span>
                    </c:if>
                    <c:if test="${ord.items.operateState_ == 1}">
                        <span class="font13">有</span>
                    </c:if>
                </div>
            </li>
            <li class="flexLayout">
                <div class="list_left">
                    <span class="font13 text-666">本次运维开箱时间：</span>
                </div>
              <!--   <div class="list_right">
                    <span class="font13">
                    <input type="datetime-local" name="OpenBoxTime_" value="" readonly="readonly" class="tr border_0 date_bg">
                    <input type="date" name="OpenBoxTime_" value=""  class="tr border_0 date_bg">
                    </span>
                </div> -->
                
                   <div>
                	 <input type="text" class="time"  onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD hh:MM:ss'})" name="OpenBoxTime_" id="OpenBoxTime_"  placeholder="请选择" style=""/>
                </div>
            </li>
            <li class="flexLayout">
                <div class="list_left">
                    <span class="font13 text-666">本次运维关箱时间：</span>
                </div>
               <!--  <div class="list_right">
                    <span class="font13"><input type="datetime-local" name="closeBoxTime_" value="" readonly="readonly" class="tr border_0 date_bg"></span>
                </div> -->
                
                <div>
                	 <input type="text" class="time" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD hh:MM:ss'})" name="closeBoxTime_" id="closeBoxTime_" placeholder="请选择"  />
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
        <div class="textarea_box"><textarea placeholder="已沟通上次归还人，大致描述使用情况" name="leaveMess_" value="" class="textarea"></textarea></div>
        <div class="maintenance_description border_0"><span class="font13 text-666">上传图片：（0-3张）</span></div>
        <div class="img-block IDcard-upload" style="height: 1.7rem;margin-top: -.1rem;padding-top:0;">
            <div class="self-fileBox" style="margin-right: 0.1rem">
                <div class="upFileInputBox bg" id="upFile">
                    <img class="img"  src(unknown)/>
                    <input class="file" type="file" onchange="getImgURL(this)"  name="sampleImg_" id="fileInputUrl">
                    <input type="hidden" name="sampleImg_" value="" class="urlImg" id="upload1"> 
                    <span class="remBut" style="cursor:pointer;"></span>
                </div>
            </div>
        </div>
        <input type="hidden" name="orderId_"  value="${ord.items.orderId_}">
        <input type="hidden" name="zhuCode_"  value="${zhuCode_}">
        <div id="foot_mat"></div>
        <div class="flexLayout rightAway_maintainOperation ">
            <input type="button" value="重新开锁" class="border_r border_t font18">
            <input type="button" value="刷新状态" class="border_t font18">
            <input type="submit" value="确认提交"  id="sub" class="font18">
        </div>
    </form>
</div>

    <%-- <div>
        <span>物品名称：${pro.items.proName_ }</span>  <span>   识别码：${zhuCode_ }</span><br>
        <span>箱子编号：${pro.items.setBoxId_ }</span><span>   状态：开箱</span><br>
        <span>本次运维订单编号：${ord.items.orderId_}</span><br>
        <span>累计租借时长：${ord.items.sumTime_}天</span><br>
        <span>历史检查维护：
            <c:if test="${empty ope.items.count_ }">
                暂无记录
            </c:if>
            <c:if test="${not empty ope.items.count_ }">
                ${ope.items.count_ }
            </c:if>
        </span><span>历史折损率：${ord.items.scrapState_}</span>
    </div> --%>
    <%-- <div>
        <form action="FrmProDetails.addOperate"  enctype="multipart/form-data" method="post" id="form1">
            <span>本次运维定义折损率：<input type="text" name="nowLoss_" value="">%</span><br>
            <span>本次订单开锁次数：${ord.items.openCount_}次</span><br>
            <span>物品上次订单归还时间：
                <fmt:formatDate value="${ord.items.returnOverTime_}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </span><br>
            <span>订单上次联系人电话：${ord.items.recPhone_}</span><br>
            <span>物品上次归还前是否有运维：
            
                <c:if test="${empty ord.items.operateState_ }">
                        无
                </c:if>
                <c:if test="${ord.items.operateState_ == 0}">
                    无
                </c:if>
                <c:if test="${ord.items.operateState_ == 1}">
                    有
                </c:if>
            </span><br>
            ??<input type="text" value="${ord.items.zhuCode_}">
            <span>本次运维开箱时间：<input type="datetime-local" name="OpenBoxTime_" value=""></span><br>
            <span>本次运维关箱时间：<input type="datetime-local" name="closeBoxTime_" value=""></span><br>
            <a href="FrmProDetails.goOrder?zhuCode_=${ord.items.zhuCode_}">此商品租借历史 ----------------></a><br>
            <span>运维描述：</span><br>
            <textarea placeholder="已沟通上次归还人，大致描述使用情况" name="leaveMess_" value=""></textarea>
            <div class="group-box">
                <label class="fl">上传图片：</label>
                <div class="fileBox">
                    <div class="upFileBox">
                        <img style="width: 50px;height: 50px;display:none;"  class="img"> <input type="file"
                            onchange="getImgURL(this)" id="imgUrlFile" class="fileInput"
                            accept="pdf/gif/png" name="upload1"> 
                            <input type="hidden" name="" value="" class="urlImg" id="upload1"> 
                            <span class="removeBut"  style="display: none;">X</span>
                    </div>
                </div>
            </div>
            <input type="hidden" name="orderId_"  value="${ord.items.orderId_}">
            <input type="hidden" name="zhuCode_"  value="${zhuCode_}">
            <input type="submit" value="确认提交">
        </form>
    </div>     --%>
</body>
<script type="text/javascript">
/* var imgurl = "";
var count = 0;
function getImgURL(node) {
    var imgURL = "";
    try {
        var file = null;
        if (node.files && node.files[0]) {
            file = node.files[0];
            
        } else if (node.files && node.files.item(0)) {
            file = node.files.item(0);
        }
        //Firefox 因安全性问题已无法直接通过input[file].value 获取完整的文件路径  
        try {
            //Firefox7.0   
            imgURL = file.getAsDataURL();
            //alert("//Firefox7.0"+imgRUL);                           
        } catch (e) {
            //Firefox8.0以上                                
            imgRUL = window.URL.createObjectURL(file); //alert("//Firefox8.0以上"+imgRUL);  
        }
    } catch (e) {
        //支持html5的浏览器,比如高版本的firefox、chrome、ie10  
        if (node.files && node.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                imgURL = e.target.result;
            };
            reader.readAsDataURL(node.files[0]);
        }
    }
    var formFile = new FormData();
    formFile.append("action", "UploadVMKImagePath");
    formFile.append("file", file); //加入文件对象
    var data = formFile;
    var nameValue=$(node).attr("name");
    count=count+1;
    var imglength=$(node).parent().parent().parent().find("img").length;
    var a2=$(node).parent().find("img").length;
    if(imglength<3){
         $(node).parent().parent().after("<div class='self-fileBox' style='margin-right: 0.12rem'>"+
                         "<div class='upFileInputBox bg' id='upFile'>"+
                         "<img class='img' src='' style='display:none;width: 50px;height: 50px'>"+
                         "<input class='file' type='file' onchange='getImgURL(this)' name='"+nameValue+count+"' id='"+"fileInputUrl"+count+"'>"+
                          "<span class='removeBut' style='display: none;'>X</span>"+
                         "</div></div>");
            
    }
    
    imgurl = imgURL;
    wrap = $(node).attr('id');
    console.log(imgRUL);
    creatImg(imgRUL, wrap,node);
    
    return imgurl;
};
function creatImg(imgRUL, wrap,node) { //根据指定URL创建一个Img对象  
    // $("#formfileUrl span").html(imgRUL); 
    $(node).siblings('.img').attr('src', imgRUL);
    $(node).siblings('.urlImg').val(imgRUL);
    $(node).siblings('.img').show();
    $(node).siblings('.removeBut').show();
    $(node).hide();

    // alert(0);
};
$("body").on('click', '.removeBut', function() {
    $(this).siblings('.img').attr('src', '');
    $(this).siblings('.img').hide();
    $(this).siblings('.fileInput').show();
    $(this).hide();
    $("#" + wrap).siblings('.urlImg').val("");
}); */


    $(function(){
        var url=$(".self-fileBox .img").attr('src');
        if(url){
            $('.self-fileBox').find('.file').hide();
            $('.self-fileBox').find('.remBut').show();
        }else{
            $('.self-fileBox').find('.file').show();
            $('.self-fileBox').find('.remBut').hide();
        }
        $('.self-fileBox').on('click','.remBut',function(){
        $(this).siblings('.img').attr('src','');
        $(this).siblings('.img').hide();
        $(this).siblings('.file').show();
        $(this).hide();
        })
    })
    
    var imgurl = "";  
    var count=20;
    function getImgURL(node) {
    var imgURL = "";      
    try{     
    var file = null;  
    if(node.files && node.files[0] ){  
      file = node.files[0];   
    var nameValue=$(node).attr("name");
    count=count+1;
    var imglength=$(node).parent().parent().parent().find("img").length;
    if(imglength>5){
      modal("最多可添加5长图片！");
    }
    if(imglength<=2){
      $(node).parent().parent().after("<div class='self-fileBox' style='margin-right: 0.12rem'>"+
                "<div class='upFileInputBox bg' id='upFile'>"+
                "<img class='img' src='' style='display:none;'>"+
                "<input class='file' type='file' onchange='getImgURL(this)' name='"+nameValue+"' id='"+"fileInputUrl"+count+"'>"+
               "<span class='remBut' style='display:none;cursor:pointer;'></span>"+
                "</div></div>");
    }
     
      
    }else if(node.files && node.files.item(0)) {                                  
        file = node.files.item(0);     
    }     
    //Firefox 因安全性问题已无法直接通过input[file].value 获取完整的文件路径  
    try{  
        //Firefox7.0   
        imgURL =  file.getAsDataURL();   
        //modal("//Firefox7.0"+imgRUL);                           
    }catch(e){  
        //Firefox8.0以上                                
        imgRUL = window.URL.createObjectURL(file);              //modal("//Firefox8.0以上"+imgRUL);  
    }        
    }catch(e){    
    //支持html5的浏览器,比如高版本的firefox、chrome、ie10  
    if (node.files && node.files[0]) {                            
        var reader = new FileReader();   
        reader.onload = function (e) {                                        
            imgURL = e.target.result;   
        };  
        reader.readAsDataURL(node.files[0]);   
        }    
    }
        imgurl = imgURL;
        wrap=$(node).attr('id');
        $(node).next().val(imgRUL);
        creatImg(imgRUL,wrap);
        return imgURL;  
    };   
    //删除图片的方法；
    $('body').on('click touch','.remBut',function(){
        $(this).siblings('.img').attr('src', '');
        $(this).siblings('.img').hide();
        $(this).siblings('.file').show();
        $(this).hide();
        $("#" + wrap).siblings('.urlImg').val("");
    })
    function creatImg(imgRUL,wrap){   //根据指定URL创建一个Img对象  
        $("#"+wrap).siblings('.img').attr('src', imgRUL);
        $("#"+wrap).siblings('.urlImg').val(imgRUL);
        $("#"+wrap).siblings('.img').show();
        $("#"+wrap).siblings('.remBut').show();
        $("#"+wrap).hide();
    };
    
    $("input[name='OpenBoxTime_'").on("click",function(){
    	
    	 	//获取当前时间  n y r s f m 
    		var timestamp = Date.parse(new Date());
    		var today = new Date();
    		var nowDate = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
    		// 转为 ：上午10:33:24 
    		var time1 = today.getHours()+':'+today.getMinutes()+':'+today.getSeconds();
    		$("#beginTime").val(nowDate+' '+time1);
    		//获取选择当前的时间
    		var returnOverTime = $("#xzTime").val()+" "+time1 ;
    		//添加到input框
    		$("#returnOverTime").val(returnOverTime);
    		returnOverTime=returnOverTime.replace(new RegExp(/-/gm) ,"/");
    		//转时间戳
    		var timestamp2 = Date.parse(new Date(returnOverTime));
    		//时间差转天数
    		var time = timestamp2 - timestamp;
    		
    		if(time <= 0){
    			alert("归还时间应大于起租时间，请重新选择");
    			/* $("#returnOverTime").val(""); */
    			$("#xzTime").val("");
    			return;
    		}
    	//	var day =Math.floor(time/86400000);
    		//alert(time)


    	
    })
</script>
</html>