package com.huagu.admin.forms;
import java.util.List;
import com.huagu.common.util.MenuFactory;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jmis.core.MenuData;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;

/**
 * 
 * @ClassName: FrmAdminIndex
 * @Description: 后台首页
 * @author li
 * @date 2017年7月25日 下午2:36:09
 *
 */
public class FrmAdminIndex extends AbstractForm {
	@Override
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "ui/P017Page.jsp");
		List<MenuData> menus = MenuFactory.getMenuList(this);
		page.add("menus", menus);
		//验证是否有首页权限
		boolean isIndex = false;
		for (MenuData menuData : menus) {
			if("FrmAdminIndex".equals(menuData.getId())){
				isIndex = true;
				break;
			}
		}
		if(!isIndex){
			page = new JspPage(this, "common/welcome-pc.jsp");
			return page;
		}
		return page;
	}

	/*@Override
	public boolean logon() {
		return true;
	}*/
}
