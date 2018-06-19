<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@include file="../ui/head1.jspf"%>
	<%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<title>代理商列表</title>
<script type="text/javascript">
    function page(pageno) {
        $("#subForm").append(
                '<input type="hidden" name="pageno" value="'+ pageno +'">');
        $("#subForm").submit();
    }
</script>
</head>
<body>
<!-- 社区关联表 -->
<div class="box_community">
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">社区关联表</span>
    </div>
  <!--    <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	    <div class="fl leftSide">
	    	 <a href="javascript:window.history.go(-1);" class="btn_style">返回</a>
	    </div>
	    <div class="fr rightSide">
	    </div>
	</div>	 -->
	
	<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
         <a href="FrmCommunity.insertCommunity" class="btn_style">添加社区</a>
    </div>	
   <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
            <div class="fl leftSide">
    	<form action="" id="subForm">
    		<span class="mr_10">按社区名称查询</span><input type="text" value="${communityJname_}" name="communityJname_">
    		<input type="submit" value="查询">
    	</form>
    </div>
    </div>
	<div class="easyui-panel tc mt_20">
		<form action="" id="subForm">
        <div class="table">
            <table class="tbl">
                <tbody>
                   <tr>
						<td class="t-head">序号</td>
						<td class="t-head">总部</td>
						<td class="t-head">代理级别</td>
						<td class="t-head">代理商</td>
						<td class="t-head">社区名称</td>
						<td class="t-head">物业名称</td>
						<td class="t-head">操作</td>
					</tr>
					</tbody>
					<tbody class="t-body tc" id="userPage">
					<%-- <c:if test="${empty coms}"><img src="../../img/zwsj.png"></c:if> --%>
			        <c:if test="${not empty coms}"></c:if>
					<c:forEach items="${coms }" var="com" varStatus="status">
					<tr>
						<td>${status.index+1 }</td>
						<td>一启享</td>
						<td>${com.items.agentLevel_ }</td>    
						<td>${com.items.agentName_ }</td>
						<td>${com.items.communityJname_ }</td>
						<td>${com.items.wuYeName_ }</td>
						<td>
							<a class="btn_style" href="FrmCommunity.changeCom?communityId_=${com.items.communityId_ }">变更社区代理挂靠</a>&nbsp;&nbsp;&nbsp;&nbsp;
							<a class="btn_style" href="FrmCommunity.modifyCommunity?communityId_=${com.items.communityId_ }">变更社区名称</a>&nbsp;&nbsp;&nbsp;&nbsp;
							<%-- <a href="FrmCommunity.deleteCom?communityId_=${com.items.communityId_  }">删除</a> --%>
							<a class="btn_style" href="javascript:if(confirm('您确定刪除吗?'))location='FrmCommunity.deleteCom?communityId_=${com.items.communityId_  }';">删除</a>
							
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		</form>
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
</div>

<!-- 社区关联表 -->
<div class="box_community">
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">代理商列表</span>
    </div>
    <!--  <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	    <div class="fl leftSide">
	    	 <a href="javascript:window.history.go(-1);" class="btn_style">返回</a>
	    </div>
	    <div class="fr rightSide">
	    </div>
	</div> -->	
	
	<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
         <a  class="btn_style" href="FrmAgent.insertAgent">添加省级代理</a>
    </div>	
    <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
            <div class="fl leftSide">

    	<form action="" id="subForm">
    		<span class="mr_10">按代理商查询</span><input type="text" value="${agentJname_ }" name="agentJname_">
    		<input type="submit" value="查询">
    	</form>
    </div>
    </div>
	<div class="easyui-panel tc mt_20">
		<form action="" id="subForm">
        <div class="table">
            <table class="tbl">
                <tbody>
                  <tr>
				<td class="t-head">序号</td>
				<td class="t-head">代理商编码</td>
				<td class="t-head">地区</td>
				<td class="t-head">代理级别</td>
				<td class="t-head">代理商简称</td>
				<td class="t-head">代理商全称</td>
				<td class="t-head">关联社区</td>
				<td class="t-head">操作</td>
			</tr>
			</tbody>
			<%-- <c:if test="${empty agents}"><img src="../../img/zwsj.png"></c:if> --%>
            <c:if test="${not empty agents}"></c:if>
             <tbody class="t-body tc" id="userPage">
			<c:forEach items="${agents }" var="ag" varStatus="status">
			<tr>
				<td>${status.index+1 }</td>
				<td>${ag.items.agentNo_ }</td>
				<td>${ag.items.agentArea_ }</td>
				<td>${ag.items.agentLevel_ }</td>
				<td>${ag.items.agentJname_ }</td>
				<td>${ag.items.agentName_ }</td>
				<td><a href="FrmAgent.linkSheQu?agentId_=${ag.items.agentId_ }" class="btn_style">点击查看</a></td>
				<td>
					<a href="FrmAgent.changeAgent?agentId_=${ag.items.agentId_ }" class="btn_style">变更社区关联</a> &nbsp;&nbsp;&nbsp;
					<a href="FrmAgent.agentModify?agentId_=${ag.items.agentId_ }" class="btn_style">变更代理商信息</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<%-- <a href="FrmAgent.deleteAgent?UID_=${ag.items.UID_ }">删除</a> --%>
					<a href="javascript:if(confirm('您确定刪除吗?'))location='FrmAgent.deleteAgent?UID_=${ag.items.UID_ }';" class="btn_style">删除</a>
				</td>
			</tr>
			</c:forEach>
				</tbody>
			</table>
		</div>
		</form>
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
</div>

<%-- 
<div >
<h2>社区关联表</h2>
<form action="">
	<p><a href="FrmCommunity.insertCommunity">添加</a></p>
	<table border="1px;">
		<tr>
			<td>序号</td>
			<td>总部</td>
			<td>代理级别</td>
			<td>代理商</td>
			<td>社区名称</td>
			<td>物业名称</td>
			<td>操作</td>
		</tr>
		<c:if test="${empty coms}"><img src="../../img/zwsj.png"></c:if>
            <c:if test="${not empty coms}"></c:if>
		<c:forEach items="${coms }" var="com" varStatus="status">
		<tr>
			<td>${status.index+1 }</td>
			<td>一启享</td>
			<td>${com.items.agentLevel_ }</td>    
			<td>${com.items.agentName_ }</td>
			<td>${com.items.communityJname_ }</td>
			<td>${com.items.wuYeName_ }</td>
			<td>
				<a href="FrmCommunity.changeCom?communityId_=${com.items.communityId_ }">变更社区代理挂靠</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="FrmCommunity.modifyCommunity?communityId_=${com.items.communityId_ }">变更社区名称</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="FrmCommunity.deleteCom?communityId_=${com.items.communityId_  }">删除</a>
				<a href="javascript:if(confirm('您确定刪除吗?'))location='FrmCommunity.deleteCom?communityId_=${com.items.communityId_  }';">删除</a>
				
			</td>
		</tr>
		</c:forEach>
	</table>
</form>
</div>
<div>
	<h2>代理商列表</h2>
	<p><a href="FrmAgent.insertAgent">添加省级代理</a></p>
	<form action="">
		<table border="1px;">
			<tr>
				<td>序号</td>
				<td>代理商编码</td>
				<td>地区</td>
				<td>代理级别</td>
				<td>代理商简称</td>
				<td>代理商全称</td>
				<td>关联社区</td>
				<td>操作</td>
			</tr>
			<c:if test="${empty agents}"><img src="../../img/zwsj.png"></c:if>
            <c:if test="${not empty agents}"></c:if>
			<c:forEach items="${agents }" var="ag" varStatus="status">
			<tr>
				<td>${status.index+1 }</td>
				<td>${ag.items.agentNo_ }</td>
				<td>${ag.items.agentArea_ }</td>
				<td>${ag.items.agentLevel_ }</td>
				<td>${ag.items.agentJname_ }</td>
				<td>${ag.items.agentName_ }</td>
				<td><a href="FrmAgent.linkSheQu?agentId_=${ag.items.agentId_ }">点击查看</a></td>
				<td>
					<a href="FrmAgent.changeAgent?agentId_=${ag.items.agentId_ }">变更社区关联</a> &nbsp;&nbsp;&nbsp;
					<a href="FrmAgent.agentModify?UID_=${ag.items.UID_ }">变更代理商信息</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="FrmAgent.deleteAgent?UID_=${ag.items.UID_ }">删除</a>
					<a href="javascript:if(confirm('您确定刪除吗?'))location='FrmAgent.deleteAgent?UID_=${ag.items.UID_ }';">删除</a>
				</td>
			</tr>
			</c:forEach>
		</table>
	</form>
</div> --%>
</body>
</html>