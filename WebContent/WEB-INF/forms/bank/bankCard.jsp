<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${cdn}/layui/layui.js"></script>
<title>一启享</title>
</head>
<script type="text/javascript">
    function page(pageno) {
        $("#subForm").append(
                '<input type="hidden" name="pageno" value="'+ pageno +'">');
        $("#subForm").submit();
    }
</script>
<script type="text/javascript">
	layui.use('laydate', function() {
		var laydate = layui.laydate;
	});
</script>
<body>
	<h2>银行卡认证列表</h2>
	<form action="" id="subForm">
		 <div>
		 	按银行卡打款认证用户名<input type="text" value="${userName_ }" name="userName_">
		 	最近发起认证时间<input type="text"   onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="lastDate_" id="lastDate_"  value="${lastDate_ }"/>
		 </div>
		 <div>
	 	 	最近金额输入时间<input type="text"   onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="lastMoneyTime_" id="lastMoneyTime_"   value="${lastMoneyTime_ }"/>
		           认证状态
	           <select name="status_">
	             <option value="-1" <c:if test="${status_ eq '-1' || status_ eq  null }">selected="selected"</c:if>>全部</option>
	           	 <option value="0" <c:if test="${status_ eq '0' }">selected="selected"</c:if>>不通过</option>
	         	 <option value="1" <c:if test="${status_ eq '1' }">selected="selected"</c:if>>认证通过并绑定银行卡</option>
	           </select>
		 </div>
		 <div>
		 	<input type="submit" value="搜索">
		 </div>
	</form>
	<form action="" id="subForm">
		<table>
			<tr>
				<td>序号</td>
				<td>银行卡打款认证用户名</td>
				<td>最近发起认证时间</td>
				<td>发起认证次数</td>
				<td>最近发起银行卡号</td>
				<td>银行卡开户行名称</td>
				<td>银行卡用户名</td>
				<td>打款金额</td>
				<td>用户最近输入认证金额</td>
				<td>最近输入金额认证时间</td>
				<td>当前认证输入错误次数</td>
				<td>认证状态</td>
				<td>操作</td>
			</tr>
			<c:forEach items="${banks }" var="bank" varStatus="status">
			<tr>
				<td>${status.index+1 }</td>
				<td>${bank.items.userName_ }</td>
				<td>${bank.items.lastDate_ }</td>
				<td>${bank.items.rzTime_ }</td>
				<td>${bank.items.lastBankCard_ }</td>
				<td>${bank.items.bankAccount_ }</td>
				<td>${bank.items.bankUserName_ }</td>
				<td>${bank.items.account_ }</td>
				<td>${bank.items.lastMoney_ }</td>
				<td>${bank.items.lastMoneyTime_ }</td>
				<td>${bank.items.wrongTime_ }</td>
				<td>
					<c:if test="${bank.items.status_ == '1'}">
						认证通过并绑定银行卡
					</c:if>
					<c:if test="${bank.items.status_ == '0'}">
						不通过
					</c:if>
				</td>
				<td><a href="#">重置认证发起次数</a>
					&nbsp;&nbsp;&nbsp;
					<a href="#">重置当前认证错误次数</a>
				</td>
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
            <span>总条数：</span>${pages.recordCount}, 页数：${pages.current} / ${pages.count}
        </div>
    </c:if>
</body>
</html>