<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../ui/head1.jspf"%>
    <%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>区域详情</title>
<style type="text/css">
	.group-box p{
		margin-bottom:10px;
	}
</style>
</head>
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">区域详情</span>
    </div>
     <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	    <div class="fl leftSide">
	    	 <a href="javascript:window.history.go(-1);" class="min-col"
			style="padding: 4px 10px; background: #48b2bd; color: #fff; border-radius: 3px;">返回</a>
	    </div>
	    <div class="fr rightSide">
	    </div>
	</div>	
	<div class="group-box tc mt_20">
	<p><label>区域名称：</label>${area.items.province_ }${area.items.city_ }${area.items.area_ }</p>
	<p><label>区域编码：</label>${area.items.areaNum_ }</p>
	<p><label>区域类型：</label>${area.items.areaType_ }</p>
	<p><label>备注：</label>${area.items.remark_ }</p>
	<!-- <p><a href="FrmArea">返回</a></p> -->
	</div>
</div>
</body>
</html>