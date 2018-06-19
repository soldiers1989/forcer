<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript"
	src="${cdn }/admin/js/jquery-1.9.1.min.js"></script>
<title>一启享</title>
<script type="text/javascript">
	function check() {
		var reg = /^([\d]+|([\d]+[.]?|[\d]+[.]?[\d]+))$/;
		var nowLoss_ = $("#nowLoss_").val();
		if (!reg.test(nowLoss_)) {
			alert("折损率格式有误！！");
			return false;
		}
	}
</script>
</head>

<body>
	<div class="mid-box fl" id="mid-box">
		<form action="FrmYunWeiBill.modifySale" method="post"
			onsubmit="return check();">
			<input type="hidden" value="up" name="up"> <input
				type="hidden" name="operateId_" value="${sale.items.operateId_  }">
			<div class="top pl_20 pr_20">
				<span class="min-col f16">修改折旧率</span>
			</div>
			<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
				<div class="fl leftSide">
					<a href="javascript:window.history.go(-1);"
						class="min-col btn_style">返回</a>
				</div>
				<div class="fr rightSide"></div>
			</div>
			<div class="easyui-panel tc mt_20 font_16">

				<div class="group-box" name="null" id="component1" visible="false">
					<label>当前商品名称：</label>${sale.items.proName_ }
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label>主电子条码：</label>${sale.items.zhuCode_ }
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label>主电子条码：</label>${sale.items.zhuCode_ }
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label>当前折旧率：</label>${sale.items.nowLoss_ }
				</div>
				<div class="group-box" name="null" id="component1" visible="false">
					<label>变更折旧率：</label><input type="text" name="nowLoss_"
						id="nowLoss_" placeholder="请输入变更后的折旧率">
				</div>
				<div class="group-box" id="component4">
					<input type="submit" value="提交" style="margin-top: 10px;">
				</div>

			</div>
		</form>
	</div>

</body>
</html>