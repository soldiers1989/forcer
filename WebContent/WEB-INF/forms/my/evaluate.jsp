 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
#div1{
        width: 50px;
        height: 28px;
        border-radius: 50px;
        position: relative;
    }
    #div2{
        width: 25px;
        height: 25px;
        border-radius: 48px;
        position: absolute;
        background: white;
        box-shadow: 0px 2px 4px rgba(0,0,0,0.4);
    }
    .open1{
        background: rgba(0,184,0,0.8);
    }
    .open2{
        top: 2px;
        right: 1px;
    }
    .close1{
        background: rgba(255,255,255,0.4);
        border:3px solid rgba(0,0,0,0.15);
        border-left: transparent;
    }
    .close2{
        left: 0px;
        top: 0px;
        border:2px solid rgba(0,0,0,0.1);
    }
</style>
<title>订单评价</title>

</head>
<body>
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">订单评价</div>
    <!--<div class="more"><img src="../../img/1.jpg" alt=""></div>-->
</div>
<div class="main_content" id="logistics_trace">
	<form action="FrmOrder_My.addEvaluate"  enctype="multipart/form-data" method="post" id="form1">
	
    <div id="mat"></div>
    <div class="hint_box">
        <div class="star_grade flexLayout border_b">
            <div>选择星级评分</div>
            <ul class="star_img">
                <li>
                    <img src="../../img/starA.png" alt="">
                    <img src="../../img/starB.png" alt="" class="listImg">
                </li>
                <li>
                    <img src="../../img/starA.png" alt="">
                    <img src="../../img/starB.png" alt="" class="listImg">
                </li>
                <li>
                    <img src="../../img/starA.png" alt="">
                    <img src="../../img/starB.png" alt="" class="listImg">
                </li>
                <li>
                    <img src="../../img/starA.png" alt="">
                    <img src="../../img/starB.png" alt="" class="listImg">
                </li>
                <li>
                    <img src="../../img/starA.png" alt="">
                    <img src="../../img/starB.png" alt="" class="listImg">
                </li>
            </ul>
            <div><span class="grade_num">0</span>分</div>
        </div>
    </div>
    <textarea name="evaContent_" id="evaContent_" class="textarea border_0 font15"  placeholder="请输入您的使用感受，让更多的人了解" id="evaContent_" name="evaContent_"></textarea>
    <!-- <div class="add_box clearfix"><span class="add_photo fl">上传图片</span></div> -->
    <!-- <div class="group-box">
        <div class="fileBox">
            <div class="upFileBox">
                <img style="width: 50px;height: 50px;display:none;"  class="img"> 
                <input type="file" onchange="getImgURL(this)" id="imgUrlFile" class="fileInput" accept="pdf/gif/png" name="upload1"> 
                <input type="hidden" name="" value="" class="urlImg" id="upload1"> 
            </div>
        </div>
    </div> -->
    <div class="img-block IDcard-upload" style="height: auto;margin-top: -.1rem;padding: .17rem;">
		<div class="self-fileBox" style="margin-right: 0.1rem">
			<div class="upFileInputBox bg" id="upFile">
				<img class="img"  src(unknown)/>
				<input class="file" type="file" onchange="getImgURL(this)"  name="sampleImg_" id="fileInputUrl">
				<input type="hidden" name="" value="" class="urlImg" id="upload1"> 
				<span class="remBut"></span>
			</div>
		</div>
	</div>
    <div class="anonymity flexLayout border_t">
        <div class="anonymity_img list_left">
            <img src="../../img/successA.png" alt="">
            <img src="../../img/successB.png" alt="" class="listImg">
            <span>匿名</span>
        </div>
        <div class="anonymity_hint list_right">您的评价会以匿名的形式展现</div>
    </div>
    <button class="list_btn" >提交</button>
    <input type="hidden" id="evaLevel_" name="evaLevel_" value="0"/>
    <input type="hidden" id="orderId_" name="orderId_" value="${orderId_}"/>
    <input type="hidden" id="evaState_" name="evaState_" value="0"/>
    <input type="hidden" id="evaState_" name="evaState_" />
    <input type="hidden" id="userId_" name="userId_" value="${userId_}"/>
    <input type="hidden" id="orderId_" name="orderId_" value="${orderId_}"/>
    <input type="hidden" id="orderType_" name="orderType_" value="${orderType_}"/>
    </form>
</div>


    <%-- <div>
        <form action="FrmOrder_My.addEvaluate"  enctype="multipart/form-data" method="post" id="form1">
            <div>评价：
                <input type="radio" value="1"  id="evaLevel1" name="evaLevel_" >极差
                <input type="radio" value="2"  id="evaLevel2" name="evaLevel_" >差
                <input type="radio" value="3"  id="evaLevel3" name="evaLevel_" >中等
                <input type="radio" value="4"  id="evaLevel4" name="evaLevel_" >好
                <input type="radio" value="5"  id="evaLevel5" name="evaLevel_" >极好
            </div>
            <textarea placeholder="请输入您的使用感受，分享给想用的其他人吧" id="evaContent_" name="evaContent_"  ></textarea>
            <div class="group-box">
                <label class="fl">上传图片：</label>
                <div class="fileBox">
                    <div class="upFileBox">
                        <img style="width: 50px;height: 50px;display:none;"  class="img"> <input type="file"
                            onchange="getImgURL(this)" id="imgUrlFile" class="fileInput"
                            accept="pdf/gif/png" name="upload1"> 
                            <input type="hidden" name="" value="" class="urlImg" id="upload1"> 
<!--                             <span class="removeBut"  style="display: none;">X</span> -->
                    </div>
                </div>
            </div>
            匿名：
            <div id="div1" class="open1">
                      <div id="div2" class="open2"></div>
              </div>
               <input type="hidden" id="evaState_" name="evaState_" />
               <input type="hidden" id="userId_" name="userId_" value="${userId_}"/>
               <input type="hidden" id="orderId_" name="orderId_" value="${orderId_}"/>
               <input type="hidden" id="orderType_" name="orderType_" value="${orderType_}"/>
               <input type="submit" value="提交" />
        </form>
    </div> --%>
    
    <script>
    $("body").on("click",".star_img li",function(){
        var num=$(this).index();
        num=parseInt(num+1);
        $(this).addClass("imgActive").prevAll().addClass("imgActive");
        $(this).nextAll().removeClass("imgActive");
        $(this).parent().next().find($(".grade_num")).html(num)
        $("#evaLevel_").val(num);
    });
    $("body").on("click",".anonymity .anonymity_img",function(){
        if($(this).hasClass("imgActive")){
        	$("#evaState_").val("1");
            $(this).removeClass("imgActive");
        }else{
        	  $("#evaState_").val("0");
            $(this).addClass("imgActive");
            
        }
    })
</script>
</body>
<script type="text/javascript">
/* $(function(){
     if(div1.className == "open1"){
         $("#evaState_").val("0");
        }
     if(div1.className == "close1"){
         $("#evaState_").val("1");
        }
})
window.onload=function(){
    var div2=document.getElementById("div2");
    var div1=document.getElementById("div1");
    div2.onclick=function(){
      div1.className=(div1.className=="close1")?"open1":"close1";
      div2.className=(div2.className=="close2")?"open2":"close2";
     if(div1.className == "open1"){
         $("#evaState_").val("0");
        }
     if(div1.className == "close1"){
         $("#evaState_").val("1");
        }
    }
} */


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
$('.upFileBox').on('click', '.removeBut', function() {
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
      	  if(imglength > 3){
      		  modal("最多可添加3张图片！");
      		 
      	  }
      	  if(imglength<=2){
      		  $(node).parent().parent().after("<div class='self-fileBox' style='margin-right: 0.12rem'>"+
               		   "<div class='upFileInputBox bg' id='upFile'>"+
               		   "<img class='img' src='' style='display:none;'>"+
               		   "<input class='file' type='file' onchange='getImgURL(this)' name='"+nameValue+"' id='"+"fileInputUrl"+count+"'>"+
               			"<span class='remBut' style='display: none;'></span>"+
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
//原来删除图片的方法；
$('body').on('click','.remBut',function(){
	$(this).siblings('.img').attr('src','');
	$(this).siblings('.img').hide();
	$(this).parent().parent().remove();
	var fileBox = $(".self-fileBox").html();
	if(fileBox == null ){
		
	}
	
})
function creatImg(imgRUL,wrap){   //根据指定URL创建一个Img对象  
	  // $("#formfileUrl span").html(imgRUL); 
	 $("#"+wrap).siblings('.img').attr('src',imgRUL);
	 $("#"+wrap).siblings('.img').show();
	 $("#"+wrap).siblings('.remBut').show();
	 $("#"+wrap).hide();
	 // modal(0);
};  
</script>
</html>