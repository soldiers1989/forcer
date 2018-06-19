<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@include file="../jspf/head1.jspf"%>
    <%@include file="../ui/head1.jspf"%>
	<%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>关于我们后台修改</title>
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
	<!--编辑器插件-->
<link rel="stylesheet" type="text/css"
	href="${cdn}/admin/bianjiqi/styles/font-awesome.css" />
<link rel="stylesheet" type="text/css"
	href="${cdn}/admin/bianjiqi/styles/simditor.css" />
<link rel="stylesheet" type="text/css"
	href="${cdn}/admin/css/newAdd.css" />
<script type="text/javascript"
	src="${cdn}/admin/bianjiqi/scripts/js/jquery.min.js"></script>
<script type="text/javascript"
	src="${cdn}/admin/bianjiqi/scripts/js/module.js"></script>
<script type="text/javascript"
	src="${cdn}/admin/bianjiqi/scripts/js/uploader.js"></script>
<script type="text/javascript"
	src="${cdn }/admin/plugin/ckeditor/ckeditor.js"></script>
</head>
<body>
<div class="mid-box fl" id="mid-box" style="background-color:#ffffff;">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">
	        <c:if test="${values.items.type_ ==1 }">使用流程</c:if>				<c:if test="${values.items.type_ ==2 }">商务合作说明</c:if>
			<c:if test="${values.items.type_ ==3 }">联系客服</c:if>				<c:if test="${values.items.type_ ==4 }">关于我们</c:if>
			<c:if test="${values.items.type_ ==5 }">用户租赁协议</c:if>			<c:if test="${values.items.type_ ==6 }">运维服务协议</c:if>
			<c:if test="${values.items.type_ ==7 }">银行卡绑定服务协议</c:if>		<c:if test="${values.items.type_ ==8 }">积分规则说明</c:if>
			<c:if test="${values.items.type_ ==9 }">公益捐款说明</c:if>			<c:if test="${values.items.type_ ==10 }">优惠券使用规则</c:if>
			<c:if test="${values.items.type_ ==11 }">签到规则</c:if>	    		<c:if test="${values.items.type_ ==12 }">用户等级规则说明</c:if>	
			<c:if test="${values.items.type_ ==13 }">快递至启享柜说明</c:if>   	<c:if test="${values.items.type_ ==14 }">芝麻信用减免规则说明</c:if>	
			<c:if test="${values.items.type_ ==15 }">活体影像减免规则说明</c:if>    <c:if test="${values.items.type_ ==16 }">手机号减免押金规则说明</c:if>	
			<c:if test="${values.items.type_ ==17 }">邀请好友规则说明</c:if>
       </span>
    </div>
     <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	    <div class="fl leftSide">
	    	 <a href="FrmInformationList" class="min-col"
			style="padding: 4px 10px; background: #48b2bd; color: #fff; border-radius: 3px;">返回</a>
	    </div>
	    <div class="fr rightSide">
	    </div>
	</div>	
	<div class="easyui-panel tc mt_20">
	<form action="FrmRentPact.LeaseUpdate" id="subForm">
	    <c:if test="${empty values}"><img src="../../img/zwsj.png"></c:if>
        <c:if test="${not empty values}"></c:if>
		<input type="hidden" name="id_" value="${values.items.id_ }"> 
		<input type="hidden" name="type_" value="${values.items.type_ }"> 
		 <div class="group-box" name="null"  visible="false">
			<label>标题：</label><input type="text" value="${values.items.title_ }" id="leasetitle_" name="title_" maxlength="255">
		</div>
	<%-- 	<div class="group-box" name="null"  visible="false">
			<label>时间：</label><input type="text" value="${values.items.date_ }" id="leasetitle_" name="date_" maxlength="255">
		</div> --%>
		<div class="group-box" name="null"  visible="false">
			<label style="float:left">内容：</label>
			<div style="float:right;width:88%">
				<textarea  id="editor" placeholder="这里输入内容" maxlength="1000" style="width: 290px; border-radius: 4px; padding: 10px; border: 1px solid #ddd;" rows="5" cols="15" name="content_">${values.items.content_ }</textarea>
			</div>
		</div>
		<div class="group-box" visible="false" >
        	<input type="submit" onclick="submit()" value="保存" style="margin-top:10px;">
		</div>
	</form>
	</div>

<%-- <div  id="mid-box">
	<div >
	
	<span>
	<c:if test="${values.items.type_ ==1 }">使用流程</c:if>				<c:if test="${values.items.type_ ==2 }">商务合作说明</c:if>
	<c:if test="${values.items.type_ ==3 }">联系客服</c:if>				<c:if test="${values.items.type_ ==4 }">关于我们</c:if>
	<c:if test="${values.items.type_ ==5 }">用户租赁协议</c:if>			<c:if test="${values.items.type_ ==6 }">运维服务协议</c:if>
	<c:if test="${values.items.type_ ==7 }">银行卡绑定服务协议</c:if>		<c:if test="${values.items.type_ ==8 }">积分规则说明</c:if>
	<c:if test="${values.items.type_ ==9 }">公益捐款说明</c:if>			<c:if test="${values.items.type_ ==10 }">优惠券使用规则</c:if>
	<c:if test="${values.items.type_ ==11 }">签到规则</c:if>	    		<c:if test="${values.items.type_ ==12 }">用户等级规则说明</c:if>	
	<c:if test="${values.items.type_ ==13 }">快递至启享柜说明</c:if>   	<c:if test="${values.items.type_ ==14 }">芝麻信用减免规则说明</c:if>	
	<c:if test="${values.items.type_ ==15 }">活体影像减免规则说明</c:if>    <c:if test="${values.items.type_ ==16 }">手机号减免押金规则说明</c:if>	
	<c:if test="${values.items.type_ ==17 }">邀请好友规则说明</c:if>
	</span>
	</div>
	<div >
	    <a href="FrmInformationList" class="btnStyle">返回</a>
	</div>
	<form action="FrmRentPact.LeaseUpdate" id="subForm">
	    <c:if test="${empty values}"><img src="../../img/zwsj.png"></c:if>
        <c:if test="${not empty values}"></c:if>
		<input type="hidden" name="id_" value="${values.items.id_ }"> 
		<input type="hidden" name="type_" value="${values.items.type_ }"> 
		<div>
			<span>标题：</span>
			<input type="text" value="${values.items.title_ }" id="leasetitle_" name="title_" maxlength="255">
		</div>
		<div>
			<span>时间：</span>
			<input type="text" value="${values.items.date_ }" id="leasetitle_" name="date_" maxlength="255">
		</div>
		<div class="content_edit">
			<div>内容：</div>
			<textarea id="editor" placeholder="这里输入内容" maxlength="1000" style="width: 290px; border-radius: 4px; padding: 10px; border: 1px solid #ddd;" rows="5" cols="15" name="content_">${values.items.content_ }</textarea>
				
		</div>
        <div name="null" visible="false">
                 <input type="submit" onclick="submit()" value="保存">
        </div>
	</form>  --%>
    <script type="text/javascript">
    function jiancha(){
    	var title_ = $("#title_").val();
    	if(leasetitle_==""){
    		modal("标题不能为空");
    		return false;
    	}
    	
    	//更新ckeditor里面最新输入的文字
    	editorE.updateElement();
    	
    	var editor = $("#editor").val();
    	if(editor==""){
    		modal("内容不能为空");
    		return false;
    	}
    	return true;
    }
        var editorE = CKEDITOR.replace('editor');
            function submit(){
                if(jiancha()){
                    $("#subForm").ajaxSubmit({
                    success:function(data){
                        if(data){
                        modal("保存成功");
                        }else{
                            modal("保存失败")
                        }
                        
                    },
                        error:function(data){
                        modal("保存失败，请检查数据是否正确");
                        }
                        
                           });
                }
            };
    </script>
</div>
</body>
</html>