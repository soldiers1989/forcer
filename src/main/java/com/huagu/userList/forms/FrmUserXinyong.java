package com.huagu.userList.forms;

import java.util.ArrayList;
import java.util.List;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.AbstractJspPage;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jpage.grid.MutiPage;

/**
 * 后台用户征信维系
 * @author xiaofei-pc
 *
 */
public class FrmUserXinyong extends AbstractForm {

    @Override
    public IPage execute() throws Exception {
        JspPage page = new JspPage(this, "userList/userXinyong.jsp");
    	String code_ = this.getRequest().getParameter("code_");
        // 查询用当前信用情况（芝麻信用，活体映像，银行卡认证，）
        LocalService sesame = new LocalService(this, "SvrGetSesameLog");
        if (!sesame.exec("type_", "sel", "code_", code_))
            throw new RuntimeException(sesame.getMessage());
        
        if(sesame.getDataOut().size()==1)
            page.add("sesame", sesame.getDataOut().getCurrent().getString("sesameFen_"));
        else
        	page.add("sesame", "");
        

        // 查询个人征信配置
        LocalService personal = new LocalService(this, "SvrGetUserPersonalCredit");
        if (!personal.exec("code_", code_))
            throw new RuntimeException(personal.getMessage());
        
        page.add("personal", personal.getDataOut().getRecords());
        page.add("code_", code_);
        
        return page;
    }
    
    /**
     * 查询并修改他的征信配置
     * @return
     * @throws Exception
     */
    public IPage goDetails() throws Exception {
        JspPage page = new JspPage(this, "userList/userXinyong.jsp");
    	String code_ = this.getRequest().getParameter("code_");
        
        return page;
    }
    
    /**
     * 新增征信配置
     * @return
     * @throws Exception
     */
    public IPage addDetails() throws Exception {
        JspPage page = new JspPage(this, "userList/userXinyongAdd.jsp");
        
    	page.add("code_", this.getRequest().getParameter("code_"));
        return page;
    }
    
    /**
     * 更改后台客服专属用户
     */
    public JsonPage upUserXinYong(){
    	JsonPage json = new JsonPage(this);
    	String code_ = this.getRequest().getParameter("code_");
    	String source_ = this.getRequest().getParameter("source_");
    	String yuanying_ = this.getRequest().getParameter("yuanying_");
    	String node_ = this.getRequest().getParameter("node_");
    	String type_ = this.getRequest().getParameter("type_");
    	String revision_ = this.getRequest().getParameter("revision_");
    	String orderId_ = this.getRequest().getParameter("orderId_");
    	String beizhu_ = this.getRequest().getParameter("beizhu_");
    	
    	LocalService upUser = new LocalService(this, "SvrGetUserPersonalCredit");
    	if(!upUser.exec("type_s", "add", "code_", code_, "source_", source_, "yuanying_", yuanying_,
    			"node_", node_, "type_", type_, "revision_", revision_, "orderId_", orderId_, "beizhu_", beizhu_))
    		json.setData(false);
    	else
    		json.setData(true);
    	
    	return json;
    }

    // 分页
    private List<Record> setPage(AbstractJspPage page, DataSet dataSet) {
        List<Record> records = null;
        MutiPage pages = new MutiPage();
        pages.setRequest(getRequest());
        pages.setDataSet(dataSet);
        pages.setPageSize(10);
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
    @Override
    public boolean logon() {
        return true;
    }
}
