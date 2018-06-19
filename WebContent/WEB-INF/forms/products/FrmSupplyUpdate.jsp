<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<title>Insert title here</title>
</head>
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">添加/变更供应商信息</span>
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

		<form action="#" method="post" id="supplyForm">				
		<div class="group-box" name="null" id="component1" visible="false">
			<input type="hidden" name="supplyId_" placeholder="请输入供应商编号" value="${value.items.supplyId_}">
			<label style="width:200px">供应商编号（序号）：</label>
			<label>${value.items.supplyId_}</label>
			<%-- <input type="text" name="supplyId_" placeholder="请输入供应商编号" value="${value.items.supplyId_}"> --%>
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">供应商简称：</label>
			<input type="text" name="supplyShortName_" placeholder="请输入供应商简称" value="${value.items.supplyShortName_}">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">供应商全称：</label>
			<input type="text" name="supplyFullName_" placeholder="请输入供应商全称" value="${value.items.supplyFullName_}">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">营业执照号：</label>
			<input type="text" name="businessLicense_" placeholder="请输入营业执照号" value="${value.items.businessLicense_}">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">公司固话：</label>
			<input type="text" name="companyTel_" placeholder="请输入公司固话" value="${value.items.companyTel_}">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">供应物品范围：</label>
			<input type="text" name="supplyGoodsRange_" placeholder="请输入供应物品范围" value="${value.items.supplyGoodsRange_}">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">联系人姓名：</label>
			<input type="text" name="contact_" placeholder="请输入联系人姓名" value="${value.items.contact_}">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">联系手机：</label>
			<input type="text" name="tel_" placeholder="请输入联系手机" value="${value.items.tel_}">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">QQ：</label>
			<input type="text" name="qq_" placeholder="请输入QQ" value="${value.items.qq_}">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">经营模式：</label>
			<input type="text" name="businessModel_" placeholder="请输入经营模式" value="${value.items.businessModel_}">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">经营地址：</label>
			<input type="text" name="businessAdress_" placeholder="请输入经营地址" value="${value.items.businessAdress_}">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">注册资本（万人民币）：</label>
			<input type="text" name="registerMoney_" placeholder="请输入注册资本（万人民币）" value="${value.items.registerMoney_}">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">法人代表：</label>
			<input type="text" name="legalExpre_" placeholder="请输入法人代表" value="${value.items.legalExpre_}">
		</div>
	</form>
	<div class="group-box" id="component4" style="margin-left:30%">
		<input type="submit" name="submit" value="提交" onclick="submit()" >				
	</div>
</div>
</div>
	<!-- <button onclick="submit()" class="button">提交</button> -->
	<script type="text/javascript">
		function submit(){
			var formData = $('#supplyForm').serialize();
			console.log(formData);
			$.ajax({
				url: "FrmAdminSupply.updateSupply",
				data:formData,
				type: "POST",
				dataType: "json",
				async: true,
	            cache: false,
				success: function(data) {
					if(data){
						alert("修改成功!");
						window.location.href="FrmAdminSupply";
					}else{
						alert("修改失败!");
					}
				},
				error: function(data) {
						alert("网络异常，请稍后重试！");
				}
			})
		}
	</script>

</body>
</html>