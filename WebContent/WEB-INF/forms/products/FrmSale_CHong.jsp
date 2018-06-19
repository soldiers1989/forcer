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

<title>入库数量录入</title>
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
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">入库数量冲红</span>
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
	<form action="FrmSale_queryRK.CHong" method="post" id="proAttr" class="formb" onsubmit="return check()">
				<input type="hidden" name="proId_" value="${value.items.proId_}">
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">当前物品名称：</label><span>${value.items.proName_}</span>
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">分类情况：</label><span class="spe">一级：${value.items.fristName_}</span><span>二级：${value.items.twoName_}</span>
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">已关联情况：</label><span class="spe">售卖：${value.items.proSaleCount_}个</span><span>租赁：${value.items.proRentCount_}个</span>
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">物品当前库存：</label>
					<span class="sumKuCun_">${value.items.sumKuCun_}</span>
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">总库存中归属供应商库存：</label>
					<span>${value.items.supplyKuCunSum_}</span>
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">当前入库单号：</label>
					<span>${value.items.ruKuId_}</span>
					<input name="ruKuId_" type="hidden" value="${value.items.ruKuId_}">
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">入库单归属机构：</label>
						<span>${value.items.saleHomeAgency_}</span>
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">入库供应商：</label>
						<span>${value.items.saleSupply_}</span>
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">原入库数量：</label>
						<span>${value.items.ruKuCount_}</span>
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">历史冲红数：</label>
						<span class="chCount_">${value.items.chCount_}</span>
						<input name="chCountNew_" type="hidden">
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">本次冲红数：</label>
					<input name="ch" type="number" onchange="jisuan();">
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">本次冲红后当前总库存：</label>
					<span class="sumKuCunNew_"></span>
				</div>
			      <div class="ck-box">
			      	<input type="submit" value="提交 "> 
			      </div>
			 </form>	
			</div>
	</div>
<!-- <div style="display: -webkit-box;" id="load-box" class="loadingbox loadbox loadingbox2"> -->
<!-- <p class="cl-666 f14"><span class="icon"></span>正在上传，请稍后</p></div> -->
</body>
<script>
//计算冲红后总库存
function jisuan(){
	var sumKuCun_=$(".sumKuCun_").html();//总库存
	var ch=$("input[name='ch']").val();//本次冲红数
	var sumKuCunNew_=sumKuCun_-ch;
	$(".sumKuCunNew_").html(sumKuCunNew_)
}	
//检验
function check(){
	var ch=$("input[name='ch']").val();//本次冲红数
	var chCount_=$(".chCount_").html();//历史冲红数
	var chCountSum_=Number(ch)+Number(chCount_);
	$("input[name='chCountNew_']").val(chCountSum_);
}
</script>
<script type="text/javascript">
	var msg = '${msg}';
	if(msg!=''){
	   alert(msg); 
	}
</script>


</html>