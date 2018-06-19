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
<title>柜子地址</title>
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
        padding: .255rem;
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
                    var str = "";
                    for(var i=0;i<boxs.length;i++){
                        var box = boxs[i];
                        var id = box.id_;
                        var name = box.name_;
                        var address_ = box.address_;
                        /* str += "<span>"+name+"<input type='hidden' value='"+id+"' /></span><br>"; 
                        str += "<span>"+address_+"</span>";*/
                        str += "<div class='nearby_cabinetGroup'><img src='../../img/successA.png' alt=''><img src='../../img/successB.png' alt='' class='listImg'><input type='radio' value='"+id+"' name='boxId_' ><span class='cabinetGroup_name'>"+name+"</span><div class='cabinetGroup_address'>"+address_+"</div></div>";
                    }
                    $("#box").html(str);
                }
         })    
    }
</script>
<body style="background-color: #f5f5f5;">
<div class="header2">
    <a href="#" class="prev" onclick="fh();"></a>
    <div class="head_title font18">附近启享柜</div>
</div>
<form class="main_content" id="myAddress" name="form" method="post" action="FrmAdrmanage.addadr">
    <div id="mat"></div>
   <%--  <div id="userXX" class="flexLayout">
        <div class="recipients_message">
            <div>收件人：<span id="uName">${user.items.name_ }</span></div>
            <div>联系电话：<span id="uMobile">${user.items.telpho_ }</span></div>
        </div>
        <div class="recipients_editImg"><img alt="" src="../../img/rightArrows.png"> </div>
    </div> --%>
    <div class="myAddress_list">
        <div class="myAddress_details flexLayout">
            <span class="myAddress_hint">所在地区</span>
            <div class="container">
                <div class="docs-methods" name="adr">
                    <div id="distpicker">
                        <div class="form-group">
                            <div style="position: relative;">
                                <input id="city-picker3" name="city-picker3" class="form-control" readonly type="text" value="北京市" data-toggle="city-picker">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div style="width: .17rem;"><img alt="" src="${cdn }/img/rightArrows.png"> </div>
        </div>
    </div>
    <textarea class="details_address" name="exactadr_" id="exactadr_" placeholder="请填写详细地址" onchange="getBox()"></textarea>
    <div id="box" class="mt_10"></div>
    <div class="read_explainBox imgActive">
        <span class="read_explain">
            <img alt="" src="../../img/selectA.png">
            <img alt="" src="../../img/selectB.png" class="listImg">
            <span>我已阅读</span>
            <a href="#" class="text-gold">《快递至启享柜说明》</a>
        </span>
    </div>
    <input type="submit" value="保存" class="address_save11">
    <div id="userUpdate" style="display: none">
        <div><span>收件人：</span><input type="text" id="userName" ></div>
        <div class="border_0"><span>联系电话：</span> <input type="text" id="userMobile" ></div>
        <input type="button" class="btn_style2" value="保存">
    </div>
    <input type="hidden" name="userId" value="${userId}">
    <input type="hidden" name="def" id="def" value="0">
    <input type="hidden" name="mode" value="${mode}">
    <input type="hidden" name="orderType_" value="${orderType_}">
    <input type="hidden" name="zhuCode_"  value="${zhuCode_}">
    <input type="hidden" name="name" id="userName_" value="${user.items.name_ }">
    <input type="hidden" name="telpho" id="userMobile_" value="${user.items.telpho_ }">
    <input type="hidden" name="telpho"  value="idd">
    <%-- <div id="userXX" style="display: ">
           收件人：<span id="uName">${user.items.name_ }</span>联系电话：<span id="uMobile">${user.items.telpho_ }</span>
           <input type="button" value=">" onclick="getUser()">
       </div> --%>
    <!-- <div id="userUpdate" style="display: none">
        <input type="text" id="userName" >
        <input type="text" id="userMobile" >
        <input type="button" value="保存" onclick="sub()">
    </div> -->
</form>
    <script src="${cdn }/city/js/jquery.js"></script>
    <script src="${cdn }/city/js/bootstrap.js"></script>
    <script src="${cdn }/city/js/city-picker.data.js"></script>
    <script src="${cdn }/city/js/city-picker.js"></script>
    <script src="${cdn }/city/js/main.js"></script>
    <script type="text/javascript">
        $("body").on("click","#userXX",function (){
            /* $("#userXX").css("display","none"); */
            $(this).hide().next().hide().next().hide().next().hide().next().hide().next().show();
            $("#userName").val($("#uName").html());
            $("#userMobile").val($("#uMobile").html());
            $("#userUpdate").css("display","");
        })
        $("body").on("click","#userUpdate .btn_style2",function (){
            $(this).parent().hide().siblings().show();
            /* $("#userUpdate").css("display","none"); */
            $("#uName").html($("#userName").val());
            $("#uMobile").html($("#userMobile").val());
            $("#userName_").val($("#userName").val());
            $("#userMobile_").val($("#userMobile").val());
            $("#userXX").css("display","");
        })
        
        /* 点击选中事件 */
        $("body").on("click","#box .nearby_cabinetGroup",function(){
            $(this).addClass("imgActive").siblings().removeClass("imgActive");
            $(this).find("input").prop("checked","true");
        })
        
        /* 是否勾选阅读 */
        $("body").on("click",".read_explainBox",function(){
        	if($(this).hasClass("imgActive")){
        		$(this).removeClass("imgActive");
            	$(this).next("input").css("background-color","gray").prop("disabled","true");
        	}else{
        		$(this).addClass("imgActive");
            	$(this).next("input").css("background-color","#88213d").removeAttr("disabled");
        	}
        })
        
    </script>
</body>
</html>