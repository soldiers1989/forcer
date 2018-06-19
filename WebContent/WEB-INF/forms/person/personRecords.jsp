<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<title>一启享</title>
</head>
<script type="text/javascript">
    function page(pageno) {
        $("#subForm").append(
                '<input type="hidden" name="pageno" value="'+ pageno +'">');
        $("#subForm").submit();
    }
</script>

<body>
<form action="" id="subForm"> <table class="tbl" >
                 <tbody>
                    <tr>
                        <th class="t-head tc">序号</th>
                        <th class="t-head tc">创建时间</th>
                        <th class="t-head tc">流水号</th>
                        <th class="t-head tc">操作人</th>
                        <th class="t-head tc">操作金额</th>
                        <th class="t-head tc">订单号</th>
                        <th class="t-head tc">平台</th>
                        <th class="t-head tc">交易方式</th>
                        <th class="t-head tc">操作类型</th>
                        <th class="t-head tc">状态</th>
                    </tr>
                </tbody>
                <tbody class="t-body tc">
                    <c:forEach items="${proRecords }" var="fin" varStatus="status">
                        <tr>
                            <td>${status.index+1 }</td>
                            <td>${fin.items.createTime_ }</td>
                            <td>${fin.items.out_trade_no_ }</td>
                            <td>${fin.items.name_ }</td>
                            <td>${fin.items.amount_ }</td>
                            <td>${fin.items.orderId_  }</td>
                            <td>微信</td>
                            <td>
                                <c:if test="${fin.items.type_ == '0'}">
                                    <span>提现</span>
                                </c:if>
                                <c:if test="${fin.items.type_ == '1'}">
                                    <span>充值</span>
                                </c:if>
                                <c:if test="${fin.items.type_ == null || fin.items.type_ == ''}">
                                    ==
                                </c:if>
                            </td>
                            <td>
                                <c:if test="${fin.items.opeType_ == 'A'}">
                                     <span>转出</span>
                                </c:if>
                                <c:if test="${fin.items.opeType_ == 'B'}">
                                    <span>转入</span>
                                </c:if>
                                <c:if test="${fin.items.opeType_ == 'C'}">
                                    <span>付款</span>
                                </c:if>
                                <c:if test="${fin.items.opeType_ == 'D'}">
                                    <span>退款</span>
                                </c:if>
                            </td>
                            <td>${fin.items.status_ =='0'?"成功":"失败" }</td>
                        </tr>            
                    </c:forEach>
                </tbody>
            </table></form>s
             <c:if test="${pages.count >= 1}">
        <div class="foot-page" align="center">
            <a href="javascript:page(1);" class='page-index Shouw'>首页</a> <a
                href="javascript:page(${pages.prior});">上一页</a> <a
                href="javascript:page(${pages.next});">下一页</a> <a
                href="javascript:page(${pages.count});" class="page-last Shouw">尾页</a>
            <span>总条数：</span>${pages.recordCount}, 页数：${pages.current} / ${pages.count}
        </div>
    </c:if>
</body>
</html>