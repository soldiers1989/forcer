<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${cdn}/layui/layui.js"></script>
<title>财务管理</title>
<style>
table {
	width: 80%;
	text-align: left;
	font-size: 13px;
}

table tr td {
	line-height: 40px;
	padding: .1rem;
}

table tr td:first-child {
	text-align: right;
	width: 60%;
}
.box{
	width:80%;
	margin:auto;
}
.box-text{
	width:240px;
	height:100px;
	border:1px solid gray;
	font-size:17px;
	margin:10px;
	text-align:center;
	line-height:100px;
}
.box-money{
	width:260px;
	height:100px;
	background-color:#f5f5f5;
	font-size:17px;
	margin:10px;
	text-align:center;
	line-height:100px;
	white-space: nowrap;　
	 overflow:-webkit-marquee;
	 -webkit-marquee-direction:left;
	 　-webkit-marquee-style:scroll;
	 　-webkit-marquee-repetition:1;
	 -webkit-marquee-speed:normal;　　/* 文字滚动速度 可选值为slow | normal | fast */
　

}

.content{
height:auto;
}
.box-left{
	width:50%;
	float:left;
	justify-content:right;
}
.box-right {
	width:50%;
	float:right;justify-content:left;
}
.flexLayout{
	display:flex;
}
.clearfloat:after{display:block;clear:both;content:"";visibility:hidden;height:0} 
.clearfloat{zoom:1} 

marquee {
scrollamount:1 ;
margin:0 10px;"
}
</style>
<script type="text/javascript">
	<script type="text/javascript">
	layui.use('laydate', function() {
		var laydate = layui.laydate;
	});
</script>
</head>
<body style="background-color:#ffffff;">

	<div class="mid-box fl" id="mid-box">
		<div class="top pl_20 pr_20">
			<span class="min-col f16">财务总览</span>
		</div>
		<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
			<!-- <div class="fl leftSide">
				<a href="javascript:window.history.go(-1);" class="btn_style">返回</a>
			</div>
			<div class="fr rightSide"></div> -->
		</div>
		<div class="box clearfloat" >
			
			<div class=" flexLayout " >
				<div class="box-left flexLayout" style="" >
					<div class="box-text">当前一启享微信账户总余额</div>
					<div class="box-money marquee"><span class="timer count-number"  data-from='0' data-to="${userMoney}" data-speed="1000">${userMoney}</span></div>
				</div>
				<div class="box-right flexLayout" style="justify-content:left;">
					<div class="box-text">上月累计充值金额</div>
					<div class="box-money marquee"><span class="timer count-number"  data-from='0' data-to="${rechargeMoney}" data-speed="1000">${rechargeMoney}</span></div>
				</div>
			</div>
			
			<div class=" flexLayout" >
				<div class="box-left flexLayout"  >
					<div class="box-text">用户当前押金合计</div>
					<div class="box-money"><span class="timer count-number"  data-from='0' data-to="${yajin}" data-speed="1000">${yajin}</span></div>
				</div>
				<div class="box-right flexLayout">
					<div class="box-text">上月用户累计提现金额</div>
					<div class="box-money"><span class="timer count-number"  data-from='0' data-to="${withdrawMoney}" data-speed="1000">${withdrawMoney}</span></div>
				</div>
			</div>
			
			<div class=" flexLayout" >
				<div class="box-left flexLayout"  >
					<div class="box-text">用户当前正数余额合计</div>
					<div class="box-money"><span class="timer count-number"  data-from='0' data-to="${zs}" data-speed="1000">${zs}</span></div>
				</div>
				<div class="box-right flexLayout">
					<div class="box-text">上月平台财务收益提现累计金额</div>
					<div class="box-money"><span class="timer count-number"  data-from='0' data-to="" data-speed="1000"></span></div>
				</div>
			</div>
			
			<div class=" flexLayout" >
				<div class="box-left flexLayout"  >
					<div class="box-text">用户当前负数余额合计</div>
					<div class="box-money"><span class="timer count-number"  data-from='0' data-to="${fs}" data-speed="1000"></span></div>
				</div>
				<div class="box-right flexLayout">
					<div class="box-text">上月平台收益合计</div>
					<div class="box-money"><span class="timer count-number"  data-from='0' data-to="" data-speed="1000"></span></div>
				</div>
			</div>
		</div>

		<%-- 

		<table>
			<tr>
				<td>当前一启享微信账户总余额：${userMoney}</td>
				<td>上月累计充值金额：${rechargeMoney}</td>
			</tr>
			<tr>
				<td>用户当前押金合计：${yajin}</td>
				<td>上月用户累计提现金额：${withdrawMoney}</td>
			</tr>
			<tr>
				<td>用户当前正数余额合计：${zs}</td>
				<td>上月平台财务收益提现累计金额：</td>
			</tr>
			<tr>
				<td>用户当前负数余额合计：${fs}</td>
				<td>上月平台收益合计：</td>
			</tr>
		</table> --%>
	</div>
	<script type="text/javascript">
    $.fn.countTo = function(options) {
        options = options || {};
        return $(this).each(function() {
            var settings = $.extend({}, $.fn.countTo.defaults, {
                from: $(this).data('from'),
                to: $(this).data('to'),
                speed: $(this).data('speed'),
                refreshInterval: $(this).data('refresh-interval'),
                decimals: $(this).data('decimals')
            }, options);
            var loops = Math.ceil(settings.speed / settings.refreshInterval),
                increment = (settings.to - settings.from) / loops;
            var self = this,
                $self = $(this),
                loopCount = 0,
                value = settings.from,
                data = $self.data('countTo') || {};
            $self.data('countTo', data);
            if(data.interval) {
                clearInterval(data.interval);
            }
            data.interval = setInterval(updateTimer, settings.refreshInterval);
            render(value);
            function updateTimer() {
                value += increment;
                loopCount++;
                render(value);
                if(typeof(settings.onUpdate) == 'function') {
                    settings.onUpdate.call(self, value);
                }
                if(loopCount >= loops) {
                    $self.removeData('countTo');
                    clearInterval(data.interval);
                    value = settings.to;
                    if(typeof(settings.onComplete) == 'function') {
                        settings.onComplete.call(self, value);
                    }
                }
            }
            function render(value) {
                var formattedValue = settings.formatter.call(self, value, settings);
                $self.html(formattedValue);
            }
        });
    };

    $.fn.countTo.defaults = {
        from: 0, // the number the element should start at
        to: 0, // the number the element should end at
        speed: 1000, // how long it should take to count between the target numbers
        refreshInterval: 100, // how often the element should be updated
        decimals: 0, // the number of decimal places to show
        formatter: formatter, // handler for formatting the value before rendering
        onUpdate: null, // callback method for every time the element is updated
        onComplete: null // callback method for when the element finishes updating
    };

    function formatter(value, settings) {
        return value.toFixed(settings.decimals);
    }

    $('.count-number').data('countToOptions', {
        formatter: function(value, options) {
            return value.toFixed(options.decimals).replace(/\B(?=(?:\d{3})+(?!\d))/g, ',');
        }
    });

    $('.timer').each(count);

    function count(options) {
        var $this = $(this);
        options = $.extend({}, options || {}, $this.data('countToOptions') || {});
        $this.countTo(options);
    }
</script>
</body>
</html>
