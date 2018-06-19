<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<link href="http://cdn.bootcss.com/bootstrap/3.3.6/css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="${cdn }/city/css/city-picker.css" rel="stylesheet" type="text/css" />
<title>信息编辑</title>

<script type="text/javascript">
 function upd(id){
		$.ajax({
			url:"FrmAdrmanage.updadr",
			type:'post',
			data:{"userid_":id},
			datatype:"text",
			success:function(data){
				location.reload();
				alert("保存成功");
			},
			error:function(){
			}	
		})
	} 

 function checkForm(){
	var name=$.trim($("#name").val());
	var adr = $($($(".city-picker-span").html()).children()[2]).html();
	var telpho=$.trim($("#telpho").val());
	var exactadr = $("#exactadr").val().trim();
	var regNUm=/^[0-9]*$/;  
	var regRule = /\uD83C[\uDF00-\uDFFF]|\uD83D[\uDC00-\uDE4F]/g;
	  if(name=="" || telpho=="" || exactadr == "" || adr== null){
		  alert("请确保信息填写完整");
		  return false;
	  }if(regRule.test(name) || regRule.test(exactadr)){
			alert("暂不支持表情");
			return false;
	  }if(!regNUm.test(telpho)){
			alert("联系方式输入格式有误");
			return false;
	 }
}
</script>
<style>
    #myAddress .city-picker-span{
        border-bottom: 0
    }
    #myAddress .form-group{
        margin-bottom: 0;
    }
    #myAddress .container{
        margin: .17rem 0;
        position: absolute;
        right: 0.17rem;
        width: 75%;
    }
    .details_address{
        width: 100%;
        height: 1.45rem;
        border: 0;
        padding: .15rem;
        font-size: 0.239rem;
        font-weight: normal;
        font-stretch: normal;
        line-height: 0.425rem;
        letter-spacing: 0rem;
        color: #333333;
        display: inline-block;
    }
</style>
</head>
<body>
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">地址管理</div>
</div>
<form class="main_content" id="myAddress" name="form" method="post" action="FrmAdrmanage.updaddr" onsubmit="return checkForm()">
    <div id="mat"></div>
    <div class="myAddress_list">
        <div class="myAddress_details">
            <span class="myAddress_hint">姓名</span>
            <input type="text"  name="name" id="name" value="${values.items.name_}"/>
        </div>
        <div class="myAddress_details">
            <span class="myAddress_hint">联系方式</span>
            <input type="text" name="telpho" id="telpho" value="${values.items.telpho_}"/>
        </div>
        <div class="myAddress_details flexLayout">
            <span class="myAddress_hint">所在地区</span>
            <div class="container">
                <div class="docs-methods" name="adr">
                    <div id="distpicker">
                        <div class="form-group">
                            <div style="position: relative;">
                                <input id="city-picker3" name="city-picker3" id="area" class="form-control" type="text" value="${values.items.adr_}" data-toggle="city-picker">
                            </div>
                        </div>
                        <!-- <div class="form-group">
                            <button class="btn btn-warning" id="reset" type="button">重置</button>
                            <button class="btn btn-danger" id="destroy" type="button" onclick="a();">确定</button>
                        </div> -->
                    </div>
                </div>
            </div>
            <div style="width: .17rem;"><img alt="" src="${cdn }/img/rightArrows.png"> </div>
        </div>
        <!-- <div class="myAddress_details">
            <span class="myAddress_hint">详细地址</span>
            <input type="text"  name="exactadr" />
        </div> -->
    </div>
    <div class="myAddress_details" style="padding-left: .17rem;">
            <span class="myAddress_hint">详细地址</span>
    <textarea class="details_address"  id="exactadr" name="exactadr">${values.items.exactadr_}</textarea>
    </div>
    <p></p>
    <div class="myAddress_details ">
    	<span class="myAddress_hint" style="padding-top: 70px;padding-left: 10px;">备注:</span>
    	<input type="text" name="remark" id="remark" value="${values.items.remark_}"/>
    </div>
    <input type="submit" value="保存" class="font15 address_save">
    <input type="hidden" name="id_" value="${values.items.id_ }">	
    <%-- <input type="hidden" name="userId" value="${userId}">
    <input type="submit" value="保存" class="font15 address_save">
    <input type="hidden" name="def" id="def" value="0">
    <input type="hidden" name="mode" value="${mode}">
    <input type="hidden" name="orderType_" value="${orderType_}">
    <input type="hidden" name="zhuCode_" value="${zhuCode_}"> --%>
</form>


<%-- <form name="form" method="post" action="FrmAdrmanage.updaddr" onsubmit="return checkForm()";>
		姓名:<input type="text" name="name" id="title" value="${values.items.name_}"/></br>
		联系方式:<input type="text" name="telpho" id="telpho" value="${values.items.telpho_}"/></br>
		所在省市区:<div class="container">
		<div class="docs-methods" >
				<div id="distpicker">
					<div class="form-group">
						<div style="position: relative;">
							<input id="city-picker3" name="adr" class="form-control" readonly type="text" value="${values.items.adr_}" data-toggle="city-picker">
						</div>
					</div>
					<div class="form-group">
						<button class="btn btn-warning" id="reset" type="button">重置</button>
						<button class="btn btn-danger" id="destroy" type="button" onclick="a();">确定</button>
					</div>
				</div>
		</div>
		</div>
		</br>
		详细地址:<input type="text"  name="exactadr" value="${values.items.exactadr_}"></br>
		备注:<input type="text" name="remark" id="remark" value="${values.items.remark_}"/></br>
		<input type="hidden" name="id_" value="${values.items.id_ }">
		<input type="submit" value="保存">&nbsp;&nbsp;&nbsp;&nbsp;
		
</form> --%>
	<script src="${cdn }/city/js/jquery.js"></script>
	<script src="${cdn }/city/js/bootstrap.js"></script>
	<script src="${cdn }/city/js/city-picker.data.js"></script>
	<script src="${cdn }/city/js/city-picker.js"></script>
	<script src="${cdn }/city/js/main.js"></script>
</body>
</html>