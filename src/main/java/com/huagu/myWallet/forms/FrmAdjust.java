package com.huagu.myWallet.forms;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.IHandle;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;

/**
 * 调解账户平台金额
 * @author xiaofei-pc
 *
 */
public class FrmAdjust extends AbstractForm {
	@Override
	public IPage execute() throws Exception {
        JspPage page = new JspPage(this, "wallet/FrmAdjust.jsp");
        // 查询平台咨询账户列表
        LocalService svr = new LocalService(this, "SvrGetFinanceOvervicw");
        if (!svr.exec())
            throw new RuntimeException(svr.getMessage());
        
        page.add("values", svr.getDataOut().getRecords());
        return page;
	}
	
	/**
	 * 调账
	 * @return
	 * @throws Exception
	 */
	public JsonPage upAdjust() throws Exception {
		JsonPage json = new JsonPage(this);
        String czong_ = this.getRequest().getParameter("czong_");
        String rzong_ = this.getRequest().getParameter("rzong_");
        String money_ = this.getRequest().getParameter("money_");
        // 查询平台咨询账户列表
        LocalService svr = new LocalService(this, "SvrGetFinanceOvervicw");
        if (!svr.exec("type_", "up", "czong_", czong_, "rzong_", rzong_, "money_", money_))
            json.setData(false);
        else
            json.setData(true);
        
        return json;
	}

	/**
	 * 添加平台账户
	 * @param handle
	 * @param amount_
	 * @param type_
	 * @param qamount_
	 * @param hamount_
	 * @param accountId_
	 * @param desc_
	 * @throws Exception
	 */
    public static void addRecordLog(IHandle handle, Double amount_, String type_, Double qamount_, Double hamount_,String accountId_,String desc_ )
            throws Exception {
        LocalService svr = new LocalService(handle, "SvrRecordLog");
        if (!svr.exec("amount_", amount_, "type_", type_, "qamount_", qamount_,
        		"hamount_",hamount_,"accountId_",accountId_,"desc_",desc_))
            throw new RuntimeException(svr.getMessage());
    }
    
	@Override
	public boolean logon() {
		return true;
	}

}
