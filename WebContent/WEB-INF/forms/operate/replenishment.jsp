 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../jspf/head1.jspf"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>立即运维</title>

</head>
<body>
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">立即补货</div>
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
    <form action="FrmProDetails.addOperate"  enctype="multipart/form-data" method="post" id="form1" class="list" style="padding-left: 0">
        <ul class="message_list pl_10">
            <li class="flexLayout">
                <div class="list_left">
                    <span class="font13 text-666">本次运维定义折损率：</span>
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
        </ul>
        <div class="maintenance_description"><span class="font13 text-666">补货留言：</span></div>
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
        <div class="flexLayout rightAway_maintainOperation">
            <input type="button" value="重新开锁" class="border_r border_t">
            <input type="button" value="刷新状态" class="border_t">
            <input type="submit" value="确认提交">
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
	</div>
	<span>----------------------------------------------------</span><br/> --%>
	<%-- <div>
		<form action="FrmProDetails.addOperate"  enctype="multipart/form-data" method="post" id="form1">
			<span>本次运维定义折损率：<input type="text" name="nowLoss_" value="">%</span><br>
			<span>本次订单开锁次数：${ord.items.openCount_}次</span><br>
			<span>物品上次订单归还时间：
				<fmt:formatDate value="${ord.items.returnOverTime_}" pattern="yyyy-MM-dd HH:mm:ss"/>
			</span><br>
			<span>物品本次补货开箱时间：</span><br>
			<span>物品本次补货关箱时间：</span>
			<br>
			
			<span>----------------------------------------------------</span><br/>
			<span>补货留言：</span><br>
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
	</div>	 --%>
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
	// $("#"+wrap).val(imgRUL); 
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
</script>
</html>