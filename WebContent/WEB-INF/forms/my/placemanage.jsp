<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>地址管理</title>
<style type="text/css">
	#mrsz{
		opacity: 0;
		filter:alpha(opacity=	0); 
	}
	
	.no_content img{
    	position: absolute;
    	left: 50%;
    	top: 45%;
    	transform: translate(-50%,-50%)
    }
</style>
<script type="text/javascript">
    
    function del(id){
        var msg = "您真的确定要删除吗？\n\n请确认！"; 
         if (confirm(msg)==true){ 
          $.ajax({
                url:"FrmAdrmanage.deleteadr",
                type:'post',
                data:{"id_":id},
                datatype:"text",
                success:function(data){
                    alert("删除成功");
                    location.reload();
                },
                error:function(){
                
                },    
            })     
         }else{ 
          return false; 
         } 
                     
    
        }
    function def(id,userId){
        $.ajax({
            url:"FrmAdrmanage.upDef",
            type:'post',
            data:{"id_":id,"userId_":userId},
            datatype:"text",
            
            success:function(data){
                
            },
            error:function(){
            
            },    
        })     
    }
    
    
</script>
</head>

<body>
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">地址管理</div>
</div>
<div class="main_content" id="my_address">
    <div id="mat"></div>
    <c:if test="${empty values }">
    	<div class="no_content">
    		<img alt="" src="${cdn}/img/zwsj.png" style="width: 4rem;">
    	</div>
    </c:if>
    <c:forEach items="${values }" var="value">
        <c:if test="${value.items.adrState_ == 0}" >
            <div class="address_listBox imgActive">
                <ul class="my_address_list border_b">
                    <li class="flexLayout">
                        <div class="list_left font16">${value.items.name_}</div>
                        <div class="list_right font16">${value.items.telpho_}</div>
                    </li>
                    <li class="font14">${value.items.adr_}/${value.items.exactadr_}</li>
                    <li class="font13 text-gray"><span>备注：</span><span>${value.items.remark_}</span></li>
                </ul>
                <div class="flexLayout address_operation">
                    <div class="list_left" onclick="def('${value.items.id_}','${value.items.userId_}');">
                        <img src="../../img/checkA.png" alt="">
                        <img src="../../img/checkB.png" alt="" class="listImg">
                         <input type="radio" name="def" id="mrsz" onclick="def('${value.items.id_}','${value.items.userId_}');" checked="checked">
                    
                        <span class="text-gold font13">设为默认</span>
                    </div>
                    <div class="list_right">
                        <a class="mr_10" href="FrmAdrmanage.updadr?id_=${value.items.id_}&falg=A">
                            <img src="../../img/edit.png" alt="">
                            <span class="font13">编辑</span>
                        </a>
                        <span onclick="del('${value.items.id_}')">
                            <img src="../../img/delete.png" alt="">
                            <span class="font13">删除</span>
                        </span>
                    </div>
                </div>
            </div>
        </c:if>
        
        <c:if test="${value.items.adrState_ == 1}" >
            <div class="address_listBox">
                <ul class="my_address_list border_b">
                    <li class="flexLayout">
                        <div class="list_left font16">${value.items.name_}</div>
                        <div class="list_right font16">${value.items.telpho_}</div>
                    </li>
                    <li class="font14">${value.items.adr_}/${value.items.exactadr_}</li>
                    <li class="font13 text-gray"><span>备注：</span><span>${value.items.remark_}</span></li>
                </ul>
                <div class="flexLayout address_operation">
                    <div class="list_left" onclick="def('${value.items.id_}','${value.items.userId_}');">
                        <img src="../../img/checkA.png" alt="">
                        <img src="../../img/checkB.png" alt="" class="listImg">
                        
                         <input type="radio" name="def" id="mrsz" onclick="def('${value.items.id_}','${value.items.userId_}');" >
                        <span class="text-gold font13">设为默认</span>
                    </div>
                    <div class="list_right">
                        <a class="mr_10" href="FrmAdrmanage.updadr?id_=${value.items.id_}&falg=A">
                            <img src="../../img/edit.png" alt="">
                            <span class="font13">编辑</span>
                        </a>
                        <span onclick="del('${value.items.id_}')">
                            <img src="../../img/delete.png" alt="">
                            <span class="font13">删除</span>
                        </span>
                    </div>
                </div>
            </div>
        </c:if>
    </c:forEach>
    <div style="height: .92rem;"></div>
    <a href="FrmAdrmanage.goIncreaseadr" class="order_addAddress">添加收货地址</a>
</div>
<script>
    $("body").on("click",".address_operation .list_left",function(){
        $(this).parent().parent().addClass("imgActive").siblings().removeClass("imgActive");
        $(this).find("input").prop("checked","true");
    })
</script>
    <%-- <div>
        <c:forEach items="${values }" var="value">
            <div>
                <p>姓名：<label>${value.items.name_}</label></p>
                <p>电话：<label>${value.items.telpho_}</label></p>
                <p>地址：<label>${value.items.adr_}${value.items.exactadr_}</label></p>
                <p>备注：<label>${value.items.remark_}</label></p>
                <input type="text" name="name" readonly value="${value.items.name_}" />
                <input type="text" name="telephone" readonly value="${value.items.telpho_}"  /><br/>
                <input type="text" name="address" readonly value="${value.items.adr_}"/>
                <input type="text" name="remarks" readonly value="${value.items.remark_} "/>
                <c:if test="${value.items.adrState_ == 0}" >
                <div>
                    <input type="radio" name="def" id="mrsz" onclick="def('${value.items.id_}','${value.items.userId_}');" checked="checked">设置默认</br>
                    
                    <input type="button" name="del" value="删除" onclick="del('${value.items.id_}');">
                    <a href="FrmAdrmanage.updadr?id_=${value.items.id_}&falg=A">编辑</a>
                </div>
                </c:if>
                <c:if test="${value.items.adrState_ == 1}" >
                <div>
                    <input type="radio" name="def" id="mrsz" onclick="def('${value.items.id_}','${value.items.userId_}');" >设置默认</br>
                    
                    <input type="button" name="del" value="删除" onclick="del('${value.items.id_}');">
                    <a href="FrmAdrmanage.updadr?id_=${value.items.id_}&falg=A">编辑</a>
                </div>
                </c:if>
                
            </div>
        </c:forEach>
        <div><a href="FrmAdrmanage.goIncreaseadr">添加</a></div>
    </div> --%>
</body>
</html>