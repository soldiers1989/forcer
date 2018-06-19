<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn }/admin/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${cdn}/layui/layui.js"></script>
<title>后台物流管理</title>
<script type="text/javascript">
	layui.use('laydate', function() {
		var laydate = layui.laydate;
	});
</script>
</head>
<body>
<div class="mid-box fl" id="mid-box">
    <div class="top pl_20 pr_20">
        <span class="min-col f16">物流管理</span>
    </div>
    <div id="subForm">
        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
            <div class="fl leftSide">
                <form action="FrmLogistics" method="post" id="rentForm" class="mb_10">
                    <label>订单状态</label>
                    <select name="orderState_">
                    	<option value="0" <c:if test="${orderState_ eq '0' ||  orderState_ eq null }">selected="selected"</c:if>>全部</option>
                    	<option value="1" <c:if test="${orderState_ eq '1' }">selected="selected"</c:if>>待发货</option>
                    	<option value="2" <c:if test="${orderState_ eq '2' }">selected="selected"</c:if>>待开箱</option>
                    	<option value="3" <c:if test="${orderState_ eq '3' }">selected="selected"</c:if>>待收货</option>
                    	<option value="4" <c:if test="${orderState_ eq '4' }">selected="selected"</c:if>>租用中</option>
                    	<option value="5" <c:if test="${orderState_ eq '5' }">selected="selected"</c:if>>归还中</option>
                    	<option value="6" <c:if test="${orderState_ eq '6' }">selected="selected"</c:if>>已归还</option>
                    	<option value="7" <c:if test="${orderState_ eq '7' }">selected="selected"</c:if>>完成</option>
                    	<option value="8" <c:if test="${orderState_ eq '8' }">selected="selected"</c:if>>退款</option>
                    </select>
                    <label>按订单类型：</label>
                   <select name="orderType_">
                    	<option value="0" <c:if test="${orderType_ eq '0' ||  orderState_ eq null }">selected="selected"</c:if>>全部</option>
                    	<option value="1" <c:if test="${orderType_ eq '1' }">selected="selected"</c:if>>自取租赁</option>
                    	<option value="2" <c:if test="${orderType_ eq '2' }">selected="selected"</c:if>>寄送上门</option>
                    	<option value="3" <c:if test="${orderType_ eq '3' }">selected="selected"</c:if>>寄送到柜</option>
                    	<option value="4" <c:if test="${orderType_ eq '4' }">selected="selected"</c:if>>线上购买</option>
                    </select>
                    <label>快递公司</label>
                   <select  name="shippingCosts_">
                    	<option value="0" <c:if test="${shippingCosts_ eq '0' ||  orderState_ eq null }">selected="selected"</c:if>>全部</option>
                    	<option value="1" <c:if test="${shippingCosts_ eq '1' }">selected="selected"</c:if>>包邮</option>
                    	<option value="2" <c:if test="${shippingCosts_ eq '2' }">selected="selected"</c:if>>不包邮</option>
                    </select> 
                    <input type="text" name="content" placeholder="请输入搜索关键字" value=""${content}><br>
                      <div class="mt_10">
                      <label>发货时间</label>
                      <input type="text" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="deliveryTimeBegin_"  placeholder="起始日期" value="${deliveryTimeBegin_ }"/><font> -至- </font>
   					 <input type="text" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="deliveryTimeEnd_"  placeholder="终止日期" value="${deliveryTimeEnd_ }"/>
                      <label>收货时间</label>
                      <input type="text" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="recTimeBegin_"  placeholder="起始日期" value="${recTimeBegin_ }"/><font> -至- </font>
   					 <input type="text" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="recTimeEnd_"  placeholder="终止日期" value="${recTimeEnd_ }"/>
                      
                    <input type="submit" value="查询" class="mb_0">
                    </div>
                </form>  
            </div>
            <div class="fr rightSide">
            <a href="FrmExcel?service=SvrLogisticsQuery&amp;exportKey=SvrLogisticsQuery&amp;templateId=SvrLogisticsQuery" class="btn_style mb_0">导出（Excel）</a>
            </div>
        </div>
    </div>
    <div role="grid">
        <div class="table">
            <table class="tbl">
                <tbody>
                    <tr>
                        <th class="t-head tc">序号</th>
                        <th class="t-head tc">订单编号</th>
                        <th class="t-head tc">商品ID</th>	
                        <th class="t-head tc">商品名称</th>
                        <th class="t-head tc">订单类型</th>
                        <th class="t-head tc">下单用户</th>
                        <th class="t-head tc">订单状态</th>
                        <th class="t-head tc">邮费</th>
                        <th class="t-head tc">收件人</th>
                        <th class="t-head tc">收件人电话</th>
                        <th class="t-head tc">收件地址</th>
                        <th class="t-head tc">发货时间</th>
                        <th class="t-head tc">收货时间</th>
                        <th class="t-head tc">快递公司</th>
                        <th class="t-head tc">快递单号</th>
                        <th class="t-head tc">操作</th>
                    </tr>
                </tbody>
                <tbody class="t-body tc">
                    <c:forEach items="${logistics}" var="val" varStatus="vs">
                        <tr>
                            <td>${vs.index+1}</td>
                            <td>${val.items.orderId_ }</td>
                            <td>${val.items.proId_ }</td>
                            <td>${val.items.proName_ }</td>
                            <c:if test="${val.items.orderType_=='1' }"><td>自取租赁</td></c:if>
                            <c:if test="${val.items.orderType_=='2' }"><td>寄送上门</td></c:if>
                            <c:if test="${val.items.orderType_=='3' }"><td>寄送到柜</td></c:if>
                            <c:if test="${val.items.orderType_=='4' }"><td>线上购买</td></c:if>
                            <td>${val.items.userId_ }</td>
                            <c:if test="${val.items.orderState_=='1' }"><td>待发货</td></c:if>
                            <c:if test="${val.items.orderState_=='2' }"><td>待开箱</td></c:if>
                            <c:if test="${val.items.orderState_=='3' }"><td>待收货</td></c:if>
                            <c:if test="${val.items.orderState_=='4' }"><td>租用中</td></c:if>
                            <c:if test="${val.items.orderState_=='5' }"><td>归还中</td></c:if>
                            <c:if test="${val.items.orderState_=='6' }"><td>已归还</td></c:if>
                            <c:if test="${val.items.orderState_=='7' }"><td>完成</td></c:if>
                            <c:if test="${val.items.orderState_=='8' }"><td>退款</td></c:if>
                            <td>${val.items.shippingCosts_ }</td>
                            <td>${val.items.receiver_ }</td>
                            <td>${val.items.recAdr_ }</td>
                            <td>${val.items.recPhone_ }</td>
                            <td>${val.items.deliveryTime_ }</td>
                            <td>${val.items.recTime_ }</td>
                            <c:if test="${val.items.orderState_=='1'||val.items.orderState_=='2'||val.items.orderState_=='7'||val.items.orderState_=='8'}"><td></td><td></td></c:if>
                            <c:if test="${val.items.orderState_=='3'||val.items.orderState_=='4'}"><td>${val.items.recLogisticsName_ }</td><td>${val.items.recLogisticsId_ }</td></c:if>
                           <c:if test="${val.items.orderState_=='5'||val.items.orderState_=='6'}"><td>${val.items.returnLogisticsName_ }</td><td>${val.items.recLogisticsId_ }</td></c:if>
                            <td><a class="btn_style" href="FrmLogistics.queryDetail?orderId_=${val.items.orderId_ }">查看详情</a></td>
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
<script type="text/javascript">
    function page(pageno) {
        $("#subForm").append(
                '<input type="hidden" name="pageno" value="'+ pageno +'">');
        $("#subForm").submit();
    }
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