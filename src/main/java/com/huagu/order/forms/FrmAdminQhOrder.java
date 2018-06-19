package com.huagu.order.forms;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.log4j.Logger;

import com.huagu.common.util.ParamUtil;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jbean.other.BufferType;
import cn.cerc.jbean.other.MemoryBuffer;
import cn.cerc.jdb.core.IHandle;
import cn.cerc.jdb.core.Record;
import cn.cerc.jexport.excel.ExportExcel;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;

/**
 * 后台取货订单相关
 * @author xiaofei-pc
 *
 */
public class FrmAdminQhOrder extends AbstractForm{
	public Logger log = Logger.getLogger(this.getClass());
	
	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "order/qhOrderList.jsp");
		LocalService getYcOrder = new LocalService(this, "SvrGetQhOrder");
		if(!getYcOrder.exec())
			throw new RuntimeException(getYcOrder.getMessage());
		
		ParamUtil.addLog(this, "查询", "查询后台取货单列表", "查询后台取货单列表");
		jsp.add("qhOrder", getYcOrder.getDataOut().getRecords());
		return jsp;
	}
	
    // 查询异常订单
    public IPage getQhOrder() throws Exception {
        JspPage page = new JspPage(this, "order/qhOrderList.jsp");
        LocalService svr = new LocalService(this, "SvrGetQhOrder");
        Record record = svr.getDataIn().getHead();
        record.setField("goods_", this.getRequest().getParameter("goods_"));
        record.setField("sqName_", this.getRequest().getParameter("sqName_"));
        record.setField("cabinetName_", this.getRequest().getParameter("cabinetName_"));
        record.setField("orderId_", this.getRequest().getParameter("orderId_"));
        record.setField("zhuCode_", this.getRequest().getParameter("zhuCode_"));
        record.setField("userCode_", this.getRequest().getParameter("userCode_"));
        if (!svr.exec())
            throw new RuntimeException(svr.getMessage());
        // 查询展示数据
        page.add("qhOrder", svr.getDataOut().getRecords());
        // 所有查询输入框数据
        page.add("goods_", this.getRequest().getParameter("goods_"));
        page.add("sqName_", this.getRequest().getParameter("sqName_"));
        page.add("cabinetName_", this.getRequest().getParameter("cabinetName_"));
        page.add("orderId_", this.getRequest().getParameter("orderId_"));
        page.add("zhuCode_", this.getRequest().getParameter("zhuCode_"));
        page.add("userCode_", this.getRequest().getParameter("userCode_"));

		ParamUtil.addLog(this, "查询", "模糊查询后台取货单列表", "模糊查询后台取货单列表");
        return page;
    }
	
    /**
     * 导出excel表格
     */
    public IPage excel() throws Exception {
        ExportExcel export = new ExportExcel(getResponse());
        export.setHandle(this);
        export.setTemplateId(getRequest().getParameter("templateId"));
        String service = getRequest().getParameter("service");
        String exportKey = getRequest().getParameter("exportKey");
        LocalService svr = new LocalService(this);
		ParamUtil.addLog(this, "导出", "导出后台取货单列表", "导出后台取货单列表");
        svr.setService(service);
        try (MemoryBuffer buff = new MemoryBuffer(BufferType.getExportKey, this.getUserCode(), exportKey)) {
            svr.getDataIn().close();
            svr.getDataIn().setJSON(buff.getString("data"));
        }
        if (svr.exec()) {
            export.getTemplate().setDataSet(svr.getDataOut());
            export.export();
        } else {
            export.export(svr.getMessage());
        }
        return null;
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
	 * 新增异常单公共接口
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
