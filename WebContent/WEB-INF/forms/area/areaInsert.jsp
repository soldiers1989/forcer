<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="../ui/head1.jspf"%>
    <%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加区域信息</title>
</head>
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">添加区域信息</span>
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
		<form action="FrmArea.areaInsert">
		<p><input type="hidden" name="in" value="in"></p>
		<p><label>省：</label><input type="text" name="province_"   id="province_"></p>
		<p><label>市：</label><input type="text" name="city_"   id="city_"></p>
		<p><label>区：</label><input type="text" name="area_"   id="area_"></p>
		<p><label>区域编码：</label><input type="text" name="areaNum_"   id="areaNum_"></p>
		<p><label>区域类型：</label><input type="text" name="areaType_"   id="areaType_"></p>
		<p><label>备注：</label><input type="text" name="remark_"  id="remark_"></p>
		<p><input type="submit" value="提交"></p>
	</form>
	</div>
</div>
</body>
</html>