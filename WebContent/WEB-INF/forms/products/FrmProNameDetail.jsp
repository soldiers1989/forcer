<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn }/admin/js/jquery-1.9.1.min.js"></script>
<title>物品详细</title>
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
        <span class="min-col f16">物品名称管理</span>
    </div>
    <div  >
        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
            <div class="fl leftSide">
                <form action="FrmAdminPro" method="post" id="subForm" class="mb_10">    
                    <label class="mr_10 back_hint6">按分级过滤：</label>
                    <span>一级：</span>
                    <select name="fristNameId_" id="fristName_">
                            <c:if test="${!empty fristName_ }">
                            <option value="fristNameId_">${fristName_ }</option>
                            </c:if>
                            <c:if test="${empty fristName_ }">
                            <option>请选择</option>
                            </c:if>
                    </select>
                    <span>二级：</span>
                    <select name="twoNameId_" id="twoName_">
                           <c:if test="${!empty twoName_ }">
                            <option value="twoNameId_">${twoName_ }</option>
                             </c:if>
                            <c:if test="${empty twoName_ }">
                            <option>请选择</option>
                            </c:if>
                    </select>
                    <input type="submit" value="查询" class="mb_0">
                </form>
                <form action="FrmAdminPro" method="post" id="subForm"  class="mb_10" >
                    <label class="mr_10 back_hint6">按物品名称：</label>
                    <input type="text" name="proName_" value="${proName_ }" placeholder="请输入搜索的关键字"> 
                    <input type="submit" class="mb_0" value="查询">
                </form>   
            </div>
            <div class="fr rightSide">
                <a href="FrmAdminPro.toInsertProductsName" class="btn_style">添加</a>
            </div>
        </div>
    </div>
    <div role="grid">
        <div class="table">
           <form action="" id="subForm">
           		 <table class="tbl">
                <tbody>
                    <tr>
                        <th class="t-head tc">序号</th>
                        <th class="t-head tc">一级类别</th>
                        <th class="t-head tc">二级类别</th>
                        <th class="t-head tc">物品名称（包含型号信息）</th>
                        <th class="t-head tc">关联售卖库存数</th>
                        <th class="t-head tc">关联主电子标签数</th>
                        <th class="t-head tc">售卖热推</th>
                        <th class="t-head tc">售卖分类菜单</th>
                        <th class="t-head tc">售卖精品</th>
                        <th class="t-head tc">售卖新品</th>
                        <th class="t-head tc">租赁热推</th>
                        <th class="t-head tc">租赁分类菜单</th>
                        <th class="t-head tc">租赁精品</th>
                        <th class="t-head tc">租赁新品</th>
                        <th class="t-head tc">操作</th>
                    </tr>
                </tbody>
                <tbody class="t-body tc">
                    <c:forEach items="${values}" var="val" varStatus="status">
                        <tr>
                            <td>${status.index +1}</td>
                            <td>${val.items.fristName_ }</td>
                            <td>${val.items.twoName_ }</td>
                            <td>${val.items.proName_ }</td>
                            <td>${val.items.proGuiCount_ }</td>
                            <td>${val.items.proLaberSum_ }</td>
                            <td><c:if test="${val.items.salesHotPush_==0}">否</c:if><c:if test="${val.items.salesHotPush_==1}">是</c:if></td>
                            <td><c:if test="${val.items.salesTypeMenu_==0}">否</c:if><c:if test="${val.items.salesTypeMenu_==1}">是</c:if></td>
                            <td><c:if test="${val.items.salesFine_==0}">否</c:if><c:if test="${val.items.salesFine_==1}">是</c:if></td>
                            <td><c:if test="${val.items.salesNewPro_==0}">否</c:if><c:if test="${val.items.salesNewPro_==1}">是</c:if></td>
                            <td><c:if test="${val.items.rentHotPush_==0}">否</c:if><c:if test="${val.items.rentHotPush_==1}">是</c:if></td>
                            <td><c:if test="${val.items.rentTypeMenu_==0}">否</c:if><c:if test="${val.items.rentTypeMenu_==1}">是</c:if></td>
                            <td><c:if test="${val.items.rentFine_==0}">否</c:if><c:if test="${val.items.rentFine_==1}">是</c:if></td>
                            <td><c:if test="${val.items.rentNewPro_==0}">否</c:if><c:if test="${val.items.rentNewPro_==1}">是</c:if></td>
                            <td>
                                <a href="FrmAdminPro.toUpdateProductsName?proId_=${val.items.proId_ }" class="btn_style mb_10">变更信息</a>
                                <a href="FrmAdminPro.delProductsName?proId_=${val.items.proId_ }"  onclick="javascript:return del();" class="btn_style">删除</a>
                            </td>
                        </tr>
                </c:forEach>
                </tbody>
            </table>
           </form>
        </div>
    </div>
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
        <span>物品名称管理</span>
    </div>
    <hr>
    <a href="FrmAdminPro.toInsertProductsName" >添加物品名称（包含信号信息）</a>
        <div>
            <form action="FrmAdminPro" method="post" id="rentForm">
                <label>按物品名称</label>
                    <input type="" name="proName_" value="${proName_ }" placeholder="请输入搜索的关键字"> 
                    <input type="submit" value="查询">
            </form>    
            <form action="FrmAdminPro" method="post" id="rentForm">    
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
    
    <form action="" id="subForm">
            <table>
                    <tr>
                        <td>一级类别</td>
                        <td>二级类别</td>
                        <td>物品名称（包含型号信息）</td>
                        <td>关联售卖库存数</td>
                        <td>关联主电子标签数</td>
                        <td>售卖热推</td>
                        <td>售卖分类菜单</td>
                        <td>售卖精品</td>
                        <td>售卖新品</td>
                        <td>租赁热推</td>
                        <td>租赁分类菜单</td>
                        <td>租赁精品</td>
                        <td>租赁新品</td>
                        <td>操作</td>
                    </tr>
                <c:forEach items="${values}" var="val">
                    <tr>
                        <td>${val.items.fristName_ }</td>
                        <td>${val.items.twoName_ }</td>
                        <td>${val.items.proName_ }</td>
                        <td>${val.items.proGuiCount_ }</td>
                        <td>${val.items.proLaberSum_ }</td>
                        <td><c:if test="${val.items.salesHotPush_==0}">否</c:if><c:if test="${val.items.salesHotPush_==1}">是</c:if></td>
                        <td><c:if test="${val.items.salesTypeMenu_==0}">否</c:if><c:if test="${val.items.salesTypeMenu_==1}">是</c:if></td>
                        <td><c:if test="${val.items.salesFine_==0}">否</c:if><c:if test="${val.items.salesFine_==1}">是</c:if></td>
                        <td><c:if test="${val.items.salesNewPro_==0}">否</c:if><c:if test="${val.items.salesNewPro_==1}">是</c:if></td>
                        <td><c:if test="${val.items.rentHotPush_==0}">否</c:if><c:if test="${val.items.rentHotPush_==1}">是</c:if></td>
                        <td><c:if test="${val.items.rentTypeMenu_==0}">否</c:if><c:if test="${val.items.rentTypeMenu_==1}">是</c:if></td>
                        <td><c:if test="${val.items.rentFine_==0}">否</c:if><c:if test="${val.items.rentFine_==1}">是</c:if></td>
                        <td><c:if test="${val.items.rentNewPro_==0}">否</c:if><c:if test="${val.items.rentNewPro_==1}">是</c:if></td>
                        <td>
                            <a href="FrmAdminPro.toUpdateProductsName?proId_=${val.items.proId_ }">变更信息</a>
                            <a href="FrmAdminPro.delProductsName?proId_=${val.items.proId_ }"  onclick="javascript:return del();">删除</a>
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
        $("#subForm").append(
                '<input type="hidden" name="pageno" value="'+ pageno +'">');
        $("#subForm").submit();
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