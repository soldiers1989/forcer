<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${cdn }/css/order.css">
<link rel="stylesheet" href="${cdn }/css/homePage.css">
<%-- <link rel="stylesheet" href="${cdn }/css/common.css"> --%>
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<style>
.box{
	
}
.img-block .self-fileBox {
    display: inline-block;
    width: 250px;
    height:150px;
    margin-top: 10px;
}
.img-block .upFileInputBox {
    width: 250px;
    height:150px;
}
.img-block .upFileInputBox img {
    position: absolute;
    top: 0;
    left: 0;
    width: 250px;
    height:150px;
}
  .img-block .upFileInputBox .file{
  		height: 100%;
    	width: 100%;
  }  
  .img-block .upFileInputBox .remBut{
  		width:20px;
  		height:20px;
  }
</style>
<title>添加首页广告轮播图</title>
</head>
<body style="background-color: white;">
<div class="mid-box fl" id="mid-box">
    <div class="top pl_20 pr_20">
        <span class="min-col f16">添加首页广告轮播图</span>
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
		<div class="group-box" >
			<div style="width:150px;">首页轮播图（0-5张）</div>
		
		<form action="#" method="post" id="consultForm" class="formb" enctype="multipart/form-data">
   		<input type="hidden" name="orderId_" value="${orderId_}">
		<div class="img-block IDcard-upload">
	        <!-- <p class="addImg">首页轮播图（0-5张）</p> -->
			<div class="self-fileBox" style="margin-right: 20px">
				<div class="upFileInputBox bg" id="upFile">
					<img class="img"  src(unknown)/>
					<input class="file" type="file" onchange="getImgURL(this)"  name="Img_" id="fileInputUrl">
					<input type="hidden" name="Img_" value="" class="urlImg" id="upload1"> 
					<span class="remBut"></span>
				</div>
			</div>
		</div>
	<div style="margin:auto">
   	  	<a onclick="submit()" class="btn_style" style="margin:20px 70px;width:100px;height:30px;line-height:30px;text-align:center"" >提交</a>
   	</div>
   	</form>
		</div>



   	<%-- <!-- <p>您去现场签样的图片证据（0-5张）：</p> -->
   	<form action="#" method="post" id="consultForm" class="formb" enctype="multipart/form-data">
   		<input type="hidden" name="orderId_" value="${orderId_}">
		<div class="img-block IDcard-upload">
	        <p class="addImg">首页轮播图（0-5张）</p>
			<div class="self-fileBox" style="margin-right: 0.1rem">
				<div class="upFileInputBox bg" id="upFile">
					<img class="img"  src(unknown)/>
					<input class="file" type="file" onchange="getImgURL(this)"  name="Img_" id="fileInputUrl">
					<input type="hidden" name="Img_" value="" class="urlImg" id="upload1"> 
					<span class="remBut"></span>
				</div>
			</div>
		</div>
	<div>
   	  	<a onclick="submit()">提交</a>
   	</div>
   	</form> --%>
   	
<!-- 	<div style="display: -webkit-box;" id="load-box" class="loadingbox loadbox loadingbox1"> -->
<!-- 	<p class="cl-666 f14"><span class="icon"></span>提交中。。。</p></div> -->
<script>
function submit(){
	  var formData = new FormData($("#consultForm")[0]);
	$.ajax({
	    url: "FrmAdminHomeAdManage.insertHomeAd",
	    type: "POST",
	    data: formData,
	    dataType: "json",
	    async: true,
	    cache: false,
	    contentType: false,
	    processData: false,
	    success: function(data) {
	        if (data) {
	            alert("添加成功");
	            window.location.href="FrmAdminHomeAdManage";
	        } else {
	        	alert("添加失败");
	        }
	    },
	    error: function(data) {
	    	alert("网络异常，请稍后重试");
	    }
	});

}	
 
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
      	  if(imglength<=4){
      		  $(node).parent().parent().after("<div class='self-fileBox' style='margin-right: 20px'>"+
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
</body>
   	
   	
</html>