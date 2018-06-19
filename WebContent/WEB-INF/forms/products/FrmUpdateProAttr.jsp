<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="${cdn}/css/style.css"/>
<!-- <link rel="stylesheet" type="text/css" -->
<%-- 	href="${cdn}/admin/bianjiqi/styles/font-awesome.css" /> --%>
<!-- <link rel="stylesheet" type="text/css" -->
<%-- 	href="${cdn}/admin/bianjiqi/styles/simditor.css" /> --%>
<!-- <link rel="stylesheet" type="text/css" -->
<%-- 	href="${cdn}/admin/css/newAdd.css" /> --%>
<script type="text/javascript"
	src="${cdn}/admin/bianjiqi/scripts/js/jquery.min.js"></script>
<script type="text/javascript"
	src="${cdn}/admin/bianjiqi/scripts/js/module.js"></script>
<script type="text/javascript"
	src="${cdn}/admin/bianjiqi/scripts/js/uploader.js"></script>
<script type="text/javascript"
	src="${cdn }/admin/plugin/ckeditor/ckeditor.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>

<title>变更物品属性</title>
<style type="text/css">
	*{
	font-size:16px;
	}
	.spe{
		margin-right:30px;
	}
	/*清除浮动代码*/ 
	.clearfloat:after{
		display:block;
		clear:both;
		content:"";
		visibility:hidden;
		height:0;
	} 
	.clearfloat{
		zoom:1
	} 
	.z_addImg{
		width:100px;
		height:100px;
		float:left;
		margin:10px 20px 10px 0;
	}
	.z_addImg img{
		width:100%;
		height:100%;
	}
	.addImg-box{
		width:100%;
	}
	.img-block .remBut{
		width:15px;
		height:15px;
	}
	.img-block .upFileInputBox{
		width:100px !important;
		height: 130px; !important;
		background-size:193%;
	}
	.img-block .upFileInputBox img{
		margin-right:5px;
		width:100px;
		height:130px !important;
	}
	.IDcard-upload{
		width:70%;
		float:left;
	}
	.file{
	width:100px !important;
	height: 150px !important;
	}
	.self-fileBox{
		width:120px !important;
		height:150px  !important;
	}
</style>
</head>
<body>
<!-- <div style="display: -webkit-box;" id="load-box" class="loadingbox loadbox loadingbox1"><p class="cl-666 f14"><span class="icon"></span>请稍等。。。</p></div> -->
<!-- <div class="ajaxMars" ><p class="cl-666 f14"><span class="icon"></span>正在上传中。。。</p></div> -->
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">变更物品属性</span>
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
	<form action="FrmAdminRentPro.updateProAttr" method="post" id="proAttr" class="formb" onsubmit="return check()">
				<input type="hidden" name="proId_" value="${proId_}">
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">当前物品名称：</label><span>${proName_}</span>
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">分类情况：</label><span class="spe">一级：${fristName_}</span><span>二级：${twoName_}</span>
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">已关联情况：</label><span class="spe">售卖：${proSaleCount_}个</span><span>租赁：${proRentCount_}个</span>
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">物品价值（按零售价定）：</label><input name="price_" value="${value.items.price_}">元
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">物品定义押金：</label><input name="cashPledge_" value="${value.items.cashPledge_}">元
				</div>
				<%-- <div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">自动折旧年限定义：</label><input name="scrapTime_" value="${value.items.scrapTime_}">年
				</div> --%>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">物品原租赁价：</label><input name="dayRentMoney_" value="${value.items.dayRentMoney_}">/天
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">物品折扣后租赁价：</label>
					<c:if test="${value.items.isDiscount_ ==0}">
					<input name="discountPrice_" value="${value.items.discountPrice_}">/天		
					<input type="radio" name="isDiscount_" value="0" onclick="jin(this)" style="width:15px;" checked><span  class="spe">无折扣</span>
					<input type="radio" name="isDiscount_" value="1" onclick="op(this)" style="width:15px;">有折扣
					</c:if>
					<c:if test="${value.items.isDiscount_ ==1}">
					<input name="discountPrice_" value="${value.items.discountPrice_}">/天		
					<input type="radio" name="isDiscount_" value="0" onclick="jin(this)" style="width:15px;" ><span  class="spe">无折扣</span>
					<input type="radio" name="isDiscount_" value="1" onclick="op(this)" style="width:15px;" checked>有折扣
					</c:if>
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">消费赠送积分：</label><input name="jifen_" value="${value.items.jifen_}">
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">物品规格：</label>
				<c:if test="${value.items.proSize_ ==0}">
				大<input type="radio" name="proSize_" value="0" style="width:15px;"  class="spe" checked/>  
				中<input type="radio" name="proSize_" value="1" style="width:15px;"  class="spe"/>  
				小<input type="radio" name="proSize_" value="2" style="width:15px;"  class="spe"/> 
				</c:if>
				<c:if test="${value.items.proSize_ ==1}">
				大<input type="radio" name="proSize_" value="0" style="width:15px;"  class="spe" />  
				中<input type="radio" name="proSize_" value="1" style="width:15px;"  class="spe" checked/>  
				小<input type="radio" name="proSize_" value="2" style="width:15px;"  class="spe"/> 
				</c:if>
				<c:if test="${value.items.proSize_ ==2}">
				大<input type="radio" name="proSize_" value="0" style="width:15px;"  class="spe" />  
				中<input type="radio" name="proSize_" value="1" style="width:15px;"  class="spe"/>  
				小<input type="radio" name="proSize_" value="2" style="width:15px;"  class="spe" checked/> 
				</c:if>
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">物品净重：</label><input name="proWeight_" value="${value.items.proWeight_}">KG
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">物品同城快递邮费：</label><input name="posTage_" value="${value.items.posTage_}">元
				</div>
				<div class="group-box clearfloat" name="null" id="component1" visible="false" >
					<label style="width:200px;float:left">问题描述：</label>
					<div style="width:77%;background-color:lightgreen;float:right">
					<textarea id="editor" placeholder="这里输入内容" name="proDesc_" autofocus>${value.items.proDesc_}
					</textarea>
					</div>					
				</div>
				<div class="group-box clearfloat" name="null" id="component1" visible="false" >
				<label style="width:200px;float:left">展示图片：</label>
				<div class="img-block IDcard-upload " style="height: auto;padding-top:0;">
				<input type="hidden" name="proId_" value="${proId_}">
					
		    		<div id="cunID">
		    		</div>
		    		<div style="height: auto;background-color: white;">
					<c:if test="${!empty detailImg }">
			            <c:forEach items="${detailImg }" var="image">
			                <div class="self-fileBox" >
			                    <div class="upFileInputBox bg  imgs" id="upFile">
			                        <img class="img"  src="${image.items.imgPath_}" style="display:block"/>
			                        <input class="file" type="file" onchange="getImgURL(this)"  name="img" id="fileInputUrl" style="display:none">
			                         <input type="hidden"  name="UID" value="${image.items.UID_}">
			                        <input type="hidden"  name="img" id="image" value="${image.items.imgPath_}">
			                        <span class="remBut"></span>
			                    </div>
			                </div>
			                
						</c:forEach>
					</c:if>
					<c:if test="${empty detailImg }">
		                <div class="self-fileBox" >
		                    <div class="upFileInputBox bg imgs" id="upFile">
		                        <img class="img" src(unknown) style="display: none;"/>
		                        <input class="file" type="file" onchange="getImgURL(this)"  name="img" id="fileInputUrl1">
		                        <span class="remBut" style="cursor:pointer;display:none"></span>
		                    </div>
		                </div>
					</c:if>
					</div>
			 		 
			      </div>
			      </div>
			      <div class="ck-box">
			      	<input type="submit" value="完成"> 
			      </div>
			 </form>	
			</div>
<!-- <div style="display: -webkit-box;" id="load-box" class="loadingbox loadbox loadingbox2"> -->
<!-- <p class="cl-666 f14"><span class="icon"></span>正在上传，请稍后</p></div> -->
</body>
<script>
	function check(){
		var price_=$("input[name='price_']").val();//售价
		var cashPledge_=$("input[name='cashPledge_']").val();//押金
		var scrapTime_=$("scrapTime_[name='scrapTime_']").val();//自动折旧年限
		var dayRentMoney_=$("input[name='dayRentMoney_']").val();//日租金
		var discountPrice_=$("input[name='discountPrice_']").val();//折扣后日租金
		var jifen_=$("input[name='jifen_']").val();//晓飞赠送积分
		var proWeight_=$("input[name='proWeight_']").val();//物品重量
		var posTage_=$("input[name='posTage_']").val();//同城快递邮费
		var patt3 = /^[\u4e00-\u9fa5]$/; /*只能输入汉字*/
		if(price_==""||patt3.test(price_)){
			alert("售价不能为空且不能是包含汉字！");
			return false;
		}
		if(cashPledge_==""||patt3.test(cashPledge_)){
			alert("押金不能为空且不能是包含汉字！");
			return false;
		}
		if(scrapTime_==""||patt3.test(scrapTime_)){
			alert("折旧年限不能为空且不能是包含汉字！");
			return false;
		}
		if(dayRentMoney_==""||patt3.test(dayRentMoney_)){
			alert("日租金不能为空且不能是包含汉字！");
			return false;
		}
		if(discountPrice_==""||patt3.test(discountPrice_)){
			alert("折扣后日租金不能为空且不能是包含汉字！");
			return false;
		}
		if(jifen_==""||patt3.test(jifen_)){
			alert("积分不能为空且不能是包含汉字！");
			return false;
		}
		if(proWeight_==""||patt3.test(proWeight_)){
			alert("物品重量不能为空且不能是包含汉字！");
			return false;
		}
		if(posTage_==""||patt3.test(posTage_)){
			alert("同城邮费不能为空且不能是包含汉字！");
			return false;
		}
		return true;
	}
</script>
<script type="text/javascript">
function jin(node){
	var discountPrice_=$(node).parent().find("input[name='discountPrice_']").val();
	if(discountPrice_!=""||discountPrice_!=null){
		$(node).parent().find("input[name='discountPrice_']").val("");
	}
	$(node).parent().find("input[name='discountPrice_']").attr("readonly","readonly");
}
function op(node){
	$(node).parent().parent().find("input[name='discountPrice_']").removeAttr("readonly");
	
}


	var msg = '${msg}';
	if(msg!=''){
	   alert(msg); 
	}
</script>
<script type="text/javascript">
var imgurl = "";  
var count=20;
function getImgURL(node) {
    var imgURL = "";      
    try{     
        var file = null;  
        if(node.files && node.files[0] ){  
            file = node.files[0];   
            var addBox = document.getElementById("upFile");
            var formFile = new FormData();
            formFile.append("action", "UploadVMKImagePath");
            formFile.append("file", file); //加入文件对象
            var data = formFile;
			var nameValue=$(node).attr("name");
        	count=count+1;
        	  var imglength=$(node).parent().parent().parent().find("img").length;
        	  var a2=$(node).parent().find("img").length;
        	  if(imglength>12){
        		  modal("最多可添加10长图片！");
        	  }
        	  if(imglength<10&&a2!=0){
        		  $(node).parent().parent().after("<div class='self-fileBox' style='margin-right: 0.12rem'>"+
                		   "<div class='upFileInputBox bg' id='upFile'>"+
                		   "<img class='img' src='' style='display:none;'>"+
                		   "<input class='file' type='file' onchange='getImgURL(this)' name='"+nameValue+"' id='"+"fileInputUrl"+count+"'>"+
                			"<span class='remBut' style='display:none;cursor:pointer;'></span>"+
                		   "</div></div>");
        	  }
          $(".loadingbox2").show();
          $(".loadingbox2").on('touchmove',function(e){
              e.preventDefault();  //阻止默认行为
          })
          AjaxObj(data,node,nameValue);
            
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
function creatImg(imgRUL,wrap){   //根据指定URL创建一个Img对象  
      // $("#formfileUrl span").html(imgRUL); 
     $("#"+wrap).siblings('.img').attr('src',imgRUL);
     $("#"+wrap).siblings('.img').show();
     $("#"+wrap).siblings('.remBut').show();
     $("#"+wrap).hide();
     // modal(0);
};  
//原来删除图片的方法；
$('body').on('click touch','.remBut',function(){
	$(this).siblings('.img').attr('src','');
	$(this).siblings('.img').hide();
	var UID_=$(this).siblings("input[name='UID']").val();
	var Iv=$(this).parent().find("video").length;
		 $.ajax({
	        url : "FrmAdminPro.delImg",
	        data: {"UID_":UID_},
	        type: "Post",
	        async:false,
	        dataType: "json",
	        success: function (data) {
	        	alert("删除成功！");
	        },
			 error:function(){
				 alert("网络异常，请稍后再试！");
			 }
	      })
	var imgLength=$(this).parent().parent().parent().find("img").length;
	var a2=$(this).parent().find("img").length;
	if(imgLength>1 && a2!=0){
		$(this).parent().parent().remove();
	}else if(imgLength<=1 && a2!=0){
		 $(this).parent().find("input[type='hidden']").remove();
         $('.self-fileBox').find('.file').show();
         $(this).parent().find('.remBut').hide();
	}
})
function AjaxObj(data,node,nameValue){
        $.ajax({
              url : "FrmAdminPro.insertPictureByArtificer",
              data: data,
              type: "Post",
              dataType: "json",
              cache: false,//上传文件无需缓存
              async:true,
              processData: false,//用于对data参数进行序列化处理 这里必须false
              contentType: false, //必须
              success: function (datas) {
                $(".loadingbox2").hide();
            //    $(".loadingMars").hide();
                
              $(node).parent().append("<input type='hidden' value='"+datas+"' name='"+nameValue+"'></input>");
              },
       		 error:function(){
       			 modal("网络异常，请重新上传！");
       		 }
            })
  }
</script>
<script type="text/javascript">
	CKEDITOR.replace('editor');
</script>
</html>