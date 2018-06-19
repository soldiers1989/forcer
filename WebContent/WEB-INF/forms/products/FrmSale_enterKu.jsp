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
	.group-box{
		width:90%;
	}
	.group-box label{
		display:inline-block;
		background-color:#e6e6e6;
		padding:10px 10px;
		margin:0 20px;
		text-align:center;
	}
	.ck-box{
		width:60%;
	}
	.ck-box input{
		padding:5px 50px;
	}
</style>
</head>
<script type="text/javascript">
function pageSupply(pageno) {
    $("#saleId").append(
            '<input type="hidden" name="pageno" value="'+ pageno +'">');
    $("#saleId").submit();
}
</script>
<script type="text/javascript">
function page(pageno) {
    $("#tijiao").append(
            '<input type="hidden" name="pageno" value="'+ pageno +'">');
    $("#tijiao").submit();
}
</script>
<script type="text/javascript">
	function yanzheng(){
		var jinPrice_ = $("#jinPrice_").val();
		var ruKuCount_ = $("#ruKuCount_").val();
		var num = /^[0-9]*[1-9][0-9]*$/;
		var money = /^\d+(\.\d{1,2})?$/;
		var saleRuKuTime_ = $("#saleRuKuTime_").val();
		var saleServerDeadTime_ = $("#saleServerDeadTime_").val();
		if(!num.test(ruKuCount_)){
			alert("入库数量只可为正整数");
			return false;
		}
		if(!money.test(jinPrice_)){
			alert("进价单价格式有误");
			return false;
		}
		if(saleRuKuTime_ == null || saleRuKuTime_ == "" || saleServerDeadTime_ == null || saleServerDeadTime_ == ""){
			alert("信息填写不完整");
			return false;
		}
		
	}
</script>
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">入库数量录入</span>
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
	<form action="FrmSale_proManage.enterKuSale" method="post" id="proAttr" class="formb" onsubmit="return yanzheng()">
				<input type="hidden" name="proId_" value="${value.items.proId_}">
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">当前物品名称</label><span>${value.items.proName_}</span>
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">分类情况</label><span class="spe">一级：${value.items.fristName_}</span><span>二级：${value.items.twoName_}</span>
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">已关联情况</label><span class="spe">售卖：${value.items.proSaleCount_}个</span><span>租赁：${value.items.proRentCount_}个</span>
				</div>
				<div class="group-box" name="null" id="component1" visible="false" style="padding:20px 0 ;background-color:#f5f5f5">
					<div>
						<label style="width:200px">当前选定的入库归属机构</label><input name="saleHomeAgency_">
					</div>
				<!-- 按条件过滤 -->
		            <div class="mt_10">
		               <label style="width:200px">按条件过滤</label><input type="text" name="companyJc_">
		               <button onclick="check()" class="search btn_style">搜索</button>
		            </div>
		           
		        </div>
				
				<div class="group-box" style="background-color:#f5f5f5;padding:20px 0;margin-top:30px;">
					<div>
						<label style="width:200px">当前选定的入库供应商</label><input type="text"  name="saleSupply_">
					</div>
				 <!-- 按公司简称查询 -->
		            <div class="mt_10">
		                 <label style="width:200px">按公司简称查询</label><input type="text" name="companyJc_">
		                <button onclick="check()" class="search btn_style">搜索</button>
		            </div>
			 <%--         <div class="table mt_10">
			            <table class="tbl">
			                <tbody>
			                   <tr>
									<td class="t-head tc w_30">供应商编号</td>
									<td class="t-head tc w_30">公司简称</td>
									<td class="t-head tc w_30">公司全称</td>
									<td class="t-head tc w_30">营业执照</td>
									<td class="t-head tc w_30">公司固话</td>
									<td class="t-head tc w_30">供应物品范围</td>
									<td class="t-head tc w_30">联系人姓名</td>
									<td class="t-head tc w_30">手机</td>
									<td class="t-head tc w_30">操作</td>
								</tr>
			                </tbody>
			                <tbody class="t-body tc">
			                    <c:if test="${not empty supply}"></c:if>
			                    <c:forEach items="${supply }" var="val">
									<tr>
										<td>${val.items.supplyId_ }</td>
										<td class="supplyShortName_">${val.items.supplyShortName_ }</td>
										<td>${val.items.supplyFullName_ }</td>
										<td>${val.items.businessLicense_ }</td>
										<td>${val.items.companyTel_ }</td>
										<td>${val.items.supplyGoodsRange_ }</td>
										<td>${val.items.contact_ }</td>
										<td>${val.items.tel_ }</td>
										<td><a href="#" onclick="select2(this)" class="btn_style">选择</a></td>
									</tr>
								</c:forEach>
			                </tbody>
			            </table>	
			            </div>  --%>           
		            </div>
				
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">物品当前库存</label>
					<span>${value.items.sumKuCun_}</span>
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">总库存中归属供应商库存</label>
					<span>${value.items.couSupply_}</span>
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">当前入库单号</label>
					<span>${ruKuId_}</span>
					<input name="ruKuId_" type="hidden" value="${ruKuId_}" > 
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">进价单价</label>
					<input name="jinPrice_" type="text" onchange="jisuan();" id="jinPrice_">
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">本单入库数量</label>
					<input name="ruKuCount_" type="text" onchange="jisuan();" id="ruKuCount_">
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">进价总额</label>
					<input name="jinSum_" type="text" >
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">质保期截止至</label>
					<input name="saleServerDeadTime_" type="date" id="saleServerDeadTime_">
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">入库时间</label>
					<input name="saleRuKuTime_" type="date" id="saleRuKuTime_">
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label style="width:200px">批次</label>
					<input name="pici_" type="text">
				</div>
			      <div class="ck-box">
			      	<input type="submit" value="提交 "> 
			      </div>
			 </form>
			 <form action="FrmSale_proManage.searchSupply"  id="saleId">
			 <input name="ruKuId_" type="text" value="${ruKuId_}" > 
			 	     <div class="table mt_10">
			            <table class="tbl">
			                <tbody>
			                   <tr>
									<td class="t-head tc w_30">供应商编号</td>
									<td class="t-head tc w_30">公司简称</td>
									<td class="t-head tc w_30">公司全称</td>
									<td class="t-head tc w_30">营业执照</td>
									<td class="t-head tc w_30">公司固话</td>
									<td class="t-head tc w_30">供应物品范围</td>
									<td class="t-head tc w_30">联系人姓名</td>
									<td class="t-head tc w_30">手机</td>
									<td class="t-head tc w_30">操作</td>
								</tr>
			                </tbody>
			                <tbody class="t-body tc">
			                    <c:if test="${not empty supply}"></c:if>
			                    <c:forEach items="${supply }" var="val">
									<tr>
										<td>${val.items.supplyId_ }</td>
										<td class="supplyShortName_">${val.items.supplyShortName_ }</td>
										<td>${val.items.supplyFullName_ }</td>
										<td>${val.items.businessLicense_ }</td>
										<td>${val.items.companyTel_ }</td>
										<td>${val.items.supplyGoodsRange_ }</td>
										<td>${val.items.contact_ }</td>
										<td>${val.items.tel_ }</td>
										<td><a href="#" onclick="select2(this)" class="btn_style">选择</a></td>
									</tr>
								</c:forEach>
			                </tbody>
			            </table>	
			            </div> 
			 </form>
			   <c:if test="${pages.count >= 1}">
			        <div class="foot-page" align="center">
			            <a href="javascript:pageSupply(1);" class='page-index Shouw'>首页</a> <a
			                href="javascript:pageSupply(${pages.prior});">上一页</a> <a
			                href="javascript:pageSupply(${pages.next});">下一页</a> <a
			                href="javascript:pageSupply(${pages.count});" class="page-last Shouw">尾页</a>
			            <span>总条数：</span>${pages.recordCount}, 页数：${pages.current} / ${pages.count}
			        </div>
			    </c:if>
			    <div>
			     <form action="FrmSale_proManage.search" id="tijiao">
			        <div class="table mt_10">
			            <table class="tbl" style="width:80%">
			                <tbody>
			                   <tr>
									<td class="t-head tc w_30">地区</td>
									<td class="t-head tc w_30">代理级别</td>
									<td class="t-head tc w_30">代理简称</td>
									<td class="t-head tc w_30">操作</td>
								</tr>
			                </tbody>
			                <tbody class="t-body tc">
			                    <c:if test="${not empty agents}"></c:if>
			                    <c:forEach items="${agents }" var="val">
									<tr>
										<td>${val.items.agentArea_ }</td>
										<td class="agentLevel_">${val.items.agentLevel_ }</td>
										<td class="agentJname_">${val.items.agentJname_ }</td>
										<td><a href="#" onclick="select1(this)" class="btn_style">选择</a></td>
									</tr>
								</c:forEach>
			                </tbody>             
			            </table>	            
		            </div>
			 </form>
			 </div>
			  <c:if test="${pages.count >= 1}">
			        <div class="foot-page" align="center">
			            <a href="javascript:page(1);" class='page-index Shouw'>首页</a> <a
			                href="javascript:page(${pages.prior});">上一页</a> <a
			                href="javascript:page(${pages.next});">下一页</a> <a
			                href="javascript:page(${pages.count});" class="page-last Shouw">尾页</a>
			            <span>总条数：</span>${pages.recordCount}, 页数：${pages.current} / ${pages.count}
			        </div>
			    </c:if>
			</div>
	</div>
<!-- <div style="display: -webkit-box;" id="load-box" class="loadingbox loadbox loadingbox2"> -->
<!-- <p class="cl-666 f14"><span class="icon"></span>正在上传，请稍后</p></div> -->
</body>
<script>
	function jisuan(){
		var jinPrice_=$("input[name='jinPrice_']").val();
		var ruKuCount_=$("input[name='ruKuCount_']").val();
		var jinSum_=jinPrice_*ruKuCount_;
		$("input[name='jinSum_']").val(jinSum_);
	}

//搜索供应商
function check(){
	var companyJc_=$("input[name='companyJc_']").val();
	$.ajax({
		url: "FrmAdminRentPro.querySupply",
		data:{companyJc_:companyJc_},
		type: "POST",
		dataType: "json",
		async: true,
        cache: false,
        contentType: false,
		processData: false,
		success: function(data) {
			if(data){
				window.location.href="FrmAdminRentPro.queryNodeList?proId_="+proId_+"";
			}
		},
		error: function(data) {
				alert("网络异常，请稍后重试！");
		}
	})
}
//添加机构
function select1(node){
	var saleHomeAgency_=$(node).parent().parent().find(".agentJname_").html();
	$("input[name='saleHomeAgency_']").val(saleHomeAgency_);
}

//添加供应商
function select2(node){
	var saleSupply_=$(node).parent().parent().find(".supplyShortName_").html();
	$("input[name='saleSupply_']").val(saleSupply_);
}
</script>
<script type="text/javascript">
	var msg = '${msg}';
	if(msg!=''){
	   alert(msg); 
	}
</script>


</html>