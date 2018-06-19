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

<title>添加物品属性</title>
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
</style>
</head>
<body>
<!-- <div style="display: -webkit-box;" id="load-box" class="loadingbox loadbox loadingbox1"><p class="cl-666 f14"><span class="icon"></span>请稍等。。。</p></div> -->
<!-- <div class="ajaxMars" ><p class="cl-666 f14"><span class="icon"></span>正在上传中。。。</p></div> -->
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">添加物品属性</span>
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
	<form action="FrmAdminRentPro.insertProAttr" method="post" id="proAttr" class="formb" onsubmit="return check()">
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
				<input type="hidden" name="discount_" value="${discountPrice_ }">
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">物品价值（按零售价定）：</label><input name="price_" >元
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">物品定义押金：</label><input name="cashPledge_">元
				</div>
				<!-- <div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">自动折旧年限定义：</label><input name="scrapTime_" >年
				</div> -->
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">物品原租赁价：</label><input name="dayRentMoney_">/天
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">物品折扣后租赁价：</label>
					<input name="discountPrice_">/天		
					<input type="radio" name="isDiscount_" value="0" onclick="jin(this)" style="width:15px;"><span  class="spe">无折扣</span>
					<input type="radio" name="isDiscount_" value="1" onclick="op(this)" style="width:15px;">有折扣
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">消费赠送积分：</label><input name="jifen_">
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">物品规格：</label>
				
				大<input type="radio" name="proSize_" value="0" style="width:15px;"  class="spe"/>  
				中<input type="radio" name="proSize_" value="1" style="width:15px;"  class="spe"/>  
				小<input type="radio" name="proSize_" value="2" style="width:15px;"  class="spe"/> 
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">物品净重：</label><input name="proWeight_">KG
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">物品同城快递邮费：</label><input name="posTage_">元
				</div>
				<div class="group-box clearfloat" name="null" id="component1" visible="false" >
					<label style="width:200px;float:left">问题描述：</label>
					<div style="width:77%;background-color:lightgreen;float:right">
					<textarea id="editor" placeholder="这里输入内容" name="proDesc_" autofocus>
					</textarea>
					</div>					
				</div>
				<div class="group-box clearfloat">
				<input type="hidden" name="proId_" value="${proId_}">
					<label style="width:200px;float:left">展示图片：</label>
		    		<div id="cunID">
		    		</div>
					<!-- <label class="fl">展示图片：</label> -->
					<div class="ck-box" style="width:77%;float:right">
						<div class="z_photo " style="width:100%;height:100%;">
				            <div class="z_file" style="width:100%;height:100%;">
				                <input class="file fileInput" type="file" name="file"  id="files"  accept="image/*" multiple="multiple"  onchange="imgChange('z_photo','z_file',this);" />
								<span class="remBut" style="width:15px;height:15px;display:none"></span>
				            </div>
				            <div id="addImg-box" style="float:left"></div>
				        </div>
			      </div> 
			      
			      
			      
			     <!--  <div class="img-block IDcard-upload fileBox" style="height:100px;float:left;width:127px;padding-top:0px;">
					      <div class="upFileBox upFileInputBox" style="height:100px;float:left;width:100px;background-size:100px 100px">
					        <img class="img"   src="" style="width: 100px;height: 100px;display:none;border:1px solid #f5f5f5"/>
					        <input class="file fileInput" type="file" onchange="getImgURL(this)"  name="proLbImges_" id="imgUrlFile" style="height:100px;width:100px;">
					        <input type="hidden" name="proLbImges_" value="" class="urlImg" id="upload1"> 
					        <span class="remBut" style="width:15px;height:15px;display:none"></span>
					      </div>
			 		 </div> -->
			 		 
			 		 
			 		 
			      </div>
			      <div class="ck-box">
			      	<input type="submit" value="完成"> 
			      </div>
			 </form>	
			</div>
</body>
<script>
	function check(){
		var discount_=$("input[name='discount_']").val();//进价
		var price_=$("input[name='price_']").val();//售价
		var cashPledge_=$("input[name='cashPledge_']").val();//押金
		var scrapTime_=$("scrapTime_[name='scrapTime_']").val();//自动折旧年限
		var dayRentMoney_=$("input[name='dayRentMoney_']").val();//日租金
		var discountPrice_=$("input[name='discountPrice_']").val();//进价
		var jifen_=$("input[name='jifen_']").val();//晓飞赠送积分
		var proWeight_=$("input[name='proWeight_']").val();//物品重量
		var posTage_=$("input[name='posTage_']").val();//同城快递邮费
		var patt3 = /^[\u4e00-\u9fa5]$/; /*只能输入汉字*/
		if(price_==""||patt3.test(price_)){
			alert("售价不能为空且不能是包含汉字！");
			return false;
		}else{
			if(price_<discount_){
				alert("售价不能低于进价！")
				return false;
			}
		}
		if(cashPledge_==""||patt3.test(cashPledge_)){
			alert("押金不能为空且不能是包含汉字！");
			return false;
		}
		if(scrapTime_==""||patt3.test(scrapTime_)){
			alert("折旧年限不能为空且不能是包含！");
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
	$(node).parent().find("input[name='discountPrice_']").attr("readonly","readonly");
	
}
function op(node){
	$(node).parent().find("input[name='discountPrice_']").removeAttr("readonly");
	
}

var imgs=[];
$(function(){
	$(".loadingbox1").hide();
})
	var imgurl = "";
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
		imgurl = imgURL;
		wrap = $(node).attr('id');
		console.log(imgRUL);
		creatImg(imgRUL, wrap,node);
		return imgurl;
	};

	function creatImg(imgRUL, wrap,node) { //根据指定URL创建一个Img对象  
		// $("#formfileUrl span").html(imgRUL); 
		$(node).siblings('.img').attr('src', imgRUL);
		/*  $("#"+wrap).val(imgRUL); */
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
	});
	
	(function(doc, win) {
	    var docEl = doc.documentElement,
	        resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
	        recalc = function() {
	            var clientWidth = docEl.clientWidth;
	            if (!clientWidth) return;
	            if (clientWidth >= 640) {
	                docEl.style.fontSize = '100px';
	            } else {
	                docEl.style.fontSize = 100 * (clientWidth / 640) + 'px';
	            }
	        };

	    if (!doc.addEventListener) return;
	   win.addEventListener(resizeEvt, recalc, false);
	    doc.addEventListener('DOMContentLoaded', recalc, false);
	})(document, window); 
	var num = 0;
	function imgChange(obj1, obj2,node) {
		
	    //获取点击的文本框
	    //var file = document.getElementById("files");
	    var file = $(node).get(0);
	    //存放图片的父级元素
	    var imgContainer = document.getElementsByClassName(obj1)[0];
	    //获取的图片文件
	    var fileList = file.files;
	    //文本框的父级元素
	    var z_file = document.getElementsByClassName(obj2)[0];
	    var addBox = document.getElementById("addImg-box");
	    var imgArr = [];
	    //遍历获取到得图片文件
	    if(fileList.length > 10){
	    	alert("不能超过10张图片")
	    }else{
	    	for (var i = 0; i < fileList.length; i++) {
	    		 var fileObj = $(node)[0].files[i];
		    	 if (typeof (fileObj) == "undefined" || fileObj.size <= 0) {
		        	 return;
		        }
		        var size = (fileObj.size) / 1024 / 1024;
		        if(size > 10){
		        	alert("您上传的图片超过10M， 请重新整理后再上传！");
		        	return;
		        }
		        var imgUrl = window.URL.createObjectURL(file.files[i]);
		        imgArr.push(imgUrl);
		        imgs.push(imgUrl);
		        var img = document.createElement("img");
		        img.setAttribute("src", imgArr[i]);
		        var input = document.createElement("input"); 
		        //input.setAttribute("value", imgArr[i]);
		       	input.setAttribute("type", "file"); 
		       	input.setAttribute("id", "files"); 
		       	input.setAttribute("accept", "image/*"); 
		       	input.setAttribute("multiple", "multiple"); 
		       	input.setAttribute("onchange", "imgChange('z_photo','z_file',this);"); 
		       	input.setAttribute("style",'z-index: '+(i+2)+';');
		       // input.setAttribute("style",'position: absolute; left: 0px; top: 0px; height: 100%; width: 100%; opacity: 0;' ); 
		         input.setAttribute("name", "img"+i);
		        var imgAdd = document.createElement("div");
		        var divI = document.getElementsByClassName("fileInput")[0];
		        imgAdd.setAttribute("class", "z_addImg");
		        imgAdd.appendChild(img);
		        z_file.appendChild(input) ;
		        addBox.appendChild(imgAdd);
		       	
		        var formFile = new FormData();
		        formFile.append("action", "UploadVMKImagePath");
		        formFile.append("file", fileObj); //加入文件对象
		        var data = formFile;
		        var obj = new AjaxObj();
		        $(".ajaxMars").show();
		        obj.ajax(data,imgAdd);
		    };
	    }
	    imgRemove();
	    $(".loadingbox1").hide();
	};
	//获取上传图片的路径，添加input绑定到div里
	function AjaxObj(){
		this.ajax = function(data,imgAdd){
			  $.ajax({
		        	url : 'FrmAdminRentPro.ajaxText',
		        	data: data,
		        	type: "Post",
		        	dataType: "json",
		        	cache: false,//上传文件无需缓存
		        	processData: false,//用于对data参数进行序列化处理 这里必须false
		        	contentType: false, //必须
		        	success: function (data) {
		        		setInterval(function(){ $(".ajaxMars").hide();},20000);
		        		var input = document.createElement("input");
		        		input.setAttribute("type", "hidden"); 
		        		input.setAttribute("value", data);
		        		input.setAttribute("name", "image");
		        		imgAdd.appendChild(input);
		        	}
		        })
		}
	}
	function imgRemove() {
	    var imgList = document.getElementsByClassName("z_addImg");
	    var mask = document.getElementsByClassName("z_mask")[0];
	    var cancel = document.getElementsByClassName("z_cancel")[0];
	    var sure = document.getElementsByClassName("z_sure")[0];
	    for (var j = 0; j < imgList.length; j++) {
	        imgList[j].index = j;
	        imgList[j].onclick = function() {
	            var t = this;
	            mask.style.display = "block";
	            cancel.onclick = function() {
	                mask.style.display = "none";
	            };
	            sure.onclick = function() {
	                mask.style.display = "none";
	                t.style.display = "none";
	                //removeElement(mask);
	                num -= 1;
	                $(t).remove();
	            };

	        }
	    };
	};
	var msg = '${msg}';
	if(msg!=''){
	   alert(msg); 
	}
</script>
<script type="text/javascript">
	CKEDITOR.replace('editor');
</script>
</html>s