<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>    
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn }/admin/js/jquery-1.9.1.min.js"></script>
<title>入库单列表</title>
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
        <span class="min-col f16">入库单列表</span>
    </div>
    <div id="subForm">
        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
         <div class="fr rightSide">
        	<a href="FrmExcel?service=SvrSaleProManage.queryRKList&amp;exportKey=SvrSaleProManage.queryRKList&amp;templateId=queryRKList" class="btn_style mb_0">查询结果导出</a>
          </div>
            <div class="fl leftSide">
                <form action="FrmSale_queryRK" method="post" id="rentForm" class="mb_10">    
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
                <form action="FrmSale_queryRK" method="post" id="rentForm" class="mb_10">
                    <label>按物品名称</label>
                    <input type="text" name="proName_" value="${proName_ }" placeholder="请输入搜索的关键字"> 
                    <label>归属机构简称</label>
                    <input type="text" name="saleHomeAgency_" value="${saleHomeAgency_ }" placeholder="请输入搜索的关键字"> 
                      <label>供应商简称</label>
                    <input type="text" name="saleSupply_" value="${saleSupply_ }" placeholder="请输入搜索的关键字"> 
                      <label>入库时间</label>
                    <input type="date" name="saleRuKuTime_" value="${saleRuKuTime_ }" placeholder="请输入搜索的关键字"> 
                    <input type="submit" value="查询" class="mb_0">
                </form>  
            </div>
        </div>
    </div>
    <div role="grid">
        <div class="table">
            <table class="tbl">
                <tbody>
                    <tr>
                        <th class="t-head tc">序号</th>
                        <th class="t-head tc">入库单号</th>
                        <th class="t-head tc">一级类别</th>
                        <th class="t-head tc">二级类别</th>
                        <th class="t-head tc">物品名称（+型号）</th>
                        <th class="t-head tc">供应商</th>
                        <th class="t-head tc">物品归属机构</th>
                        <th class="t-head tc">进价单价</th>
                        <th class="t-head tc">原始库存数</th>
                        <th class="t-head tc">冲红数量</th>
                        <th class="t-head tc">冲红后物品库存总数</th>
                        <th class="t-head tc">入库时间</th>
                        <th class="t-head tc">最后冲红时间</th>
                        <th class="t-head tc">质保截止时间</th>
                        <th class="t-head tc">操作</th>
                    </tr>
                </tbody>
                <tbody class="t-body tc">
                    <c:forEach items="${value}" var="val"  varStatus="vs">
                        <tr>
                            <td>${vs.index+1}</td>
                            <td>${val.items.ruKuId_ }</td>
                            <td>${val.items.fristName_ }</td>
                            <td>${val.items.twoName_ }</td>
                            <td>${val.items.proName_ }</td>
                            <td>${val.items.saleSupply_ }</td>
                            <td>${val.items.saleHomeAgency_ }</td>
                            <td>￥${val.items.jinPrice_ }</td>
                            <td>${val.items.ruKuCount_ }</td>
                            <td>${val.items.chCount_ }</td>
                            <td>${val.items.sumKuCun_ }</td>
                           <td> <fmt:formatDate value="${val.items.saleRuKuTime_ }" type="date" pattern="yyyy-MM-dd"/></td>
                            <td><fmt:formatDate value="${val.items.chTime_ }" type="date" pattern="yyyy-MM-dd"/></td>
                            <td><fmt:formatDate value="${val.items.saleServerDeadTime_ }" type="date" pattern="yyyy-MM-dd"/></td>
                            <td>
                            <div>
                             <a href="FrmSale_queryRK.toCHong?ruKuId_=${val.items.ruKuId_ }" class="btn_style mb_10">入库单冲红</a>
                            </div>
                            </td>
                        </tr>
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