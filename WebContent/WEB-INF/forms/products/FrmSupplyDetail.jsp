<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="${cdn }/css/order.css">
<script type="text/javascript"
	src="${cdn }/admin/js/jquery-1.9.1.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>供应商信息管理</title>
</head>
<body>

	<div class="mid-box fl" id="mid-box">
		<div class="top pl_20 pr_20">
			<span class="min-col f16">供应商信息管理</span>
		</div>
		<div id="subForm">
			<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
				<div class="fl leftSide">
					<form action="FrmAdminSupply" method="post" id="rentForm">
						<label>按公司简称</label> <input type="text" name="supplyShortName_"
							placeholder="请输入关键字搜索" value="${supplyShortName_}">
						<!-- <input type="submit" value="搜索"> -->
						<label class="ml_10">按手机号查询</label> <input type="text" name="tel_"
							placeholder="请输入关键字搜索" value="${tel_}">
						<!-- <input type="submit" value="搜索"> -->
						<label class="ml_10">按经营模式 查询</label> <input type="text"
							name="businessModel_" placeholder="请输入关键字搜索"
							value="${businessModel_}"> <input type="submit"
							value="搜索" class="mb_0">
					</form>
				</div>
				<div class="fr rightSide">
					<a href="FrmAdminSupply.toInsertSupply" class="btn_style">添加供应商</a>
				</div>
			</div>
		</div>
		<div role="grid">
			<div class="table">
				<table class="tbl">
					<tbody>
						<tr>
							<th class="t-head tc">序号</th>
							<th class="t-head tc">供应商编号</th>
							<th class="t-head tc">公司简称</th>
							<th class="t-head tc">公司全称</th>
							<th class="t-head tc">营业执照号</th>
							<th class="t-head tc">公司固话</th>
							<th class="t-head tc">供应物品范围</th>
							<th class="t-head tc">姓名</th>
							<th class="t-head tc">手机</th>
							<th class="t-head tc">QQ</th>
							<th class="t-head tc">经营模式</th>
							<th class="t-head tc">经营地址</th>
							<th class="t-head tc">注册资本（万人民币)</th>
							<th class="t-head tc">法人代表</th>
							<th class="t-head tc">关联物品状态</th>
							<th class="t-head tc">操作</th>
						</tr>
					</tbody>
					<tbody class="t-body tc">
						<c:forEach items="${values}" var="val" varStatus="status">
							<tr>
								<td>${ status.index + 1}</td>
								<td>${val.items.supplyId_ }</td>
								<td>${val.items.supplyShortName_ }</td>
								<td>${val.items.supplyFullName_ }</td>
								<td>${val.items.businessLicense_ }</td>
								<td>${val.items.companyTel_ }</td>
								<td>${val.items.supplyGoodsRange_ }</td>
								<td>${val.items.contact_ }</td>
								<td>${val.items.tel_ }</td>
								<td>${val.items.qq_ }</td>
								<td>${val.items.businessModel_ }</td>
								<td>${val.items.businessAdress_ }</td>
								<td>${val.items.registerMoney_ }</td>
								<td>${val.items.legalExpre_ }</td>
								<c:if test="${val.items.isAssociated_=='0'}">
									<td>未关联</td>
								</c:if>
								<c:if test="${val.items.isAssociated_!='0'}">
									<td>已关联</td>
								</c:if>
								<td><a
									href="FrmAdminSupply.toUpdateSupply?supplyId_=${val.items.supplyId_ }"
									class="btn_style mb_10">变更信息</a> <a
									href="FrmAdminSupply.delSupply?supplyId_=${val.items.supplyId_ }"
									onclick="javascript:return del();" class="btn_style">删除</a></td>
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
				<span>总条数：</span>${pages.recordCount}, 页数：${pages.current} /
				${pages.count}
			</div>
		</c:if>
	</div>
	<%-- <div>
<script type="text/javascript">
function page(pageno) {
    $("#rentForm").append(
            '<input type="hidden" name="pageno" value="'+ pageno +'">');
    $("#rentForm").submit();
}
</script>
<div class="mid-box fl" id="mid-box">
    <div class="top pl_20 pr_20">
        <span class="min-col f16">供应商信息管理</span>
    </div>
    <div id="subForm">
        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
            <div class="fl leftSide">
                <form action="FrmAdminSupply" method="post" id="rentForm">
                    <label>按公司简称</label>
                    <input type="text" name="supplyShortName_" placeholder="请输入关键字搜索" value="${supplyShortName_}"> 
                    <!-- <input type="submit" value="搜索"> -->
                    <label class="ml_10">按手机号查询</label>
                    <input type="text" name="tel_" placeholder="请输入关键字搜索" value="${tel_}"> 
                    <!-- <input type="submit" value="搜索"> -->
                    <label class="ml_10">按经营模式 查询</label>
                    <input type="text" name="businessModel_" placeholder="请输入关键字搜索" value="${businessModel_}"> 
                    <input type="submit" value="搜索" class="mb_0">
                </form>
            </div>
            <div class="fr rightSide">
                <a href="FrmAdminSupply.toInsertSupply" class="btn_style">添加供应商</a>
            </div>
        </div>
    </div>
    <div role="grid">
        <div class="table">
       <form action="" id="rentForm">
            <table class="tbl">
                <tbody>
                    <tr>
                        <th class="t-head tc">序号</th>
                        <th class="t-head tc">供应商编号</th>
                        <th class="t-head tc">公司简称</th>
                        <th class="t-head tc">公司全称</th>
                        <th class="t-head tc">营业执照号</th>
                        <th class="t-head tc">公司固话</th>
                        <th class="t-head tc">供应物品范围</th>
                        <th class="t-head tc">姓名</th>
                        <th class="t-head tc">手机</th>
                        <th class="t-head tc">QQ</th>
                        <th class="t-head tc">经营模式</th>
                        <th class="t-head tc">经营地址</th>
                        <th class="t-head tc">注册资本（万人民币)</th>
                        <th class="t-head tc">法人代表</th>
                        <th class="t-head tc">关联物品状态</th>
                        <th class="t-head tc">操作</th>
                    </tr>
                </tbody>
                <tbody class="t-body tc">
                    <c:forEach items="${values}" var="val" varStatus="status">
                        <tr>
                            <td>${ status.index + 1}</td>
                            <td>${val.items.supplyId_ }</td>
                            <td>${val.items.supplyShortName_ }</td>
                            <td>${val.items.supplyFullName_ }</td>
                            <td>${val.items.businessLicense_ }</td>
                            <td>${val.items.companyTel_ }</td>
                            <td>${val.items.supplyGoodsRange_ }</td>
                            <td>${val.items.contact_ }</td>
                            <td>${val.items.tel_ }</td>
                            <td>${val.items.qq_ }</td>
                            <td>${val.items.businessModel_ }</td>
                            <td>${val.items.businessAdress_ }</td>
                            <td>${val.items.registerMoney_ }</td>
                            <td>${val.items.legalExpre_ }</td>
                            <c:if test="${val.items.isAssociated_=='0'}">
                            <td>未关联</td>
                            </c:if>
                            <c:if test="${val.items.isAssociated_!='0'}">
                            <td>已关联</td>
                            </c:if>
                            <td>
                                <a href="FrmAdminSupply.toUpdateSupply?supplyId_=${val.items.supplyId_ }" class="btn_style mb_10">变更信息</a>
                                <a href="FrmAdminSupply.delSupply?supplyId_=${val.items.supplyId_ }"  onclick="javascript:return del();" class="btn_style">删除</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
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
    </div>
    
</div>
    <%-- <div>
        <span>供应商信息管理</span>
    </div>
    <hr>
        <div>
            <form action="FrmAdminSupply" method="post" id="rentForm">
                <label>按公司简称</label>
                    <input type="" name="supplyShortName_" placeholder="请输入关键字搜索" value="${supplyShortName_}"> 
                    <input type="submit" value="搜索">
                    
                <label>按手机号查询</label>
                    <input type="" name="tel_" placeholder="请输入关键字搜索" value="${tel_}"> 
                    <input type="submit" value="搜索">
                <label>按经营模式 查询</label>
                    <input type="" name="businessModel_" placeholder="请输入关键字搜索" value="${businessModel_}"> 
                    <input type="submit" value="搜索">
            </form>
        </div>
    <a href="FrmAdminSupply.toInsertSupply" >添加供应商</a>
    <form action="" id="subForm">
            <table>
                    <tr>
                        <td>供应商编号</td>
                        <td>公司简称</td>
                        <td>公司全称</td>
                        <td>营业执照号</td>
                        <td>公司固话</td>
                        <td>供应物品范围</td>
                        <td>姓名</td>
                        <td>手机</td>
                        <td>QQ</td>
                        <td>经营模式</td>
                        <td>经营地址</td>
                        <td>注册资本（万人民币</td>
                        <td>法人代表</td>
                        <td>关联物品状态</td>
                        <td>操作</td>
                    </tr>
                <c:forEach items="${values}" var="val">
                    <tr>
                        <td>${val.items.supplyId_ }</td>
                        <td>${val.items.supplyShortName_ }</td>
                        <td>${val.items.supplyFullName_ }</td>
                        <td>${val.items.businessLicense_ }</td>
                        <td>${val.items.companyTel_ }</td>
                        <td>${val.items.supplyGoodsRange_ }</td>
                        <td>${val.items.contact_ }</td>
                        <td>${val.items.tel_ }</td>
                        <td>${val.items.qq_ }</td>
                        <td>${val.items.businessModel_ }</td>
                        <td>${val.items.businessAdress_ }</td>
                        <td>${val.items.registerMoney_ }</td>
                        <td>${val.items.legalExpre_ }</td>
                        <c:if test="${val.items.isAssociated_=='0'}">
                        <td>未关联</td>
                        </c:if>
                        <c:if test="${val.items.isAssociated_!='0'}">
                        <td>已关联</td>
                        </c:if>
                        <td>
                            <a href="FrmAdminSupply.toUpdateSupply?supplyId_=${val.items.supplyId_ }">变更信息</a>
                            <a href="FrmAdminSupply.delSupply?supplyId_=${val.items.supplyId_ }"  onclick="javascript:return del();">删除</a>
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
    
    <script type="text/javascript">
    
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