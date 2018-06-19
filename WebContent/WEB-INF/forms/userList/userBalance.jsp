<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@include file="../ui/head1.jspf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<div class="flayout_r">
		<div class="user_info" style="width:80%">
			<div class="flayout_sb">
				<div class="info-left ">
					<div class="list flexLayout" name="null" visible="false">
						<label>账户余额：</label>
							<input type="text" disabled="disabled" value="${values.items.overMoney_}">
					</div>
					<div class="list flexLayout" name="null" visible="false">
						<label>押金合计：</label>
						<c:if test="${cashPledge_ eq ''}">
							<input type="text" disabled="disabled" value="0.00">
						</c:if>
						<c:if test="${cashPledge_ ne ''}">
							<input type="text" disabled="disabled" value="${cashPledge_}">
						</c:if>
					</div>
					<div class="list flexLayout mb_10" name="null" visible="false">
						<label>锁定金额：</label>
						<c:if test="${sumRentMoney_ eq ''}">
							<input type="text" disabled="disabled" value="0.00">
						</c:if>
						<c:if test="${sumRentMoney_ ne ''}">
							<input type="text" disabled="disabled" value="${sumRentMoney_}">
						</c:if>
					</div>
					<div class="list flexLayout" name="null" visible="false">
						<label>历史充值：</label>
						<c:if test="${mc eq ''}">
							<input type="text" disabled="disabled" value="0.00">
						</c:if>
						<c:if test="${mc ne ''}">
							<input type="text" disabled="disabled" value="${mc}">
						</c:if>
					</div>
					<div class="list flexLayout" name="null" visible="false">
						<label>历史提现：</label>
						<c:if test="${mt eq ''}">
							<input type="text" disabled="disabled" value="0.00">
						</c:if>
						<c:if test="${mt ne ''}">
							<input type="text" disabled="disabled" value="${mt}">
						</c:if>
					</div>
					<div class="list flexLayout" name="null" visible="false">
						<label>在租订单物品价值总金额：</label>
						<c:if test="${dayRentMoney_ eq ''}">
							<input type="text" disabled="disabled" value="0.00">
						</c:if>
						<c:if test="${dayRentMoney_ ne ''}">
							<input type="text" disabled="disabled" value="${dayRentMoney_}">
						</c:if>
					</div>
					<div class="list flexLayout" name="null" visible="false">
						<label>免押额度使用总额：</label>
							<input type="text" disabled="disabled" value="0.00">
					</div>
				</div>
					<div class="user-jfjl" style="width:30%">
						<div class="txt">交易明细</div>
						<ul class="jfqd-ul">
							<c:if test="${empty jf}">
								此用户暂无交易明细！
							</c:if>
						</ul>
					</div>
				</div>
			</div>
		</div>
	
	