package com.huagu.order.forms;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.log4j.Logger;

import com.huagu.common.util.ParamUtil;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jbean.tools.MD5;
import cn.cerc.jdb.core.IHandle;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;

/**
 * 异常单相关
 * @author xiaofei-pc
 *
 */
public class FrmYcOrder extends AbstractForm{
	public Logger log = Logger.getLogger(this.getClass());
	
	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "order/ycOrderList.jsp");
		LocalService getYcOrder = new LocalService(this, "SvrGetYcOrder");
		if(!getYcOrder.exec())
			throw new RuntimeException(getYcOrder.getMessage());
		
		ParamUtil.addLog(this, "查询", "查询后台异常单列表", "查询后台异常单列表");
		jsp.add("ycOrder", getYcOrder.getDataOut().getRecords());
		return jsp;
	}
	
    // 查询异常订单
    public IPage getYcOrder() throws Exception {
        JspPage page = new JspPage(this, "order/ycOrderList.jsp");
        LocalService svr = new LocalService(this, "SvrGetYcOrder");
        Record record = svr.getDataIn().getHead();
        record.setField("ycOrder_", this.getRequest().getParameter("ycOrder_"));
        record.setField("goodsAgency_", this.getRequest().getParameter("goodsAgency_"));
        record.setField("source_", this.getRequest().getParameter("source_"));
        record.setField("ycTime_", this.getRequest().getParameter("ycTime_"));
        record.setField("ycStatus_", this.getRequest().getParameter("ycStatus_"));
        if (!svr.exec())
            throw new RuntimeException(svr.getMessage());
        // 查询展示数据
        page.add("ycOrder", svr.getDataOut().getRecords());
        // 所有查询输入框数据
        page.add("ycOrder_", this.getRequest().getParameter("ycOrder_"));
        page.add("goodsAgency_", this.getRequest().getParameter("goodsAgency_"));
        page.add("source_", this.getRequest().getParameter("source_"));
        page.add("ycTime_", this.getRequest().getParameter("ycTime_"));
        page.add("ycStatus_", this.getRequest().getParameter("ycStatus_"));

		ParamUtil.addLog(this, "查询", "模糊查询后台异常单列表", "模糊查询后台异常单列表");
        return page;
    }
	
    public JsonPage upOrderStatus(){
    	JsonPage json = new JsonPage(this);
    	String ycNo_ = this.getRequest().getParameter("ycNo_");
    	LocalService upOrder = new LocalService(this, "SvrGetYcOrder");
    	if(!upOrder.exec("type_", "up", "ycNo_", ycNo_))
    		json.setData(false);
    	else
    		json.setData(true);
    	
    	return json;
    }
    
	/**
	 * 新增赔付单公共接口
	 * @param source_  异常描述
	 * @param orderId_ 订单号
	 * @param orderStatus  订单状态
	 * @param result  异常处理结果
	 * @return
	 */
	public static void saveYcOrder(IHandle handle, String source_, String orderId_, String orderStatus ,String result
			){
		// 取上一单编号，并生产下一单单号，宝安区区域代码440306
		LocalService getOrderNo_ = new LocalService(handle, "SvrGetYcOrder");
		if(!getOrderNo_.exec("no_", "yi"))
			throw new RuntimeException(getOrderNo_.getMessage());
		String previous = getOrderNo_.getDataOut().getCurrent().getSafeString("ycNo_");
		int No_ = Integer.parseInt(previous.substring(previous.length()-9))+1;
		SimpleDateFormat format = new SimpleDateFormat("yyMMdd"); 
		String ycNo_ = format.format(new Date())+ 440306 + No_; 
		// 这里异常单要根据时间和地区生成
		// 异常单时间
		LocalService getYcOrder = new LocalService(handle, "SvrGetYcOrder");
		if(!getYcOrder.exec("type_", "add", "ycNo_", ycNo_, "source_", source_, "orderId_", orderId_, "orderStatus", orderStatus, "result", result))
			throw new RuntimeException(getYcOrder.getMessage());
	}
	
	public static void main(String[] args) {
		int No_ = 200000003 + 1;
		SimpleDateFormat format = new SimpleDateFormat("yyMMdd"); 
		String str = format.format(new Date())+ 440306 + No_; 
		System.err.println(str);
	}
	
	@Override
	public boolean logon() {
		return true;
	}

}
