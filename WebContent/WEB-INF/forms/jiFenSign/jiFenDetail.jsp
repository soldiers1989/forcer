<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="../ui/head1.jspf"%>
	<%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>积分等级查看</title>
</head>
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">积分等级查看</span>
    </div>
     <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	    <div class="fl leftSide">
	    <!-- <a href="FrmJifenSign">返回</a> -->
	    	 <a href="javascript:window.history.go(-1);" class="min-col"
			style="padding: 4px 10px; background: #48b2bd; color: #fff; border-radius: 3px;">返回</a>
	    </div>
	    <div class="fr rightSide">
	    </div>
	</div>
	<div class="easyui-panel tc mt_20">
		<form action="FrmJifenSign.jiFenUpdate" method="post" onsubmit="return check();">
		<input type="hidden" value="up" name="up">
		<input type="hidden" value="${jifen.items.UID_}" name="UID_">
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">积分等级：</label>${jifen.items.grade_ }
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">积分值：</label>${jifen.items.num_ }
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">积分说明：</label>${jifen.items.remark_ }
		</div>
	</form>
	</div>
</div>


	<%-- <div>
		<p>积分等级:<label>${jifen.items.grade_ }</label></p>
		<p>积分值:<label>${jifen.items.num_ }</label></p>
		<p>积分说明:<label>${jifen.items.remark_ }</label></p>
		<p><a href="FrmJifenSign">返回</a></p>
	</div> --%>
</body>
</html>