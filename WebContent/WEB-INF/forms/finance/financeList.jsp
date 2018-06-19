<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../ui/head1.jspf"%>
    <%@include file="../ui/head2.jspf" %> 
    <%--  <%@include file="../jspf/head1.jspf"%> --%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${cdn}/layui/layui.js"></script>
<title>财务管理列表</title>
<style type="text/css">
	.back_hint4{
		width: 76px;
	}
</style>
<script type="text/javascript">
function page(pageno) {
    $("#subForm").append(
            '<input type="hidden" name="pageno" value="'+ pageno +'">');
    $("#subForm").submit();
}
</script>
<script type="text/javascript">
    layui.use('laydate', function(){
        var laydate = layui.laydate; 
      });
</script>
<script type="text/javascript">
    $(function(){
        $("#search").click(function(){
            var createDate1=$("#createDate1").val();
            var createDate2=$("#createDate2").val();
            if(createDate1 != "" && createDate2 != ""){
            if(createDate1>=createDate2){
                alert("开始时间必须小于结束时间");
                return false;
            }
            }
        });
    });
</script>
</head>
<body>
<div class="mid-box fl" id="mid-box">
    <div class="top pl_20 pr_20">
        <span class="min-col f16">财务管理列表</span>
    </div>
    <form action="FrmFinance" method="post" id="subForm">
        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
            <div class="fl leftSide">
                <div class="mb_10">
                    <span class="back_hint4" style="margin-right: 3px;">操作人：</span><input type="text" value="${name_}" name="name_" placeholder="操作人">
                    <span class="back_hint4" style="margin-right: 3px;">订单号：</span><input type="text" value="${orderId_}" name="orderId_" placeholder="订单号">
                    <span class="back_hint4" style="margin-right: 3px;">开始时间：</span><input type="text" id="createDate1" name="createDate1" class="seach-date mr_0" placeholder="开始时间" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD'})" value="${createDate1}">-<input type="text" name="createDate2" id="createDate2"  class="seach-date" placeholder="结束时间" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD'})" value="${createDate2}">  
                </div>
                <div>
                    <span class="back_hint4">交易方式：</span>
                    <select name="type_">    
                        <option value="2" <c:if test="${type_ eq '2' || type_ eq null }">selected="selected"</c:if>>交易方式</option>
                        <option value="0" <c:if test="${type_ eq '0' }">selected="selected"</c:if>>提现</option>
                        <option value="1" <c:if test="${type_ eq '1'}">selected="selected"</c:if>>充值</option>
                    </select>
                    <span class="back_hint4">状态：</span>
                    <select name="status_">    
                        <option value="2" <c:if test="${status_ eq '2' || status_ eq null }">selected="selected"</c:if>>状态</option>
                        <option value="0" <c:if test="${status_ eq '0' }">selected="selected"</c:if>>成功</option>
                        <option value="1" <c:if test="${status_ eq '1'}">selected="selected"</c:if>>失败</option>
                    </select>
                    <span class="back_hint4">操作类型：</span>
                    <select name="opeType_">    
                        <option value="E" <c:if test="${opeType_ eq 'E' || opeType_ eq null }">selected="selected"</c:if>>操作类型</option>
                        <option value="A" <c:if test="${opeType_ eq 'A' }">selected="selected"</c:if>>转出</option>
                        <option value="B" <c:if test="${opeType_ eq 'B'}">selected="selected"</c:if>>转入</option>
                        <option value="C" <c:if test="${opeType_ eq 'C' }">selected="selected"</c:if>>付款</option>
                        <option value="D" <c:if test="${opeType_ eq 'D'}">selected="selected"</c:if>>退款</option>
                    </select>
                </div>
            </div>
            <div class="fr rightSide">
                <input type="submit"  value="查询" id="search">
            </div>
        </div>
    </form>
    <div role="grid">
        <div class="table">
            <table class="tbl">
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
                    <c:forEach items="${finances }" var="fin" varStatus="status">
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
    <%-- <form action="FrmFinance" id="subForm">
            <input type="text" value="${name_}" name="name_" placeholder="操作人">
            <input type="text" value="${orderId_}" name="orderId_" placeholder="订单号">
            <input type="text" id="createDate1" name="createDate1" class="seach-date" placeholder="开始时间" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD'})" value="${createDate1}">
            <span style="margin-right: 10px;">-至-</span>
            <input type="text" name="createDate2" id="createDate2"  class="seach-date" placeholder="结束时间" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD'})" value="${createDate2}">  
            <select name="type_">    
                <option value="2" <c:if test="${type_ eq '2' || type_ eq null }">selected="selected"</c:if>>交易方式</option>
                <option value="0" <c:if test="${type_ eq '0' }">selected="selected"</c:if>>提现</option>
                <option value="1" <c:if test="${type_ eq '1'}">selected="selected"</c:if>>充值</option>
            </select>
            <select name="status_">    
                <option value="2" <c:if test="${status_ eq '2' || status_ eq null }">selected="selected"</c:if>>状态</option>
                <option value="0" <c:if test="${status_ eq '0' }">selected="selected"</c:if>>成功</option>
                <option value="1" <c:if test="${status_ eq '1'}">selected="selected"</c:if>>失败</option>
            </select>
            <select name="opeType_">    
                <option value="E" <c:if test="${opeType_ eq 'E' || opeType_ eq null }">selected="selected"</c:if>>操作类型</option>
                <option value="A" <c:if test="${opeType_ eq 'A' }">selected="selected"</c:if>>转出</option>
                <option value="B" <c:if test="${opeType_ eq 'B'}">selected="selected"</c:if>>转入</option>
                <option value="C" <c:if test="${opeType_ eq 'C' }">selected="selected"</c:if>>付款</option>
                <option value="D" <c:if test="${opeType_ eq 'D'}">selected="selected"</c:if>>退款</option>
            </select>
        <input type="submit"  value="查询" id="search">
    </form>
    <form action="" id="subForm">
        <table border="1px;">
            <tr>
                <td>序号</td>
                <td>创建时间</td>
                <td>流水号</td>
                <td>操作人</td>
                <td>操作金额</td>
                <td>订单号</td>
                <td>平台</td>
                <td>交易方式</td>
                <td>操作类型</td>
                <td>状态</td>
            </tr>
            <c:forEach items="${finances }" var="fin" varStatus="status">
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
                        提现
                    </c:if>
                    <c:if test="${fin.items.type_ == '1'}">
                        充值
                    </c:if>
                    <c:if test="${fin.items.type_ == null || fin.items.type_ == ''}">
                        ==
                    </c:if>
                </td>
                <td>
                    <c:if test="${fin.items.opeType_ == 'A'}">
                         转出
                    </c:if>
                    <c:if test="${fin.items.opeType_ == 'B'}">
                        转入
                    </c:if>
                    <c:if test="${fin.items.opeType_ == 'C'}">
                        付款    
                    </c:if>
                    <c:if test="${fin.items.opeType_ == 'D'}">
                        退款
                    </c:if>
                </td>
                <td>${fin.items.status_ =='0'?"成功":"失败" }</td>
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
