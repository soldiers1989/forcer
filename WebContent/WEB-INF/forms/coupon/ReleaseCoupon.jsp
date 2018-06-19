<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	 <%@include file="../ui/head1.jspf"%>
	<%@include file="../ui/head2.jspf" %> 
<link rel="stylesheet" type="text/css" href="${cdn}/css/style.css"/>
<script type="text/javascript"
	src="${cdn}/admin/bianjiqi/scripts/js/jquery.min.js"></script>
<script type="text/javascript"
	src="${cdn}/admin/bianjiqi/scripts/js/module.js"></script>
<script type="text/javascript"
	src="${cdn}/admin/bianjiqi/scripts/js/uploader.js"></script>
<script type="text/javascript"
	src="${cdn }/admin/plugin/ckeditor/ckeditor.js"></script>

 <div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">优惠券发放</span>
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
	<form action="FrmReleaseCoupon.insert" method="post" enctype="multipart/form-data" onsubmit="return tishi();">
		<input  type="hidden" name="insert" value="insert">
		
		<div class="group-box two" name="null" visible="false">
			<label style="width:200px">优惠券名称：</label>
			<input type="text" name="couponname_" id="couponname_" value=""/>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label style="width:200px">优惠券类型：</label>
			<select  name="type_" style="width:300px">
		         <option value="全平台"> 全平台</option>
		         <option value="租赁">租赁</option>
				 <option value="购买">购买</option>
				 <option value="新注册用户">新注册用户</option>
	    	 </select>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label style="width:200px">接收人群：</label>
			<select  name="receive_" style="width:300px">
		         <option value="所有用户"> 所有用户</option>
		         <option value="v1等级会员">v1等级会员</option>
				 <option value="v2等级会员">v2等级会员</option>
				 <option value="v3等级会员">v3等级会员</option>
	    	 </select>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label style="width:200px">发送总数：</label>
			<input type="text" name="total_">
		</div>
		<div class="group-box two" name="null" visible="false">
			<label style="width:200px">可领取时间段：</label>
			从<input type="date" name="grantdate_" style="border:1px solid #e6e6e6;border-radius:3px;line-height:30px;wigth:150px;margin:0 10px;"/>到<input type="date" name="grantdate1_" style="border:1px solid #e6e6e6;border-radius:3px;line-height:30px;wigth:150px;margin:0 10px;"/>
		</div>	
		<div class="group-box two" name="null" visible="false">
			<label style="width:200px">有效使用时间段：</label>
			从 <input type="date" name="enddate_" style="border:1px solid #e6e6e6;border-radius:3px;line-height:30px;wigth:150px;margin:0 10px;"/>到<input type="date" name="enddate1_" style="border:1px solid #e6e6e6;border-radius:3px;line-height:30px;wigth:150px;margin:0 10px;"/>
		</div>	
		<div class="group-box two" name="null" visible="false">
			<label style="width:200px">优惠券面额(元)：</label>
			<input type="text" name="Denomination_">
		</div>
		<div class="group-box two" name="null" visible="false">
			<label style="width:200px">使用范围：</label>
			<select type="text" name="range_">
	         	<option value="租赁商品"> 租赁商品</option>
	         	<option value="购买商品">购买商品</option>
	    	 </select>
		</div>	
		<div class="group-box two" name="null" visible="false">
			<label style="float:left;width:200px">优惠券图片：</label>
			<div class="img-block IDcard-upload" style="height:110px;">
				<div id="upFile " class="upFileInputBox img" style="width:100px;height:100px;background-size:100px 100px;">
					<img class="images" id="fileImg" style="width:100px;height:100px;display:none"/>
					<!-- <input class="file " type="file" onchange="getImgURL(this)"  name="imageURL_" id="fileInputUrl"> -->
					<input class="file fileInput" type="file" onchange="getImgURL(this)"  name="imageURL_" id="fileInputUrl" style="width:100px;height:100px;">
				    <div class="removeBut remBut"  style="width:15px;height:15px;position:relative;left:100px;top:0px;display:none;"><img src="${cdn }/img/remove-img.png" style="width:100%;height:100%;"></div>
				</div><!-- style="display: none;" -->
			</div>
		</div> 
		<%--  <label style="width:200px">商品小图标：</label>
					<img class="img" alt="" src="" style="width:50px;height:50px;"> 
					<input class="file" type="file" name="proZsImges_" id="fileInputUrl" onchange="getImgURL(this)" class="fileInput"> 
					<input type="hidden" name="proZsImges_" value="" class="urlImg" id="upload3"> 
					<span class="removeBut"  style="display: none;"><img src="${cdn }/img/remove-img.png" style="width:15px;height:15px;position:relative;left:5px;top:-35px"></span>
			</div> --%>
		<div class="group-box two clearfloat" name="null" visible="false">
			<label style="width:200px;float:left">使用说明：</label>
			<div style="width:77%;float:right">
			<textarea id="editor" placeholder="这里输入内容" name="couponcontent_" autofocus style="margin-top:10px;">
			</textarea> 
			</div>
		</div>
		<div  class="group-box two" name="null" id="component8" visible="false" >
			<label></label><input type="submit" value="保存" style="margin:20px 0 20px 0">
		</div>
		</form>
		</div>
		
	
	
		
	

 

<!-- <div >
	<div >
	   <h2>优惠券发放</h2>
	</div>
	<form action="FrmReleaseCoupon.insert" method="post" enctype="multipart/form-data" onsubmit="return tishi();">
		<input  type="hidden" name="insert" value="insert">
	<div class="group-box two" name="null" visible="false">
			<label>优惠券名称：</label>
			<input type="text" name="couponname_" id="couponname_" value=""/>
	</div>
		优惠券类型：<select  name="type_">
         <option value="全平台"> 全平台</option>
         <option value="租赁">租赁</option>
		 <option value="购买">购买</option>
		 <option value="新注册用户">新注册用户</option>
    	 </select>
     <div>
     
     </div>
		接收人群：<select  name="receive_">
         <option value="所有用户"> 所有用户</option>
         <option value="v1等级会员">v1等级会员</option>
		 <option value="v2等级会员">v2等级会员</option>
		 <option value="v3等级会员">v3等级会员</option>
    	 </select>
     <div>
     
     <div>发送总数：<input type="text" name="total_"></div>
     
     <div>可领取时间段：从 <input type="date" name="grantdate_" />到<input type="date" name="grantdate1_" /> </div>
      <div>有效使用时间段：从 <input type="date" name="enddate_" />到<input type="date" name="enddate1_" /></div>
     
     <div>优惠券面额(元)：<input type="text" name="Denomination_"></div>
     
     <div>
     	使用范围：<select type="text" name="range_">
         <option value="租赁商品"> 租赁商品</option>
         <option value="购买商品">购买商品</option>
    	 </select>
     </div>
     
	 </div>
	
	     <div name="null" visible="false">
					<label >优惠券图片：</label>
					<div >
						<div  id="upFile">
							<img   />
							<input  type="file" onchange="getImgURL(this)"  name="imageURL_" id="fileInputUrl">
							<span ></span>
						</div>
					</div>
		</div>
		
		<table >
		  <tr>
			<td style="vertical-align:top;"><label>使用说明：</label></td>
			<td>
				<textarea id="editor" placeholder="这里输入内容"
							name="couponcontent_" autofocus>
				</textarea> 
			</td>
		</tr>
		</table>
		
		<div  name="null" id="component8" visible="false">
				<input type="submit" value="保存">
		</div>	
	</form> 
</div>-->
<%@include  file="../ui/footer.jspf"%>
<script>
$(function(){
	var url=$(".self-fileBox .img").attr('src');
	if(url){
		$('.self-fileBox').find('.file').hide();
		$('.self-fileBox').find('.remBut').show();
	}else{
		$('.self-fileBox').find('.file').show();
		$('.self-fileBox').find('.remBut').hide();
	}
	$('.upFile').on('click','.remBut',function(){
		alert();
		$(this).siblings('.img').attr('src','');
		$(this).siblings('.img').hide();
		$(this).siblings('.file').show();
		$(this).hide();
	})
})


var imgurl = "";  
function getImgURL(node) {
    var imgURL = "";      
    try{     
        var file = null;  
        if(node.files && node.files[0] ){  
            file = node.files[0];              
        }else if(node.files && node.files.item(0)) {                                  
            file = node.files.item(0);          
        }     
        //Firefox 因安全性问题已无法直接通过input[file].value 获取完整的文件路径  
        try{  
            //Firefox7.0   
            imgURL =  file.getAsDataURL();   
            //alert("//Firefox7.0"+imgRUL);                           
        }catch(e){  
            //Firefox8.0以上                                
            imgRUL = window.URL.createObjectURL(file);              //alert("//Firefox8.0以上"+imgRUL);             
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
     var test = window.URL.createObjectURL(node.files[0]);   
         imgurl = imgURL;
         wrap=$(node).attr('id');
		 creatImg(imgRUL,wrap);
		
   		 return imgURL;  
};   
/* function creatImg(imgRUL,wrap){  
	 //根据指定URL创建一个Img对象  
	 // $("#formfileUrl span").html(imgRUL); 
	 $("#"+wrap).siblings('.img').attr('src',imgRUL);
	 $("#"+wrap).siblings('.img').show();
	 $("#"+wrap).siblings('.remBut').show();
	 $("#"+wrap).hide();
	 // alert(0);
}; */ 

/* function creatImg(imgRUL, wrap) { //根据指定URL创建一个Img对象  
	alert(0)
	// $("#formfileUrl span").html(imgRUL); 
	$("#" + wrap).siblings('.images').attr('src', imgRUL);
	/*  $("#"+wrap).val(imgRUL); 
	$("#" + wrap).siblings('.images').val(imgRUL);
	$("#" + wrap).siblings('.images').show();
	$("#" + wrap).siblings('.removeBut').show();
	$("#" + wrap).hide();

	// alert(0);
}; */
function creatImg(imgRUL, wrap) { //根据指定URL创建一个Img对象  
	// $("#formfileUrl span").html(imgRUL); 
//console.log(imgRUL)

	$("#" + wrap).siblings('.images').attr('src', imgRUL);
	$("#" + wrap).siblings('.images').show();
	$("#" + wrap).siblings('.remBut').show();
	$("#" + wrap).hide();
	// alert(0);
};

$('body').on('click', '.removeBut', function() {
	$(this).siblings('.images').attr('src', '');
	$(this).siblings('.images').hide();
	$(this).siblings('.file').show();
	/* $(this).parent().remove();  */
	$(this).siblings("input[type='hidden']").remove();
	$(this).hide();
});

</script>
</body>
<script type="text/javascript">
	CKEDITOR.replace('editor');
</script>
<script type="text/javascript">
function tishi(){
	var couponname_ = $("#couponname_").val();
	var editor = $("#editor").val();
	if(couponname_==""){
		alert("标题不能为空！");
		return false;
	}
	if(editor==""){
		alert("文章内容不能为空！");
		return false;
	}
	return true;
}
</script>
</html>
 