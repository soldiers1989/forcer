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
			<span class="min-col f16">运维上报征信单</span>
		</div>
    <form action="FrmOperateReported.getUser" method="post" id="subForm">
        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
            <div class="fl leftSide">
                <div>
                    <span class="back_hint6">按运维单号</span><input type="text" name="ywNo_" value="${ywNo_}">
                	<span class="back_hint6">按上报人员号码</span><input type="text" name="mobile_" value="${mobile_}">
                	<span class="back_hint6">客户号码</span><input type="text" name="khmobile_" value="${khmobile_}">
                	<span class="back_hint6">上报时间</span><input type="text" name="time_" value="${time_}">
                	<span class="back_hint6">按标记状态</span><select name="status_"><option>----请选择----</option><option value="1">未处理</option><option value="2">已处理</option></select>
                </div>
            </div>
            <div class="fr rightSide">
                <input type="submit" value="查询" id="sub">
            </div>
        </div>
    </form>
    <div role="grid">
        <div class="table">
            <table class="tbl">
                <tbody>
                    <tr>
                        <th class="t-head tc">序号</th>
                        <th class="t-head tc">关联运维订单号</th>
                        <th class="t-head tc">上报运维人员</th>
                        <th class="t-head tc">上报时间</th>
                        <th class="t-head tc">上报客户名</th>
                        <th class="t-head tc">上报说明</th>
                        <th class="t-head tc">上报处理建议</th>
                        <th class="t-head tc">后台处理人</th>
                        <th class="t-head tc">标记处理状态</th>
                        <th class="t-head tc">操作</th>
                    </tr>
                </tbody>
                <tbody class="t-body tc">
                  	<c:if test="${empty values}"><div  class="no_content"><img src="../../img/zwsj.png" style="width: 4rem;"></div></c:if>
                   	<c:if test="${not empty values}"></c:if>
                    <c:forEach items="${values }" var="value" varStatus="status">
                        <tr>
                            <td>${ status.index + 1}</td>
                            <td>${value.items.ywNo_}</td>
                            <td>${value.items.reportedRen_}</td>
                            <td>${value.items.reportedTime_}</td>
                            <td>${value.items.reportedClient_}</td>
                            <c:if test="${empty value.items.reportedInstructions_}">
                           		<td>/</td>
                            </c:if>
                            <c:if test="${!empty value.items.reportedInstructions_}">
                           		<td>${value.items.reportedInstructions_}</td>
                            </c:if>
                            <c:if test="${empty value.items.reportedSuggest_}">
                           		<td>/</td>
                            </c:if>
                            <c:if test="${!empty value.items.reportedSuggest_}">
                           		<td>${value.items.reportedSuggest_}</td>
                            </c:if>
                           	<td>${value.items.dealer_}</td>
                            <c:if test="${value.items.status_ eq 2}">
                           		<td>已处理</td>
                            </c:if>
                            <c:if test="${value.items.status_ ne 2}">
                           		<td>未处理</td>
                            </c:if>
                            <c:if test="${value.items.status_ eq 2}">
                            <td><a onclick="nprocess()" class="btn_style">标记处理</a></td>
                            </c:if>
                            <c:if test="${value.items.status_ ne 2}">
                            <td><a onclick="process('${value.items.ywNo_ }')" class="btn_style">标记处理</a></td>
                            </c:if>
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
<script language="javascript" type="text/javascript" src="../../admin/My97DatePicker/WdatePicker.js"></script> 
<script type="text/javascript">
function page(pageno) {
    $("#subForm").append('<input type="hidden" name="pageno" value="'+ pageno +'">');
    $("#subForm").submit();
}

function process(ywNo_){
    $.ajax({
		url : 'FrmOperateReported.upstatus',
		dataType : 'json',
		type : 'post',
		data : { 
			"ywNo_" : ywNo_
		},
		cache : false,
		success : function(data) {
			if(data == true){
				alert("标记处理该订单成功！");
				window.location.href='FrmOperateReported';
			}else{
				alert("标记处理该订单失败!")
			}
		}
		});
}
function nprocess(){
	alert("已标记的订单不可再次标记！");
}
</script>
</html>