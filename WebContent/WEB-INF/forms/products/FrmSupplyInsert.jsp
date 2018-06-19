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
			<label style="width:200px">供应商编号（序号）：</label>
			<input type="text" name="supplyId_" placeholder="请输入供应商编号" id="supplyId_">
		</div>
			
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">供应商简称：</label><input type="text" name="supplyShortName_" placeholder="请输入供应商简称" id="supplyShortName_">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">供应商全称：</label><input type="text" name="supplyFullName_" placeholder="请输入供应商全称" id="supplyFullName_">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">营业执照号：</label><input type="text" name="businessLicense_" placeholder="请输入营业执照号" id="businessLicense_">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">公司固话：</label><input type="text" name="companyTel_" placeholder="请输入公司固话" id="companyTel_">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">供应物品范围：</label><input type="text" name="supplyGoodsRange_" placeholder="请输入供应物品范围" id="supplyGoodsRange_">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">联系人姓名：</label><input type="text" name="contact_" placeholder="请输入联系人姓名" id="contact_">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">联系手机：</label><input type="text" name="tel_" placeholder="请输入联系手机" id="tel_">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">QQ：</label><input type="text" name="qq_" placeholder="请输入QQ" id="qq_">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">经营模式：</label><input type="text" name="businessModel_" placeholder="请输入经营模式" id="businessModel_">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">经营地址：</label><input type="text" name="businessAdress_" placeholder="请输入经营地址" id="businessAdress_">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">注册资本（万人民币）：</label><input type="text" name="registerMoney_" placeholder="请输入注册资本（万人民币）" id="registerMoney_">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">法人代表：</label><input type="text" name="legalExpre_" placeholder="请输入法人代表" id="legalExpre_">
		</div>
				
		</form>
		<div class="group-box" id="component4" style="margin-left:30%">
			<input type="submit" name="submit" value="提交" onclick="submit()" >				
		</div>
	<script type="text/javascript">
		function submit(){
			var supplyId_=$("#supplyId_").val();//供应商编号
			var supplyShortName_=$("#supplyShortName_").val();//供应商简称
			var supplyFullName_=$("#supplyFullName_").val();//供应商全称
			var businessLicense_=$("#businessLicense_").val();//营业执照号
			var companyTel_=$("#companyTel_").val();//公司固话
			var supplyGoodsRange_=$("#supplyGoodsRange_").val();//供应物品范围
			var contact_=$("#contact_").val();//联系人
			var tel_=$("#tel_").val();//联系人电话
			var businessModel_=$("#businessModel_").val();//经营模式
			var businessAdress_=$("#businessAdress_").val();//经营地址
			var registerMoney_=$("#registerMoney_").val();//注册资本
			var legalExpre_=$("#legalExpre_").val();//法人代表
			if(supplyId_==""||supplyId_==null){
				alert("请输入供应商编号！");
				return false;
			}
			if(supplyShortName_==""||supplyShortName_==null){
				alert("请输入供应商简称！");
				return false;
			}
			if(supplyFullName_==""||supplyFullName_==null){
				alert("请输入供应商全称！");
				return false;
			}
			if(businessLicense_==""||businessLicense_==null){
				alert("请输入营业执照号！");
				return false;
			}
			if(companyTel_==""||companyTel_==null){
				alert("请输入公司固话！");
				return false;
			}
			if(supplyGoodsRange_==""||supplyGoodsRange_==null){
				alert("请输入供应物品范围！");
				return false;
			}
			if(contact_==""||contact_==null){
				alert("请输入联系人姓名！");
				return false;
			}
			if(tel_==""||tel_==null){
				alert("请输入联系人电话！");
				return false;
			}
			if(businessModel_==""||businessModel_==null){
				alert("请输入经营模式！");
				return false;
			}
			if(businessAdress_==""||businessAdress_==null){
				alert("请输入经营地址！");
				return false;
			}
			if(registerMoney_==""||registerMoney_==null){
				alert("请输入相对应的注册资本！");
				return false;
			}
			if(legalExpre_==""||legalExpre_==null){
				alert("请输入法人代表！");
				return false;
			}
			var formData = $('#supplyForm').serialize();
			console.log(formData);
			$.ajax({
				url: "FrmAdminSupply.insertSupply",
				data:formData,
				type: "POST",
				dataType: "json",
				async: true,
	            cache: false,
				success: function(data) {
					if(data){
						alert("添加成功!");
						window.location.href="FrmAdminSupply";
					}else{
						alert("添加失败!");
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