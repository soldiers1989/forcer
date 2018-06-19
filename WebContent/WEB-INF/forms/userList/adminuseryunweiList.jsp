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
        <span class="min-col f16">绑定登录运维端</span>
    </div>
    <form action="FrmAdminUserList.getUser" method="post" id="subForm">
        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
            <div class="fl leftSide">
                <div>
                    <span class="back_hint6">按用户手机号</span><input type="text" name="mobile_">
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
                        <th class="t-head tc">微信注册手机号</th>
                        <th class="t-head tc">微信昵称</th>
                        <th class="t-head tc">最后登录时间</th>
                        <th class="t-head tc">后台用户</th>
                        <th class="t-head tc">后台姓名</th>
                        <th class="t-head tc">所属角色</th>
                        <th class="t-head tc">绑定后台与微信关系</th>
                        <th class="t-head tc">操作</th>
                    </tr>
                </tbody>
                <tbody class="t-body tc">
                  	<c:if test="${empty values}"><div  class="no_content"><img src="../../img/zwsj.png" style="width: 4rem;"></div></c:if>
                   	<c:if test="${not empty values}"></c:if>
                    <c:forEach items="${values }" var="value" varStatus="status">
                        <tr>
                            <td>${ status.index + 1}</td>
                            <td>${value.items.mobile_}</td>
                            <td>${value.items.name_}</td>
                            <td>${value.items.loginTime_}</td>
                            <c:if test="${empty value.items.name_}">
                           		<td>/</td>
                            </c:if>
                            <c:if test="${!empty value.items.name_}">
                           		<td>${value.items.name_}</td>
                            </c:if>
                            <td>${value.items.mobile_}</td>
                           	<td>${value.items.uName_}</td>
                            <c:if test="${value.items.binding eq 2}">
                           		<td>已绑定</td>
                            </c:if>
                            <c:if test="${value.items.binding ne 2}">
                           		<td>未绑定</td>
                            </c:if>
                            <td><a onclick="bd('${value.items.code_ }')" class="btn_style mr_10">绑定</a><a onclick="qxbd('${value.items.code_ }')" class="btn_style">取消绑定</a></td>
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

function bd(code_){
    $.ajax({
		url : 'FrmAdminUserList.upBinding',
		dataType : 'json',
		type : 'post',
		data : { 
			"code_" : code_,
			"type_" : "bd"
		},
		cache : false,
		success : function(data) {
			if(data == true){
				alert("绑定登录用户端用户成功！");
				window.location.href='FrmAdminUserList';
			}else{
				alert("绑定登录用户端用户失败!")
			}
		}
		});
}
function qxbd(code_){
    $.ajax({
		url : 'FrmAdminUserList.upBinding',
		dataType : 'json',
		type : 'post',
		data : { 
			"code_" : code_,
			"type_" : "qxbd"
		},
		cache : false,
		success : function(data) {
			if(data == true){
				alert("取消绑定登录用户端用户成功！");
				window.location.href='FrmAdminUserList';
			}else{
				alert("取消绑定登录用户端用户失败!")
			}
		}
		});
}
</script>
</html>