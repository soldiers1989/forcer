package com.huagu.addBank.forms;

import org.netbeans.lib.cvsclient.commandLine.command.export;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;
/**
 * 绑定银行卡
 * @author 沈叶
 *
 */

public class FrmAddBank extends AbstractForm{
	//跳转到绑定银行卡
	@Override
	public IPage execute() throws Exception {
		  JspPage jsp = new JspPage(this, "addBank/BankCardList.jsp");
		    LocalService svr = new LocalService(this,"SvrBankCardList.getBankCardList");
			if (!svr.exec())
				throw new RuntimeException(svr.getMessage());
			jsp.add("Lists", svr.getDataOut().getRecords());
	        return jsp;
	}
	
	public IPage gotoAddCard() throws Exception {
		  JspPage jsp = new JspPage(this, "addBank/addBankCard.jsp");
	        return jsp;
	}
	
	
	public IPage addBank() throws Exception{
		 JspPage jsp = new JspPage(this, "addBank/CardMessage.jsp");
		 String BankCard= this.getRequest().getParameter("BankCard");
		 String userName= this.getRequest().getParameter("userName");
		 jsp.add("BanKCard", BankCard);
		 jsp.add("userName", userName);
		return jsp;
	}
	
	public IPage addBankCarkMessage() throws Exception{
			JsonPage json = new JsonPage(this);
			LocalService svr = new LocalService(this,"SvrAddBankCard");
		 	Record headIn=svr.getDataIn().getHead();
			headIn.setField("bankName",this.getRequest().getParameter("bankName"));
			headIn.setField("BanKCard",this.getRequest().getParameter("BanKCard"));
			headIn.setField("userName",this.getRequest().getParameter("userName"));
			headIn.setField("cardType", this.getRequest().getParameter("cardType"));
			if(!svr.exec()){
				json.setData(false);
				throw new RuntimeException(svr.getMessage());
			}
			json.setData(true);
			return  json;
	}
	
	//删除
		public IPage delBankCard() throws Exception{
			String cardNum_ = this.getRequest().getParameter("cardNum_");
			LocalService svr = new LocalService(this, "SvrBankCardList.delBankCard");
			if (!svr.exec("cardNum_", cardNum_))
				throw new RuntimeException(svr.getMessage());
			return execute();	
		}
	
	@Override
	public boolean logon() {
		return true;
	}
}
