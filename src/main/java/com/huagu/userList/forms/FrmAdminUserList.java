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
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;
import cn.cerc.jpage.grid.MutiPage;

/**
 * 绑定登录运维端
 * @author xiaofei-pc
 *
 */
public class FrmAdminUserList extends AbstractForm {

    @Override
    public IPage execute() throws Exception {
        JspPage page = new JspPage(this, "userList/adminuseryunweiList.jsp");
        LocalService svr = new LocalService(this, "SvrGetAdminUserList");
        if (!svr.exec())
            throw new RuntimeException(svr.getMessage());
        
        page.add("values", this.setPage(page, svr.getDataOut()));
		ParamUtil.addLog(this, "查询", "查询后台绑定登录运维端列表", "查询后台绑定登录运维端列表");
        return page;
    }

    /**
     * 根据手机号模糊查询微信用户
     * @return
     * @throws Exception
     */
    public IPage getUser() throws Exception {
        JspPage page = new JspPage(this, "userList/adminuseryunweiList.jsp");
        LocalService svr = new LocalService(this, "SvrGetAdminUserList");
        Record record = svr.getDataIn().getHead();
        record.setField("mobile_", this.getRequest().getParameter("mobile_"));
        if (!svr.exec())
            throw new RuntimeException(svr.getMessage());
        page.add("values", svr.getDataOut().getRecords());
        
        page.add("mobile_", this.getRequest().getParameter("mobile_"));
		ParamUtil.addLog(this, "查询", "模糊查询后台绑定登录运维端列表", "模糊查询后台绑定登录运维端列表");
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

    /**
     * 绑定和取消绑定方法
     * @return
     */
    public JsonPage upBinding(){
    	String code_ = this.getRequest().getParameter("code_");
    	String type_ = this.getRequest().getParameter("type_");
    	JsonPage json = new JsonPage(this);
    	LocalService upBinding = new LocalService(this, "SvrUpBinding");
    	if(!upBinding.exec("code_", code_, "type_", type_))
    		json.setData(false);
    	else
    		json.setData(true);
    	
    	return json;
    }

    @Override
    public boolean logon() {
        return true;
    }
}
