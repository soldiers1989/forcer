<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../ui/head1.jspf"%>
    <%@include file="../ui/head2.jspf" %> 
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
     <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${cdn}/layui/layui.js"></script>
<title>一起享</title>
</head>
<style>
   .no_content img{
      position: absolute;
      left: 50%;
      top: 50%;
      transform: translate(-50%,-50%)
    }
    .back_hint{
    	display: inline-block;
    	width: 100px;
    }
    #subForm .leftSide input{
    	margin-bottom: 0;
    	width: 153px;
    }
    #subForm .leftSide>div{
    	margin-bottom: 10px;
    }
    #subForm .leftSide .Wdate{
    	width: 180px;
    }
</style>
<script type="text/javascript">
  layui.use('laydate', function(){
      var laydate = layui.laydate; 
    });
</script>
<body>
<div class="mid-box fl" id="mid-box">
    <div class="top pl_20 pr_20">
        <span class="min-col f16">异常单</span>
    </div>
    <form action="FrmYcOrder.getYcOrder" method="post" id="subForm">
        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
            <div class="fl leftSide">
                <div>
                    <span class="back_hint6">按异常单据号</span>
                    <input type="text" name="ycOrder_" value="${ycOrder_ }">
                    <span class="back_hint6">按物品归属机构</span>
                    <input type="text" name="goodsAgency_" value="${goodsAgency_ }">
                    <span class="back_hint6">异常单来源</span>
                    <input type="text" name="source_" value="${source_ }">
                    <span class="back_hint6">异常单时间</span>
                    <input type="datetime-local" name="ycTime_" value="${ycTime_ }">
                    <span class="back_hint6">按标记状态</span>
                    <input type="text" name="ycStatus_" value="${ycStatus_ }">
                </div>
            </div>
            <div class="fr rightSide">
                <input type="submit" value="搜索" id="sub">
                <a href="FrmExcel?service=SvrgetUserList&amp;exportKey=SvrgetUserList&amp;templateId=UserList"><input type="button" value="查询结果导出"></a>
            </div>
        </div>
    </form>
    <div role="grid">
        <div class="table">
            <table class="tbl">
                <tbody>
                    <tr>
                        <th class="t-head tc">序号</th>
                        <th class="t-head tc">异常单据号</th>
                        <th class="t-head tc">异常单来源</th>
                        <th class="t-head tc">关联订单号</th>
                        <th class="t-head tc">关联物品名称</th>
                        <th class="t-head tc">关联物品归属机构</th>
                        <th class="t-head tc">异常单时间</th>
                        <th class="t-head tc">异常单处理状态</th>
                        <th class="t-head tc">异常单处理结果</th>
                        <th class="t-head tc">异常单处理时间</th>
                        <th class="t-head tc">人工标记状态</th>
                        <th class="t-head tc">处理人</th>
                        <th class="t-head tc">操作</th>
                    </tr>
                </tbody>
                <tbody class="t-body tc">
                  	<c:if test="${empty ycOrder}"><div  class="no_content"><img src="../../img/zwsj.png" style="width: 4rem;"></div></c:if>
                   	<c:if test="${not empty ycOrder}">
	                    <c:forEach items="${ycOrder }" var="value" varStatus="status">
	                        <tr>
	                            <td>${ status.index + 1}</td>
	                            <td>${value.items.ycNo_}</td>
	                            <td>${value.items.source_}</td>
	                            <td>${value.items.orderId_}</td>
	                            <td>${value.items.goodsName_}</td>
	                            <%-- <td><fmt:formatDate value="${value.items.createTime_ }" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td> --%>
	                            <td>${value.items.goodsAgency_}</td>
	                            <td>${value.items.ycTime_}</td>
	                            <td>${value.items.ycStatus_}</td>
	                            <td>${value.items.ycResult}</td>
	                            <td>${value.items.clTime_}</td>
	                            <td>${value.items.markStatus_}</td>
	                            <td>${value.items.dealer}</td>
	                            <td>
	                            <c:if test="${value.items.markStatus_ eq '0'}">
	                            	<a class="btn_style" onclick="upBiaoji('${value.items.ycNo_}')" style="margin-right:5px;">标记处理</a>
	                            </c:if>
		                            <a href="#" class="btn_style">订单手工结算</a>
	                            </td>
	                        </tr>
	                    </c:forEach>
                    </c:if>
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
<script language="javascript" type="text/javascript" src="../../admin/My97DatePicker/WdatePicker.js"></script> 
<script type="text/javascript">
function page(pageno) {
    $("#subForm").append('<input type="hidden" name="pageno" value="'+ pageno +'">');
    $("#subForm").submit();
}

function upBiaoji(ycNo_){
    $.ajax({
		url : 'FrmYcOrder.upOrderStatus',
		dataType : 'json',
		type : 'post',
		data : { 
			"ycNo_" : ycNo_
		},
		cache : false,
		success : function(data) {
			if(data == true){
				alert("该异常单标记处理成功！");
				window.location.href = "FrmYcOrder";
			}else{
				alert("该异常单标记处理失败！")
			}
		}
		});
}
</script>
</html>