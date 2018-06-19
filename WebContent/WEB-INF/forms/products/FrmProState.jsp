<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
		<span>物品（电子条码）&转态查询与变更</span>
	</div>
	<hr>
		<div>
			<button>查询结果导出</button>
			<form action="FrmAdminRentPro" method="post" id="rentForm">
				<label>按物品主电子条码</label>
					<input type="" name="proName_" value="${proName_ }" placeholder="请输入搜索的关键字"> 
				<label>按物品归属机构</label>
					<input type="" name="zhuCode_" value="${zhuCode_ }" placeholder="请输入搜索的关键字"> 
				<<label>按物品状态</label>
					<input type="" name="zhuCode_" value="${zhuCode_ }" placeholder="请输入搜索的关键字"> 
				<<label>按变更时间</label>
					<input type="" name="zhuCode_" value="${zhuCode_ }" placeholder="请输入搜索的关键字"> 
					<input type="submit" value="查询">
			</form>
		</div>
	<form action="" id="subForm">
			<table>
					<tr>
						<td>一级分类</td>
						<td>二级分类</td>
						<td>物品名称</td>
						<td>物品主条码</td>
						<td>物品归属机构</td>
						<td>物品当前状态</td>
						<td>单据发起人</td>
						<td>状态变更时间</td>
						<td>操作</td>
					</tr>
				<c:forEach items="${values}" var="val"  varStatus="vs">
					<tr>
						<td>${vs.index+1}</td>
						<td>${val.items.UID_ }</td>
						<td>${val.items.fristName_ }</td>
						<td>${val.items.twoName_ }</td>
						<td>${val.items.proName_ }</td>
						<td>${val.items.proLaberSum_ }</td>
						<td>${val.items.proGuiCount_ }</td>
						<td>${val.items.proTuCount_ }</td>
						<td>${val.items.proRentCount_ }</td>
						<td>${val.items.proFixCount_ }</td>
						<td>￥ ${val.items.price_ }</td>
						<td>￥ ${val.items.proCostPrice_ }</td>
						<td>
							<a href="FrmAdminRentPro.toInsertProAttr?proId_=${val.items.proId_ }">变更物品属性</a>
						</td>
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