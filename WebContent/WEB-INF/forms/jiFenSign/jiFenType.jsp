<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="../ui/head1.jspf"%>
    <%@include file="../ui/head2.jspf" %> 
    <%-- <%@include file="../jspf/head1.jspf"%> --%>
    <%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<title>积分类型</title>
</head>
<body>
<div class="mid-box fl" id="mid-box">
    <div class="top pl_20 pr_20">
        <span class="min-col f16">积分类型列表</span>
    </div>
    <form action="FrmJiFenType" method="post" id="subForm">
        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
            <div class="fl leftSide">
                <span>积分类型：</span>
                <select name="type_">
                    <c:if test="${type_ eq '2' || type_ eq null }">
                        <option value="2">全部</option>
                        <option value="1">邀请积分</option>
                        <option value="0">签到积分</option>
                    </c:if>
                    <c:if test="${type_ eq '1' }">
                        <option value="2">全部</option>
                        <option value="1" selected="selected">邀请积分</option>
                        <option value="0">签到积分</option>
                    </c:if>
                    <c:if test="${type_ eq '0' }">
                        <option value="2">全部</option>
                        <option value="1">邀请积分</option>
                        <option value="0" selected="selected">签到积分</option>
                    </c:if>
                </select>
                <button class="btn_style">查询</button>
            </div>
        </div>
    </form>
    <div role="grid">
        <div class="table">
            <table class="tbl">
                <tbody>
                    <tr>
                        <th class="t-head">序号</th>
                        <th class="t-head">类型名称</th>
                        <th class="t-head">所属模块</th>
                        <th class="t-head">积分值</th>
                        <th class="t-head">操作</th>
                    </tr>
                </tbody>
                <tbody class="t-body tc" id="userPage">
                    <c:forEach items="${types }" var="type" varStatus="status">
                        <tr>
                            <td>${status.index+1 }</td>
                            <td>${type.items.type_ == '0'?"签到积分":"邀请积分"}</td>
                            <td>${type.items.type_ == '0'?"签到":"邀请"}</td>
                            <td>${type.items.integral_}</td>
                            <td>
                                <a href="FrmJiFenType.typeUpdate?UID_=${type.items.UID_}" class="btn_style">编辑</a> &nbsp;&nbsp;&nbsp;
                                <a href="FrmJiFenType.jfTypeDetails?UID_=${type.items.UID_}" class="btn_style">查看</a>
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
<%-- <form action="">
    <select name="type_">
        <c:if test="${type_ eq '2' || type_ eq null }">
            <option value="2">全部</option>
            <option value="1">邀请积分</option>
            <option value="0">签到积分</option>
        </c:if>
        <c:if test="${type_ eq '1' }">
            <option value="2">全部</option>
            <option value="1" selected="selected">邀请积分</option>
            <option value="0">签到积分</option>
        </c:if>
        <c:if test="${type_ eq '0' }">
            <option value="2">全部</option>
            <option value="1">邀请积分</option>
            <option value="0" selected="selected">签到积分</option>
        </c:if>
    </select>
    <button>查询</button>
</form>
<form action="" >
<table  border="1px;">
    <tr>
        <td>序号</td>
        <td>类型名称</td>
        <td>所属模块</td>
        <td>积分值</td>
        <td>操作</td>
    </tr>    
    <c:forEach items="${types }" var="type" varStatus="status">
        <tr>
            <td>${status.index+1 }</td>
            <td>${type.items.type_ == '0'?"签到积分":"邀请积分"}</td>
            <td>${type.items.type_ == '0'?"签到":"邀请"}</td>
            <td>${type.items.integral_}</td>
            <td>
                <a href="FrmJiFenType.typeUpdate?UID_=${type.items.UID_}">编辑</a> &nbsp;&nbsp;&nbsp;
                <a href="FrmJiFenType.jfTypeDetails?UID_=${type.items.UID_}">查看</a>
            </td>
        </tr>    
    </c:forEach>
</table>
</form> --%>
</body>
</html>