<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="head1.jspf"%>

<%@include file="head2.jspf" %> 
<!--中间内容-->
<div class="mid-box fl" id="mid-box">
<div class="top pl_20 pr_20">
   <span class="min-col f16">${title}</span>
</div>
	<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	    <div class="fl leftSide">
	    	 <a href="FrmAppUserManagerData" class="min-col" style="padding: 4px 10px; background: #48b2bd; color: #fff; border-radius: 3px;">返回</a>
	    </div>
	</div>
	<div class="tab-record cf ml_20" id="tab">
	<ul class="tabul">
		<li class="bor"><a href="javascript:void(0);" class="curr-txt">住院记录</a><i class="ic"></i>
			<ul class="option">
				<li><a href="FrmAppUserManagerData.recordMain?code_=22111&cardNo_=${cardNo_}">住院病案首页</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=221110&cardNo_=${cardNo_}">住院影像记录</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=221111&cardNo_=${cardNo_}">住院血清学检查记录</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22112&cardNo_=${cardNo_}">住院医嘱明细</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22114&cardNo_=${cardNo_}">住院手术记录</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22115&cardNo_=${cardNo_}">住院转科记录</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22116&cardNo_=${cardNo_}">住院放射治疗记录</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22117&cardNo_=${cardNo_}">住院输血记录</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22118&cardNo_=${cardNo_}">住院实验室检查记录</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22118&cardNo_=${cardNo_}">住院实验室检查明细记录</a></li>
			</ul>
		</li>
		<li class="bor"><a href="javascript:void(0);" class="curr-txt">门诊记录</a><i class="ic"></i>
			<ul class="option">
				<li><a href="FrmAppUserManagerData.recordMain?code_=22121&cardNo_=${cardNo_}">门诊病案首页</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22122&cardNo_=${cardNo_}">门诊处方</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22123&cardNo_=${cardNo_}">门诊输血记录</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22124&cardNo_=${cardNo_}">门诊手术记录</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22125&cardNo_=${cardNo_}">门诊实验室检查主记录</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22126&cardNo_=${cardNo_}">门诊实验室检查明细记录</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22127&cardNo_=${cardNo_}">门诊放射治疗记录</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22128&cardNo_=${cardNo_}">门诊影像记录</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22129&cardNo_=${cardNo_}">门诊血清学检查记录</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=307&cardNo_=${cardNo_}">门诊-费用</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=305&cardNo_=${cardNo_}">门诊-化验</a></li>
			</ul>
		</li>
		<li class="bor"><a href="javascript:void(0);" class="curr-txt">体检记录</a><i class="ic"></i>
			<ul class="option">
				<li><a href="FrmAppUserManagerData.recordMain?code_=22131&cardNo_=${cardNo_}">体检登记及评价</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22132&cardNo_=${cardNo_}">体检实验室检查主记录</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22133&cardNo_=${cardNo_}">体检实验室检查明细记录</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22134&cardNo_=${cardNo_}">体检影像记录</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22125&cardNo_=${cardNo_}">体检血清学检查记录</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=2225&cardNo_=${cardNo_}">老年人健康体检记录</a></li>
			</ul>
		</li>
		<li class="bor"><a href="javascript:void(0);" class="curr-txt">其他记录</a><i class="ic"></i>
			<ul class="option">
				<li><a href="FrmAppUserManagerData.record?code_=2214&cardNo_=${cardNo_}">会诊记录推送</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=2215&cardNo_=${cardNo_}">转诊记录</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=2216&cardNo_=${cardNo_}">居民死亡报告数据</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22171&cardNo_=${cardNo_}">分娩记录</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22172&cardNo_=${cardNo_}">新生儿情况</a></li>
			</ul>
		</li>
		<li class="bor"><a href="javascript:void(0);" class="curr-txt">公共卫生记录</a><i class="ic"></i>
			<ul class="option">
				<li><a href="FrmAppUserManagerData.record?code_=22211&cardNo_=${cardNo_}">健康档案--个人基本信息</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22212&cardNo_=${cardNo_}">健康档案--家庭基本信息</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22221&cardNo_=${cardNo_}">高血压随访记录</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22222&cardNo_=${cardNo_}">糖尿病随访记录</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22223&cardNo_=${cardNo_}">用药情况</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22231&cardNo_=${cardNo_}">产前首检记录</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22232&cardNo_=${cardNo_}">产前检查记录</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22233&cardNo_=${cardNo_}">产后访视记录</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22234&cardNo_=${cardNo_}">产后42天访视记录</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22241&cardNo_=${cardNo_}">儿童基本信息</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22243&cardNo_=${cardNo_}">儿童健康检查记录</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=2225&cardNo_=${cardNo_}">老年人健康体检记录</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22261&cardNo_=${cardNo_}">接种卡信息推</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22262&cardNo_=${cardNo_}">接种记录</a></li>
			</ul>
		</li>
		<li class="bor"><a href="javascript:void(0);" class="curr-txt">新农合</a><i class="ic"></i>
			<ul class="option">
				<li><a href="FrmAppUserManagerData.record?code_=22311&cardNo_=${cardNo_}">新农合门诊结算数据</a></li>
				<li><a href="FrmAppUserManagerData.record?code_=22321&cardNo_=${cardNo_}">新农合住院结算数据</a></li>
			</ul>
		</li>
	</ul>
	</div>
	<c:if test="${empty titleMap}">
		<div class="ml_20 mt_20 pt_20 tc">无记录</div>
	</c:if>
	<c:if test="${!empty titleMap}">
		<div class="table mt_20">
			<table class="tb ui-bd-gray tbl" style="width: 100%;" id="grid-bx">
				<tr>
					 <c:forEach items="${titleMap}" var="map">
						<td>${map.value}</td>
					 </c:forEach>
					 <td>详情</td>
				</tr> 
				<c:forEach items="${valueList}" var="rec">
					<tr>
						<c:forEach items="${rec.items}" var="map">
							<c:if test="${map.key != 'UID_'}">
								<td>${map.value}</td>
							</c:if>
						</c:forEach>
						<td><a class="button" href="${url_ }?code_=${rec.items.table_ }&cardNo_=${rec.items.cardNo_ }&UID_=${rec.items.UID_ }">详情</a></td>
					</tr> 
				</c:forEach>
			</table>
		</div>
	</c:if>
</div>

<script>

	$(function(){
		$("#grid-bx table.tbl-cord tr:even").addClass("grid-box-bg");
		$("#tab>ul>li").each(function(){
			$(this).on("click",function(){
				$("#tab>ul>li").removeClass("active");
				$(this).addClass("active");
				$(".option").hide();
				$(this).find(".option").toggle();
				return false;
			})
		});
		$(".option").find("li>a").on("click",function(){
			window.location.href = $(this).attr("href");
		})
		
		$(document).on("click",function(){
			$(this).find(".option").hide();
		}) 
	});
</script>
<%@include file="footer.jspf"%>