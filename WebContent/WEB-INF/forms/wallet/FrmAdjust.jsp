<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../ui/head1.jspf"%>
    <%@include file="../ui/head2.jspf" %> 
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
     <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${cdn}/layui/layui.js"></script>
<title>一起享</title>
</head>
<style>
   .no_content img{
      position: absolute;
      left: 50%;
      top: 50%;
      transform: translate(-50%,-50%)
    }
    .back_hint{
    	display: inline-block;
    	width: 100px;
    }
    #subForm .leftSide input{
    	margin-bottom: 0;
    	width: 153px;
    }
    #subForm .leftSide>div{
    	margin-bottom: 10px;
    }
    #subForm .leftSide .Wdate{
    	width: 180px;
    }
</style>
<script type="text/javascript">
$(function(){
$('#sub').on('click', function() {
    var startdate=$('#unlockDate_').val();
  var enddate=$('#endDate_').val();
  if(startdate != null && startdate!=""){
  if(startdate>enddate){ 
    alert("结束时间必须大于开始时间");
    return false;
    }
  }
    });
})
</script>
<script type="text/javascript">
  layui.use('laydate', function(){
      var laydate = layui.laydate; 
    });
</script>
<body>
<div class="mid-box fl" id="mid-box">
    <div class="top pl_20 pr_20">
        <span class="min-col f16">手工调账弹出试页面</span>
    </div>
        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
            <div class="fl leftSide">
                <div>
	                <a href="javascript:window.history.go(-1);" class="min-col"
						style="padding: 4px 10px; background: #48b2bd; color: #fff; border-radius: 3px;">返回</a>
                </div>
            </div>
            <div class="fr rightSide">
            </div>
        </div>
    <div role="grid">
        <div class="group-box">
        	<label>调出总账户：</label>
        		<select id="czong" style="width:300px;">
	        		<c:forEach items="${values }" var="value">
	        			<option value="${value.items.id_}">${value.items.id_}</option>
	        		</c:forEach>
        		</select><br/>
        	<label>调出子账户：</label><input type="text" name=""><br/>
        	<label>调出金额：</label><input type="number" id="money_"><br/>
        	<label>调入总账户：</label>
        		<select id="rzong" style="width:300px;" class="mt_10">
	        		<c:forEach items="${values }" var="value">
	        			<option value="${value.items.id_}">${value.items.id_}</option>
	        		</c:forEach>
	        	</select><br/>
        	<label>调入子账户：</label><input type="text" name=""><br/>
        	<label>填写调账备注：</label><input type="text" name="desc_"><br/>
        	<input type="button" onclick="tijiao()" value="提交" class="btn_bdkf" style="margin-left:106px;">
        </div>
    </div>
</div>
</body>
<script language="javascript" type="text/javascript" src="../../admin/My97DatePicker/WdatePicker.js"></script> 
<script type="text/javascript">
function page(pageno) {
    $("#subForm").append('<input type="hidden" name="pageno" value="'+ pageno +'">');
    
    $("#subForm").submit();
}

function tijiao(){
	var czong = $("#czong").val();
	var rzong = $("#rzong").val();
	var money_ = $("#money_").val();
	
	if(czong == rzong){
		alert("调出账户和调入账户不能相同！")
		return false;
	}
	if(money_ == ""){
		alert("请输入操作金额！")
		return false;
	}
	$.ajax({
		url : 'FrmAdjust.upAdjust',
		dataType : 'json',
		type : 'post',
		data : { 
			"czong_" : czong,
			"rzong_" : rzong,
			"money_" : money_
		},
		cache : false,
		success : function(data) {
			if(data == true){
				alert("调账成功!");
			}else{
				alert("调用失败!")
			}
		}
		});
}
</script>
</html>