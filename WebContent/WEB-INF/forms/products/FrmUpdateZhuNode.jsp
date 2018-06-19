<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn }/admin/js/jquery-1.9.1.min.js"></script>
<title>修改电子标签</title>
<style>
.group-box label{
		width:115px;
	}
</style>
</head>
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">变更电子条码信息</span>
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
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:100px">当前物品名称：</label><span>${proName_}</span>
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:100px">分类情况：</label><span class="spe">一级：${fristName_}</span><span>二级：${twoName_}</span>
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:100px">已关联情况：</label><span class="spe">售卖：${proSaleCount_}个</span><span>租赁：${proRentCount_}个</span>
		</div>
		<form action="#" method="post" id="updateProNode" enctype="multipart/form-data">
			<input type="hidden" name="proId_" value="${proId_ }">
			<div class="group-box" name="null" id="component1" visible="false">
				<label >主电子条码：</label><input type="text" name="zhuCode_" value="${value.items.zhuCode_ }" readonly>
			</div>
			<input type="hidden" name="ciIdTotal_" value="${value.items.ciCode_ }">
			<input type="hidden" name="ciNameTotal_" value="${value.items.ciCodeName_ }">
			<div class="group-box" name="null" id="component1" visible="false">
				<label >配件电子条码1：</label>
				<input type="text" name="ciCode_">
				<label >配件名称：</label>
				<input type="text" name="ciCodeName_">
			</div>
			<div class="group-box" name="null" id="component1" visible="false">
				<label >配件电子条码2：</label>
				<input type="text" name="ciCode_">
				<label >配件名称：</label>
				<input type="text" name="ciCodeName_">
			</div>
			<div class="group-box" name="null" id="component1" visible="false">
				<label >配件电子条码3：</label>
				<input type="text" name="ciCode_">
				<label >配件名称：</label>
				<input type="text" name="ciCodeName_">
			</div>
			<div class="group-box" name="null" id="component1" visible="false">
				<label>进价：</label><input type="text" name="proCostPrice_" value="${value.items.proCostPrice_ }">
			</div>
			<div class="group-box" name="null" id="component1" visible="false">
				<label>当前折旧率：</label><input type="text" name="scrapState_" value="${value.items.scrapState_ }">
			</div>
			<div class="group-box" name="null" id="component1" visible="false">
				<label>当前选定机构：</label><input type="text" name="homeAgency_" value="${value.items.homeAgency_ }">
			</div>
			<div class="group-box" name="null" id="component1" visible="false">
				<label>当前选定供应商：</label><input type="text" name="supplyUser_" value="${value.items.supplyUser_ }">
			</div>
			
			
	    </form>

		<div class="group-box" style="margin-left:30%">
      		<input onclick="submit()" value="提交" type="button" >      		
        </div>

<script type="text/javascript">

	function submit(){
		var data = new FormData($("#updateProNode")[0]);
		var proId_=$("input[name='proId_']").val();
		$.ajax({
			url: "FrmAdminRentPro.updateProNode",
			data:data,
			type: "POST",
			dataType: "json",
			async: true,
            cache: false,
            contentType: false,
			processData: false,
			success: function(data) {
				if(data){
					alert("修改成功!");
					window.location.href="FrmAdminRentPro.queryNodeList?proId_="+proId_+"";
				}else{
					alert("修改失败!");
					window.location.href="FrmAdminRentPro.queryNodeList?proId_="+proId_+"";
				}
			},
			error: function(data) {
					alert("网络异常，请稍后重试！");
			}
		})
	}
	//展示配件电子条码的信息
	$(function(){
		var ciIdTotal_=$("input[name='ciIdTotal_']").val().split(" ");
		var ciNameTotal_=$("input[name='ciNameTotal_']").val().split(" ");
		for(var i=0;i<ciIdTotal_.length;i++){
			$("input[name='ciCode_']").each(function(){
				if($(this).val().length==0){
					$(this).val(ciIdTotal_[i]);
					return false;
				}
			});
		}
		for(var i=0;i<ciNameTotal_.length;i++){
			$("input[name='ciCodeName_']").each(function(){
				if($(this).val().length==0){
					$(this).val(ciNameTotal_[i]);
					return false;
				}
			});
		}
	})
</script>
</body>
</html>