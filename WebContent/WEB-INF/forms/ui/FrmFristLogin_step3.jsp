<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="head1.jspf"%>
<div class="bartop min-bg" id="header">
	<div class="wrap">
		<h1 class="title">百姓健康信息服务平台</h1>
		<div class="head-men">
			<a href="javascript:;"><i class="icon"><img
					src="${cdn }/admin/images/icon/icon_head.png" width="14"
					height="14"> </i></a> <a href="javascript:;" class="name">${jspFile.handle.handle.params.UserCode }</a>|
			<a href="javascript:Loginexit();">退出</a>
		</div>
	</div>
</div>

<div class="forget-box">
	<form>
		<h3 class="min-col f16 mb_10">修改密码</h3>
		<div class="tip">
			<ul>
				<li class="curr"><i class="one icon"></i>
					<p>登记手机号</p></li>
				<li class="curr"><i class="two icon"></i>
					<p>修改密码</p></li>
				<li class="curr"><i class="over icon"></i>
					<p>完成</p></li>
			</ul>
		</div>
		<div class="mid-keytext" id="test" style="">
			<div class="pt_20 pb_20 mid-keytext" id="compty" style="display: block;">
				<div class="tc pt_20 pb_20 mt_20 mb_20">
					<img src="${cdn}/admin/images/icon/icon_big_over.png" style="display:inline-block;vertical-align: middle;" class="mr_10">
					尊敬的用户:<br>密码重置成功,请使用新的密码<a href="FrmAdminLogin" class="min-col"> 登录</a>
				</div>
			</div>
			
		</div>
	</form>
</div>
</body>
</html>