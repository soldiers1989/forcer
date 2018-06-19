package com.huagu.common.forms;

import org.apache.log4j.Logger;
import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.IHandle;
import cn.cerc.jmis.form.AbstractForm;

/**
 * @ClassName: FrmMoneyRecord
 * @Description: 交易记录公共接口
 * @author 
 * @date 
 *
 */
public class FrmMoneyRecord extends AbstractForm {

	private static Logger log = Logger.getLogger(FrmMoneyRecord.class);

	@Override
	public IPage execute() throws Exception {
		return null;
	}

	/**
	 * 添加交易记录接口
	 */
	public static void addMoneyRecord(IHandle handle, String userCode_, String amount_, String platform_, String opeType_, String out_trade_no_, String orderId_, String openid_) throws Exception  {
		if(userCode_ != null && userCode_ != "" ){
			if(amount_ != null && amount_ != ""){
				String typeInfo = null;
				switch (opeType_) {//操作类型   A:转出 B：转入 C：付款 D：退款
				case "A":
					typeInfo = "转出";
					break;
				case "B":
					typeInfo = "转入";
					break;
				case "C":
					typeInfo = "付款";
					break;
				case "D":
					typeInfo = "退款";
					break;
				default:
					System.out.println("default");
					break;
				}
				log.info("正在添加 " + typeInfo + "操作类型。。。");
		        LocalService addMR = new LocalService(handle, "SvrMoneyRecord");
				if(!addMR.exec("userCode_",userCode_,"amount_",amount_,"platform_",platform_,"opeType_",opeType_,"out_trade_no_",out_trade_no_,"orderId_",orderId_,"openid_",openid_)){
					log.info("添加 " + typeInfo + "操作类型失败。。。");
				}else{
					log.info("添加 " + typeInfo + "操作类型成功。。。");
				}
			}else{
				log.info("添加 交易记录时：操作金额为空，操作失败。。。");
			}
		}else{
			log.info("添加 交易记录时：用户ID为空，操作失败。。。");
		}
		
	}

	public static void main(String[] args) {
	
	}
	
	public boolean logon() {
		return true;
	}
}
