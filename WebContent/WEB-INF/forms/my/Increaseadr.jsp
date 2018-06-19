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
<title>新增地址</title>
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
<script type="text/javascript">
    function a(){
        console.log($("#city-picker3").val());
    }
    
    function fh(){
        window.history.back(-1);
    }
    function getBox(){
    	var city = $("#city-picker3").val();
    	var exactadr_ = $("#exactadr_").val();
    	 $("#box").html("");
    	 $.ajax({
			 url:"FrmAdrmanage.getBox",
				type:'post',
				data:{"city":city,"exactadr_":exactadr_},
				datatype:"json",
				success:function(data){
					
					var str = eval('(' + data + ')');
					var boxs = eval('(' + str.box + ')');
					console.log(boxs);
					var str = "";
					for(var i=0;i<boxs.length;i++){
						var box = boxs[i];
						var id = box.id_;
						var name = box.name_;
						str = "<span>"+name+"<input type='hidden' value='"+id+"' /></span>";
					}
					$("#box").html(str);
				}
		 })	
    }
</script>
<body>
<div class="header2">
    <a href="#" class="prev" onclick="fh();"></a>
    <div class="head_title font18">地址新增</div>
</div>
<form class="main_content" id="myAddress" name="form" method="post" action="FrmAdrmanage.addadr" onsubmit="return check();">
    <div id="mat"></div>
    <div class="myAddress_list">
        <div class="myAddress_details">
            <span class="myAddress_hint">姓名</span>
            <input type="text"  name="name" placeholder="请填写姓名" id="name"/>
        </div>
        <div class="myAddress_details">
            <span class="myAddress_hint">联系方式</span>
            <input type="text"  name="telpho" placeholder="请填写联系方式" id="telpho"/>
        </div>
        <div class="myAddress_details flexLayout">
            <span class="myAddress_hint">所在地区</span>
            <div class="container">
                <div class="docs-methods" name="adr" >
                    <div id="distpicker">
                        <div class="form-group">
                            <div style="position: relative;">
                                <input id="city-picker3" id="adr" name="city-picker3" class="form-control" readonly type="text" value="" data-toggle="city-picker">
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
    	<textarea class="details_address" name="exactadr_" id="exactadr_" placeholder="请填写详细地址" onchange="getBox()"></textarea>
    <input type="hidden" name="userId" value="${userId}">
    <input type="submit" value="保存" class="font15 address_save">
    <input type="hidden" name="def" id="def" value="0">
    <input type="hidden" name="mode" value="${mode}">
    <input type="hidden" name="orderType_" value="${orderType_}">
    <input type="hidden" name="zhuCode_" value="${zhuCode_}">
    <div  style="padding-left: .17rem;">
    	<span class="myAddress_hint">附近柜组：</span>
    </div> 
    <div class="set_default flexLayout">
        <input type="button" name="radio_name" value="设为默认" class="font15"/>
        <div>
            <img alt="" src="${cdn }/img/checkA.png" class="listImg">
            <img alt="" src="${cdn }/img/checkB.png">
        </div>
    </div>
  	
</form>
  <div id="box">
    
    </div>
<%-- <input type="button" name="mode" value="返回" onclick="fh();">
<form name="form" method="post" action="FrmAdrmanage.addadr" >
        收货人:<input type="text"  name="name" /></br>
        联系方式<input type="text"  name="telpho" /> </br>
        所在省市区:<div class="container">
        <div class="docs-methods" name="adr">
                <div id="distpicker">
                    <div class="form-group">
                        <div style="position: relative;">
                            <input id="city-picker3" name="city-picker3" class="form-control" readonly type="text" value="北京市" data-toggle="city-picker">
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
        详细地址:<input type="text"  name="exactadr" /> </br>
        <input type="hidden" name="userId" value="${userId}">
        <input type="submit" value="保存">
        <input type="hidden" name="def" id="def" value="1">
        <input type="hidden" name="mode" value="${mode}">
        <input type="hidden" name="orderType_" value="${orderType_}">
        <input type="hidden" name="zhuCode_" value="${zhuCode_}">
        <input type="button" name="radio_name" value="设为默认" onclick="d(id);" />
</form> --%>
    <script src="${cdn }/city/js/jquery.js"></script>
    <script src="${cdn }/city/js/bootstrap.js"></script>
    <script src="${cdn }/city/js/city-picker.data.js"></script>
    <script src="${cdn }/city/js/city-picker.js"></script>
    <script src="${cdn }/city/js/main.js"></script>
    <script type="text/javascript">
    $("body").on("click",".set_default",function(){
        if($(this).hasClass("imgActive")){
            $(this).removeClass("imgActive");
            $("#def").val("0");
        }else{
            $(this).addClass("imgActive");
            $("#def").val("1");
        }
    })
    /* function d(){
        $("#def").val("0");
        //$("#mrsz").attr("checked","checked");
        $("input[name='radio_name'][value='0']").attr("checked",true); 
        $("input[name='radio_name']").get(0).checked=true; 
    } */
    </script>
    <script type="text/javascript">
    	function check(){
    		var name = $("#name").val().trim();
    		var telpho = $("#telpho").val().trim(); 
    		var adr = $($($(".city-picker-span").html()).children()[2]).html();
    		var exactadr_ = $("#exactadr_").val().trim();
    		var regNUm=/^[0-9]*$/;  
    		var regRule = /\uD83C[\uDF00-\uDFFF]|\uD83D[\uDC00-\uDE4F]/g;
    		if(name == "" || telpho == "" || exactadr_== "" || adr == null){
    			alert("请确认信息是否填写完整");
    			return false;
    		}if(regRule.test(name) || regRule.test(exactadr_)){
    			alert("暂不支持表情");
    			return false;
    		}if(!regNUm.test(telpho)){
    			alert("联系方式输入格式有误");
    			return false;
    		}
    	}
    </script>
</body>
</html>