package com.huagu.userList.forms;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRichTextString;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.huagu.common.util.ParamUtil;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.AbstractJspPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;
import cn.cerc.jpage.grid.MutiPage;

/**
 * 后台专属客服用户列表
 * @author xiaofei-pc
 *
 */
public class FrmAdminExclusiveUser extends AbstractForm {

    @Override
    public IPage execute() throws Exception {
        JspPage page = new JspPage(this, "userList/adminuserList.jsp");
        LocalService svr = new LocalService(this, "SvrgetUserList");
        if (!svr.exec("type_", "zs"))
            throw new RuntimeException(svr.getMessage());
        page.add("values", this.setPage(page, svr.getDataOut()));
		ParamUtil.addLog(this, "查询", "查询后台专属客服用户列表", "查询后台专属客服用户列表");
        return page;
    }

    // 查询用户
    public IPage getUser() throws Exception {
        JspPage page = new JspPage(this, "userList/adminuserList.jsp");
        LocalService svr = new LocalService(this, "SvrgetUserList");
        Record record = svr.getDataIn().getHead();
        record.setField("type_", "zs");
        record.setField("mobile_", this.getRequest().getParameter("mobile_"));
        record.setField("smoney_", this.getRequest().getParameter("smoney_"));
        record.setField("money_", this.getRequest().getParameter("money_"));
        record.setField("endDate_", this.getRequest().getParameter("endDate_"));
        record.setField("enabled_", this.getRequest().getParameter("enabled_"));
        if (!svr.exec())
            throw new RuntimeException(svr.getMessage());
        page.add("values", this.setPage(page, svr.getDataOut()));
        page.add("mobile_", this.getRequest().getParameter("mobile_"));
        page.add("unlockDate_", this.getRequest().getParameter("unlockDate_"));
        page.add("endDate_", this.getRequest().getParameter("endDate_"));
        page.add("enabled_", this.getRequest().getParameter("enabled_"));
		ParamUtil.addLog(this, "查询", "模糊查询后台专属客服用户列表", "模糊查询后台专属客服用户列表");
        return page;
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

    // 导出excel
    public IPage exportExcel() throws Exception {
        // JspPage page = new JspPage(this, "products/FrmImportNode.jsp");
        // 获取导出的数据
        LocalService svr = new LocalService(this, "SvrgetUserList");
        if (!svr.exec())
            throw new RuntimeException(svr.getMessage());
        List<Record> records = svr.getDataOut().getRecords();
        List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
        Map<String, Object> map = new HashMap<>();
        for (int i = 0; i < records.size(); i++) {
            map.put("微信昵称", records.get(i).getString("name_"));
            map.put("手机号", records.get(i).getString("mobile_"));
            map.put("注册时间", records.get(i).getString("createTime_"));
            map.put("余额", records.get(i).getString("overMoney_"));
            map.put("积分", records.get(i).getString("userJifen_"));
            map.put("状态", records.get(i).getString("enabled_"));
            map.put("", records.get(i).getString(""));
            dataList.add(map);
            map = new HashMap<>();
        }
        String[] headers = { "微信昵称", "手机号", "注册时间", "余额", "积分", "状态" };
        String sheetName = "用户表";
        String exportExcelName = "UserList";
        // 声明一个工作薄
        XSSFWorkbook workbook = new XSSFWorkbook();
        // 生成一个表格
        XSSFSheet sheet = workbook.createSheet(sheetName);
        // 设置表格默认列宽度为15个字节
        sheet.setDefaultColumnWidth(20);

        // 生成表格中非标题栏的样式
        XSSFCellStyle style = workbook.createCellStyle();
        // 设置这些样式
        style.setFillForegroundColor(HSSFColor.WHITE.index);// 背景色
        style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        style.setBorderBottom(BorderStyle.THIN);
        style.setBorderLeft(BorderStyle.THIN);
        style.setBorderRight(BorderStyle.THIN);
        style.setBorderTop(BorderStyle.THIN);
        style.setAlignment(HorizontalAlignment.CENTER);
        // 生成表格中非标题栏的字体
        XSSFFont font = workbook.createFont();
        font.setColor(HSSFColor.BLACK.index);
        font.setFontHeightInPoints((short) 12);
        font.setBold(true);
        // 把字体应用到当前的样式
        style.setFont(font);
        // 设置表格标题栏的样式
        XSSFCellStyle titleStyle = workbook.createCellStyle();
        titleStyle.setFillForegroundColor(HSSFColor.BLUE_GREY.index);
        titleStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        titleStyle.setBorderBottom(BorderStyle.THIN);
        titleStyle.setBorderLeft(BorderStyle.THIN);
        titleStyle.setBorderRight(BorderStyle.THIN);
        titleStyle.setBorderTop(BorderStyle.THIN);
        titleStyle.setAlignment(HorizontalAlignment.CENTER);
        titleStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        // 设置标题栏字体
        XSSFFont titleFont = workbook.createFont();
        titleFont.setColor(HSSFColor.WHITE.index);
        titleFont.setFontHeightInPoints((short) 12);
        titleFont.setBold(true);
        // 把字体应用到当前的样式
        titleStyle.setFont(titleFont);

        // 产生表格标题行
        XSSFRow row = sheet.createRow(0);
        for (short i = 0; i < headers.length; i++) {
            XSSFCell cell = row.createCell(i);
            cell.setCellStyle(titleStyle);
            XSSFRichTextString text = new XSSFRichTextString(headers[i]);
            cell.setCellValue(text);
        }

        // 遍历集合数据，产生数据行
        Iterator<Map<String, Object>> it = dataList.iterator();
        int index = 0;
        while (it.hasNext()) {
            index++;
            row = sheet.createRow(index);
            Map<String, Object> data = it.next();
            int i = 0;
            for (String key : data.keySet()) {
                XSSFCell cell = row.createCell(i);
                cell.setCellStyle(style);
                XSSFRichTextString text = new XSSFRichTextString(data.get(key) + "");
                cell.setCellValue(text);
                i++;
            }
        }
        OutputStream out = null;
        try {
            String tmpPath = "E:\\datas\\" + exportExcelName + ".xlsx";
            out = new FileOutputStream(tmpPath);
            workbook.write(out);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (workbook != null) {
                try {
                    workbook.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (out != null) {
                try {
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
		ParamUtil.addLog(this, "查询", "导出用户信息", "导出用户信息");
        return new RedirectPage(this, "FrmgetUser");
    }

    // 删除用户
    public IPage delUser() throws Exception {
        String id_ = this.getRequest().getParameter("id_");
        LocalService svr = new LocalService(this, "SvrgetUserList.delUser");
        if (!svr.exec("id_", id_))
            throw new RuntimeException(svr.getMessage());
        return execute();
    }

    // 查看用户导航页面
    public IPage detailMenu() throws Exception {
        JspPage page = new JspPage(this, "userList/userDetailList.jsp");
        String id_ = this.getRequest().getParameter("id_");
        LocalService svr = new LocalService(this, "SvrgetUserDetail.detail");
        if (!svr.exec("id_", id_, "type_", "login"))
            throw new RuntimeException(svr.getMessage());
        
        page.add("id_", id_);
        page.add("code_", svr.getDataOut().getCurrent().getString("code_"));
        page.add("loginTime_", svr.getDataOut().getCurrent().getString("LoginTime_"));
        return page;
    }
    
    // 查看用户详情
    public IPage detail() throws Exception {
        JspPage page = new JspPage(this, "userList/userDetail.jsp");
        String id_ = this.getRequest().getParameter("id_");
        // 查询用户基本信息
        LocalService svr = new LocalService(this, "SvrgetUserDetail.detail");
        if (!svr.exec("id_", id_))
            throw new RuntimeException(svr.getMessage());
        
        // 查询用户积分记录
        LocalService getJf = new LocalService(this, "SvrMySignRecords");
        if (!getJf.exec("userCode_", svr.getDataOut().getCurrent().getString("code_")))
            throw new RuntimeException(getJf.getMessage());
        
        // 查询用户优惠卷使用情况
        LocalService getYhj = new LocalService(this, "SvrCouponState.coupon");
        if (!getYhj.exec("code_", svr.getDataOut().getCurrent().getString("code_")))
            throw new RuntimeException(getYhj.getMessage());
        
        // 查询用户意见反馈历史记录
        LocalService getYjfk = new LocalService(this, "SvrFeedBack.queryopinion");
        if (!getYjfk.exec("code_", svr.getDataOut().getCurrent().getString("code_")))
            throw new RuntimeException(getYjfk.getMessage());

        // 查询用户意见反馈历史记录
        LocalService getAdr = new LocalService(this, "SvrAdrManager.querydata");
        if (!getAdr.exec("code_", svr.getDataOut().getCurrent().getString("code_")))
            throw new RuntimeException(getAdr.getMessage());
        
        page.add("values", svr.getDataOut().getCurrent());
        page.add("jf", getJf.getDataOut().getRecords());
        page.add("yhj", getYhj.getDataOut().getRecords());
        page.add("yjfk", getYjfk.getDataOut().getRecords());
        page.add("Adr", getAdr.getDataOut().getRecords());
        page.add("id_", id_);
		ParamUtil.addLog(this, "查询", "查看用户详情信息", "查看用户详情信息");
        return page;
    }
    
    public IPage addFeedBack() throws Exception {
    	JspPage page = new JspPage(this, "userList/userDetail.jsp");
    	String id_ = this.getRequest().getParameter("id_");
    	LocalService svr = new LocalService(this, "SvrFeedBackYunWei.addView");
   		Record headIn = svr.getDataIn().getHead();
   		headIn.setField("view_", this.getRequest().getParameter("view_"));
   		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
   		page.add("view_", this.getRequest().getParameter("view_"));
   		page.add("id_", id_);
		return  page;
    }
    

    @Override
    public boolean logon() {
        return true;
    }
}
