<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<title>导入电子条码信息</title>
</head>
<body>
<div class="mid-box fl" id="mid-box">
    <div class="top pl_20 pr_20">
        <span class="min-col f16">导入电子条码信息</span>
    </div>
	<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	    <div class="fl leftSide">
	    	<a href="javascript:window.history.go(-1);" class=" btn_style">返回</a>
	    </div>
	    <div class="fr rightSide">
	    </div>
	</div>
	<div class="easyui-panel tc mt_20">
		<div class="group-box flexLayout " name="null" id="component1" visible="false">
			<form action="FrmAdminRentPro.importNodeExcel" enctype="multipart/form-data" method="post">
			<input type="file" name="excel" style="margin-left:111px;margin-right:10px;text-indent:4px;">
				<button type="submit" class="bigBtn_style" style="margin-right:5px;">导入电子标签</button>
			</form> 
	        <a href="FrmExcel?service=SvrAdminRentPro.queryNodeState&amp;exportKey=SvrAdminRentPro.queryNodeState&amp;templateId=QueryNodeStateTemplate" class="bigBtn_style">导出电子标签</a>
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<form action="FrmAdminRentPro.importNode" method="post">
				<div>
					输入主电子标签：<input type="text" name="zhuCode_" id="zhuCode_" value="${zhuCode_ }" class="mt_10"/>
					<button type="submit" class="bigBtn_style">查找</button>
					<a href="FrmAdminRentPro.importInsertNode" class="bigBtn_style">添加</a>
				</div>
			</form>
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
	<form action="" id="nodeForm">
		<div role="grid">
            <table class="tbl" style="width:100%">

			<tr>
				<td class="t-head">物品名称</td>
				<td class="t-head">主电子条码（主键）</td>
				<td class="t-head">自动读取的配件电子条码</td>
				<td class="t-head">商品状态</td>
				<td class="t-head">添加时间</td>
				<td class="t-head">操作</td>
			</tr>
			 <tbody class="t-body tc" id="userPage">
			
			<c:forEach items="${values}" var="val" >
					<tr>
						<td>${val.items.proName_ }</td>
						<td>${val.items.zhuCode_ }</td>
						<td>${val.items.ciCode_ }</td>
						<td>${val.items.nodeState_}</td>
						<td>${val.items.createDate_ }</td>
						<td><a href="FrmAdminRentPro.delProNode?zhuCode_=${val.items.zhuCode_ }" class="btn_style">删除</a></td>
					</tr>
			</c:forEach>
			</tbody>
		</table>
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
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	<%-- 
		<div>
			<p>定义租赁到柜&手数量</p>
		</div>
			<hr>
			<div class="fanhui">
				<a href="javascript:window.history.go(-1);" class="min-col aButton">返回</a>
			</div>
			<form action="FrmAdminRentPro.importNodeExcel" enctype="multipart/form-data" method="post">
			<input type="file" name="excel">
				<button type="submit">导入电子标签</button>
			</form>
        <a href="FrmExcel?service=SvrAdminRentPro.queryNodeState&amp;exportKey=SvrAdminRentPro.queryNodeState&amp;templateId=QueryNodeStateTemplate">导出电子标签</a>
		<form action="FrmAdminRentPro.importNode" method="post">
			<div>
				输入主电子标签：<input type="text" name="zhuCode_" id="zhuCode_" value="${zhuCode_ }"/>
				<button type="submit">查找</button>
				<a href="FrmAdminRentPro.importInsertNode">添加</a>
			</div>
		</form>
		<form action="" id="nodeForm">
		<table>
			<tr>
				<td>物品名称</td>
				<td>主电子条码（主键）</td>
				<td>自动读取的配件电子条码</td>
				<td>商品状态</td>
				<td>添加时间</td>
				<td>操作</td>
			</tr>
			<c:forEach items="${values}" var="val" >
					<tr>
						<td>${val.items.proName_ }</td>
						<td>${val.items.zhuCode_ }</td>
						<td>${val.items.ciCode_ }</td>
						<td>${val.items.nodeState_}</td>
						<td>${val.items.createDate_ }</td>
						<td><a href="FrmAdminRentPro.delProNode?zhuCode_=${val.items.zhuCode_ }">删除</a></td>
					</tr>
			</c:forEach>
		</table>
		</form>
		<c:if test="${pages.count >= 1}">
			<div class="foot-page" align="center">
				<a href="javascript:page(1);" class='page-index Shouw'>首页</a> <a
					href="javascript:page(${pages.prior});">上一页</a> <a
					href="javascript:page(${pages.next});">下一页</a> <a
					href="javascript:page(${pages.count});" class="page-last Shouw">尾页</a>
				总条数：${pages.recordCount}, 页数：${pages.current} / ${pages.count}
			</div>
		</c:if> --%>
<script>

	
</script>		
		
<script type="text/javascript">
	function page(pageno) {
		$("#nodeForm").append(
				'<input type="hidden" name="pageno" value="'+ pageno +'">');
		$("#nodeForm").submit();
	}
	function del() {
	  var msg = "您确定要删除吗？";
	  if (confirm(msg) == true) {
	    return true;
	  } else {
	    return false;
	  }
	}
	var message = '${msg}';
	if(message!=''){
	    alert(message);
	}
</script>
</body>
</html>