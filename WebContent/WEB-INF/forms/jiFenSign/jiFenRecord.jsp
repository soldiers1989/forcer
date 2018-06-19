wolengchang<%@ page language="java" contentType="text/html; charset=UTF-8"
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
<script type="text/javascript">
    function page(pageno) {
        $("#subForm").append(
                '<input type="hidden" name="pageno" value="'+ pageno +'">');
        $("#subForm").submit();
    }
</script>

<title>积分记录</title>
</head>
<body>
<div class="mid-box fl" id="mid-box">
    <div class="top pl_20 pr_20">
        <span class="min-col f16">积分记录列表</span>
    </div>
    <form action="FrmJiFenRecords" method="post" id="subForm">
        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
            <div class="fl leftSide">
                <span>用户名：</span><input type="text" value="${shareName }" name="name_" placeholder="请输入用户名">
                <span>积分类型：</span>
                <select name="type_">
                    <option value="2" <c:if test="${type_ eq '2' || type_ eq null }">selected="selected"</c:if>>全部</option>
                    <option value="1" <c:if test="${type_ eq '1' }">selected="selected"</c:if>>分享</option>
                    <option value="0" <c:if test="${type_ eq '0' }">selected="selected"</c:if>>签到</option>
                </select>
                <button class="btn_style">查询</button>
            </div>
        </div>
    </form>
    <div role="grid" class="mt_20">
        <div class="table">
            <table class="tbl">
                <tbody>
                    <tr>
                        <th class="t-head">序号</th>
                        <th class="t-head">用户名</th>
                        <th class="t-head">获取方式</th>
                        <th class="t-head">获取积分</th>
                        <th class="t-head">积分总额</th>
                        <th class="t-head">当前积分等级</th>
                        <th class="t-head">被分享用户</th>
                        <th class="t-head">操作</th>
                    </tr>
                </tbody>
                <tbody class="t-body tc" id="userPage">
                    <c:forEach items="${records }" var="re" varStatus="status">
                        <tr>
                            <td>${status.index+1 }</td>
                            <td>${re.items.shareName }</td>
                            <td>${re.items.type_ == '0'?"签到":"分享" }</td>
                            <td>${re.items.integral_ }</td>
                            <td>${re.items.sum }</td>
                            <td>${re.items.grade_ }</td>
                            <td>
                                <c:if test="${re.items.regName != null}">
                                    <span>${re.items.regName }</span>
                                </c:if>
                                <c:if test="${re.items.regName == null}">
                                    <span>/</span>
                                </c:if>
                            </td>
                            <td>
                                <a href="FrmJiFenRecords.recordDetails?userCode_=${re.items.userCode_ }" class="btn_style">查看</a>
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


<%-- <form action="" id="subForm">
    <input type="text" value="${shareName }" name="name_" placeholder="请输入用户名"> --%>
<%-- <select name="type_">
        <c:if test="${type_ eq '2' || type_ eq null }">
            <option value="2">全部</option>
            <option value="1">分享</option>
            <option value="0">签到</option>
        </c:if>
        <c:if test="${type_ eq '1' }">
            <option value="2">全部</option>
            <option value="1" selected="selected">分享</option>
            <option value="0">签到</option>
        </c:if>
        <c:if test="${type_ eq '0' }">
            <option value="2">全部</option>
            <option value="1">分享</option>
            <option value="0" selected="selected">签到</option>
        </c:if>
    </select> --%>
    <%-- <select name="type_">
            <option value="2" <c:if test="${type_ eq '2' || type_ eq null }">selected="selected"</c:if>>全部</option>
            <option value="1" <c:if test="${type_ eq '1' }">selected="selected"</c:if>>分享</option>
            <option value="0" <c:if test="${type_ eq '0' }">selected="selected"</c:if>>签到</option>
    </select>
    <button>查询</button>
</form>
    <form action="" id="subForm">
        <table border="1px;">
            <tr>
                <td>序号</td>
                <td>用户名</td>
                <td>获取方式</td>
                <td>获取积分</td>
                <td>积分总额</td>
                <td>当前积分等级</td>
                <td>被分享用户</td>
                <td>操作</td>
            </tr>
            <c:forEach items="${records }" var="re" varStatus="status">
                <tr>
                    <td>${status.index+1 }</td>
                    <td>${re.items.shareName }</td>
                    <td>${re.items.type_ == '0'?"签到":"分享" }</td>
                    <td>${re.items.integral_ }</td>
                    <td>${re.items.sum }</td>
                    <td>${re.items.grade_ }</td>
                    <td>
                        <c:if test="${re.items.regName != null}">
                            ${re.items.regName }
                        </c:if>
                        <c:if test="${re.items.regName == null}">
                            /
                        </c:if>
                    </td>
                    <td>
                        <a href="FrmJiFenRecords.recordDetails?userCode_=${re.items.userCode_ }">查看</a>
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