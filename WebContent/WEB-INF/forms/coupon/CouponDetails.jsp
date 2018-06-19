<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="../ui/head1.jspf"%>
    <%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<script type="text/javascript" src="${cldn}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${cdn}/layui/layui.js"></script>
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
$('#sub').on('click', function() {
    var startdate=$('#unlockDate_').val();
  var enddate=$('#endDate_').val();
  if(startdate != null && startdate!=""){
  if(startdate>enddate){ 
    alert("结束时间必须大于开始时间");
    return false;
    }
  }
    });
})
</script>
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
<body>
<div class="mid-box fl" id="mid-box">
    <div class="top pl_20 pr_20">
        <span class="min-col f16">优惠券管理列表</span>
    </div>
    <form action="FrmCouponDetails" method="post" id="subForm">
        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
            <div class="fl leftSide">
                <span>发放时间：</span>
                <input type="text" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="unlockDate_" id="unlockDate_"  placeholder="起始日期" value="${unlockDate_ }"/><span class="mr_10"> -至- </span>
                <input type="text" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="endDate_" id="endDate_"  placeholder="终止日期" value="${endDate_ }"/>
                <span>类型：</span>
                <select name = "type_">
                	<option value="" <c:if test="${type_ eq  '0' || type_ eq null}">selected="selected"</c:if>>全部</option>
                    <option value="全平台" <c:if test="${type_ eq  '全平台'}">selected="selected"</c:if>> 全平台</option>
                    <option value="租赁" <c:if test="${type_ eq  '租赁'}">selected="selected"</c:if>>租赁</option>
                    <option value="购买" <c:if test="${type_ eq  '购买'}">selected="selected"</c:if>>购买</option>
                    <option value="新注册用户" <c:if test="${type_ eq  '新注册用户'}">selected="selected"</c:if>>新注册用户</option>
                </select>
                <input type="submit" value="查询" id="sub" class="btn_style mb_0">
            </div>
            <div class="fr rightSide">
                <a href="FrmReleaseCoupon" class="btn_style mb_0">发布优惠券</a>
            </div>
        </div>
    </form>
    <div role="grid" class="mt_20">
        <div class="table">
            <table class="tbl">
                <tbody>
                    <tr>
                        <th class="t-head">序号</th>
                        <th class="t-head">优惠券名称</th>
                        <th class="t-head">优惠券类型</th>
                        <th class="t-head">接收人群</th>
                        <th class="t-head">发放总数</th>
                        <th class="t-head">优惠券图片</th>
                        <th class="t-head">发放时间</th>
                        <th class="t-head">操作</th>
                    </tr>
                </tbody>
                <tbody class="t-body tc" id="userPage">
                    <c:forEach items="${coupon_list }" var="var" varStatus="status">
                        <tr>
                            <td>${status.index+1 }</td>
                            <td>${var.items.couponname_}</td>
                            <td>${var.items.type_}</td>
                            <td>${var.items.receive_}</td>
                            <td>${var.items.total_}</td>
                            <td>
                                <img alt="" src="${var.items.imgUrl_}" style="width:100px;height:120px;">
                            </td>
                            <td>${var.items.releasedate_}</td>
                            <td>
                                <a href="FrmCouponDetails.deleopinion?couponId_=${var.items.couponId_}" onclick="javascript:return del();"  class="btn_style">删除</a>
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
    <p>
        发放时间：<input type="text" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="unlockDate_" id="unlockDate_"  placeholder="起始日期" value="${unlockDate_ }"/><font> -至- </font>
        <input type="text" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="endDate_" id="endDate_"  placeholder="终止日期" value="${endDate_ }"/>
    </p>
    <p>
        <select name = "type_">
             <option value="全平台" <c:if test="${type_ eq  '全平台'}">selected="selected"</c:if>> 全平台</option>
             <option value="租赁" <c:if test="${type_ eq  '租赁'}">selected="selected"</c:if>>租赁</option>
             <option value="购买" <c:if test="${type_ eq  '购买'}">selected="selected"</c:if>>购买</option>
             <option value="新注册用户" <c:if test="${type_ eq  '新注册用户'}">selected="selected"</c:if>>新注册用户</option>
        </select>
    </p>
    <input type="submit" value="查询" id="sub">
</form>
<form action="" id="subForm">
<p><a href="FrmReleaseCoupon.CouponInsert">新增</a></p>
    <table border="1px;" >
        <tr>
            <td>序号</td>
            <td>优惠券名称</td>
            <td>优惠券类型</td>
            <td>接收人群</td>
            <td>发放总数</td>
            <td>优惠券图片</td>
            <td>发放时间</td>
            <td>操作</td>
        </tr>
        <c:forEach items="${coupon_list }" var="var" varStatus="tatus">
        <tr>
            <td>${status.index+1 }</td>
            <td>${var.items.couponname_}</td>
            <td>${var.items.type_}</td>
            <td>${var.items.receive_}</td>
            <td>${var.items.total_}</td>
            <td>
                <img alt="" src="${var.items.imgUrl_}" style="width:100px;height:120px;">
            </td>
            <td>${var.items.releasedate_}</td>
            <td>
                <a href="FrmCouponDetails.deleopinion?cWouponId_=${var.items.couponId_}" onclick="javascript:return del();">删除</a>
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