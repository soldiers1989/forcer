package com.huagu.box.front.forms;

import com.huagu.common.util.StringUtils;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;

/**
 * @ClassName: FrmMyBoxGroup
 * @Description: 用户端--我的柜组
 * @author tj
 * @date 2018年3月12日 上午8:38:43
 */
public class FrmMyBoxGroup extends AbstractForm {

	/*
	 * TODO 柜组详情(non-Javadoc)
	 * 
	 * @see cn.cerc.jbean.form.IForm#execute()
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "box/FrmMyBoxGroup_user.jsp");
		String cabinetId = getRequest().getParameter("cabinetId");
		if (StringUtils.isEmpty(cabinetId)) {
			/* cabinetId = "11111111111"; */
			cabinetId = "gz1";
		}

		LocalService svr = new LocalService(this, "SvrMyBoxGroup.detail");
		if (!svr.exec("cabinetId", cabinetId)) {
			throw new RuntimeException(svr.getMessage());
		}
		page.add("boxInfo", svr.getDataOut().getHead().getField("boxInfo"));
		page.add("cabinetId", cabinetId);
		return page;
	}

	/*
	 * TODO 附近柜列表
	 */
	public IPage nearbyCabinet() throws Exception {
		JspPage page = new JspPage(this, "/box/FrmMyBoxGroupList_user.jsp");
		// 当前的经纬度
		String curlongitude = getRequest().getParameter("longitude");
		String curlatitude = getRequest().getParameter("latitude");
		if (StringUtils.isEmpty(curlongitude) || StringUtils.isEmpty(curlatitude)) {
			// 测试数据，待删除
			curlongitude = "113.872166";
			curlatitude = "22.581929";
		}

		LocalService svr = new LocalService(this, "SvrMyBoxGroup.list");
		if (!svr.exec("curlongitude", curlongitude, "curlatitude", curlatitude)) {
			throw new RuntimeException(svr.getMessage());
		}
		page.add("cabinets", svr.getDataOut().getRecords());
		return page;
	}

	/*
	 * TODO 进入搜索页面
	 */
	public IPage searchPage() throws Exception {
		JspPage page = new JspPage(this, "/box/FrmFindMyBox.jsp");
		return page;
	}
	

    // 查看柜子位置
    public IPage myBoxPosition() {
        JspPage page = new JspPage(this, "box/FrmMyBoxPosition.jsp");
        String cabinetId = getRequest().getParameter("cabinetId");
        LocalService svr = new LocalService(this, "SvrMyBoxGroup.boxPosition");
        if (!svr.exec("cabinetId", cabinetId)) {
            page.add("msg", svr.getMessage());
            return page;
        }
        page.add("position", svr.getDataOut().getHead());
        return page;
    }
    
	/*
	 * TODO 进入柜子搜索页面
	 */
	public IPage searchPageProduct() throws Exception {
		JspPage page = new JspPage(this, "/box/FrmFindProduct.jsp");
		String cabinetId = getRequest().getParameter("cabinetId");
		String searchText = getRequest().getParameter("searchText");
		page.add("searchText", searchText);
		page.add("cabinetId", cabinetId);
		return page;
	}
	
	//搜索柜子内物品
	public IPage ProductDetail() throws Exception{
		JspPage page= new JspPage(this,"/box/FrmCabinet.jsp");
		LocalService svr = new LocalService(this, "SvrCabinetDetail.CabinetDetail");
		String searchText =getRequest().getParameter("searchText");
		String cabinetId = getRequest().getParameter("cabinetId");
		 if (!svr.exec("cabinetId", cabinetId,"searchText",searchText)) {
	            page.add("msg", svr.getMessage());
	            return page;
	        }
		page.add("products", svr.getDataOut().getRecords());
		page.add("cabinetId", cabinetId);
		page.add("searchText", searchText);
	/*	page.add("searchText", searchText);*/
		return page;
	} 
	
	
	@Override
	public boolean logon() {
		return true;
	}

}
