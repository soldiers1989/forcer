<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="../ui/head1.jspf"%>
	<%@include file="../ui/head2.jspf" %> 
    <%-- <%@include file="../jspf/head1.jspf"%> --%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<title>一启享</title>
<script type="text/javascript">
	function page(pageno) {
		$("#subForm").append(
				'<input type="hidden" name="pageno" value="'+ pageno +'">');
		$("#subForm").submit();
	}
</script>
</head>
<body>
<div class="mid-box fl" id="mid-box">
    <div class="top pl_20 pr_20">
        <span class="min-col f16">积分等级列表</span>
    </div>
    <form action="FrmgetUser.getUser" method="post" id="subForm">
        <div class="tab_box mt_20 mb_20 clear pr_20 pl_20">
            <div class="fl leftSide">
                <a href="FrmJifenSign.levelInsert" class="btn_style">添加</a>
            </div>
        </div>
    </form>
    <div role="grid">
        <div class="table">
            <table class="tbl">
                <tbody>
                    <tr>
                        <th class="t-head tc">序号</th>
                        <th class="t-head tc">积分等级</th>
                        <th class="t-head tc">积分值</th>
                        <th class="t-head tc">等级说明</th>
                        <th class="t-head tc">操作</th>
                    </tr>
                </tbody>
                <tbody class="t-body tc">
                    <c:forEach items="${jifens }" var="jifen" varStatus="status">
                        <tr>
                            <td>${status.index+1 }</td>
                            <td>${jifen.items.grade_ }</td>
                            <td>${jifen.items.num_ }</td>
                            <td>${jifen.items.remark_ }</td>
                            <td>
                                <a href="FrmJifenSign.jiFenUpdate?UID_=${jifen.items.UID_ }" class="btn_style">编辑</a>&nbsp;&nbsp;&nbsp;
                                <a href="FrmJifenSign.jiFenDetail?UID_=${jifen.items.UID_ }" class="btn_style">查看</a>&nbsp;&nbsp;&nbsp;
                              <%--   <a href="FrmJifenSign.deleteLevel?levelID_=${jifen.items.levelID_}" class="btn_style">删除</a> --%>
                                <a href="javascript:if(confirm('您确定刪除吗?'))location='FrmJifenSign.deleteLevel?levelID_=${jifen.items.levelID_}';" class="btn_style">删除</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
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
<%-- <p><a href="FrmJifenSign.levelInsert">添加</a></p>
	<form action="" id="subForm">
		<table border="1px;">
			<tr>
				<td>序号</td>
				<td>积分等级</td>
				<td>积分值</td>
				<td>等级说明</td>
				<td>操作</td>
			</tr>
			<c:forEach items="${jifens }" var="jifen" varStatus="status">
			<tr>
				<td>${status.index+1 }</td>
				<td>${jifen.items.grade_ }</td>
				<td>${jifen.items.num_ }</td>
				<td>${jifen.items.remark_ }</td>
				<td>
					<a href="FrmJifenSign.jiFenUpdate?UID_=${jifen.items.UID_ }">编辑</a>&nbsp;&nbsp;&nbsp;
					<a href="FrmJifenSign.jiFenDetail?UID_=${jifen.items.UID_ }">查看</a>&nbsp;&nbsp;&nbsp;
					<a href="FrmJifenSign.deleteLevel?levelID_=${jifen.items.levelID_}">删除</a>
					<a href="javascript:if(confirm('您确定刪除吗?'))location='FrmJifenSign.deleteLevel?levelID_=${jifen.items.levelID_}';">删除</a>
				</td>
			</tr>
			</c:forEach>
		</table>
	</form>
	<c:if test="${pages.count >= 1}">
		<div class="foot-page">
			<a href="javascript:page(1);" class='page-index Shouw'>首页</a> <a
				href="javascript:page(${pages.prior});">上一页</a> <a
				href="javascript:page(${pages.next});">下一页</a> <a
				href="javascript:page(${pages.count});" class="page-last Shouw">尾页</a>
			条数：${pages.recordCount}, 页数：${pages.current} / ${pages.count}
		</div>
   </c:if> --%>
</body>
</html>