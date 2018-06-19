<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../ui/head1.jspf"%>
    <%@include file="../ui/head2.jspf" %> 
    <%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${cdn}/layui/layui.js"></script>
<title>一启享</title>
<style>
	.leftSide input[type='text'],.leftSide select{
		width:153px;
	}
	.tbl tbody:first-child tr:first-child td{
		background: #f2f2f2;
	}
	table th{
		white-space: nowrap;
		padding:10px;
	}  
	table td{
	   white-space: nowrap;
	   padding:5px;
	} 
	.table{
	width:98%;
		overflow:scroll;
		 min-height: 550px;
		 padding:0 15px;
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
  layui.use('laydate', function(){
      var laydate = layui.laydate; 
    });
</script>
<script type="text/javascript">
	function send(orderId_){
		$.ajax({
			url : 'FrmCabinetOrders.sendMessage',
			dataType : 'json',
			type : 'post',
			cache : false,
			
			data : {
				orderId_ : orderId_
			},
			success : function(data) {
				if (data == false) {
					alert("消息发送失败 ！");
				/* 	window.location.reload(); */
				} else {
					alert("消息成功发送！");
				/* 	window.location.reload(); */
				}
			}
		});
	}
</script>
<body>
<div class="mid-box fl" id="mid-box">
    <div class="top pl_20 pr_20">
        <span class="min-col f16">租赁柜归还订单列表</span>
    </div>

	<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
		<form action="">
 	 	     <div class="fl leftSide">
                <div>
					<span class="back_hint8">物品名称</span><input type="text" name="proName_" value="${proName_ }">
					<span class="back_hint6">归属机构</span><input type="text" name="homeAgency_" value="${homeAgency_ }">
					<span class="back_hint6">成功时间</span><input type="text"   onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="createDate_" id="createDate_"  placeholder="起始日期" value="${createDate_ }"/>
				</div>
				<div>
					<span class="back_hint8">关联租赁单号</span><input type="text" name="orderId_" value="${orderId_ }">
					<span class="back_hint6">归还后运检时间</span><input type="text"   onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="OpenBoxTime_" id="createTime_"  placeholder="起始日期" value="${OpenBoxTime_}"/>
					<span class="back_hint6">归还用户手机号</span><input type="text" name="mobile_" value="${mobile_ }">
					<span class="back_hint8">用户所报归还状态</span>
					<select name="returnType_">
					   <option value="-2" <c:if test="${returnType_ eq '-2' || returnType_ eq  null  }">selected="selected"</c:if>>全部</option>
					   <option value="0" <c:if test="${returnType_ eq '0' }">selected="selected"</c:if>>无损归还</option>
				       <option value="1" <c:if test="${returnType_ eq '1' }">selected="selected"</c:if>>报修自己责任归还</option>
					</select>
					<input type="submit" value="搜索">
				</div>
			</div>
		</form>
		<div class="fr rightSide">
		     <a href="FrmExcel?service=SvrCabinetOrdersQuery&amp;exportKey=SvrCabinetOrdersQuery&amp;templateId=SvrCabinetOrdersQuery" class="btn_style mb_0">导出（Excel）</a>
		</div>
	</div>
    <div role="grid">
        <div class="table">
            <table class="tbl">
                <tbody>
		<tr>
			<td>序号</td>
			<td>租赁柜归还订单号</td>
			<td>归还人手机号</td>
			<td>物品归属机构</td>
			<td>归还柜所在社区名称</td>
			<td>归还柜名称</td>
			<td>归还箱号</td>
			<td>归还柜运维人员手机号</td>
			<td>归还订单成功时间（创建）</td>
			<td>关联租赁订单号</td>
			<td>商品名称</td>
			<td>租借时主电子条码</td>
			<td>租借时配件电子条码</td>
			<td>归还时电子条码</td>
			<td>缺失条码</td>
			<td>判断物品未匹配全，开门次数</td>
			<td>用户所报归还状态</td>
			<td>归还后运维检修是否报异常</td>
			<td>归还后运维检修时间</td>
			<td>关联运维订单单号</td>
			<td>关联租赁订单结算状态</td>
			<td>操作</td>
		</tr>
		<tbody class="t-body tc" id="userPage">
		<c:forEach items="${cabinets}" var="ca" varStatus="status">
			<tr>
				<td>${status.index+1 }</td>
				<td>${ca.items.orderId_ }</td>
				<td>${ca.items.mobile_ }</td>
				<td>${ca.items.homeAgency_ }</td>
				<td>${ca.items.boxName_ } </td>
				<td>${ca.items.boxCommunityName_ } </td>
				<td>${ca.items.setBoxId_ }</td>
				<td></td>
				<td>${ca.items.createDate_ }</td>  
				<td>${ca.items.orderId_ }</td>
				<td>${ca.items.proName_ }</td>
				<td>${ca.items.zhuCode_ }</td>
				<td>${ca.items.ciCode_ }</td>
				<td>${ca.items.zhuCode_ }${ca.items.ciCode_ }</td>
				<td>无</td>
				<td>0</td>
				<td>
					<c:if test="${ca.items.returnType_ == '0'}">
						无损归还
					</c:if>
					<c:if test="${ca.items.returnType_ == '1'}">
						报修自己责任归还
					</c:if>
				</td>
				<td>无异常</td>
				<td>${ca.items.OpenBoxTime_ }</td>
				<td>${ca.items.operateId_ }</td>
				<td>
					<c:if test="${ca.items.settleState_  == '0'}">
						未结算
					</c:if>
					<c:if test="${ca.items.settleState_  == '1'}">
						手工结算
					</c:if>
					<c:if test="${ca.items.settleState_  == '2'}">
						已结算
					</c:if>
				</td>
				<td><a onclick="send('${ca.items.orderId_ }');" class="btn_style">发催促运维信息到运维终端</a></td>
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
</body>
</html>