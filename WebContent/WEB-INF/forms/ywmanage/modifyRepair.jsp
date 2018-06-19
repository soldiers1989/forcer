<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一启享</title>
<style type="text/css">
.rad {
	width: 20px;
}

.spe {
	margin-right: 10px;
}
</style>
</head>
<body>
	<div class="mid-box fl" id="mid-box">
		<div class="top pl_20 pr_20 mb_20">
			<span class="min-col f16">手动变更状态</span>
		</div>
		<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
			<div class="fl leftSide">
				<a href="javascript:window.history.go(-1);" class="min-col"
					style="padding: 4px 10px; background: #48b2bd; color: #fff; border-radius: 3px;">返回</a>
			</div>
			<div class="fr rightSide"></div>
		</div>
		<div class="easyui-panel tc mt_20">
			<form action="FrmDiaoHuoBill.modifyRepair">
				<input type="hidden" value="up" name="up"> <input
					type="hidden" value="${repair.items.operateId_ }" name="operateId_">
				<div class="group-box" name="null" id="component1" visible="false">
					<label>物品名称：</label><input type="text" name="proName_"
						value="${repair.items.proName_ }">
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label>主电子条码：</label><input type="text" name="zhuCode_"
						value="${repair.items.zhuCode_ }">
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label>变更报修状态：</label>
					<c:if test="${repair.items.repairStatus_ == 0 }">
						<input class="rad" type="radio" value="0" name="repairStatus_"
							checked="checked" style="width: 15px;">
						<span class="spe">否</span>
						<input type="radio" value="1" name="repairStatus_"
							style="width: 15px;">
						<span>是</span>
					</c:if>
					<c:if test="${repair.items.repairStatus_ == 1 }">
						<input type="radio" value="0" name="repairStatus_"
							style="width: 15px;">
						<span class="spe">否</span>
						<input type="radio" value="1" name="repairStatus_"
							checked="checked" style="width: 15px;">
						<span>是</span>
					</c:if>
				</div>
				<div class="group-box" id="component4">
					<input type="submit" value="提交" style="margin-top: 10px;">
				</div>
			</form>
		</div>
	</div>
</body>
</html>