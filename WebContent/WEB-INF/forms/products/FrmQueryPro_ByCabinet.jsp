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
<title>按机柜组查询物品存放情况</title>
</head>
<body>
<div class="mid-box fl" id="mid-box">
    <div class="top pl_20 pr_20">
        <span class="min-col f16">按机柜组查询物品存放情况</span>
    </div>
    <div id="subForm">
        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
            <div class="fl leftSide">
                <form action="FrmQueryPro_ByCabinet" method="post" id="rentForm" class="mb_10">
                    <label>按物品主电子条码</label>
                    <input type="text" name="zhuCode_" value="${zhuCode_ }" placeholder="请输入搜索的关键字"> 
                    <label>按物品归属机构</label>
                    <input type="text" name="homeAgency_" value="${homeAgency_ }" placeholder="请输入搜索的关键字"> 
                    <label>按柜组名称</label>
                    <input type="text" name="name_" value="${name_ }" placeholder="请输入搜索的关键字"> 
                    <label>按社区简称</label>
                    <input type="text" name="communityName_" value="${communityName_ }" placeholder="请输入搜索的关键字"> 
                     <label>按补货时间</label>
                    <input type="text" name="zhuCode_" value="${zhuCode_ }" placeholder="请输入搜索的关键字"> 
                    <input type="submit" value="查询" class="mb_0">
                </form>  
            </div>
            <div class="fr rightSide">
            <a href="FrmExcel?service=SvrQueryPro_ByCabinet.queryProByCabinet&amp;exportKey=SvrQueryPro_ByCabinet.queryProByCabinet&amp;templateId=queryProByCabinet" class="btn_style mb_0">导出电子标签</a>
            </div>
        </div>
    </div>
    <div role="grid">
        <div class="table">
            <table class="tbl">
                <tbody>
                    <tr>
                        <th class="t-head tc">序号</th>
                        <th class="t-head tc">机柜编号</th>
                        <th class="t-head tc">机柜名称</th>	
                        <th class="t-head tc">柜组所在社区简称</th>
                        <th class="t-head tc">"箱子锁编号（主键，有物品的查出来）"</th>
                        <th class="t-head tc">箱子内物品的名称</th>
                        <th class="t-head tc">箱子物品归属机构</th>
                        <th class="t-head tc">箱子物品主电子条码</th>
                        <th class="t-head tc">补货时间</th>
                    </tr>
                </tbody>
                <tbody class="t-body tc">
                    <c:forEach items="${value}" var="val"  varStatus="vs">
                        <tr>
                            <td>${vs.index+1}</td>
                            <td>${val.items.id_ }</td>
                            <td>${val.items.name_ }</td>
                            <td>${val.items.communityName_ }</td>
                            <td>${val.items.boxId_ }</td>
                            <td>${val.items.proName_ }</td>
                            <td>${val.items.homeAgency_ }</td>
                            <td>${val.items.zhuCode_ }</td>
                            <td>${val.items.boxId }</td>
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