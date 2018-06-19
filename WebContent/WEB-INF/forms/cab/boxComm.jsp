<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../ui/head1.jspf"%>
	<%@include file="../ui/head2.jspf" %> 
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一启享</title>
</head>
<body>
	
	<div class="mid-box fl" id="mid-box">
    <div class="top pl_20 pr_20">
        <span class="min-col f16">箱柜区域管理</span>
    </div>
    <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
         <a href="FrmBoxComm.insertCommunity" class="btn_style">添加</a>
    </div>
  
    <div role="grid">
        <div class="table">
            <table class="tbl">
                <tbody>
                    <tr>
						<td>序号</td>
						<td>社区名称</td>
						<td>物业名称</td>
						<td>操作</td>
					</tr>
                </tbody>
                <tbody class="t-body tc">
                    <c:if test="${empty boxComms}"><div  class="no_content"><img src="../../img/zwsj.png" style="width: 4rem;"></div></c:if>
                    <c:if test="${not empty boxComms}"></c:if>
                    <c:forEach items="${boxComms }" var="com" varStatus="status">
						<tr>
							<td>${status.index+1 }</td>
							<td>${com.items.communityName_ }</td>
							<td>${com.items.wuYeName_ }</td>
							<td><a href="FrmBoxComm.deleteCom?communityId_=${com.items.communityId_}" class="btn_style">删除</a>
							    &nbsp; &nbsp; &nbsp; &nbsp;
							    <a href="FrmBoxComm.modifyCommunity?communityId_=${com.items.communityId_}" class="btn_style ">修改</a>
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




<%-- 
	<h2>箱柜区域管理</h2>
	<a href="FrmBoxComm.insertCommunity">添加</a>
	<form action="">
		<table border="1px;">
			<tr>
				<td>序号</td>
				<td>社区名称</td>
				<td>物业名称</td>
				<td>操作</td>
			</tr>
			<c:forEach items="${boxComms }" var="com" varStatus="status">
			<tr>
				<td>${status.index+1 }</td>
				<td>${com.items.communityName_ }</td>
				<td>${com.items.wuYeName_ }</td>
				<td><a href="FrmBoxComm.deleteCom?communityId_=${com.items.communityId_}">删除</a>
				    &nbsp; &nbsp; &nbsp; &nbsp;
				    <a href="FrmBoxComm.modifyCommunity?communityId_=${com.items.communityId_}">修改</a>
				</td>
			</tr>
			</c:forEach>
		</table>
	</form> --%>
</body>
</html>