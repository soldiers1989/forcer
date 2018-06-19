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
  layui.use('laydate', function(){
      var laydate = layui.laydate; 
    });
</script>
<body>
<div class="mid-box fl" id="mid-box">
    <div class="top pl_20 pr_20">
        <span class="min-col f16">日账单</span>
    </div>
    <form action="FrmWeekBill" method="post" id="subForm">
        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
            <div class="fl leftSide">
                <div>
                    <span class="back_hint6">按日期范围</span>
                    <input type="text" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="unlockDate_" id="unlockDate_"  placeholder="起始日期" value="${unlockDate_ }"/><font> -至- </font>
                    <input type="text" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="endDate_" id="endDate_"  placeholder="终止日期" value="${endDate_ }"/>
                </div>
            </div>
            <div class="fr rightSide">
                <input type="submit" value="查询" id="sub">
                <a href="FrmWeekBill.excel?service=SvrGetDayBill&amp;exportKey=SvrWeekBill&amp;templateId=SvrWeekBill"><input type="button" value="查询结果导出"></a>
            </div>
        </div>
    </form>
    <div role="grid">
        <div class="table">
            <table class="tbl">
                <tbody>
                    <tr>
                        <th class="t-head tc">序号</th>
                        <th class="t-head tc">时间范围(周)</th>
                        <th class="t-head tc">充值金额(累计)</th>
                        <th class="t-head tc">提现金额(累计)</th>
                        <th class="t-head tc">租赁订单周结算<br/>租金总金额<br/>（累计）</th>
                        <th class="t-head tc">租赁订单今日结<br/>算时扣除的租<br/>金金额（累计）</th>
                        <th class="t-head tc">本周产生赔付单<br/>金额（累计）</th>
                        <th class="t-head tc">本周用户充值<br/>填补负数总金额<br/>(累计)</th>
                        <th class="t-head tc">本周新建产生<br/>租赁单立收租金<br/>金额（累计）</th>
                    </tr>
                </tbody>
                <tbody class="t-body tc">
                  <%-- 	<c:if test="${empty values}"><div  class="no_content"><img src="../../img/zwsj.png" style="width: 4rem;"></div></c:if>
                    --%>	<c:if test="${not empty values}">
	                    <c:forEach items="${values }" var="value" varStatus="status">
	                        <tr>
	                            <td>${ status.index + 1}</td>
	                            <td>${value.items.createTime_}</td>
	                            <td>${value.items.cMoney_}</td>
	                            <td>${value.items.tMoney_ }</td>
	                            <td>${value.items.leaseTotalMoney_ }</td>
	                            <td>${value.items.leaseKouchuMoney_ }</td>
	                            <td>${value.items.userPeifuMoney_}</td>
	                            <td>${value.items.userTianbuMoney_ }</td>
	                            <td>${value.items.leaseLishouMoney_ }</td>
	                        </tr>
	                    </c:forEach>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
    <div>
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
</div>
</body>
<script language="javascript" type="text/javascript" src="../../admin/My97DatePicker/WdatePicker.js"></script> 
<script type="text/javascript">
function page(pageno) {
    $("#subForm").append(
            '<input type="hidden" name="pageno" value="'+ pageno +'">');
    $("#subForm").submit();
}

function show(){
	var kefu = $("#kefu").val();
	if(kefu == "请选择后台客服"){
		alert("请选择后台客服!");
		return false;
	}
    obj = document.getElementsByName("code_");
    check_val = [];
    for(k in obj){
        if(obj[k].checked)
            check_val.push(obj[k].value);
    }
    var checkList = check_val.join("-");
    if(check_val == ""){
    	alert("请选择用户！");
    	return false;
    }
    $.ajax({
		url : 'FrmgetUser.upAdminUser',
		dataType : 'json',
		type : 'post',
		data : { 
			"checkList" : checkList,
			"kefu" : kefu
		},
		cache : false,
		success : function(data) {
			if(data == true){
				alert("变更客服成功！");
			}else{
				alert("变更客服失败!")
			}
		}
		});
}
</script>

</html>