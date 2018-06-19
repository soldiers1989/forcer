<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<title>分类管理</title>
<style type="text/css">
    #subForm .leftSide input[type='text']{
        margin-bottom: 0;
        width: 153px;
    }
    #subForm .leftSide select{
        margin-bottom: 0;
        width: 153px;
    }
   .back_hint4{
   		 width: 76px;
    }
    .w_30{
    	width:30%;
    }
     .w_40{
    	width:40%;
    }
</style>
<script type="text/javascript">
    function huan(node){
        var fid=$(node).parent().find("input").val();
        var twoLength=$(node).parent().next().find("input[name='twoNameId_']").length;
        if(twoLength==0){
        $.ajax({
            url: "FrmAdminProType.queryType",
            type: "POST",
            data:{"fristNameId_":fid},
            dataType: "text",
            async: false,
            cache: false,
            success: function(data) {
                var vals = eval('(' + eval('(' + data + ')').va + ')');
                var str = ''; 
                for(var i=0;i<vals.length;i++){
                    var val = vals[i];
                    var twoNameId_ = val.twoNameId_;
                    var twoName_ = val.twoName_;
                    var fristNameId_ = val.fristNameId_;
                    str +="<tr><td></td><td onclick='erhuan(this)'>"+twoName_+
                    "<input type='hidden' value="+fristNameId_+" name='fristNameId_'></td>"+
                    "<input type='hidden' value="+twoNameId_+" name='twoNameId_'></td>"+
                    "<td><a class='btn_style mr_10' href='FrmAdminProType.toUpdateType?fristNameId_="+fristNameId_+"&twoNameId_="+twoNameId_+"'>编辑</a>"+
                    "<a class='btn_style' href='FrmAdminProType.delType?twoNameId_="+twoNameId_+"' onclick='javascript:return del()'>删除</a>"+
                    "</td></tr>";
                }
                $(node).parent().after(str);
            },
            error: function(data) {
                    alert("网络异常，请稍后查询！");
            }
        })
        }else{
            return false;
        }
    }
    
    //页面加载后显示一级分类的下拉
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
        <span class="min-col f16" onclick="asd()">商品分类管理</span>
    </div>
    <div id="subForm">
        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
            <div class="fl leftSide">
                <form action="FrmAdminProType" method="post" id="rentForm" class="mb_10">    
                    <label class="mr_10 back_hint4">分类名称：</label>
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
                <form action="FrmAdminProType" method="post" id="rentForm"  class="mb_10" >
                    <label class="mr_10 back_hint4">分类名称：</label>
                    <input type="text" name="proName_" value="${proName_ }" placeholder="请输入搜索的关键字"> 
                    <input type="submit" class="mb_0" value="查询">
                </form>    
                <a href="FrmAdminProType.toInsertProType" class="btn_style">+新增分类</a>
            </div>
        </div>
    </div>
    <div role="grid">
        <div class="table">
            <table class="tbl">
                <tbody>
                    <tr>
                        <th class="t-head tc w_30">序号</th>
                        <th class="t-head tc w_30">分类名称</th>
                        <th class="t-head tc w_40">操作</th>
                    </tr>
                </tbody>
                <tbody class="t-body tc">
                    <c:forEach items="${values }" var="value" varStatus="status">
                        <tr>
                            <td>${ status.index + 1}</td>
                            <td onclick="huan(this)">${value.items.fristName_ }
                                <input type="hidden" value="${value.items.fristNameId_ }" name="fristNameId_">
                            </td>
                            <td>
                                <a href="FrmAdminProType.toInsertProType?fristNameId_=${value.items.fristNameId_ }" class="btn_style">新增下级</a>
                                <a href="FrmAdminProType.toUpdateType?fristNameId_=${value.items.fristNameId_ }" class="btn_style">编辑</a>
                                <a href="FrmAdminProType.delType?fristNameId_=${value.items.fristNameId_ }" onclick="javascript:return del();" class="btn_style">删除</a>
                            </td>
                        </tr>
                        <c:if test="${!empty twoName_ }">
                         <tr>
                            <td></td>
                            <td >${value.items.twoName_ }
                                <input type="hidden" value="${value.items.twoNameId_ }" name="twoNameId_">
                            </td>
                            <td>
                                <a href="FrmAdminProType.toUpdateType?fristNameId_=${value.items.fristNameId_ }&twoNameId_=${value.items.twoNameId_ }" class="btn_style">编辑</a>
                                <a href="FrmAdminProType.delType?twoNameId_=${value.items.twoNameId_ }" onclick="javascript:return del();" class="btn_style">删除</a>
                            </td>
                        </tr>
                        </c:if>
                    </c:forEach>
                </tbody>
            </table>
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
        <span onclick="asd()">商品分类管理</span>
    </div>
    <hr>
        <div>
            <form action="FrmAdminProType" method="post" id="rentForm">    
                <label>分类名称</label>
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
            <form action="FrmAdminProType" method="post" id="rentForm">
                <label>关键字</label>
                    <input type="" name="proName_" value="${proName_ }" placeholder="请输入搜索的关键字"> 
                    <input type="submit" value="查询">
            </form>    
                <a href="FrmAdminProType.toInsertProType">+新增分类</a>
        </div>
        
        </p>
        <form action="" id="subForm">
            <table>
                    <tr><td>分类名称</td>
                    <td>操作</td></tr>
                <c:forEach items="${values }" var="value">
                    <tr>
                    <td onclick="huan(this)">${value.items.fristName_ }
                    <input type="hidden" value="${value.items.fristNameId_ }" name="fristNameId_"></td>
                    <td><a href="FrmAdminProType.toInsertProType?fristNameId_=${value.items.fristNameId_ }">+新增下级，</a>
                    <a href="FrmAdminProType.toUpdateType?fristNameId_=${value.items.fristNameId_ }">编辑，</a>
                    <a href="FrmAdminProType.delType?fristNameId_=${value.items.fristNameId_ }" onclick="javascript:return del();">删除</a></td>
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