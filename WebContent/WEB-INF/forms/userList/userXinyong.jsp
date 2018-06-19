<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="flayout_r">
	<div class="" style="width:100%">
	<a href="FrmUserXinyong.addDetails?code_=${code_}"><input type="button" value="新增该用户征信配置单" class="btn_style"></a>
	<br/><br/>
		<div class="">
			<div style="width:89%">
				芝麻信用认证：
					<c:if test="${sesame eq ''}">无认证</c:if>
					<c:if test="${sesame ne ''}">${sesame }</c:if><br/><br/>
				活体映像：无认证<br/><br/>
				银行卡认证：无认证<br/><br/>
				独立征信配置情况：
				<table class="tbl mt_20">
                <tbody>
                    <tr>
                        <th class="t-head tc">序号</th>
                        <th class="t-head tc">征信对象</th>
                        <th class="t-head tc">个人征信来源</th>
                        <th class="t-head tc">产生征信原因</th>
                        <th class="t-head tc">产生征信节点</th>
                        <th class="t-head tc">产生征信责任人</th>
                        <th class="t-head tc">征信时间</th>
                        <th class="t-head tc">征信方法</th>
                        <th class="t-head tc">征信调整数据</th>
                        <th class="t-head tc">征信关联单据详情</th>
                        <th class="t-head tc">状态</th>
                    </tr>
                </tbody>
                <tbody class="t-body tc">
                  	<%-- <c:if test="${empty personal}"><div  class="no_content"><img src="../../img/zwsj.png" style="width: 4rem;"></div></c:if>
                   	<c:if test="${not empty personal}"> --%>
	                    <c:forEach items="${personal }" var="value" varStatus="status">
	                        <tr>
	                            <td>${ status.index + 1}</td>
	                            <td>${value.items.userCode_}</td>
	                            <td>${value.items.source_}</td>
	                            <td>${value.items.yuanying_}</td>
	                            <td>${value.items.node_}</td>
	                            <td>${value.items.people_}</td>
	                            <td><fmt:formatDate value="${value.items.time_ }" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
	                            <%-- <td>${value.items.method_}</td> --%>
	                            <td>
	                            	<c:if test="${value.items.type_ == '0'}">押金比例浮动</c:if>
	                            	<c:if test="${value.items.type_ == '1'}">是否给予押金 </c:if>
	                            	<c:if test="${value.items.type_ == '2'}">免押金额度调整</c:if>
	                            	<c:if test="${value.items.type_ == '3'}">租赁订单结算方式</c:if>
	                            </td>
	                            <td>${value.items.revision_}</td>
	                            <td><a href="#" class="btn_style">查看修改</a></td>
	                            <td>
	                            	<c:if test="${value.items.status_ == '0'}">启用</c:if>
	                            	<c:if test="${value.items.status_ == '1'}">失效</c:if>
	                            </td>
							</tr>
	                    </c:forEach>
                   <%--  </c:if> --%>
                </tbody>
            </table>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	function showa(){
		alert("此订单状态已经变更过！！")
	}
	function show(orderId_){
		if(window.confirm('你确定变更状态吗？\n\n 请确认！！')){
		    $.ajax({
				url : 'FrmgetUser.upDonationOrder',
				dataType : 'json',
				type : 'post',
				data : { 
					"orderId_" : orderId_
				},
				cache : false,
				success : function(data) {
					if(data == true){
						alert("变更捐赠状态成功！");
						window.location.href='FrmgetUser.userDonateOrder';
					}else{
						alert("变更捐赠状态失败!")
					}
				}
				});
         }else{
            //alert("取消");
            return false;
        }
	}
</script>
