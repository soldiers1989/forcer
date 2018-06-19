<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn }/admin/js/jquery-1.9.1.min.js"></script>
<title>变更代理商的社区管辖</title>
<style>
	.group-box p{
		margin-top:10px;
	}
</style>
</head>
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">变更代理商的社区管辖</span>
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
		<form action="FrmAgent.changeAgent">
		<p><input type="hidden" value="up" name="up"></p>
		<p><input type="hidden" value="${change.items.agentId_ }" name="agentId_"></p>
		<p><label>代理商序号：</label>${change.items.agentNum_ }</p>
		<p><label>代理商编号：</label><input type="text" value="${change.items.agentNo_ }" name="agentNo_" id="agentNo_"></p>
		<p><label>代理商简称：</label><input type="text" value="${change.items.agentJname_ }" name="agentJname_" id="agentJname_"></p>
		<p><label>代理商全称：</label><input type="text" value="${change.items.agentName_ }" name="agentName_" id="agentName_"></p>
		<p><label>代理商级别：</label>${change.items.agentLevel_ } </p>
		<p><label>代理区域：</label>${change.items.agentArea_ } </p>
		<p><label class="fl">当前管辖社区：</label>
				<table class="tbl" >
					<tbody class="t-body tc" id="userPage">
					<c:forEach items="${coms }" var="com">
						<tr >
							<td style="min-width:100px;text-align:left">${com.items.address_ }</td>
							<td><a href="#" class="btn_style">删除</a></td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
		</p>
		<p>
			<label class="fl">新增管辖社区：</label>
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
		<p><input type="submit" value="提交" style="margin-left: 106px !important;"></p>
		</form>
	</div>
</div>






	<%-- <form action="FrmAgent.changeAgent">
		<p><input type="hidden" value="up" name="up"></p>
		<p><input type="hidden" value="${change.items.agentId_ }" name="agentId_"></p>
		<p>代理商序号：<label>${change.items.agentNum_ }</label></p>
		<p>代理商编号:<input type="text" value="${change.items.agentNo_ }" name="agentNo_" id="agentNo_"></p>
		<p>代理商简称:<input type="text" value="${change.items.agentJname_ }" name="agentJname_" id="agentJname_"></p>
		<p>代理商全称:<input type="text" value="${change.items.agentName_ }" name="agentName_" id="agentName_"></p>
		<p>代理商级别:  <label>${change.items.agentLevel_ } </label>  </p>
		<p>代理区域:<label>${change.items.agentArea_ } </label></p>
		<div>
			<table border="1px;">
			<c:forEach items="${coms }" var="com">
				<tr>
					<td>${com.items.address_ }</td>
					<td><a href="#">删除</a></td>
				</tr>
				</c:forEach>
			</table>
		</div>
		<div>
			<p>新增管辖社区</p> --%>
			<%-- //省
			<select name="province_">
				<c:forEach items="${lists }" var="li">
					<option value="${li.items.province_}" <c:if test="${li.items.province_ == province_ }">selected="selected"</c:if>>
						${li.items.province_ }
					</option>
				</c:forEach>
			</select>
			
			//市
			<select name="city_">
				<c:forEach items="${lists }" var="li">
					<option value="${li.items.city_ }" <c:if test="${li.items.city_ == city_ }">selected="selected"</c:if>>
						${li.items.city_ }
					</option>
				</c:forEach>
			</select>
			
			//区
			<select name="area_">
				<c:forEach items="${lists }" var="li">
					<option value="${li.items.area_ }" <c:if test="${li.items.area_ == area_ }">selected="selected"</c:if>>
						${li.items.area_ }
					</option>
				</c:forEach>
			</select>  --%>
				<!-- <select name="province_" id="province_" hid="areaid_">
						<option>省份</option>
				</select>
				<select name="city_" id="city_">
						<option selected>市</option>
				</select>
				<select name="area_" id="area_">
						<option selected>区</option>
				</select>
		</div>
		<p><input type="submit" value="提交"></p>
	</form> -->
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
				str +="<option value='"+areaid_+"'>"+area_+"</option>";
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