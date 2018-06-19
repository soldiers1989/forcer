<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
<head> 
<title>意见反馈</title> 
</head> 
<body> 
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20">
	    <span class="min-col f16">意见反馈</span>
	</div>
	 <form action=""  id="subForm">
	        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	            <div class="fl leftSide">
	              
		反馈时间：<input type="text" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="unlockDate_" id="unlockDate_"  placeholder="起始日期" value="${unlockDate_ }" class="mr_0"/><font> -至- </font>
	    <input type="text" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="endDate_" id="endDate_"  placeholder="终止日期" value="${endDate_ }"/>
	
		<input type="text" value="${username }" name="username" placeholder="请输入反馈人姓名">
		<input type="text" value="${userphone }" name="userphone" placeholder="请输入反馈人手机号">
		<input type="text" value="${view_ }" name="view_" placeholder="请输入反馈内容">

	            </div>
	            <div class="fr rightSide">
	            <input type="submit" value="查询" id="sub" class="btn_style mb_0">
	            </div>
	        </div>
	    </form> 
	   <form action="" id="subForm">
	   <div role="grid" class="pt_10">
        <div class="table">
		<table class="tbl " >
			<tr>
				<td class="t-head">序号</td>
				<td class="t-head">反馈人姓名</td>
				<td class="t-head">反馈人电话</td>
				<td class="t-head">反馈时间</td>
				<td class="t-head">反馈内容</td>
				<td class="t-head">操作</td>
			</tr>
			<c:forEach items="${values }" var="val" varStatus="status">
				<tr>
					<td>${status.index+1 }</td>
					<td>${val.items.username }</td>
					<td>${val.items.userphone }</td>
					<td>${val.items.submit_time }</td>
					<td>${val.items.view_ }</td>
					<td>
						<a href="FrmFeedback.details?id_=${val.items.id_ }" class="btn_style">查看</a> &nbsp;&nbsp;&nbsp;
						<a href="FrmFeedback.addreply?id_=${val.items.id_}" class="btn_style">回复</a>
					</td>
				</tr>
			</c:forEach>
		</table>	
		</div>
		</div>	
	</form>
	<c:if test="${pages.count >= 1}">
		<div class="foot-page">
			<a href="javascript:page(1);" class='page-index Shouw'>首页</a> <a
				href="javascript:page(${pages.prior});">上一页</a> <a
				href="javascript:page(${pages.next});">下一页</a> <a
				href="javascript:page(${pages.count});" class="page-last Shouw">尾页</a>
			条数：${pages.recordCount}, 页数：${pages.current} / ${pages.count}
		</div>
	</c:if>





	<%-- <h6>意见反馈</h6>
	<form action=""  id="subForm">
	<p>
		反馈时间：<input type="text" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="unlockDate_" id="unlockDate_"  placeholder="起始日期" value="${unlockDate_ }"/><font> -至- </font>
	    <input type="text" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="endDate_" id="endDate_"  placeholder="终止日期" value="${endDate_ }"/>
	</p>
	<p>
		<input type="text" value="${username }" name="username" placeholder="请输入反馈人姓名">
		<input type="text" value="${userphone }" name="userphone" placeholder="请输入反馈人手机号">
		<input type="text" value="${view_ }" name="view_" placeholder="请输入反馈内容">
	</p>
		<input type="submit" value="查询" id="sub">
	</form>
	<form action="" id="subForm">
		<table border="1px;">
			<tr>
				<td>序号</td>
				<td>反馈人姓名</td>
				<td>反馈人电话</td>
				<td>反馈时间</td>
				<td>反馈内容</td>
				<td>操作</td>
			</tr>
			<c:forEach items="${values }" var="val" varStatus="status">
				<tr>
					<td>${status.index+1 }</td>
					<td>${val.items.username }</td>
					<td>${val.items.userphone }</td>
					<td>${val.items.submit_time }</td>
					<td>${val.items.view_ }</td>
					<td>
						<a href="FrmFeedback.details?id_=${val.items.id_ }">查看</a> &nbsp;&nbsp;&nbsp;
						<a href="FrmFeedback.addreply?id_=${val.items.id_}">回复</a>
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