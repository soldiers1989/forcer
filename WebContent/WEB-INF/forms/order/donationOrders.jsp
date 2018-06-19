<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 	<%@include file="../ui/head1.jspf"%>
 	<%@include file="../ui/head2.jspf"%>
    <%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${cdn}/layui/layui.js"></script>
<title>一启享</title>
</head>
<script type="text/javascript">
    function page(pageno) {
        $("#subForm").append(
                '<input type="hidden" name="pageno" value="'  pageno  '">');
        $("#subForm").submit();
    }
</script>
<script type="text/javascript">
	layui.use('laydate', function() {
		var laydate = layui.laydate;
	});
</script>
<body>
	<div class="mid-box fl" id="mid-box">
 	 		<div class="top pl_20 pr_20">
 	 			<span class="min-col f16">捐赠单列表</span>
 	 		</div>
 	 		<form action="FrmDonationOrder" id="subForm">
 	 			<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
 	 	            <div class="fl leftSide">
 	 	                <div>
 	 	                	<span class="back_hint6">按用户手机号</span>
 	 	                	<input type="text" name="mobile_" value="${mobile_ }">
 	 	                    <span class="back_hint4">按收货状态</span>
 	 	                <!--     <select name="shStatus_">
 	 	                    	<option value="0">已收货</option>
 	 	                    	<option value="1">未收货</option>
 	 	                    </select> -->
 	 	                    <select name="shStatus_">
								 <option value="-1" <c:if test="${shStatus_ eq '-1'  || shStatus_ eq null }">selected="selected"</c:if>>全部</option>
								 <option value="0" <c:if test="${shStatus_ eq '0' }">selected="selected"</c:if>>已收货</option>
								 <option value="1" <c:if test="${shStatus_ eq '1' }">selected="selected"</c:if>>未收货</option>
							</select>
 	 	                	<%-- <span class="back_hint4">按收货时间</span>
 	 	                	<input type="text" name="shouhuoTime_" value="${shouhuoTime_ }"> --%>
 	 	                	
 	 	                	<span
							class="back_hint8">按收货时间</span><input type="text"
							onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})"
							name="shouhuoTime_" value="${shouhuoTime_}" />
 	 	                	
 	 	                	<input type="submit" value="查询" id="sub">
 	 	                  </div>
 	 	                  <div class="mt_10">
 	 	                    <span class="back_hint6">按运维人员电话</span>
 	 	                    <input type="text" name="maintainPhone_" value="${maintainPhone_ }">
 	 	                    <span class="back_hint4">捐赠状态</span>
 	 	                   <!--  <select name="status_">
 	 	                    	<option value="0">未发公益机构</option>
 	 	                    	<option value="1">已发公益机构</option>
 	 	                    </select> -->
 	 	                    <select name="status_">
								 <option value="-1" <c:if test="${status_ eq '-1'  || status_ eq null }">selected="selected"</c:if>>全部</option>
								 <option value="0" <c:if test="${status_ eq '0' }">selected="selected"</c:if>>未发公益机构</option>
								 <option value="1" <c:if test="${status_ eq '1' }">selected="selected"</c:if>>已发公益机构</option>
							</select>
 	 	                </div>
 	 	                
 	 	            </div>
 	 	            <div class="fr rightSide">
 	 	            	
 	 	                <a href="FrmExcel?service=SvrGetUserDonationOrder&amp;exportKey=SvrGetUserDonationOrder&amp;templateId=SvrGetUserDonationOrder"><input type="button" value="导出"></a>
 	 	            </div>
 	 	        </div>
 	 		</form>
 	 		<form action="" id="subForm">
 	 			<div role="grid">
 	 				<div class="table">
 	 					<table class="tbl">
 	 						<tbody>
 	 							<tr>
 	 								<td class="t-head">订单单号</td>
 	 								<td class="t-head">订单创建时间</td>
 	 								<td class="t-head">捐赠用户名</td>
 	 								<td class="t-head">订单物品描述</td>
 	 								<td class="t-head">数量</td>
 	 								<td class="t-head">捐赠柜地址</td>
 	 								<td class="t-head">捐赠状态变更时间</td>
 	 								<td class="t-head">收货状态</td>
 	 								<td class="t-head">收货运维人员电话</td>
 	 								<td class="t-head">收货时间</td>
 	 								<td class="t-head">捐赠状态</td>
 	 								<td class="t-head">操作</td>
 	 							</tr>
 	 						</tbody>
 	 						
 	 	                <tbody class="t-body tc">
 	 	                   	<c:if test="${not empty donations}">
 	 		                    <c:forEach items="${donations }" var="value" varStatus="status">
 	 		                        <tr>
 	 		                            <td>${value.items.orderId_}</td>
 	 		                            <td>${value.items.createTime_}</td>
 	 		                            <td>${value.items.createUser_}</td>
 	 		                            <td>${value.items.orderDesc_}</td>
 	 		                            <td>${value.items.count_}</td>
 	 		                            <td>${value.items.adr_}</td>
 	 		                            <td>${value.items.statusTime_}</td>
 	 		                            <td>
 	 		                            	<c:if test="${value.items.shStatus_ == '0'}">
 	 											已发货
 	 										</c:if>
 	 		                            	<c:if test="${value.items.shStatus_ == '1'}">
 	 											未发货
 	 										</c:if>
 	 		                            </td>
 	 		                            <td>${value.items.maintainPhone_}</td>
 	 		                            <td>${value.items.shouhuoTime_}</td>
 	 		                            <td>
 	 		                            	<c:if test="${value.items.status_ == '0'}">
 	 											未发公益机构
 	 										</c:if>
 	 		                            	<c:if test="${value.items.status_ == '1'}">
 	 											已发公益机构
 	 										</c:if>
 	 		                            </td>
 	 		                            <td>
 	 		                            	<c:if test="${value.items.status_ == '0'}">
 	 											<a onclick="show('${value.items.orderId_}')" class="btn_style" style="margin-right:5px;">变更捐赠状态 </a>
 	 										</c:if>
 	 		                            	<c:if test="${value.items.status_ == '1'}">
 	 											<a onclick="showa()" class="btn_style" style="margin-right:5px;">变更捐赠状态 </a>
 	 										</c:if>
 	 		                            </td>
 	 		                        </tr>
 	 		                    </c:forEach>
 	 	                    </c:if>
 	 	                </tbody>
 	 					</table>
 	 				</div>
 	 			</div>
 	 		</form>
 	 		<c:if test="${pages.count >= 1}">
 	 			<div class="foot-page" align="center">
 	 				<a href="javascript:page(1);" class='page-index Shouw'>首页</a> <a
 	 					href="javascript:page(${pages.prior});">上一页</a> <a
 	 					href="javascript:page(${pages.next});">下一页</a> <a
 	 					href="javascript:page(${pages.count});" class="page-last Shouw">尾页</a>
 	 				<span>总条数：</span>${pages.recordCount}, 页数：${pages.current} /
 	 				${pages.count}
 	 			</div>
 	 		</c:if>
 	 	</div>
 	 	 </body>
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
 	 						window.location.href='FrmDonationOrder';
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
</html>