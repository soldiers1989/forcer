<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>中控屏视频修改</title>
<style>
	.uploadVedio{
		border:none !important;
		width:150px !important;
		height:40px !important;
		position:absolute;
		top:0;
		left:0;
		opacity: 0;
	
	}
	.click{
		width:150px;
		height:40px;
		line-height:40px;
		text-align:center;
		background-color: #48b2bd;
		color:#fff !important;
		vertical-align: middle;
   		border-radius: 3px;
	}
	.mr_40{
		margin-right:40%;
	}
	.po_re{
		position:relative;
	}
	.submit_c{
		display:block;
	}
	#vedio_edit{
		width:700px;
		margin-top:20px;
	}
</style>
</head>
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">中控屏视频修改</span>
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
		
	<form action="#" id="consultForm" class="formb" enctype="multipart/form-data">
		<div class="group-box po_re flexLayout" name="null" id="component1" visible="false">
			<div class="click mr_40">点击修改文件</div>
	    	<input type="file" name="vedio" onchange="getVideo(this)" class="uploadVedio">
	    	<input type="hidden" name="UID_" value="${video.items.UID_}" >
	    	<a onclick="submit()" class="submit_c click">提交</a>
	    </div>
	    <%-- <input type="text" name="imgId_" value="${video.items.vedioId_}"> --%>
	</form>
	<div class="group-box" name="null" id="component1" visible="false">
		 <video alt="" src="${video.items.vedioId_ }" controls id="vedio_edit">该浏览器不支持</video>
	</div>
	</div>
</div>

 <%-- <video alt="" src="${video.items.vedioId_ }" controls></video>
<hr color="blue" width="%60%" style="...."/>
<form action="FrmAdminHomeAdManage.updateHomeAd?UID_=4" method="post" >
 <input type="text" name="imgId_" value="${video.items.imgId_}">
    <input type="hidden" name="UID_" value="${video.items.UID_}">
    <input type="submit" value="修改" >
</form>

<form action="FrmAdminHomeAdManage.updateHomeAd?UID_=4" method="post" enctype="multipart/form-data">
<input type="file" name="video">
 <input type="text" name="imgId_" value="${video.items.imgId_}">
<input type="submit" value="修改">
</form>

<form action="#" id="consultForm" class="formb" enctype="multipart/form-data">
    <input type="file" name="vedio" onchange="getVideoURL(this)">
    <input type="text" name="imgId_" value="${video.items.vedioId_}">
    <input type="hidden" name="UID_" value="${video.items.UID_}">
    <a onclick="submit()">提交</a>
</form> --%>
<script>
function submit(){
	 var formData = new FormData($("#consultForm")[0]);
	 var UID_=${video.items.UID_};
  $.ajax({
      url: "FrmAdminHomeAdManage.updateHomeAd?UID_="+UID_,
      type: "POST",
      data: formData,
      dataType: "json",
      async: true,
      cache: false,
      contentType: false,
      processData: false,
      success: function(data) {
          if (data) {
              alert("修改成功");
              window.location.href="FrmAdminHomeAdManage";
          } else {
              alert("修改失败");
          }
      },
      error: function(data) {
          alert("网络异常，请稍后重试");
      }
  });
}   
function getVideo(node){
	
	document.getElementById("vedio_edit").src =  window.URL.createObjectURL(node.files[0]);
}
/* var videourl = "";  
var count=20;
function getVideoURL(node) {
  var videoURL = "";      
  try{     
      var file = null;  
      if(node.files && node.files[0] ){  
          file = node.files[0];   
          var nameValue=$(node).attr("name");
        count=count+1;
        var videolength=$(node).parent().parent().parent().find("video").length;
        if(videolength>5){
            modal("最多可添加5长图片！");
        }
        if(videolength<=4){
            $(node).parent().parent().after("<div class='self-fileBox' style='margin-right: 0.12rem'>"+
                     "<div class='upFileInputBox bg' id='upFile'>"+
                     "<video class='video' src='' style='display:none;'>"+
                     "<input class='file' type='file' onchange='getvideoURL(this)' name='"+nameValue+"' id='"+"fileInputUrl"+count+"'>"+
                      "<span class='remBut' style='display: none;'></span>"+
                     "</div></div>");
        }
         
          
      }else if(node.files && node.files.item(0)) {                                  
          file = node.files.item(0);     
      }     
      //Firefox 因安全性问题已无法直接通过input[file].value 获取完整的文件路径  
      try{  
          //Firefox7.0   
          videoURL =  file.getAsDataURL();   
          //modal("//Firefox7.0"+videoRUL);                           
      }catch(e){  
          //Firefox8.0以上                                
          videoRUL = window.URL.createObjectURL(file);              //modal("//Firefox8.0以上"+videoRUL);  
      }        
   }catch(e){    
      //支持html5的浏览器,比如高版本的firefox、chrome、ie10  
      if (node.files && node.files[0]) {                            
          var reader = new FileReader();   
          reader.onload = function (e) {                                        
              videoURL = e.target.result;   
          };  
          reader.readAsDataURL(node.files[0]);   
      }    
   }  
       videourl = videoURL;
     //wrap=$(node).attr('id');
     //creatvideo(videoRUL,wrap);
      
  return videoURL;  
};  */  
</script>


</body>
</html>