<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <%@include file="../ui/head1.jspf"%>
    <%@include file="../ui/head2.jspf" %> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>区域列表</title>
<style>
	table tr th{
		text-align:center !important;
	}
	table tr td:first-child{
		text-align:left !important;
	}
	.area{
		width:.8rem;
	}
	.ml_10{
		margin-right:10px;
	}
	.ml_20{
		margin-right:20px;
	}
	.ml_30{
		margin-right:30px;
	}
	.area_first{
		width:100%;
		height:100%;
	}
	.red{
		color:red;
	}
</style>
</head>
<body>
<div class="mid-box fl" id="mid-box">
    <div class="top pl_20 pr_20">
        <span class="min-col f16">区域列表</span>
    </div>
    <form action="" method="post" >
        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
            <a href="FrmArea.areaInsert" class="btn_style">添加</a>
            <a href="FrmArea" class="btn_style">刷新</a>
        </div>
    </form>

	<form action="">
	<div class="table">
		<table class="tbl" >
			<tr>
				<th class="t-head">区域名称</th>
				<th class="t-head">区域编码</th>
				<th class="t-head">区域类型</th>
				<th class="t-head">备注</th>
				<th class="t-head">操作</th>
			</tr>
			 <tbody class="t-body tc" id="userPage">
			 <tr class="country">
				 	<td>
				 		<div >
				 			<img src="${cdn }/img/right_area.png" class="area"><span id="country_" >${country.items.country_ }</span>
				 		</div>
				 	</td>
			 		<td>${country.items.areaNum_ }</td>
			 		<td>${country.items.areaType_ }</td>
			 		<td>${country.items.remark_ }</td>
			 	<td>
			 		<a href="FrmArea.areaDetails?UID_=${country.items.UID_ }" class="btn_style">查看</a>&nbsp;&nbsp;&nbsp;
					<a href="FrmArea.areaModify?UID_=${country.items.UID_ }" class="btn_style">修改</a>&nbsp;&nbsp;&nbsp;
					<%-- <a href="FrmArea.areaDelete?UID_=${area.items.UID_ }" class="btn_style">删除</a> --%>
					<a href="javascript:if(confirm('您确定刪除吗?'))location='FrmArea.areaDelete?UID_=${country.items.UID_ }';" class="btn_style">删除</a>&nbsp;&nbsp;&nbsp;
					<a href="#" class="btn_style">添加下级区域</a>
			 	</td>
		 	</tr>
			 <tbody class="t-body tc" id="userPage">
		</table>
		</div>
	</form>
<%-- <p><a href="FrmArea.areaInsert">添加</a></p>
<p><a href="FrmArea">刷新</a></p>
	<form action="">
		<table border="1px;">
			<tr>
				<td>省</td>
				<td>市</td>
				<td>区</td>
				<td>区域编码</td>
				<td>区域类型</td>
				<td>备注</td>
				<td>操作</td>
			</tr>
			<c:forEach items="${areas }" var="area">
			<tr>
				<td>${area.items.province_ }</td>
				<td>${area.items.city_ }</td>
				<td>${area.items.area_ }</td>
				<td>${area.items.areaNum_ }</td>
				<td>${area.items.areaType_ }</td>
				<td>${area.items.remark_ }</td>
				<td>
					<a href="FrmArea.areaDetails?UID_=${area.items.UID_ }">查看</a>&nbsp;&nbsp;&nbsp;
					<a href="FrmArea.areaModify?UID_=${area.items.UID_ }">修改</a>&nbsp;&nbsp;&nbsp;
					<a href="FrmArea.areaDelete?UID_=${area.items.UID_ }">删除</a>
					<a href="javascript:if(confirm('您确定刪除吗?'))location='FrmArea.areaDelete?UID_=${area.items.UID_ }';">删除</a>&nbsp;&nbsp;&nbsp;
					<a href="#">添加下级区域</a>
				</td>
			</tr>
			</c:forEach>
		</table>
	</form> --%>
	<script>
	function ajax(url,dataArea,area,ml,node){
		 $.ajax({
	            url: url,
	            type: "POST",
	            dataType: "text",
	            data:{
	            	country_:dataArea
	            },
	            async: false,
	            cache: false,
	            success: function(data) {
	                var vals = eval('(' +eval('(' + data + ')').va+ ')');
	                var str = "";
	                for(var i=0;i<vals.length;i++){
	                    var val = vals[i];
	                    var UID_ = val.UID_;
	                    var d = false;
	                    var province_ = "";
	                    var t = "";
	                    var img = "<img src='${cdn }/img/right_area.png' class='area'>";
	                    if(area=="country"){
	                    	province_ = val.country_;
	                    	d = true;
	                    }else if(area=="province"){
	                    	province_ = val.province_;
	                    	if(province_!=""){
	                    		d = true;
	                    	}
	                    }else if(area=="city"){
	                    	province_ = val.city_;
	                    	if(province_!=""){
	                    		d = true;
	                    	}
	                    }else if(area=="area"){
	                    	province_ = val.area_;
	                    	if(province_!=""){
	                    		d = true;
	                    		t = dataArea;
	                    	}
	                    	img ="";
	                    }
	                   if(d){
	                    var areaNum_ = val.areaNum_;
	                    var areaType_ = val.areaType_;
	                     str += "<tr class="+area+" name="+t+"><td><div class='area_first "+ml+"'>"
							str += img + "<span>" + province_ + "</span></td>";
							str += "</div></td><td>" + areaNum_ + "</td><td>" + areaType_ + "</td><td></td><td>";
							str += "<a href='FrmArea.areaDetails?UID_=" + UID_+"' class='btn_style mr_15'>查看</a><a href='FrmArea.areaModify?UID_=" + UID_+"&area="+area+"' class='btn_style mr_15'>修改</a>";
							str += "<a onclick='deleteArea("+ UID_ +",\""+area+"\")'  class='btn_style mr_15'>删除</a><a href='#' class='btn_style mr_15'>添加下级区域</a></td></tr>";
	                   }
	                   };              //   href="javascript:if(confirm('您确定刪除吗?'))location='FrmArea.areaDelete?UID_=${area.items.UID_ }';"
	                node.parent().after(str);
	            },
	            error: function(data) {
	                    alert("网络异常，请稍后再添加！");
	            }
	         })		
	}
	
	
		$(function(){
			//点击区域名称时，展开或者折叠区域
			$("table").on("click","tr td:first-child",function(){
				var area = $(this).parent().attr("class"); //class的值为country、province、city三种类型，用于判断展开或折叠区域类型
				var node = $(this);//当前点击的节点
				var state = $(this).find("img").attr("src");//当前点击节点状态图片的路径
				if(state.indexOf("right") != '-1'){//折叠状态，执行展开操作
					$(this).find("img").attr("src","${cdn}/img/down_area.png");
					if(area == "country"){
						var country_ = $("#country_").text();
							ajax("FrmArea.queryProvince",country_,"province","ml_10",node);
						}
					else if(area == "province"){
						var province = node.find("span").text();
							ajax("FrmArea.queryCity",province,"city","ml_20",node);
					}else if(area == "city"){
						var city = node.find("span").text();
						ajax("FrmArea.queryAera",city,"area","ml_30",node);
					}
				}else{//展开状态，执行折叠操作
					if(area == "country"){//折叠国家操作，移除当前节点外后的所有节点，并把状态片改为折叠
						$(this).parent().nextAll().remove();
						$(this).find("img").attr("src","${cdn}/img/right_area.png");
					}
					if(area == "province"){//折叠省级操作，移除到下一个省间的所有节点，并把状态片改为折叠
						$(this).parent().nextUntil($(".province"),"tr").remove();
						$(this).find("img").attr("src","${cdn}/img/right_area.png");
					}
					if(area == "city"){//折叠市级操作，获取市的名称；循环所有td，获取区的name(每个市下的区name相同)，二者相同则执行删除操作
						var node = $(this).find("span").text();
						$("table tr").each(function(){
							if($(this).attr("name") == node){
								$(this).remove();
							};
						})
						$(this).find("img").attr("src","${cdn}/img/right_area.png");
					}
				}
			})
		})
		function deleteArea(UID_,area){
			if(confirm("您确定刪除吗?")){
				window.location.href= "FrmArea.areaDelete?UID_=" + UID_+"&area="+area;
			}
			//href='javascript:if(confirm(\"您确定刪除吗?\"))location=\'FrmArea.areaDelete?UID_=" + UID_+"\'\'
		}
		
		
	</script>
</body>
</html>