<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     <%@include file="../ui/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<title>一启享</title>
<style>
	.box{
		width:80%;
	}
</style>
</head>
<script type="text/javascript">
    function page(pageno) {
        $("#subForm").append(
                '<input type="hidden" name="pageno" value="'+ pageno +'">');
        $("#subForm").submit();
    }
</script>
<script type="text/javascript">
//生效
function addJifen(userCode_) {
	$.ajax({
		url : 'FrmPersonalInfo.addJifen',
		dataType : 'json',
		type : 'post',
		cache : false,
		
		data : {
			userCode_ : userCode_
		},
		success : function(data) {
			if (data == true) {
				alert("追加积分成功 ！");
				window.location.reload();
			} else {
				alert("追加积分失败！");
				window.location.reload();
			}
		}
	});
}
</script>
<body>
<div class="mid-box fl" id="mid-box">
	<form action="">
	<input type="hidden" value="${userCode_ }" name="code_">
		按受邀人电话搜索：<input type="text" value="${userId_ }" name="userId_">
		<input type="submit" value="搜索">
	</form>
	<form action="" id="subForm">
		<table class="tbl" style="width:100%">
			<tr>
				<td class="t-head tc">序号</td>
				<td class="t-head tc">受邀请人电话</td>
				<td class="t-head tc">微信昵称</td>
				<td class="t-head tc">注册时间</td>
				<td class="t-head tc">租赁订单总数</td>
				<td class="t-head tc">物品租金总价值</td>
				<td class="t-head tc">购买订单总金额</td>
				<td class="t-head tc">运维报异常次数</td>
				<td class="t-head tc">积分</td>
				<td class="t-head tc">操作</td>
			</tr>
			<tbody class="t-body tc">
				<c:forEach items="${customerInvitation }" var="custome" varStatus="status">
				<tr>
					<td>${status.index+1 }</td>
					<td>${custome.items.userId_ }</td>
					<td></td>
					<td>${custome.items.createTime_ }</td>
					<td>${custome.items.countOrder }</td>
					<td>
						<c:if test="${custome.items.sumRentMoney_  == null }">
							0
						</c:if>
						<c:if test="${custome.items.sumRentMoney_  != null }">
							${custome.items.sumRentMoney_ }
						</c:if>
					</td>
					<td>
						<c:if test="${custome.items.sumMoney_ == null}">
							0
						</c:if>
						<c:if test="${custome.items.sumMoney_ != null}">
							${custome.items.sumMoney_}
						</c:if>
					</td>
					<td></td>
					<td>${custome.items.integral_ }</td>
					<td>
						<a  onclick="addJifen('${custome.items.userCode_ }')" class="btn_style">追加积分</a>
					</td>
				</tr>
				</c:forEach>
			</tbody>
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
</div>
</body>
</html>