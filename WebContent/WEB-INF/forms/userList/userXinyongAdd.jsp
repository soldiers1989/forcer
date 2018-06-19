<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="flayout_r">
	<div class="" style="width:100%">
		<div class="userXinyong">
			<div style="width:100%">
				<span>当前用户：</span><input type="text" name="code_" value="${code_}"><br/><br/>
				<span>征信来源：</span><select name="source_">
							<option value="疑似不良租赁行为">疑似不良租赁行为</option>
							<option value="确认不良租赁行为">确认不良租赁行为</option>
						</select><br/>
				<span>产生征信原因：</span><input type="text" name="yuanying_" placeholder="按条件汇总 运维检查异常上报 客服沟通确认 或10字以内自填"><br/>
				<span>产生征信节点：</span><select name="node_">
							<option value="数据分析方法">数据分析方法</option>
							<option value="租赁中异常">租赁中异常</option>
							<option value="租赁后异常">租赁后异常</option>
							<option value="认证异常">认证异常</option>
							</select><br/>
				<span>征信方法：</span><select name="type_">
							<option value="0">押金比例浮动</option>
							<option value="1">是否给予押金</option>
							<option value="2">免押金额度跳转</option>
							<option value="3">租赁订单结算方式</option>
						</select><br/>
				<span>征信数据调整：</span><input type="text" name="revision_"><br/>
				<span>录入关联单据号：</span><input type="text" name="orderId_"><br/>
				<span>备注说明：</span><input type="text" name="beizhu"><br/>
				<input type="button" onclick="show()" value="提交" class="btn_bdkf" style="margin-left:120px;">
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	function showa(){
		alert("此订单状态已经变更过！！")
	}
	function show(){
		var code_ = $("input[name='code_']").val();
		var source_ = $("select[name='source_']").val();
		var yuanying_ = $("input[name='yuanying_']").val();
		var node_ = $("select[name='node_']").val();
		var type_ = $("select[name='type_']").val();
		var revision_ = $("input[name='revision_']").val();
		var orderId_ = $("input[name='orderId_']").val();
		var beizhu_ = $("input[name='beizhu']").val();
		
		if(revision_ == ""){
			alert("征信数据调整不能为空！")
			return false;
		}
		
		if(window.confirm('你确定新增此人征信配置吗？\n\n 请确认！！')){
		    $.ajax({
				url : 'FrmUserXinyong.upUserXinYong',
				dataType : 'json',
				type : 'post',
				data : { 
					"code_" : code_,
					"source_" : source_,
					"yuanying_" : yuanying_,
					"node_" : node_,
					"type_" : type_,
					"revision_" : revision_,
					"orderId_" : orderId_,
					"beizhu_" : beizhu_
				},
				cache : false,
				success : function(data) {
					if(data == true){
						alert("新增征信配置成功！");
						window.location.href='FrmUserXinyong?code_='+code_;
					}else{
						alert("新增征信配置失败!")
					}
				}
				});
         }else{
            //alert("取消");
            return false;
        }
	}
</script>
