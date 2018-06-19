package com.huagu.product.forms;

import java.util.ArrayList;
import java.util.List;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;

public class FrmWeiPro extends AbstractForm{

	//租赁物品的商品详情
	@Override
	public IPage execute() throws Exception {
		JspPage page;
		// type_有值进运维端页面  没值进用户端页面
		String type_ = this.getRequest().getParameter("type_");
		
		if("".equals(type_) || type_ == null)
			page = new JspPage(this, "products/FrmWeiProDetail.jsp");
		else
			page = new JspPage(this, "products/FrmWeiProDetailYw.jsp");
		
		String zhuCode_ = this.getRequest().getParameter("zhuCode_");
//		String zhuCode_ = "11123452345";
		//String proId_ = "1521770986201";
		//System.out.println("proId_"+proId_);
		LocalService svr =new LocalService(this, "SvrWeiPro.queryProDetail");
		Record head = svr.getDataIn().getHead();
		head.setField("zhuCode_", zhuCode_);
		if(!svr.exec()){
			throw new RuntimeException();
		}
		Record record = svr.getDataOut().getHead();
		String proLbImges_ = svr.getDataOut().getHead().getString("proLbImges_");
		proLbImges_ = proLbImges_.replace("[", "");
		proLbImges_ = proLbImges_.replace("]", "");
		String[] imgs = proLbImges_.split(",");
		List<String> list = new ArrayList<>();
		for (int i = 0; i < imgs.length; i++) {
		    list.add(imgs[i]);
        }
		page.add("proLbImges", list);
		page.add("value", record);
		LocalService svr1 =new LocalService(this, "SvrWeiPro.queryImg");
		Record head1 = svr1.getDataIn().getHead();
		head1.setField("proId_", svr.getDataOut().getHead().getString("proId_"));
		if(!svr1.exec()){
			throw new RuntimeException();
		}
		page.add("Img", svr1.getDataOut().getRecords());
		page.add("zhuCode_", zhuCode_);
		LocalService svrCollect =new LocalService(this, "SvrCollect.getCollectByProid");
        if(!svrCollect.exec("zhuCode_", zhuCode_)){
            throw new RuntimeException();
        }
        page.add("status_", svrCollect.getDataOut().getHead().getString("status_"));
        page.add("type_", type_);
        page.add("id_", this.getRequest().getParameter("a"));
        page.add("cid_", this.getRequest().getParameter("id_"));
		return page;
	}
	
	
	//售卖商品的详情
	public IPage saleProDetail() throws Exception {
		JspPage page =new JspPage(this, "products/FrmSale_proDetail.jsp");
		String ruKuId_ = this.getRequest().getParameter("ruKuId_");
		LocalService svr =new LocalService(this, "SvrWeiPro.querySaleProDetail");
		Record head = svr.getDataIn().getHead();
		head.setField("ruKuId_", ruKuId_);
		if(!svr.exec()){
			throw new RuntimeException();
		}
		Record record = svr.getDataOut().getHead();
		String proLbImges_ = svr.getDataOut().getHead().getString("proLbImges_");
		proLbImges_ = proLbImges_.replace("[", "");
		proLbImges_ = proLbImges_.replace("]", "");
		String[] imgs = proLbImges_.split(",");
		List<String> list = new ArrayList<>();
		for (int i = 0; i < imgs.length; i++) {
		    list.add(imgs[i]);
        }
		page.add("proLbImges", list);
		page.add("value", record);
		LocalService svr1 =new LocalService(this, "SvrWeiPro.queryImg");
		Record head1 = svr1.getDataIn().getHead();
		head1.setField("proId_", svr.getDataOut().getHead().getString("proId_"));
		if(!svr1.exec()){
			throw new RuntimeException();
		}
		page.add("Img", svr1.getDataOut().getRecords());
		LocalService queryColor =new LocalService(this, "SvrWeiPro.queryColor");
		Record headIn = queryColor.getDataIn().getHead();
		headIn.setField("proId_", svr.getDataOut().getHead().getString("proId_"));
		if(!queryColor.exec()){
			throw new RuntimeException();
		}
		page.add("proZsImges_",  queryColor.getDataOut().getRecords().get(0).getString("proZsImges_"));
		page.add("color", queryColor.getDataOut().getRecords());
		return page;
	}

		
	
	/**
	 * 用户对商品的评价详情
	 * @Title: queryProEvaluate 
	 * @Description: TODO 
	 * @author 乔晨光
	 * @param @return
	 * @param @throws Exception    
	 * @return IPage
	 */
	public IPage queryProEvaluate() throws Exception {
		JspPage page = new JspPage(this, "products/FrmEvaluateDetail.jsp");
		String proId_ = this.getRequest().getParameter("proId_");
		String evaLevel_ = this.getRequest().getParameter("evaLevel_");
		//测试用的
		//String proId_ = "1521440566484";
		LocalService svr =new LocalService(this, "SvrWeiPro.queryEvaluateDetail");
		Record head = svr.getDataIn().getHead();
		head.setField("proId_", proId_);
		head.setField("evaLevel_", evaLevel_);
		if(!svr.exec()){
			throw new RuntimeException();
		}
		List<Record> records = svr.getDataOut().getRecords();
		for(Record r:records ){
			String imgPath_ = r.getSafeString("imgPath_");
			imgPath_ = imgPath_.replace("[", "");	
			imgPath_ = imgPath_.replace("]", "");
			r.setField("imgPath_", imgPath_);
		}
		Record record = svr.getDataOut().getHead();
		page.add("sum", record.getInt("sum"));
		page.add("praise", record.getInt("praise"));
		page.add("average", record.getInt("average"));
		page.add("badReview", record.getInt("badReview"));
		page.add("proId_", proId_);
		page.add("evaLevel_", evaLevel_);
		page.add("value", svr.getDataOut().getRecords());
		return page;
		
	}
	
	public boolean logon() {
		return true;
	}
}
