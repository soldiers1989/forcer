<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
    <%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/layui/layui.js"></script>
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<head>
<body>
<script type="text/javascript">
    function page(pageno) {
        $("#subForm").append(
                '<input type="hidden" name="pageno" value="'+ pageno +'">');
        $("#subForm").submit();
    }
</script>
<script type="text/javascript">
  layui.use('laydate', function(){
      var laydate = layui.laydate; 
    });
</script>
<script type="text/javascript">
$(function(){
$('#sub').on('click', function() {
    var startdate=$('#unlockDate_').val();
  var enddate=$('#endDate_').val();
  if(startdate != null && startdate!=""){
  if(startdate>enddate){ 
    alert("结束时间必须大于开始时间");
    return false;
    }
  }
    });
})
</script>
<div class="mid-box fl" id="mid-box">
    <div class="top pl_20 pr_20">
        <span class="min-col f16">资讯管理列表</span>
    </div>
    <form action="FrmInformationList" method="post" id="subForm">
        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
            <div class="fl leftSide">
                <span>反馈时间：</span>
                <input type="text" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="unlockDate_" id="unlockDate_"  placeholder="起始日期" value="${unlockDate_ }"/><span class="mr_10"> -至- </span>
                <input type="text" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="endDate_" id="endDate_"  placeholder="终止日期" value="${endDate_ }"/>
                <span>类型：</span>
                <select name="type_">
                    <option value="0" <c:if test="${type_ eq '0' }">selected="selected"</c:if>>全部</option>
                    <option value="1" <c:if test="${type_ eq '1' }">selected="selected"</c:if>>使用流程</option>
                    <option value="2" <c:if test="${type_ eq '2'}">selected="selected"</c:if>>商务合作</option>
                    <option value="3" <c:if test="${type_ eq '3' }">selected="selected"</c:if>>联系客服</option>
                    <option value="4" <c:if test="${type_ eq '4' }">selected="selected"</c:if>>关于我们</option>
                    <option value="5" <c:if test="${type_ eq '5' }">selected="selected"</c:if>>用户租赁</option>
                    <option value="6" <c:if test="${type_ eq '6'}">selected="selected"</c:if>>运维服务</option>
                    <option value="7" <c:if test="${type_ eq '7' }">selected="selected"</c:if>>银行卡绑定</option>
                    <option value="8" <c:if test="${type_ eq '8' }">selected="selected"</c:if>>积分规则</option>
                    <option value="9" <c:if test="${type_ eq '9' }">selected="selected"</c:if>>公益捐款</option>
                    <option value="10" <c:if test="${type_ eq '10'}">selected="selected"</c:if>>优惠券使用</option>
                    <option value="11" <c:if test="${type_ eq '11' }">selected="selected"</c:if>>签到规则</option>
                    <option value="12" <c:if test="${type_ eq '12' }">selected="selected"</c:if>>用户等级</option>
                    <option value="13" <c:if test="${type_ eq '13' }">selected="selected"</c:if>>快递至启享柜</option>
                    <option value="14" <c:if test="${type_ eq '14'}">selected="selected"</c:if>>芝麻信用减免</option>
                    <option value="15" <c:if test="${type_ eq '15' }">selected="selected"</c:if>>活体影像减免</option>
                    <option value="16" <c:if test="${type_ eq '16' }">selected="selected"</c:if>>手机号减免押金</option>
                    <option value="17" <c:if test="${type_ eq '17' }">selected="selected"</c:if>>邀请好友</option>
                </select>
                <button class="btn_style mb_0">查询</button>
            </div>
        </div>
    </form>
    <div role="grid">
        <div class="table">
            <table class="tbl">
                <tbody>
                    <tr>
                        <th class="t-head">序号</th>
                        <th class="t-head">文章标题</th>
                        <th class="t-head">发布时间</th>
                        <th class="t-head">操作</th>
                    </tr>
                </tbody>
                <tbody class="t-body tc" id="userPage">
                    <c:if test="${empty values}"><img src="../../img/zwsj.png"></c:if>
                    <c:if test="${not empty values}"></c:if>
                    <c:forEach items="${values }" var="values" varStatus="status">
                        <tr>
                            <td>${status.index+1 }</td>
                            <td>${values.items.title_ }</td>
                            <td>${values.items.date_ }</td>
                            <td>
                                <a href="FrmRentPact.LeaseSel?type_=${values.items.type_}" class="btn_style mr_10">修改</a>
                                <a href="FrmInformationList.infoDetails?type_=${values.items.type_}" class="btn_style">查看</a>
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
<%-- <form action="" id="subForm">
    <p>
        反馈时间：<input type="text" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="unlockDate_" id="unlockDate_"  placeholder="起始日期" value="${unlockDate_ }"/><font> -至- </font>
        <input type="text" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="endDate_" id="endDate_"  placeholder="终止日期" value="${endDate_ }"/>
    </p>
    <select name="type_">
        <option value="0" <c:if test="${type_ eq '0' }">selected="selected"</c:if>>全部</option>
        <option value="1" <c:if test="${type_ eq '1' }">selected="selected"</c:if>>使用流程</option>
        <option value="2" <c:if test="${type_ eq '2'}">selected="selected"</c:if>>商务合作</option>
        <option value="3" <c:if test="${type_ eq '3' }">selected="selected"</c:if>>联系客服</option>
        <option value="4" <c:if test="${type_ eq '4' }">selected="selected"</c:if>>关于我们</option>
        <option value="5" <c:if test="${type_ eq '5' }">selected="selected"</c:if>>用户租赁</option>
        <option value="6" <c:if test="${type_ eq '6'}">selected="selected"</c:if>>运维服务</option>
        <option value="7" <c:if test="${type_ eq '7' }">selected="selected"</c:if>>银行卡绑定</option>
        <option value="8" <c:if test="${type_ eq '8' }">selected="selected"</c:if>>积分规则</option>
        <option value="9" <c:if test="${type_ eq '9' }">selected="selected"</c:if>>公益捐款</option>
        <option value="10" <c:if test="${type_ eq '10'}">selected="selected"</c:if>>优惠券使用</option>
        <option value="11" <c:if test="${type_ eq '11' }">selected="selected"</c:if>>签到规则</option>
        <option value="12" <c:if test="${type_ eq '12' }">selected="selected"</c:if>>用户等级</option>
        <option value="13" <c:if test="${type_ eq '13' }">selected="selected"</c:if>>快递至启享柜</option>
        <option value="14" <c:if test="${type_ eq '14'}">selected="selected"</c:if>>芝麻信用减免</option>
        <option value="15" <c:if test="${type_ eq '15' }">selected="selected"</c:if>>活体影像减免</option>
        <option value="16" <c:if test="${type_ eq '16' }">selected="selected"</c:if>>手机号减免押金</option>
        <option value="17" <c:if test="${type_ eq '17' }">selected="selected"</c:if>>邀请好友</option>
    </select>
    <button>查询</button>
</form>
<form action="" id="subForm">
    <table border="1px;">
        <tr>
            <td>序号</td>
            <td>文章标题</td>
            <td>发布时间</td>
            <td>操作</td>
        </tr>
        <c:if test="${empty values}"><img src="../../img/zwsj.png"></c:if>
            <c:if test="${not empty values}"></c:if>
    <c:forEach items="${values }" var="values" varStatus="status">
        <tr>
            <td>${status.index+1 }</td>
            <td>${values.items.title_ }</td>
            <td>${values.items.date_ }</td>
            <td>
                <a href="FrmRentPact.LeaseSel?type_=${values.items.type_}">修改</a>&nbsp;&nbsp;&nbsp;
                <a href="FrmInformationList.infoDetails?type_=${values.items.type_}">查看</a>
            </td>
        </tr>
    </c:forEach>
    </table>
</form>
<c:if test="${pages.count >= 1}">
        <div class="foot-page">
            <a href="javascript:page(1);" class='page-index Shouw'>首页</a> <a
                href="javascript:page(${pages.prior});">上一页</a> <a
                href="javascript:page(${pages.next});">下一页</a> <a
                href="javascript:page(${pages.count});" class="page-last Shouw">尾页</a>
            条数：${pages.recordCount}, 页数：${pages.current} / ${pages.count}
        </div>
    </c:if> --%>
</body>
</html>