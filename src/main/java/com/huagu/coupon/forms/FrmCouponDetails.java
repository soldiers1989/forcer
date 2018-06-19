package com.huagu.coupon.forms;

import java.util.ArrayList;
import java.util.List;

import com.huagu.common.util.ParamUtil;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.AbstractJspPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;
import cn.cerc.jpage.grid.MutiPage;

public class FrmCouponDetails extends AbstractForm {
	/**
	 * 
	 * @ClassName: FrmGuideList
	 * @Description: 优惠券发布详情
	 * @author 李佳炫
	 * @date 2018年3月19日
	 *
	 */
	/*
	 * //查询优惠券 public IPage details() throws Exception { JspPage page = new
	 * JspPage(this, "coupon/CouponDetails.jsp"); LocalService svr = new
	 * LocalService(this, "SvrCouponDetails.details"); if (!svr.exec()) throw
	 * new RuntimeException(svr.getMessage());
	 * 
	 * page.add("coupon_list", svr.getDataOut().getRecords()); return page;
	 * 
	 * }
	 */

	/**
	 * @describe 优惠券发放记录后台查询展示
	 * @author 王姣
	 * @date 2018年3月21日下午5:35:19
	 * @return
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "coupon/CouponDetails.jsp");
		LocalService svr = new LocalService(this, "SvrCouponDetails.details");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("unlockDate_", this.getRequest().getParameter("unlockDate_"));
		headIn.setField("endDate_", this.getRequest().getParameter("endDate_"));
		headIn.setField("type_", this.getRequest().getParameter("type_"));
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("coupon_list", this.setPage(page, svr.getDataOut()));
		page.add("unlockDate_", getRequest().getParameter("unlockDate_"));
		page.add("endDate_", getRequest().getParameter("endDate_"));
		page.add("type_", getRequest().getParameter("type_"));
		ParamUtil.addLog(this, "查询", "后台优惠券发放记录后台查询展示", "后台优惠券发放记录后台查询展示");
		return page;
	}

	// 设置分页
	private List<Record> setPage(AbstractJspPage page, DataSet dataSet) {
		List<Record> records = null;
		MutiPage pages = new MutiPage();
		pages.setRequest(getRequest());
		pages.setDataSet(dataSet);
		pages.setPageSize(2);
		page.add("pages", pages);
		if (dataSet.size() > 0) {
			records = new ArrayList<>();
			for (int i = pages.getBegin(); i <= pages.getEnd(); i++) {
				dataSet.setRecNo(i + 1);
				Record record = dataSet.getCurrent();
				records.add(record);
			}
		}
		return records;
	}

	// 删除优惠券
	public IPage deleopinion() throws Exception {
		String couponId_ = this.getRequest().getParameter("couponId_");
		LocalService svr = new LocalService(this, "SvrCouponDetails.delcoupon");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("couponId_", couponId_);
		// System.out.println(couponId+"-0--------------------------------------------------------");
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		ParamUtil.addLog(this, "删除", "删除优惠卷", "删除优惠卷id：" +couponId_);
		return new RedirectPage(this, "FrmCouponDetails");
	}

	/**
	 * 优惠券使用情况（用户端）
	 * 
	 * @author 王姣
	 * @date 2018年3月22日上午10:38:19
	 * @return
	 */
	public IPage opnionUseInfo() throws Exception {
		JspPage page = new JspPage(this, "coupon/opnionUseInfo.jsp");
		LocalService svr = new LocalService(this, "SvrCouponDetails.details");
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("infos", svr.getDataOut().getRecords());
		return page;
	}

	@Override
	public boolean logon() {
		return true;
	}
}
