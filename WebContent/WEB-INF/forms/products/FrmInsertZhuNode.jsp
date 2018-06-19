<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn }/admin/js/jquery-1.9.1.min.js"></script>
<title>添加电子标签</title>
<style>
.spe{
		margin-right:30px;
	}
.group-box label{
	width:115px;
}
.search{
	 width: 100px;
    text-indent: 10px;
    line-height: 30px;
    outline: none;
    color: #4c4c4c;
    height: 30px;
    border-radius: 3px;
    border: none;
    margin: 0 5px;
    border-radius: 3px;
    -webkit-border-radius: 3px;
    -moz-border-radius: 3px;
    -o-border-radius: 3px;
    -ms-border-radius: 3px;
  
    background: #48b2bd;
    color: #fff;
    cursor: pointer;
}
</style>
</head>
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">添加电子条码信息</span>
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
		<div class="group-box" name="null"  visible="false">
			<label>当前物品名称：</label><span>${proName_ }</span>
		</div>
		<div class="group-box" name="null"  visible="false">
			<label >分类情况：</label><span class="spe">一级：${fristName_}</span><span>二级：${twoName_}</span>
		</div>
		<div class="group-box" name="null"  visible="false">
			<label >已关联情况：</label><span class="spe">售卖：${proSaleCount_}个</span><span>租赁：${proRentCount_}个</span>
		</div>
		<div class="group-box" name="null"  visible="false">
			<form action="#" method="post" id="insertProNode" enctype="multipart/form-data">
					<input type="hidden" name="proId_" value="${proId_ }" id="proId_">
					<div class="group-box" name="null" id="component1" visible="false">
						<label >主电子条码：</label><input type="text" name="zhuCode_" id="zhuCode_"> 
					</div>
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
						<label>当前选定机构：</label><input type="text" name="homeAgency_" id="homeAgency_">
					</div>
					<!-- 按条件过滤 -->
			        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
			            <div class="fl leftSide">
			                <div>
			                    <span class="back_hint6">按条件过滤</span><input type="text" name="companyJc_">
			                </div>
			            </div>
			            <div class="fr rightSide">
			               <button onclick="check()" class="search">搜索</button>
			            </div>
			        </div>
			        <div class="table">
			            <table class="tbl">
			                <tbody>
			                   <tr>
									<td>地区</td>
									<td>代理级别</td>
									<td>代理简称</td>
									<td>操作</td>
								</tr>
			                </tbody>
			                <tbody class="t-body tc">
			                    <c:if test="${empty agents}"><div  class="no_content"><img src="../../img/zwsj.png" style="width: 4rem;"></div></c:if>
			                    <c:if test="${not empty agents}"></c:if>
			                    <c:forEach items="${agents }" var="val">
										<tr>
											<td>${val.items.agentArea_ }</td>
											<td class="agentLevel_">${val.items.agentLevel_ }</td>
											<td class="agentJname_">${val.items.agentJname_ }</td>
											<td><a href="#" onclick="select1(this)">选择</a></td>
										</tr>
									</c:forEach>
			                </tbody>
			            </table>	            
		            </div>
			        	        
			        <div class="group-box" name="null" id="component1" visible="false" style="margin-top: 20px">
						<label>  当前选定供应商：</label><input type="text" name="supplyUser_" id="supplyUser_">
					</div>
					 <!-- 按公司简称查询 -->
			        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
			            <div class="fl leftSide">
			                <div>
			                    <span class="back_hint6">按公司简称查询</span><input type="text" name="companyJc_">
			                </div>
			            </div>
			            <div class="fr rightSide">
			                <!-- <input  type="button" value="搜索" style="width:100px;" class="search"> -->
			                <button onclick="check()" class="search">搜索</button>
			            </div>
			        </div>
			         <div class="table">
			            <table class="tbl">
			                <tbody>
			                   <tr>
										<td>供应商编号</td>
										<td>公司简称</td>
										<td>公司全称</td>
										<td>营业执照</td>
										<td>公司固话</td>
										<td>供应物品范围</td>
										<td>联系人姓名</td>
										<td>手机</td>
										<td>操作</td>
									</tr>
			                </tbody>
			                <tbody class="t-body tc">
			                    <c:if test="${empty value}"><div  class="no_content"><img src="../../img/zwsj.png" style="width: 4rem;"></div></c:if>
			                    <c:if test="${not empty value}"></c:if>
			                    <c:forEach items="${value }" var="val">
									<tr>
										<td>${val.items.supplyId_ }</td>
										<td class="supplyShortName_">${val.items.supplyShortName_ }</td>
										<td>${val.items.supplyFullName_ }</td>
										<td>${val.items.businessLicense_ }</td>
										<td>${val.items.companyTel_ }</td>
										<td>${val.items.supplyGoodsRange_ }</td>
										<td>${val.items.contact_ }</td>
										<td>${val.items.tel_ }</td>
										<td><a href="#" onclick="select2(this)">选择</a></td>
									</tr>
								</c:forEach>
			                </tbody>
			            </table>	            
		            </div>
		           
		            <div class="group-box" name="null" id="component1" visible="false" style="margin-top: 20px">
						<label>进价：</label><input type="text" name="proCostPrice_" id="proCostPrice_">元
					</div>
					<div class="group-box" name="null" id="component1" visible="false">
						<label>质保期截止至：</label><input type="Date" name="serverDeadTime_" id="serverDeadTime_">
					</div>
					
					<div class="group-box" name="null" id="component1" visible="false">
						<label>入库时间：</label><input type="Date" name="enterKu_" id="enterKu_">
					</div>
					<div class="group-box" name="null" id="component1" visible="false">
						<label>当前折旧率：</label><input type="text" name="scrapState_" id="scrapState_">% 
					</div>
					<div class="group-box" name="null" id="component1" visible="false">
						<label>状态：</label>
						<input type="radio" name="state_" value="0" style="width:15px;" ><span class="spe">启用</span>
						<input type="radio" name="state_" value="1" style="width:15px;" ><span class="spe">保修</span>
						<input type="radio" name="state_" value="2" style="width:15px;" ><span class="spe">报废</span>
						<input type="radio" name="state_" value="3" style="width:15px;" ><span class="spe">返厂翻新</span>
					</div>
					<div class="group-box" name="null" id="component1" visible="false">
						<label>备注：</label><input type="text" name="remark_">
					</div>
					
			       
			</form>
			<div style="margin-left:13%">
	      		<input onclick="submit()" value="提交" type="button" style="color:#ffffff">
	        </div>
<script type="text/javascript">
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
		var supplyShortName_=$(node).parent().parent().find(".agentJname_").html();
		$("input[name='homeAgency_']").val(supplyShortName_);
	}
	
	//添加供应商
	function select2(node){
		var supplyShortName_=$(node).parent().parent().find(".supplyShortName_").html();
		$("input[name='supplyUser_']").val(supplyShortName_);
	}
	//提交
	function submit(){
		var zhuCode_ = $("#zhuCode_").val();
		var homeAgency_ = $("#homeAgency_").val();
		var supplyUser_ = $("#supplyUser_").val();
		var proCostPrice_ = $("#proCostPrice_").val();
		var serverDeadTime_ = $("#serverDeadTime_").val();
		var enterKu_ = $("#enterKu_").val();
		var scrapState_ = $("#scrapState_").val();
		
		if(zhuCode_== null || zhuCode_.length<=0){
			alert("请填写主电子条码");
			return false;
		}
		if(homeAgency_== null || homeAgency_.length<=0){
			alert("请选择机构");
			return false;
		}
		if(supplyUser_== null || supplyUser_.length<=0){
			alert("请选择供应商");
			return false;
		}
		if(proCostPrice_== null || proCostPrice_.length<=0){
			alert("请填写进价");
			return false;
		}
		if(serverDeadTime_== null || serverDeadTime_.length<=0){
			alert("请填写质保期");
			return false;
		}
		if(enterKu_== null || enterKu_.length<=0){
			alert("请填写入库时间");
			return false;
		}
		if(scrapState_== null || scrapState_.length<=0){
			alert("请填写折旧率");
			return false;
		}
		var data = new FormData($("#insertProNode")[0]);
		var proId_=$("#proId_").val();
		$.ajax({
			url: "FrmAdminRentPro.insertProNode",
			data:data,
			type: "POST",
			dataType: "json",
			async: true,
            cache: false,
            contentType: false,
			processData: false,
			success: function(data) {
				if(data){
					alert("添加成功!");
					window.location.href="FrmAdminRentPro";
				}else{
					alert("添加失败!已有相同的主电子条码，请添加不同的电子条码！");
					window.location.href="FrmAdminRentPro.toInsertProNode?proId_="+proId_+"";
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