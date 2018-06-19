<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../ui/head1.jspf"%>
	<%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加社区信息</title>
<style>
.group-box label{
width:130PX;
}
.box{
margin-left:30%;
}
</style>
</head>
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">添加社区信息</span>
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
		<form action="FrmCommunity.insertCommunity">	
			<input type="hidden" name="in" value="in">
			<div class="group-box" name="null" id="component1" visible="false">
				<label>社区名称：</label><input type="text" name="communityName_" id="communityName_">
			</div>
			<div class="group-box" name="null" id="component1" visible="false">
				<label>社区简称：</label><input type="text" name="communityJname_" id="communityJname_">
			</div>
			<div class="group-box" name="null" id="component1" visible="false">
				<label>社区物业简称：</label><input type="text" name="wuYeJname_" id="wuYeJname_">
			</div>
			<div class="group-box" name="null" id="component1" visible="false">
				<label>社区物业全称：</label><input type="text" name="wuYeName_" id="wuYeName_">
			</div>
			<div class="group-box" name="null" id="component1" visible="false">
				<label>社区物业电话：</label><input type="text" name="wuYePhone_" id="wuYePhone_">
			</div>
			<!-- <div class="group-box" name="null" id="component1" visible="false">
				<input type="text" name="communityArea_" id="communityArea_">
			</div> -->
			<div class="group-box"><label>社区所在区域：</label> 
				<select name="province_" id="province_" hid="areaid_">
						<option>省份</option>
				</select>
				<select name="city_" id="city_">
						<option selected>市</option>
				</select>
				<select name="area_" id="area_">
						<option selected>区</option>
				</select>
			</div>
			<div class="group-box" name="null" id="component1" visible="false">
				<label>社区街道门牌地址：</label><input type="text" name="doorPlate_" id="doorPlate_">
			</div>
			<div class="group-box" name="null" id="component1" visible="false">
				<label>商城社区地址显示：</label><input type="text" name="address_" id="address_">
			</div>
			<div  class="group-box " style="margin-left:22.5%;" >
				<input type="submit" value="提交" style="width:100px;color:#ffffff;">
			</div>
		</form>
	</div>
</div>
<script type="text/javascript">
//查询省份
$(document).ready(function(){
  	$.ajax({
  		url: "FrmAgent.selectProvince",
		type: "POST",
		dataType: "text",
		async: true,
        cache: false,
		success: function(data) {
			var vals = eval('(' +eval('(' + data + ')').provinces+ ')');
			var str='';
			for(var i=0;i<vals.length;i++){
				var val = vals[i];
				var areaid_ = val.areaid_;
				var province_ = val.province_;
				str +="<option value='"+province_+"'>"+province_+"</option>";
				console.log(str);
			};
			$("#province_").append(str);
		},
		error: function(data) {
				alert("网络异常，请稍后再添加！");
		}
  	})
});
</script> 
<script type="text/javascript">
//动态显示市
$("#province_").on("change",function(){
	 $("#city_").empty(); 
	var areaid_=$(this).val();
	var province_ =  $("#province_").val();
	$.ajax({
		url: "FrmAgent.selectCity",
		type: "POST",
		data:{areaid_:areaid_,
			province_:province_},
		dataType: "text",
		async: false,
        cache: false,
		success: function(data) {
			var vals = eval('(' +eval('(' + data + ')').citys+ ')');
			var str = ''; 
			for(var i=0;i<vals.length;i++){
				var val = vals[i];
				var areaid_ = val.areaid_;
				var city_ = val.city_;
				str +="<option value='"+city_+"'>"+city_+"</option>";
				console.log(str);
			}
			$("#city_").append(str);
		},
		error: function(data) {
				alert("网络异常，请稍后重试！");
		}
	})
})	
</script>
<script type="text/javascript">
//动态显示区
$("#city_").on("change",function(){
 	$("#area_").empty(); 
	var areaid_=$(this).val();
	var city_ =  $("#city_").val();
	$.ajax({
		url: "FrmAgent.selectArea",
		type: "POST",
		data:{areaid_:areaid_,
			city_:city_},
		dataType: "text",
		async: false,
        cache: false,
		success: function(data) {
			var vals = eval('(' +eval('(' + data + ')').areas+ ')');
			var str = ''; 
			for(var i=0;i<vals.length;i++){
				var val = vals[i];
				var areaid_ = val.areaid_;
				var area_ = val.area_;
				str +="<option value='"+area_+"'>"+area_+"</option>";
				console.log(str);
			}
			$("#area_").append(str);
		},
		error: function(data) {
				alert("网络异常，请稍后重试！");
		}
	})
})	
</script>
</body>
</html>