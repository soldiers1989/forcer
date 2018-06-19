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
        <span class="min-col f16">${title_}</span>
    </div>
    <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	    <div class="fl leftSide">
	    	 <a href="javascript:window.history.go(-1);" class="min-col"
					style="padding: 4px 10px; background: #48b2bd; color: #fff; border-radius: 3px;">返回</a>
	    </div>
	    <div class="fr rightSide">
	    </div>
	</div>
    
   	<form action="FrmFundsAccount.hongbao" method="post" id="subForm">
        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20 mt_10">
            <div class="fl leftSide">
                <div>
                	<input type="hidden" name="accountId_" value="${accountId_}">
                	<span class="back_hint6">发生时间范围</span>
                	<input type="text" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="unlockDate_" id="unlockDate_"  placeholder="起始日期" value="${unlockDate_ }"/><font> -至- </font>
                    <input type="text" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="endDate_" id="endDate_"  placeholder="终止日期" value="${endDate_ }"/>
                    <span class="back_hint4">交易备注</span><input type="text" name="desc_" value="${desc_ }">
                </div>
            </div>
            <div class="fr rightSide">
            	<input type="submit" value="查询" id="sub">
                <a href="FrmExcel?service=SvrGetAccountRecordLog&amp;exportKey=SvrGetAccountRecordLog&amp;templateId=SvrGetAccountRecordLog&accountId_=${accountId_}"><input type="button" value="导出"></a>
            </div>
        </div>
       </form>
    <div role="grid">
        <div class="table">
            <table class="tbl">
                <tbody>
                    <tr>
                        <th class="t-head tc">序号</th>
                        <th class="t-head tc">资金流水</th>
                        <th class="t-head tc">发生时间</th>
                        <th class="t-head tc">发生金额</th>
                        <th class="t-head tc">交易类型</th>
                        <th class="t-head tc">期初金额<br/>${accountId_}</th>
                        <th class="t-head tc">期末金额<br/>${accountId_}</th>
                        <th class="t-head tc">对应流水</th>
                        <th class="t-head tc">交易备注</th>
                    </tr>
                </tbody>
                <tbody class="t-body tc">
                  	<c:if test="${empty values}"><div  class="no_content"><img src="../../img/zwsj.png" style="width: 4rem;"></div></c:if>
                   	<c:if test="${not empty values}">
	                    <c:forEach items="${values }" var="value" varStatus="status">
	                        <tr>
	                            <td>${ status.index + 1}</td>
	                            <td>${value.items.number_}</td>
	                            <td>${value.items.createTime_}</td>
	                            <td>${value.items.amount_}</td>
	                            <td>${value.items.type_}</td>
	                            <td>${value.items.qamount_}</td>
	                            <td>${value.items.hamount_}</td>
	                            <td>${value.items.recordId_}</td>
	                            <td>${value.items.desc_}</td>
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