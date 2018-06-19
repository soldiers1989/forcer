<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn }/admin/js/jquery-1.9.1.min.js"></script>
<title>变更代理商信息</title>
</head>
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">变更代理商信息</span>
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
		<form action="FrmAgent.agentModify">
			<input type="hidden" name="up" value="up">
			<input type="hidden" name="UID_" value="${agent.items.UID_ }">
			<input type="hidden" name="communityId_" value="${agent.items.communityId_ }">
			<input type="hidden" name="agentId_" value="${agent.items.agentId_ }">
			<p><label>代理商序号：</label>${agent.items.agentNum_ }</p>
			<p><label>代理商编码：</label><input type="text" name="agentNo_" value="${agent.items.agentNo_ }"></p>
			<p><label>代理商简称：</label><input type="text" value="${agent.items.agentJname_ }" name="agentJname_"></p>
			<p><label>代理商全称：</label><input type="text" value="${agent.items.agentName_ }" name="agentName_"></p>
			<p><label>代理商级别：</label><%-- <input type="text" value="${agent.items.agentLevel_ }" name="agentLevel_"> --%>
				<select name="agentLevel_">
					<option value="省级代理" <c:if test="${agent.items.agentLevel_ == '省级代理' }">selected="selected"</c:if>>省级代理商</option>
					<option value="市级代理" <c:if test="${agent.items.agentLevel_ == '市级代理' }">selected="selected"</c:if>>市级代理商</option>
					<option value="区级代理" <c:if test="${agent.items.agentLevel_ == '区级代理' }">selected="selected"</c:if>>区级代理商</option>
				</select>
			</p>
			<p><label>代理商区域：</label>
			<input type="hidden" value="${area.items.province_ }" name="province_"> 
				<select name="province_" id="province_" hid="areaid_">
						<option>${area.items.province_ }</option>
				</select>
				<select name="city_" id="city_">
						<option selected>${area.items.city_ }</option>
				</select>
				<select name="area_" id="area_">
						<option selected>${area.items.area_ }</option>
				</select>
			</p>
			<p><input type="submit" value="提交" style="margin-left:106px !important"></p>
		</form>
	</div>
</div>





<%-- <form action="FrmAgent.agentModify">
<p><a href="FrmAgent">返回</a></p>
	<input type="hidden" name="up" value="up">
	<input type="hidden" name="UID_" value="${agent.items.UID_ }">
	<input type="hidden" name="communityId_" value="${agent.items.communityId_ }">
	<input type="hidden" name="agentId_" value="${agent.items.agentId_ }">
	<p>代理商序号：<label>${agent.items.agentNum_ }</label></p>
	<p>代理商编码:<input type="text" name="agentNo_" value="${agent.items.agentNo_ }"></p>
	<p>代理商简称:<input type="text" value="${agent.items.agentJname_ }" name="agentJname_"></p>
	<p>代理商全称:<input type="text" value="${agent.items.agentName_ }" name="agentName_"></p>
	<p>代理商级别:<input type="text" value="${agent.items.agentLevel_ }" name="agentLevel_">
		<select name="agentLevel_">
			<option value="省级代理" <c:if test="${agent.items.agentLevel_ == '省级代理' }">selected="selected"</c:if>>省级代理商</option>
			<option value="市级代理" <c:if test="${agent.items.agentLevel_ == '市级代理' }">selected="selected"</c:if>>市级代理商</option>
			<option value="区级代理" <c:if test="${agent.items.agentLevel_ == '区级代理' }">selected="selected"</c:if>>区级代理商</option>
		</select>
	</p>
	<p>代理商区域:<input type="text" value="${agent.items.agentArea_ }" name="agentArea_"></p>
	
	<p>代理商区域:<!-- <input type="text"  name="agentArea_" id="agentArea_"> -->
	<input type="hidden" value="${area.items.province_ }" name="province_"> 
		<select name="province_" id="province_" hid="areaid_">
				<option>${area.items.province_ }</option>
		</select>
		<select name="city_" id="city_">
				<option selected>${area.items.city_ }</option>
		</select>
		<select name="area_" id="area_">
				<option selected>${area.items.area_ }</option>
		</select>
	</p>
	
	<p><input type="submit" value="提交"></p>
</form> --%>
<script type="text/javascript">
//查询省份
$(document).ready(function(){
/* 	$("#province_").empty();  */
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