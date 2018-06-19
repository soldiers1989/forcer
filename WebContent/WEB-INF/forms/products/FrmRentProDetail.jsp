<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn }/admin/js/jquery-1.9.1.min.js"></script>
<title>租赁物品列表</title>
<script type="text/javascript">
$(document).ready(function(){
      $.ajax({
          url: "FrmAdminProType.queryProTypes",
        type: "POST",
        dataType: "text",
        async: true,
        cache: false,
        success: function(data) {
            var vals = eval('(' +eval('(' + data + ')').va+ ')');
            var str='';
            for(var i=0;i<vals.length;i++){
                var val = vals[i];
                var fristName_ = val.fristName_;
                var twoNameId_ = val.twoNameId_;
                var fristNameId_ = val.fristNameId_;
                str +="<option value='"+fristNameId_+"'>"+fristName_+"</option>";
                console.log(str);
            };
            $("#fristName_").append(str);
        },
        error: function(data) {
                alert("网络异常，请稍后再添加！");
        }
      })
});
</script> 
</head>
<body>
<div class="mid-box fl" id="mid-box">
    <div class="top pl_20 pr_20">
        <span class="min-col f16">租赁物品列表</span>
    </div>
    <div id="subForm">
        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
            <div class="fl leftSide">
                <form action="FrmAdminRentPro" method="post" id="rentForm" class="mb_10">    
                    <label>按分级过滤：</label>
                    <span>一级：</span>
                    <select name="fristNameId_" id="fristName_">
                        <option>请选择</option>
                    </select>
                    <span>二级：</span>
                    <select name="twoNameId_" id="twoName_">
                        <option selected>请选择</option>
                    </select>
                    <input type="submit" value="查询" class="mb_0">
                </form>
                <form action="FrmAdminRentPro" method="post" id="rentForm" class="mb_10">
                    <label>按物品名称</label>
                    <input type="text" name="proName_" value="${proName_ }" placeholder="请输入搜索的关键字"> 
                  <%--   <label>按电子条码反查物品名称</label>
                    <input type="text" name="zhuCode_" value="${zhuCode_ }" placeholder="请输入搜索的关键字"> --%> 
                    <input type="submit" value="查询" class="mb_0">
                </form>  
            </div>
            <div class="fr rightSide">
                <a href="FrmAdminRentPro.importNode" class="btn_style mb_0">导入/导出电子条码</a>
            </div>
        </div>
    </div>
    <form action="#" id="rentId">
	    <div role="grid">
	        <div class="table">
	            <table class="tbl">
	                <tbody>
	                    <tr>
	                        <th class="t-head tc">序号</th>
	                        <th class="t-head tc">物品名称ID</th>
	                        <th class="t-head tc">所属一级分类</th>
	                        <th class="t-head tc">所属二级分类</th>
	                        <th class="t-head tc">物品名称（+型号）</th>
	                        <th class="t-head tc">主标签总数</th>
	                        <th class="t-head tc">主标签在柜数</th>
	                        <th class="t-head tc">主标签在途数</th>
	                        <th class="t-head tc">主标签在租数</th>
	                        <th class="t-head tc">主标签报修数</th>
	                        <th class="t-head tc">物品价值总额</th>
	                        <th class="t-head tc">物品进价总额</th>
	                        <th class="t-head tc">操作</th>
	                    </tr>
	                </tbody>
	                <tbody class="t-body tc">
	                    <c:forEach items="${values}" var="val"  varStatus="vs">
	                        <tr>
	                            <td>${vs.index+1}</td>
	                            <td>${val.items.UID_ }</td>
	                            <td>${val.items.fristName_ }</td>
	                            <td>${val.items.twoName_ }</td>
	                            <td>${val.items.proName_ }</td>
	                            <td>${val.items.proLaberSum_ }</td>
	                            <td>${val.items.proGuiCount_ }</td>
	                            <td>${val.items.proTuCount_ }</td>
	                            <td>${val.items.proRentCount_ }</td>
	                            <td>${val.items.proFixCount_ }</td>
	                            <td>￥ ${val.items.price_ }</td>
	                            <td>￥ ${val.items.proCostPrice_ }</td>
	                            <td>
	                            <div>
	                            <c:if test="${not empty val.items.cashPledge_ }">
		                             <a href="FrmAdminRentPro.toInsertProNode?proId_=${val.items.proId_ }" class="btn_style mb_10" >添加电子标签</a>
		                             <a href="FrmAdminRentPro.queryNodeList?proId_=${val.items.proId_ }" class="btn_style mb_10"  >变更电子标签</a>
		                         </c:if>
		                          <c:if test="${val.items.cashPledge_  == null || val.items.cashPledge_  == '' || val.items.cashPledge_  == '0.0'}">
		                             <a href="#" class="btn_style mb_10" style="background-color: #e0dbdb">添加电子标签</a>
		                             <a href="#" class="btn_style mb_10" style="background-color: #e0dbdb">变更电子标签</a>
		                         </c:if>
	                            </div>
	                            
	                            <div>
		                             <c:if test="${val.items.cashPledge_  == null || val.items.cashPledge_  == '' || val.items.cashPledge_  == '0.0'}">
			                       		 <a href="FrmAdminRentPro.toInsertProAttr?proId_=${val.items.proId_ }" class="btn_style mb_10">添加物品属性</a>
		                             	 <a href="3" class="btn_style mb_10" style="background-color: #e0dbdb">变更物品属性</a>
		                             </c:if>
	                                  <c:if test="${not empty val.items.cashPledge_ }">
	                                   	<a href="#" class="btn_style mb_10" style="background-color: #e0dbdb">添加物品属性</a>
		                        		<a href="FrmAdminRentPro.toUpdateProAttr?proId_=${val.items.proId_ }" class="btn_style mb_10">变更物品属性</a>
		                        	 </c:if>
	                            </div>
	                            </td>
	                        </tr>
	                    </c:forEach>
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
            <span>总条数：</span>${pages.recordCount}, 页数：${pages.current} / ${pages.count}
        </div>
    </c:if>
</div>
    <%-- <div>
        <span>租赁物品列表</span>
    </div>
    <hr>
        <div>
            <form action="FrmAdminRentPro" method="post" id="rentForm">
                <label>按物品名称</label>
                    <input type="" name="proName_" value="${proName_ }" placeholder="请输入搜索的关键字"> 
                    <input type="submit" value="查询">
            </form>    
            <form action="FrmAdminRentPro" method="post" id="rentForm">
                <label>按电子条码反查物品名称</label>
                    <input type="" name="zhuCode_" value="${zhuCode_ }" placeholder="请输入搜索的关键字"> 
                    <input type="submit" value="查询">
            </form>    
            <form action="FrmAdminRentPro" method="post" id="rentForm">
                <label>按分级过滤</label>
                    <span>一级：</span>
                    <select name="fristNameId_" id="fristName_">
                            <option>请选择</option>
                    </select>
                    <span>二级：</span>
                    <select name="twoNameId_" id="twoName_">
                            <option selected>请选择</option>
                    </select>
                    <input type="submit" value="查询">
            </form>
        </div>
        <div><a href="FrmAdminRentPro.importNode"><button>导入/导出电子条码</button></a></div>
    <form action="" id="subForm">
            <table>
                    <tr>
                        <td>序号</td>
                        <td>物品名称ID</td>
                        <td>所属一级分类</td>
                        <td>所属二级分类</td>
                        <td>物品名称（+型号）</td>
                        <td>主标签总数</td>
                        <td>主标签在柜数</td>
                        <td>主标签在途数</td>
                        <td>主标签在租数</td>
                        <td>主标签报修数</td>
                        <td>物品价值总额</td>
                        <td>物品进价总额</td>
                        <td>操作</td>
                    </tr>
                <c:forEach items="${values}" var="val"  varStatus="vs">
                    <tr>
                        <td>${vs.index+1}</td>
                        <td>${val.items.UID_ }</td>
                        <td>${val.items.fristName_ }</td>
                        <td>${val.items.twoName_ }</td>
                        <td>${val.items.proName_ }</td>
                        <td>${val.items.proLaberSum_ }</td>
                        <td>${val.items.proGuiCount_ }</td>
                        <td>${val.items.proTuCount_ }</td>
                        <td>${val.items.proRentCount_ }</td>
                        <td>${val.items.proFixCount_ }</td>
                        <td>￥ ${val.items.price_ }</td>
                        <td>￥ ${val.items.proCostPrice_ }</td>
                        <td>
                            <a href="FrmAdminRentPro.toInsertProNode?proId_=${val.items.proId_ }">添加</a>
                            <a href="FrmAdminRentPro.queryNodeList?proId_=${val.items.proId_ }">/变更电子标签</a>
                            <a href="FrmAdminRentPro.toInsertProAttr?proId_=${val.items.proId_ }">添加/</a>
                            <a href="FrmAdminRentPro.toInsertProAttr?proId_=${val.items.proId_ }">变更物品属性</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
    </form>
        <c:if test="${pages.count >= 1}">
            <div class="foot-page" align="center">
                <a href="javascript:page(1);" class='page-index Shouw'>首页</a> <a
                    href="javascript:page(${pages.prior});">上一页</a> <a
                    href="javascript:page(${pages.next});">下一页</a> <a
                    href="javascript:page(${pages.count});" class="page-last Shouw">尾页</a>
                总条数：${pages.recordCount}, 页数：${pages.current} / ${pages.count}
            </div>
        </c:if> --%>
    
<script type="text/javascript">
//动态显示二级分类
$("#fristName_").on("change",function(){
    $("#twoName_").empty();
    var fristNameId_=$(this).val();
    $.ajax({
        url: "FrmAdminProType.queryType",
        type: "POST",
        data:{fristNameId_:fristNameId_},
        dataType: "text",
        async: false,
        cache: false,
        success: function(data) {
            var vals = eval('(' +eval('(' + data + ')').va+ ')');
            var str = ''; 
            for(var i=0;i<vals.length;i++){
                var val = vals[i];
                var twoName_ = val.twoName_;
                var twoNameId_ = val.twoNameId_;
                var fristNameId_ = val.fristNameId_;
                str +="<option value='"+twoNameId_+"'>"+twoName_+"</option>";
                console.log(str);
            }
            $("#twoName_").append(str);
        },
        error: function(data) {
                alert("网络异常，请稍后重试！");
        }
    })
})    

    function page(pageno) {
        $("#rentId").append(
                '<input type="hidden" name="pageno" value="'+ pageno +'">');
        $("#rentId").submit();
    }
    function del() {
      var msg = "您确定要删除吗？";
      if (confirm(msg) == true) {
        return true;
      } else {
        return false;
      }
    }
</script>
</body>
</html>