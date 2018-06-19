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
        <span class="min-col f16">用户列表</span>
    </div>
    <form action="FrmAdminExclusiveUser.getUser" method="post" id="subForm">
        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
            <div class="fl leftSide">
                <div>
                    <span class="back_hint6">按用户手机号</span><input type="text" name="mobile_">
                    <span class="back_hint6">按账户余额范围</span><input type="text" name="smoney_" width="30px">-<input type="text" name="money_" width="30px">
                    <span class="back_hint6">按大于押金范围</span><input type="text" name="yajin_">
                    <span class="back_hint4">按在租订单数大于范围</span><input type="text" name="orderNum_">
                    <span class="back_hint4">按注册时间范围</span><input type="text" name="mobile_"><input type="text" name="mobile_">
                </div>
            </div>
            <div class="fr rightSide">
                <input type="submit" value="查询" id="sub">
                <a href="FrmExcel?service=SvrgetUserList&amp;exportKey=SvrgetUserList&amp;templateId=UserList"><input type="button" value="查询结果导出"></a>
            </div>
        </div>
    </form>
    <div role="grid">
        <div class="table">
            <table class="tbl">
                <tbody>
                    <tr>
                        <th class="t-head tc"></th>
                        <th class="t-head tc">序号</th>
                        <th class="t-head tc">微信昵称</th>
                        <th class="t-head tc">手机号</th>
                        <th class="t-head tc">活体认证</th>
                        <th class="t-head tc">银行卡认证</th>
                        <th class="t-head tc">芝麻认证分</th>
                        <th class="t-head tc">注册时间</th>
                        <th class="t-head tc">账户余额</th>
                        <th class="t-head tc">押金</th>
                        <th class="t-head tc">在租订单数</th>
                        <th class="t-head tc">积分</th>
                        <th class="t-head tc">账户状态</th>
                        <th class="t-head tc">邀请码</th>
                        <th class="t-head tc">专属客服</th>
                        <th class="t-head tc">邀请客户数</th>
                        <th class="t-head tc">操作</th>
                    </tr>
                </tbody>
                <tbody class="t-body tc">
                  <%--   <c:if test="${empty values}"><div  class="no_content"><img src="../../img/zwsj.png" style="width: 4rem;"></div></c:if>
                   --%>  <c:if test="${not empty values}"></c:if>
                    <c:forEach items="${values }" var="value" varStatus="status">
                        <tr>
                            <td><input type="checkbox" name="code_" value="${value.items.code_}"></td>
                            <td>${ status.index + 1}</td>
                            <td>${value.items.name_}</td>
                            <c:if test="${empty value.items.mobile_}">
                           		<td>${value.items.code_}</td>
                            </c:if>
                            <c:if test="${!empty value.items.mobile_}">
                           		<td>${value.items.mobile_}</td>
                            </c:if>
                            <td>是</td>
                            <td>是</td>
                            <td>600</td>
                            <td><%-- <fmt:formatDate value="" type="both" pattern="yyyy-MM-dd HH:mm:ss" /> --%>${value.items.createTime_ }</td>
                            <c:if test="${empty value.items.overMoney_}">
                           		<td>0</td>
                            </c:if>
                            <c:if test="${!empty value.items.overMoney_}">
                           		<td>${value.items.overMoney_}</td>
                            </c:if>
                            <td>500</td>
                            <td>200</td>
                            <c:if test="${empty value.items.userJifen_}">
                           		<td>0</td>
                            </c:if>
                            <c:if test="${!empty value.items.userJifen_}">
                           		<td>${value.items.overMoney_}</td>
                            </c:if>
                            <td>
                            	<c:if test="${value.items.enabled_ == '1'}">启用</c:if>
                            	<c:if test="${value.items.enabled_ == '0'}">未启用</c:if>
                            </td>
                            <td>2222</td>
                            <td>A1</td>
                            <td>3</td>
                            <td><a href="FrmAdminExclusiveUser.detailMenu?id_=${value.items.id_}" class="btn_style">查看用户信息</a></td>
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
    var check_val = [];
    for(k in obj){
        if(obj[k].checked)
            check_val.push(obj[k].value);
    }
    alert(check_val);
    var checkList = check_val.join("-");;
    alert(checkList);
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