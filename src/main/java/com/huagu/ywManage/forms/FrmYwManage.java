package com.huagu.ywManage.forms;

import java.util.List;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;
/**
 * 前台运维管理
 * @author wj  
 * @date 2018年4月27日 
 *
 */
public class FrmYwManage extends AbstractForm {

	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "ywmanage/yunWeiManage.jsp");
		//运维单
		LocalService svr = new LocalService(this, "SvrYunWeiQuery");
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		
		if(!svr.getDataOut().bof())
			jsp.add("yunweis", svr.getDataOut().getRecords());
		
		
		//调货单
		LocalService svrDh = new LocalService(this, "SvrDiaoHuoQuery");
		if(!svrDh.exec()){
			throw new RuntimeException(svrDh.getMessage());
		}
		if(!svrDh.getDataOut().bof())
			jsp.add("diaohuos", svrDh.getDataOut().getRecords());
		
		//补货单
		LocalService svrBh = new LocalService(this, "SvrAddGoodsQuery");
		
		if(!svrBh.exec())
			throw new RuntimeException(svrBh.getMessage());
		if(!svrBh.getDataOut().bof())
			jsp.add("addGoods", svrBh.getDataOut().getRecords());
		
		
		return jsp;
	}
	

	/**
	 *  前台运维单详情查看
	 *  @author wj  
	 *  @date 2018年4月27日  
	 */
	public IPage lookYunWeiDetails() throws Exception{
		JspPage  jsp = new JspPage(this, "ywmanage/ywDetails.jsp");
		LocalService svr = new LocalService(this, "SvrYDetailsQuery");
		Record head = svr.getDataIn().getHead();
		head.setField("operateId_", this.getRequest().getParameter("operateId_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		List<Record> records = svr.getDataOut().getRecords();
		for(Record r:records ){
		      String imgPath_ = r.getSafeString("imgPath_");
		      imgPath_ = imgPath_.replace("[", "");  
		      imgPath_ = imgPath_.replace("]", "");
		      r.setField("imgPath_", imgPath_);
		    }
		if(!svr.getDataOut().bof())
			jsp.add("yunwei", svr.getDataOut().getCurrent());
		return jsp;
	}
	
	/**
	 *  调货单详情查看
	 *  @author wj   
	 *  @date 2018年4月27日
	 */
	public IPage lookDiaoHuoDetails() throws Exception{
		JspPage  jsp = new JspPage(this, "ywmanage/dhDetails.jsp");
		LocalService svr = new LocalService(this, "SvrDHetailsQuery");
		Record head = svr.getDataIn().getHead();
		head.setField("operateId_", this.getRequest().getParameter("operateId_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		if(!svr.getDataOut().bof())
			jsp.add("diaohuo", svr.getDataOut().getCurrent());
		return jsp;
	}
	
	/**
	 * 补货单详情查看
	 *  @author wj    
	 *  @date 2018年4月27日
	 */
	public IPage lookBuHuoDetails() throws Exception{
		JspPage  jsp = new JspPage(this, "ywmanage/bhDetails.jsp");
		LocalService svr = new LocalService(this, "SvrBHetailsQuery");
		Record head = svr.getDataIn().getHead();
		head.setField("operateId_", this.getRequest().getParameter("operateId_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		List<Record> records = svr.getDataOut().getRecords();
		for(Record r:records ){
		      String imgPath_ = r.getSafeString("imgPath_");
		      imgPath_ = imgPath_.replace("[", "");  
		      imgPath_ = imgPath_.replace("]", "");
		      r.setField("imgPath_", imgPath_);
		    }
		if(!svr.getDataOut().bof())
			jsp.add("buhuo", svr.getDataOut().getCurrent());
		return jsp;
	}
	
	@Override
	public boolean logon() {
		return true;
	}

}
