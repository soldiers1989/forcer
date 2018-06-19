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
        <span class="min-col f16">租赁柜取物订单查询</span>
    </div>
    <form action="FrmAdminQhOrder.getQhOrder" method="post" id="subForm">
        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
            <div class="fl leftSide">
                <div>
                    <span class="back_hint8">按物品名称</span>
                    <input type="text" name="goods_" value="${goods_ }">
              <%--       <span class="back_hint8">按归属机构简称</span>
                    <input type="text" name="sqName_" value="${sqName_ }"> --%>
                    <span class="back_hint8">按取物柜名称</span>
                    <input type="text" name="cabinetName_" value="${cabinetName_ }">
                    <input type="submit" value="搜索" id="sub" style="width:70px;">
                 </div>
                 <div>
                    <span class="back_hint8">按关联租赁订单号</span>
                    <input type="text" name="orderId_" value="${orderId_ }">
                    <span class="back_hint8">按物品主电子条码</span>
                    <input type="text" name="zhuCode_" value="${zhuCode_ }">
                    <span class="back_hint8">按取物用户手机号</span>
                    <input type="text" name="userCode_" value="${userCode_ }">
                </div>
            </div>
            <div class="fr rightSide">
                <a href="FrmAdminQhOrder.excel?service=SvrGetQhOrder&amp;exportKey=SvrGetQhOrder&amp;templateId=SvrGetQhOrder"><input type="button" value="查询结果导出"></a>
            </div>
        </div>
    </form>
    <div role="grid">
        <div class="table">
            <table class="tbl">
                <tbody>
                    <tr>
                        <th class="t-head tc">序号</th>
                        <th class="t-head tc">单据号</th>
                        <th class="t-head tc">取物用户名</th>
                        <th class="t-head tc">关联订单号</th>
                        <th class="t-head tc">商品名称</th>
                        <th class="t-head tc">租赁时主电子条码</th>
                        <th class="t-head tc">租赁时配件电子条码</th>
                        <th class="t-head tc">取物柜所在社区名称</th>
                        <th class="t-head tc">取物柜名称</th>
                        <th class="t-head tc">取物箱号</th>
                        <th class="t-head tc">取物时间</th>
                        <th class="t-head tc">取物后是否关门</th>
                    </tr>
                </tbody>
                <tbody class="t-body tc">
                  	<%-- <c:if test="${empty qhOrder}"><div  class="no_content"><img src="../../img/zwsj.png" style="width: 4rem;"></div></c:if> --%>
                   	<c:if test="${not empty qhOrder}">
	                    <c:forEach items="${qhOrder }" var="value" varStatus="status">
	                        <tr>
	                            <td>${status.index + 1}</td>
	                            <td>${value.items.id_}</td>
	                            <td>${value.items.userCode_}</td>
	                            <td>${value.items.orderId_}</td>
	                            <td>${value.items.goodName_}</td>
	                            <td>${value.items.zhuCode_}</td>
	                            <td>${value.items.pzhuCode_}</td>
	                            <td>${value.items.sqName_}</td>
	                            <td>${value.items.cabinetName_}</td>
	                            <td>${value.items.boxNo_}</td>
	                            <td>${value.items.createTime_}</td>
	                            <td>${value.items.isClosed_}</td>
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