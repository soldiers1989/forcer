package com.huagu.creditManagement.forms;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.net.URLEncoder;

import org.apache.log4j.Logger;

import com.huagu.common.util.ParamUtil;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jimport.excel.ColumnValidateException;
import cn.cerc.jimport.excel.ImportExcel;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;

/**
 * 查询后台客户认证资料
 * 
 * @author xiaofei-pc
 *
 */
public class FrmClientList extends AbstractForm {
	@SuppressWarnings("unused")
	private static final Logger LOGGER = Logger.getLogger(FrmClientList.class);

	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "creditManageMent/clientList.jsp");
		String mobile_ = this.getRequest().getParameter("mobile_");
		String status_ = this.getRequest().getParameter("status_");
		LocalService getCreditDeploy = new LocalService(this, "SvrGetClientLog");
		if (!getCreditDeploy.exec("mobile_", mobile_, "status_", status_))
			throw new RuntimeException(getCreditDeploy.getMessage());

		ParamUtil.addLog(this, "查询", "查询后台客户认证资料列表", "查询后台客户认证资料列表");
		jsp.add("sesame", getCreditDeploy.getDataOut().getRecords());
		jsp.add("mobile_", mobile_);
		jsp.add("status_", status_);
		return jsp;
	}

	/**
	 * 修改客户认证的状态
	 * 
	 * @return
	 * @throws Exception 
	 */
	public JsonPage up() throws Exception {
		JsonPage json = new JsonPage(this);
		String id_ = this.getRequest().getParameter("id_");
		String status_ = this.getRequest().getParameter("status_");
		LocalService upCredit = new LocalService(this, "SvrGetClientLog");
		if (!upCredit.exec("type_", "up", "status_", status_, "id_", id_)) {
			json.setData(false);
		} else {
			json.setData(true);
		}
		ParamUtil.addLog(this, "修改", "修改后台客户认证资料列表", "修改后台客户认证资料列表"+ id_);
		return json;
	}
	
	/**
	 * 删除客户认证记录
	 * 
	 * @return
	 * @throws Exception 
	 */
	public JsonPage del() throws Exception {
		JsonPage json = new JsonPage(this);
		String id_ = this.getRequest().getParameter("id_");
		LocalService upCredit = new LocalService(this, "SvrGetClientLog");
		if (!upCredit.exec("type_", "del", "id_", id_)) {
			json.setData(false);
		} else {
			json.setData(true);
		}
		ParamUtil.addLog(this, "删除", "删除后台客户认证资料列表", "删除后台客户认证资料列表"+ id_);
		return json;
	}

	
	/**   
     * 导入客户认证资料excel
     */
    public IPage importCustomerExcel() throws InstantiationException, IllegalAccessException, UnsupportedEncodingException,
            IllegalArgumentException, InvocationTargetException, NoSuchMethodException, SecurityException {
        String msg = null;
        try {
            ImportExcel imp = new ImportExcel(getRequest(), getResponse());
            imp.setTemplateId("FrmCustomer");
            imp.init();
            DataSet dataSrc = imp.getDataSet();
            if (dataSrc.eof()) {
                msg = "请先选择需要文件！";
            } else {
                while (dataSrc.fetch()) {
                    DataSet dataSet = imp.readFileData(dataSrc.getCurrent());
                    excelImportCustomer(dataSet);
                    msg="导入成功！";
                }
            }
        } catch (ColumnValidateException err) {
            msg=String.format("第%d行第%d列：%s", err.getRow(), err.getCol() + 1, err.getMessage());
        } catch (Exception e) {
            msg=e.getMessage();
        }
        return new RedirectPage(this, "FrmClientList?msg="+URLEncoder.encode(msg,"UTF-8"));
    }
    
  /*  private void excelImportCustomer(DataSet dataSet) {
        LocalService svr = new LocalService(this);
        svr.setService("SvrAddExcelInfo");
        
        DataSet dataIn = svr.getDataIn();
        dataSet.first();
        //遍历放数据进数据库
        while (dataSet.fetch()) {
            dataIn.append();
            dataIn.setField("userCode_", dataSet.getString("userCode_"));
            dataIn.post();
        }
        if (!svr.exec() ){
            throw new RuntimeException(svr.getMessage());
        }
    }*/
    
    /*
    private void excelImportCustomer(DataSet dataSet) {
		//遍历放数据进数据库
		dataSet.first();
        while (dataSet.fetch()) {
			LocalService svr = new LocalService(this);
			svr.setService("SvrAddExcelInfo");
			Record headIn = svr.getDataIn().getHead();
			headIn.setField("userCode_", dataSet.getString("userCode_"));
			headIn.setField("source_", dataSet.getString("source_"));
			headIn.setField("attributes_", dataSet.getString("attributes_"));
			headIn.setField("status_", dataSet.getString("status_"));
			headIn.setField("dataRen_", dataSet.getString("dataRen_"));
		 if (!svr.exec() ){
			throw new RuntimeException(svr.getMessage());
			}
        }
        
    }*/
    
    private void excelImportCustomer(DataSet dataSet) {
		//遍历放数据进数据库
		dataSet.first();
        while (dataSet.fetch()) {
        	if ("".equals(dataSet.getString("userCode_"))) {
				continue;
			}
			
			LocalService svr = new LocalService(this);
			svr.setService("SvrAddExcelInfo");
			Record headIn = svr.getDataIn().getHead();
			headIn.setField("userCode_", dataSet.getString("userCode_"));
			headIn.setField("source_", dataSet.getString("source_"));
			headIn.setField("attributes_", dataSet.getString("attributes_"));
			headIn.setField("status_", dataSet.getString("status_"));
			headIn.setField("dataRen_", dataSet.getString("dataRen_"));
		 if (!svr.exec() ){
			throw new RuntimeException(svr.getMessage());
			}
        }
    }
    
    
    
	public boolean logon() {
		return true;
	}
}
