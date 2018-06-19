package com.huagu.common.filter;

import java.io.IOException;
import javax.servlet.http.HttpServletResponse;
import com.huagu.common.util.StringUtils;
import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.core.AppHandle;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jmis.core.IFormFilter;

public class AppFormFilter implements IFormFilter {

	@Override
	public boolean doFilter(HttpServletResponse resp, String formId, String funcCode) throws IOException {
		if("execute".equals(funcCode)){
			LocalService svr = new LocalService(new AppHandle(), "SvrWEBMenuFilter");
			if (svr.exec("frmCode_", formId)){
				DataSet dataSet = svr.getDataOut();
				if(!dataSet.eof()){
					String selfLive = dataSet.getString("SelfLive");
					if(StringUtils.notEmpty(selfLive) && !dataSet.getBoolean("SelfLive")){
						resp.sendRedirect("FrmDevelop");
						return true;
					}
				}
			}
		}
		return false;
	}

}
