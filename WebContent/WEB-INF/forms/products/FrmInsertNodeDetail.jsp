<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<title>添加主电子条码详情</title>
</head>
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">添加主电子条码详情</span>
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
		<div class="group-box" name="null" id="component1" visible="false">
		<form action="FrmAdminRentPro.queryNodeList" method="post" id="rentForm">
		<div class="group-box" name="null" id="component1" visible="false">
			<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	            <div class="fl leftSide">
	            	<input type="hidden" name="proId_" value="${proId_ }">
	                <div>
	                    <span class="back_hint6">按电子条码:</span>
	                    <input type="" name="zhuCode_" value="${zhuCode_ }" placeholder="请输入搜索的电子条码" > 
	                </div>
	                
	            </div>
	            <div class="fr rightSide">
	                <input type="submit" value="查询" style="width:100px;color:#ffffff">
	            </div>
        	</div>
		</div>
		</form>
		</div>
	</div>

		<form action="" id="subForm">			 
        <div class="table">
            <table class="tbl">
                <tbody>
                   <tr>
						<td>主电子条码</td>
						<td>配件条码</td>
						<td>归属机构</td>
						<td>供应商简称</td>
						<td>进价</td>
						<td>保修截至日期</td>
						<td>入库时间</td>
						<td>最近修改时间</td>
						<td>当前折旧情况</td>
						<td>状态</td>
						<td>备注</td>
						<td>操作</td>
					</tr>
                </tbody>
                <tbody class="t-body tc">
                    <c:if test="${empty values}"><div  class="no_content"><img src="../../img/zwsj.png" style="width: 4rem;"></div></c:if>
                    <c:if test="${not empty values}"></c:if>
                    <c:forEach items="${values}" var="val" >
					<tr>
						<td>${val.items.zhuCode_ }</td>
						<td>${val.items.ciCode_ }</td>
						<td>${val.items.homeAgency_ }</td>
						<td>${val.items.supplyUser_ }</td>
						<td>${val.items.proCostPrice_ }</td>
						<td>${val.items.serverDeadTime_ }</td>
						<td>${val.items.enterKu_ }</td>
						<td>${val.items.updateDate_ }</td>
						<td>${val.items.scrapState_ }</td>
						<td><c:if test="${val.items.state_==0}">启用</c:if><c:if test="${val.items.state_==1}">保修</c:if>
						<c:if test="${val.items.state_==2}">报废</c:if><c:if test="${val.items.state_==3}">返厂翻新</c:if>
						</td>
						<td>${val.items.remark_ }</td>
						<td>
							<a href="FrmAdminRentPro.toUpdateProNode?proId_=${val.items.proId_ }" class="btn_style mb_10">变更信息</a>
						</td>
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
				总条数：${pages.recordCount}, 页数：${pages.current} / ${pages.count}
			</div>
		</c:if>



<script type="text/javascript">
	
	function page(pageno) {
		$("#subForm").append(
				'<input type="hidden" name="pageno" value="'+ pageno +'">');
		$("#subForm").submit();
	}
	function del() {
	  var msg = "您确定要删除吗？";
	  if (confirm(msg) == true) {
	    return true;
	  } else {
	    return false;
	  }
	}
</script>			
</body>
</html>