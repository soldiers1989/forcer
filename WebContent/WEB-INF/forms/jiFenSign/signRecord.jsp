<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../ui/head1.jspf"%>
    <%@include file="../ui/head2.jspf" %> 
    <%-- <%@include file="../jspf/head1.jspf"%> --%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<title>签到记录</title>
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
        <span class="min-col f16">签到记录列表</span>
    </div>
    <%-- <form action="FrmgetUser.getUser" method="post" id="subForm">
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
    </form> --%>
    <div role="grid" class="mt_20">
        <div class="table">
            <table class="tbl">
                <tbody>
                    <tr>
                        <th class="t-head">序号</th>
                        <th class="t-head">用户微信昵称</th>
                        <th class="t-head">用户手机号</th>
                        <th class="t-head">签到时间</th>
                        <th class="t-head">当前所获积分</th>
                        <th class="t-head">积分总额</th>
                        <th class="t-head">当前积分等级</th>
                        <th class="t-head">操作</th>
                    </tr>
                </tbody>
                <tbody class="t-body tc" id="userPage">
                    <c:forEach items="${signs }" var="sign" varStatus="status">
                        <tr>
                            <td>${status.index+1 }</td>
                            <td>${sign.items.userName }</td>
                            <td>${sign.items.mobile }</td>
                            <td>${sign.items.createTime }</td>
                            <td>${sign.items.integral_ }</td>
                            <td>${sign.items.sum}</td>
                            <td>
                            <c:if test="${sign.items.sum > 0}">
                                <c:if test="${sign.items.sum < 99}">
                                    <span>V1</span>
                                </c:if>
                            </c:if>
                            <c:if test="${sign.items.sum >=99}">
                                <c:if test="${sign.items.sum < 199}">
                                    <span>V2</span>
                                </c:if>
                            </c:if>
                            <c:if test="${sign.items.sum >= 199}">
                                <c:if test="${sign.items.sum < 299}">
                                    <span>V3</span>
                                </c:if>
                            </c:if>
                            <c:if test="${sign.items.sum >= 299}">
                                <c:if test="${sign.items.sum < 399}">
                                    <span>V4</span>
                                </c:if>
                            </c:if>
                            </td>
                            <td>
                                <a href="FrmSignRecords.signDetails?userCode_=${sign.items.userCode_ }" class="btn_style">查看</a>
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

<!-- 原先注释 -->
<%-- <form action="">
    <c:forEach items="${list }" var="li">
        <select name="grade_">
            <option value="${li.items.grade_ }" <c:if test="${li.items.grade_ == grade_ }">selected="selected"</c:if>>
                ${li.items.grade_ }
            </option>
        </select>
    </c:forEach>
    <input type="submit" value="查询">
</form>  --%>

    <!-- 修改样式注释 -->
    <%-- <form action=""  id="subForm">
        <table border="1px;">
            <tr>
                <td>序号</td>
                <td>用户微信昵称</td>
                <td>用户手机号</td>
                <td>签到时间</td>
                <td>当前所获积分</td>
                <td>积分总额</td>
                <td>当前积分等级</td>
                <td>操作</td>
            </tr>
            <c:forEach items="${signs }" var="sign" varStatus="status">
                <tr>
                    <td>${status.index+1 }</td>
                    <td>${sign.items.userName }</td>
                    <td>${sign.items.mobile }</td>
                    <td>${sign.items.createTime }</td>
                    <td>${sign.items.integral_ }</td>
                    <td>${sign.items.sum}</td>
                    <td>
                    <c:if test="${sign.items.sum > 0}">
                        <c:if test="${sign.items.sum < 99}">
                            V1
                        </c:if>
                    </c:if>
                    <c:if test="${sign.items.sum >=99}">
                        <c:if test="${sign.items.sum < 199}">
                            V2
                        </c:if>
                    </c:if>
                    <c:if test="${sign.items.sum >= 199}">
                        <c:if test="${sign.items.sum < 299}">
                            V3
                        </c:if>
                    </c:if>
                    <c:if test="${sign.items.sum >= 299}">
                        <c:if test="${sign.items.sum < 399}">
                            V4
                        </c:if>
                    </c:if>
                    </td>
                    <td>
                        <a href="FrmSignRecords.signDetails?userCode_=${sign.items.userCode_ }">查看</a>
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