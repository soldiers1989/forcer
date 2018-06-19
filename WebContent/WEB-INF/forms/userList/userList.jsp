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
        <span class="min-col f16">按租赁订单查询关联单</span>
    </div>
    <form action="FrmgetUser.getUser" method="post" id="subForm">
        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
            <div class="fl leftSide">
                <div>
                    <span class="back_hint6">注册时间范围</span>
                  <!--   <input class="Wdate mr_10" type="text" onClick="WdatePicker()" name="startTime_">
                    ----------
                    <input class="Wdate ml_10" type="text" onClick="WdatePicker()" name="endTime_">
                     -->
                    <input type="text"   onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="unlockDate_" id="unlockDate_"  placeholder="起始日期" value="${unlockDate_ }"/><font> -至- </font>
                    <input type="text"   onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="endDate_" id="endDate_"  placeholder="终止日期" value="${endDate_ }"/>
                    <span class="back_hint4">手机号</span><input type="text" name="mobile_" value="${mobile_ }">
                 	<!--    <span class="back_hint">邀请码</span><input type="text">
                    <span class="mr_10">专属客服</span><input type="text"> -->
                    <span class="back_hint4">账户状态</span>
                    <select name="enabled_">
                    <option value="2" <c:if test="${enabled_ eq '2' || enabled_ eq null }">selected="selected"</c:if>>全部</option>
                   	<option value="0" <c:if test="${enabled_ eq '0' }">selected="selected"</c:if>>未启用</option>
                   	<option value="1" <c:if test="${enabled_ eq '1' }">selected="selected"</c:if>>启用</option>
                    </select>
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
                        <th class="t-head tc">等级</th>
                        <th class="t-head tc">账户状态</th>
                        <th class="t-head tc">邀请码</th>
                        <th class="t-head tc">专属客服</th>
                        <th class="t-head tc">邀请客户数</th>
                        <th class="t-head tc">操作</th>
                    </tr>
                </tbody>
                <tbody class="t-body tc">
                  	<c:if test="${empty values}"><div  class="no_content"><img src="../../img/zwsj.png" style="width: 4rem;"></div></c:if>
                   	<c:if test="${not empty values}">
	                    <c:forEach items="${values }" var="value" varStatus="status">
	                        <tr>
	                            <td><input type="checkbox" name="code_" value="${value.items.code_}"></td>
	                            <td>${ status.index + 1}</td>
	                            <td>${value.items.name_}</td>
	                            <td>${value.items.mobile_}</td>
	                            <td>是</td>
	                            <td>是</td>
	                            <td>600</td>
	                            <td>${value.items.createTime_ }</td>
	                            <td>${value.items.overMoney_}</td>
	                            <td>500</td>
	                            <td>200</td>
	                            <td>${value.items.userJifen_}</td>
	                            <td>V1</td>
	                            <td>
	                            	<c:if test="${value.items.enabled_ == '1'}">启用</c:if>
	                            	<c:if test="${value.items.enabled_ == '0'}">未启用</c:if>
	                            </td>
	                            <td>2222</td>
	                            <td>A1</td>
	                            <td>3</td>
	                            <td><a href="FrmAdminExclusiveUser.detailMenu?id_=${value.items.id_}" class="btn_style">查看客户信息</a></td>
	                        </tr>
	                    </c:forEach>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
    <div class="flayout_sb">
    <div class="bdkf">
	    <span>勾选用户绑定客服：</span>
	    <select id="kefu">
		    <option value="请选择后台客服">请选择后台客服</option>
		    <c:forEach items="${manager }" var="value" varStatus="status">
			    <option value="${value.items.code_}">${value.items.name_}</option>
		    </c:forEach>
	    </select>
	    <input type="button" value="确定" onclick="show()" class="btn_bdkf">
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
</div>

<%-- <form action="FrmgetUser.getUser" method="post" >
注册时间范围<input class="Wdate" type="text" onClick="WdatePicker()" name="startTime_">--<input class="Wdate" type="text" onClick="WdatePicker()" name="endTime_"> 
手机号<input type="text" name="mobile_">邀请码<input type="text">专属客服<input type="text">
账户状态<select  name="enabled_">
<option >启用</option>
<option>禁用</option>
</select>
<input type="submit" value="查询">
<a href="FrmExcel?service=SvrgetUserList&amp;exportKey=SvrgetUserList&amp;templateId=UserList"><input type="button" value="查询结果导出"></a>
</form>
 <form action="" id="subForm">
    <table border="1">
    <tr >
        <th></th>
        <th>序号</th>
        <th>微信昵称</th>
        <th>手机号</th>
        <th>活体认证</th>
        <th>银行卡认证</th>
        <th>芝麻认证分</th>
        <th>注册时间</th>
        <th>账户余额</th>
        <th>押金</th>
        <th>在租订单数</th>
        <th>积分</th>
        <th>账户状态</th>
        <th>邀请码</th>
        <th>专属客服</th>
        <th>邀请客户数</th>
        <th>操作</th>
    </tr>
    <c:if test="${empty values}"><div  class="no_content"><img src="../../img/zwsj.png" style="width: 4rem;"></div></c:if>
    <c:if test="${not empty values}"></c:if>
    <c:forEach items="${values }" var="value" varStatus="status">
    <tr>
        <td><input type="checkbox"></td>
        <td>${ status.index + 1}</td>
        <td>${value.items.name_}</td>
        <td>${value.items.mobile_}</td>
        <td>是</td>
        <td>是</td>
        <td>600</td>
        <td>${value.items.createTime_}</td>
        <td>${value.items.overMoney_}</td>
        <td>500</td>
        <td>200</td>
        <td>${value.items.userJifen_}</td>
        <td><c:if test="${value.items.enabled_}">启用</c:if></td>
        <td>2222</td>
        <td>A1</td>
        <td>3</td>
        <td>变更客服 查看用户信息</td>
    </tr>
    </c:forEach>
</table>
 </form>
勾选用户绑定客服:<select>
                    <option>请选择后台客服</option>
                    <option>A1</option>
                     <option>A2</option>
                </select> 
                <input type="button" value="确认">
    <c:if test="${pages.count >= 1}">
            <div class="foot-page" align="center">
                <a href="javascript:page(1);" class='page-index Shouw'>首页</a> <a
                    href="javascript:page(${pages.prior});">上一页</a> <a
                    href="javascript:page(${pages.next});">下一页</a> <a
                    href="javascript:page(${pages.count});" class="page-last Shouw">尾页</a>
                <span>总条数：</span>${pages.recordCount}, 页数：${pages.current} / ${pages.count}
            </div>
    </c:if> --%>
    
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