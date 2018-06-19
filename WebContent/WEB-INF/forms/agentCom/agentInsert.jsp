<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn }/admin/js/jquery-1.9.1.min.js"></script>
<title>添加代理商</title>
</head>
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">添加代理商</span>
    </div>
     <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	    <div class="fl leftSide">
	    	<!-- <a href="FrmAgent" class="min-col btn_style">返回</p> -->
	    	 <a href="javascript:window.history.go(-1);" class="min-col btn_style">返回</a>
	    </div>
	    <div class="fr rightSide">
	    </div>
	</div>	
	<div class="easyui-panel group-box tc mt_20">
	<form action="FrmAgent.insertAgent">
		<input type="hidden" name="in" value="in">
		<div><label>代理商编码：</label><input type="text"  name="agentNo_" id="agentNo_"></div>
		<div><label>代理商简称：</label><input type="text"  name="agentJname_" id="agentJname_"></div>
		<div><label>代理商全称：</label><input type="text" name="agentName_" id="agentName_"></div>
		<div><label class="fl">代理商级别：</label>
			<select name="agentLevel_" >
				<option value="省级代理">省级代理商</option>
				<option value="市级代理">市级代理商</option>
				<option value="区级代理">区级代理商</option>
			</select>
		</div>
		<div><label class="fl">代理商区域：</label>
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
		<div>
			<input type="submit" value="提交" style="    margin-left: 106px !important;">
		</div>
	</form>
	</div>
</div>


 <!-- <form action="FrmAgent.insertAgent">
	<p><a href="FrmAgent">返回</a></p>
	<input type="hidden" name="in" value="in">
	<p>代理商编码:<input type="text"  name="agentNo_" id="agentNo_"></p>
	<p>代理商简称:<input type="text"  name="agentJname_" id="agentJname_"></p>
	<p>代理商全称:<input type="text" name="agentName_" id="agentName_"></p>
	<p>代理商级别:<input type="text" name="agentLevel_" id="agentLevel_">
		<select name="agentLevel_">
			<option value="省级代理">省级代理商</option>
			<option value="市级代理">市级代理商</option>
			<option value="区级代理">区级代理商</option>
		</select>
	</p>
	<p>代理商区域:<input type="text"  name="agentArea_" id="agentArea_">
		<select name="province_" id="province_" hid="areaid_">
						<option>省份</option>
				</select>
				<select name="city_" id="city_">
						<option selected>市</option>
				</select>
				<select name="area_" id="area_">
						<option selected>区</option>
				</select>
	</p>
	<p><input type="submit" value="提交"></p>
</form>  -->
</body>
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
</html>