<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一启享</title>
<style>
	.btn_style{
		width:80px;
		height:40px;
	}
</style>
</head>
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">打印补货二维码</span>
    </div>
     <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	    <div class="fl leftSide">
	    	 <a href="javascript:window.history.go(-1);" class="min-col"
			style="padding: 4px 10px; background: #48b2bd; color: #fff; border-radius: 3px;">返回</a>
	    </div>
	    <div class="fr rightSide">
	    </div>
	</div>	
	<div class="easyui-panel tc mt_20">
			<div class="box_qrCode">
				<div class="boxAddress_">包裹存放柜的地址：${name.items.boxAddress_ }${name.items.boxName_ }</div>
				<div class=" flexLayout mt_20" >
					<div class="boxProcess">包裹存放柜流程：</div>
					<div class="er_process ml_20">
						<div class="step">
							<p class="mb_10">1.将下方包裹的二维码拿到柜子前，进行扫码，</p>
							<p>备注:在中控屏幕下方有二维码扫描器，存放前一定</p>
							<p>要先扫描二维码，以便触发订单</p>
						</div>
						<div class="step">
							<p class="mb_10" >2.启享智能柜将为您打开一个箱门，并有提示。</p>
							<p>备注:请不要放置在扫描二维码前就打开的箱门内，</p>
							<p>如果发现空箱，但未关门的情况，请帮忙顺手关门，</p>
							<p>以便释放空箱待用状态，谢谢您的配合。</p>
						</div>
						<div class="step">
							<p class="mb_10">3.请放入包裹，尽量帮忙陈列好，并关上门。</p>
							<p>备注:系统将在关门瞬间判断包裹里的物品信息，</p>
							<p>并提示您是否存放完毕。</p>
						</div>
					</div>
				</div>
				<div class="code">
					<img alt=""  src="FrmOrderInterface.createQR?orderId_=${orderId_}">
				</div>
				<div style="text-align:center"><input type="button" value="打印" class="btn_style"></div>
			</div>
			
			
			
			



	<%-- <h2>打印补货二维码</h2>
	
	<div style="border: 1px;">
		包裹存放柜的地址:${name.items.boxAddress_ }${name.items.boxName_ }
	</div>
	<div style="border: 1px;">
		包裹存放柜流程
	</div>
	<div style="border: 1px;">
		<p>1.将下方包裹的二维码拿到柜子前，进行扫码，</p>
		<p>备注:在中控屏幕下方有二维码扫描器，存放前一定</p>
		<p>要先扫描二维码，以便触发订单</p>
	</div>
	<div style="border: 1px;">
		<p>2.启享智能柜将为您打开一个箱门，并有提示。</p>
		<p>备注:请不要放置在扫描二维码前就打开的箱门内，</p>
		<p>如果发现空箱，但未关门的情况，请帮忙顺手关门，</p>
		<p>以便释放空箱待用状态，谢谢您的配合。</p>
	</div>
	<div style="border: 1px;">
		<p>3.请放入包裹，尽量帮忙陈列好，并关上门。</p>
		<p>备注:系统将在关门瞬间判断包裹里的物品信息，</p>
		<p>并提示您是否存放完毕。</p>
	</div>
	<div>
	<img alt=""  src="FrmOrderInterface.createQR?orderId_=${orderId_}">
	</div> --%>
						
</body>
</html>