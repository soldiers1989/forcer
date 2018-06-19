<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@include file="../ui/head1.jspf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<div class="flayout_r">
		<div class="user_info">
			<div class="flayout_sb">
				<div class="info-left ">
					<div class="list flexLayout" name="null" visible="false">
						<label>微信昵称：</label><input type="text" disabled="disabled"
							value="${values.items.name_}">
					</div>
					<div class="list flexLayout" name="null" visible="false">
						<label>手机号：</label><input type="text" disabled="disabled"
							value="${values.items.mobile_}">
					</div>
					<div class="list flexLayout mb_10" name="null" visible="false">
						<label>注册时间：</label>
						<fmt:formatDate value="${values.items.createTime_ }" type="both"
							pattern="yyyy-MM-dd HH:mm:ss" />
					</div>
					<div class="list flexLayout" name="null" visible="false">
						<label>积分：</label><input type="text" disabled="disabled"
							value="${values.items.userJifen_}">
					</div>
					<div class="list flexLayout" name="null" visible="false">
						<label>余额：</label>
							<c:if test="${empty value.items.overMoney_}">
								<input type="text" disabled="disabled" value="0">
							</c:if>
							<c:if test="${!empty value.items.overMoney_}">
								<input type="text" disabled="disabled" value="${values.items.overMoney_}">
							</c:if>
					</div>
					<div class="list flexLayout" name="null" visible="false">
						<label>账户状态：</label>
						<c:if test="${values.items.enabled_ == true}">
							<input type="text" disabled="disabled" value="启用">
						</c:if>
						<c:if test="${values.items.enabled_ != true}">
							<input type="text" disabled="disabled" value="禁用">
						</c:if>
					</div>
					<div class="list flexLayout" name="null" visible="false">
						<label>邀请码：</label><input type="text" disabled="disabled" value="">
					</div>
			</div>
				<div class="user-jfjl">
					<div class="txt">积分记录</div>
					<ul class="jfqd-ul">
						<%-- <li>
							<div class="flexLayout jfqd_detail">
								<div class="left">
									<div>签到</div>
									<div>2017-09-09</div>
								</div>
								<div class="right">
									<span >+10</span>
								</div>
							</div>
						</li>
						
						<li class="more">
								<img src="${cdn }/img/blue_down.png">
						</li>  --%>
						<c:if test="${empty jf}">
							此用户暂无积分记录信息！
						</c:if>
						<c:if test="${not empty jf}">
							<c:forEach items="${jf }" var="jf">
							<li>
								<div class="flexLayout jfqd_detail">
									<div class="left">
										<div>${jf.items.type_ }</div>
										<div>${jf.items.integral_ }-----${jf.items.createTime_ }</div>
									</div>
									<div class="right">
										<span >+10</span>
									</div>
								</div>
							</li>
								<%-- <li>
									${jf.items.type_ }<br/>
									${jf.items.integral_ }-----${jf.items.createTime_ }
								</li> --%>
							</c:forEach>
							<li class="more">
								<img src="${cdn }/img/blue_down.png">
							</li>
						</c:if>
					</ul>
				</div>
			</div>
			<div class="yjfk">
			
			<form action="FrmAdminExclusiveUser.addFeedBack">
			<input type="hidden" id="id_" value="${id_}">
			<input type="text" id="view_" name="view_"><input type="submit" value="添加" onclick="winclose()">
			</form>
			
				
				<div class="tt">意见反馈</div>
				<!-- <div class="yjfk_detail">
					<div>意见反馈内容意见反馈内容意见反馈内容意见反馈内容意见反馈内容意见反
					馈内容意见反馈内容意见反馈内容意见反馈内容意见反馈内容意见反馈内容意见反馈内容意见反馈内容意见反馈内容意见反馈内容</div>
					<div class="time">2018-09-09 11:11:11</div>
				</div> -->
				
				<ul class="yjfk_ul">
					<c:if test="${empty yjfk}">
						<div class="noneYJFK">此用户暂无意见反馈信息！</div>
					</c:if>
					<c:if test="${not empty yjfk}">
						<c:forEach items="${yjfk }" var="yjfk">
						<li>
							<div class="yjfk_detail">
								<div>${yjfk.items.view_}</div>
								<div class="time">${yjfk.items.submit_time}</div>
							</div>
						</li>
						
							<%-- <li>
								${yjfk.items.view_ }
								${yjfk.items.submit_time }
							</li> --%>
						</c:forEach>
					</c:if>
				</ul>
			</div>
			<div class="yjfk">
				<div class="tt">地址信息</div>
			
				<ul>
				<c:if test="${empty Adr}">
						<div class="noneYJFK">此用户暂无地址信息！</div>
					</c:if>
					<c:if test="${not empty Adr}">
						<c:forEach items="${Adr }" var="Adr">
					<li>
						<div class="dixx_detail">
							<div><input value="${Adr.items.name_ }"></div>
							<div><input value="${Adr.items.adr_ }"></div>
							<div><input value="${Adr.items.telpho_ }"></div>
							<div><input value="${Adr.items.exactadr_ }"></div>
							<div><input value="${Adr.items.remark_ }"></div>
							<div><input value="${Adr.items.adrState_ }"></div>
						</div>
					</li>
					</c:forEach>
					</c:if>
					<%-- <c:if test="${empty Adr}">
						<div class="noneYJFK">此用户暂无地址信息！</div>
					</c:if>
					<c:if test="${not empty Adr}">
						<c:forEach items="${Adr }" var="Adr">
							<li>
								${Adr.items.name_ }
								${Adr.items.adr_ }
								${Adr.items.telpho_ }
								${Adr.items.exactadr_ }
								${Adr.items.remark_ }
								${Adr.items.adrState_ }
							</li>
						</c:forEach>
					</c:if> --%>
				</ul>
	
		</div>
		</div>
		<div class="user_yhq">
			<div>
				<div class="yhj_img">优惠券</div>
				<!-- <div>优惠卷</div> -->
			</div>			
			<div class="tab"><span>未使用</span><span>已使用</span></div>
			<ul  class="yhj_ul">
			<!-- <li>
					<div class="per_yhj">
						<div class="flexLayout ">
							<div class="yhq_l yhqW det "><div class="yhqF">￥20</div><div>全平台可用</div></div>
							<div class="yhq_c yhqW det"><div class="yhqF">启享红包</div><div>有效期：2017.09.09-2019:09:09</div></div>
							<div class="yhq_r yhqF">未使用</div>
						</div>
						<div class="mark">此红包</div>
					</div>
				</li> -->
				<c:if test="${empty yhj}">
					此用户暂无优惠卷信息！
				</c:if>
				<c:if test="${not empty yhj}">
					<c:forEach items="${yhj }" var="yhj">
						<li>
							<div class="per_yhj">
								<div class="flayout_sb ">
									<div class="yhq_l yhqW det "><div class="yhqF">￥${yhj.items.Denomination_ }</div><div>${yhj.items.type_ }</div></div>
									<div class="yhq_c yhqW det"><div class="yhqF">${yhj.items.couponname_ }</div><div>有效期：${yhj.items.enddate1_ }</div></div>
									<div class="yhq_r yhqF">
										<c:if test="${yhj.items.use_ eq 0}">未使用</c:if>
										<c:if test="${yhj.items.use_ eq 1}">已使用</c:if>
									</div>
								</div>
								<div class="mark">${yhj.items.couponcontent_ }</div>
							</div>
						</li>
						
						
						<%-- <li>
							优惠卷额度：${yhj.items.Denomination_ }
							有效时间：${yhj.items.enddate1_ }
							使用状态：<c:if test="${yhj.items.use_ eq 0}">
								未使用
							</c:if>
							<c:if test="${yhj.items.use_ eq 1}">
								已使用
							</c:if>
							使用范围：${yhj.items.type_ }
							优惠卷名称${yhj.items.couponname_ }
							优惠卷描述${yhj.items.couponcontent_ }
						</li> --%>
					</c:forEach>
				</c:if>
			</ul>
		</div>
	</div>
<script type="text/javascript">
function winclose() { 
	var id_= "${id_}";
	alert(id_);
	window.location.href="FrmAdminExclusiveUser.detailMenu?id_="+id_;
}
</script>
	