<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<head>
<script type="text/javascript">
function del() {
  var msg = "您确定要删除吗？";
  if (confirm(msg) == true) {
    return true;
  } else {
    return false;
  }
}
</script>
<head>
</head>

<body>
<div>
	<%-- <c:forEach items="${values }" var="value">
		<div>
			<ul>
				<li>${value.items.title_ }<a href="FrmGuideList.selArcitle?id_=${value.items.id_}">查看</a> 
					
					
					<input type="button" name="del" value="删除"
							onclick="del('${value.items.id_}');">
					<a href="FrmGuideList.updArcitle?id_=${value.items.id_}&falg=1">修改</a>
			<a href="FrmGuideList.addGuide">添加</a>
			
				</li>
</ul>
		</div>
	</c:forEach> --%>
	
	<p><a href="FrmGuideList.addGuide">添加</a></p>
	<table border="1px;">
		<tr>
			<td>序号</td>
			<td>文章标题</td>
			<td>文章内容</td>
			<td>操作</td>
		</tr>
		<c:forEach items="${values }" var="value" varStatus="status">
		<tr>
			<td>${status.index+1 }</td>
			<td>${value.items.title_ }</td>
			<td>${value.items.content_ }</td>
			<td><a href="FrmGuideList.selArcitle?id_=${value.items.id_}">查看</a> 
				&nbsp;&nbsp;&nbsp;
				<a href="FrmGuideList.updArcitle?id_=${value.items.id_}&falg=1">修改</a>
				&nbsp;&nbsp;&nbsp;
				<a href="FrmGuideList.deletetitle?id_=${value.items.id_}" onclick="javascript:return del();">删除</a>
			</td>
		</tr>
		</c:forEach>
	</table>

	
	</div>




</body>
</html>