<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<title>评价管理</title>
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
        <span class="min-col f16">评价管理</span>
    </div>
    <div>
        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
            <div class="fl leftSide">
                <form action="FrmEvaluate" method="post" id="subForm">
                    <span class="back_hint4">评价时间：</span>
                    <input type="date" name="beginTime_" value="${beginTime_ }"/>-<input type="date" name="endTime_" value="${endTime_ }" class="mr_10"/>
                    <span class="back_hint4"> 星级评价:</span>
                    <select name="evaLevel_" value="${evaLevel_ }">
                        <option value="0">请选择</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                    </select>
                    <span class="back_hint">匿名：</span>
                    <select name="evaState_">
                        <option value="0">匿名</option>
                        <option value="1">实名</option>
                    </select>
                    <input type="text" placeholder="请输入搜索的关键字" name="keywords"/>
                    <input type="submit" value="搜索" class="mb_0">
                </form>
            </div>
        </div>
    </div>
    <div role="grid">
        <div class="table">
        <form action="" id="subForm">
            <table class="tbl">
                <tbody>
                    <tr>
                        <th class="t-head tc">序号</th>
                        <th class="t-head tc">订单号</th>
                        <th class="t-head tc">商品名称</th>
                        <th class="t-head tc">商品类型</th>
                        <th class="t-head tc">评价用户</th>
                        <th class="t-head tc">星级评分</th>
                        <th class="t-head tc">评价内容</th>
                        <th class="t-head tc">评价时间</th>
                        <th class="t-head tc">显示</th>
                        <th class="t-head tc">操作</th>
                    </tr>
                </tbody>
                <tbody class="t-body tc">
                    <c:forEach items="${values}" var="val" varStatus="vs" >
                        <tr>
                            <td>${vs.index+1}</td>
                            <td>${val.items.orderId_ }</td>
                            <td>${val.items.proName_ }</td>
                            <td>
                                <c:if test="${val.items.orderType_==0 }">租赁</c:if>
                                <c:if test="${val.items.orderType_==1 }">购买</c:if>
                            </td>
                            <td>${val.items.name_ }</td>
                            <td>
                                <c:if test="${val.items.evaLevel_==1 }">1分</c:if>
                                <c:if test="${val.items.evaLevel_==2 }">2分</c:if>
                                <c:if test="${val.items.evaLevel_==3 }">3分</c:if>
                                <c:if test="${val.items.evaLevel_==4 }">4分</c:if>
                                <c:if test="${val.items.evaLevel_==5 }">5分</c:if>
                            </td>
                            <td>${val.items.evaContent_ }</td>
                            <td>${val.items.createDate_ }</td>
                            <td>
                                <c:if test="${val.items.isShow_==0 }">是</c:if>
                                <c:if test="${val.items.isShow_==1 }">否</c:if>
                            </td>
                            <td><a href="FrmEvaluate.toQueryEvaluateById?orderId_=${val.items.orderId_ }" class="btn_style">查看并回复</a>
                            	&nbsp;&nbsp;&nbsp;&nbsp;
                            	<a href="FrmEvaluate.deleteEve?proId_=${val.items.proId_ }" class="btn_style">删除</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            </form>
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
        <%-- <div>
            <span>评价管理</span>
        </div>
        <hr>
        <form action="FrmEvaluate" method="post">
            <span>评价时间：</span>
            <input type="date" name="beginTime_" value="${beginTime_ }"/>——<input type="date" name="endTime_" value="${endTime_ }"/>
            <span> 星级评价:</span>
            <select name="evaLevel_" value="${evaLevel_ }">
                <option value="0">请选择</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
            </select>
            <span>匿名：</span>
            <select name="evaState_">
                <option value="0">匿名</option>
                <option value="1">实名</option>
            </select>
            <input type="text" placeholde="请输入搜索的关键字" name="keywords" value="${keywords }"/>
            <button type="submit">搜索</button>
        </form>
        <form action="FrmEvaluate." id="subForm">
            <table>
                <tr>
                    <td>序号</td>
                    <td>订单号</td>
                    <td>商品名称</td>
                    <td>商品类型</td>
                    <td>评价用户</td>
                    <td>星级评分</td>
                    <td>评价内容</td>
                    <td>评价时间</td>
                    <td>显示</td>
                    <td>操作</td>
                </tr>
                <c:forEach items="${values}" var="val" varStatus="vs" >
                    <tr>
                        <td>${vs.index+1}</td>
                        <td>${val.items.orderId_ }</td>
                        <td>${val.items.proName_ }</td>
                        <td>
                            <c:if test="${val.items.orderType_==0 }">租赁</c:if>
                            <c:if test="${val.items.orderType_==1 }">购买</c:if>
                        </td>
                        <td>${val.items.name_ }</td>
                        <td>
                            <c:if test="${val.items.evaLevel_==1 }">1分</c:if>
                            <c:if test="${val.items.evaLevel_==2 }">2分</c:if>
                            <c:if test="${val.items.evaLevel_==3 }">3分</c:if>
                            <c:if test="${val.items.evaLevel_==4 }">4分</c:if>
                            <c:if test="${val.items.evaLevel_==5 }">5分</c:if>
                        </td>
                        <td>${val.items.evaContent_ }</td>
                        <td>${val.items.createDate_ }</td>
                        <td>
                            <c:if test="${val.items.isShow_==0 }">是</c:if>
                            <c:if test="${val.items.isShow_==1 }">否</c:if>
                        </td>
                        <td><a href="FrmEvaluate.toQueryEvaluateById?orderId_=${val.items.orderId_ }">查看并回复</a></td>
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
</body>
</html>