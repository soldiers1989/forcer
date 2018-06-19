package com.huagu.logs.forms;

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

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.AbstractJspPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;
import cn.cerc.jpage.grid.MutiPage;

public class FrmOperationLog extends AbstractForm {
    @Override
    public IPage execute() throws Exception {
        JspPage page = new JspPage(this, "querylog/QueryLog.jsp");
        LocalService svr = new LocalService(this, "SvrOperationLog");
        if (!svr.exec())
            throw new RuntimeException(svr.getMessage());
        page.add("values", this.setPage(page, svr.getDataOut()));
        return page;
    }

    // 查询日志
    public IPage checklog() throws Exception {
        JspPage page = new JspPage(this, "querylog/QueryLog.jsp");
        LocalService svr = new LocalService(this, "SvrOperationLog");
        Record record = svr.getDataIn().getHead();
        record.setField("operateData_", this.getRequest().getParameter("operateData_"));
        record.setField("operateType_", this.getRequest().getParameter("operateType_"));
        record.setField("startTime_", this.getRequest().getParameter("startTime_"));
        record.setField("endTime_", this.getRequest().getParameter("endTime_"));
        record.setField("unlockDate_", this.getRequest().getParameter("unlockDate_"));
        record.setField("endDate_", this.getRequest().getParameter("endDate_"));
        if (!svr.exec())
            throw new RuntimeException(svr.getMessage());
        page.add("values", this.setPage(page, svr.getDataOut()));
        page.add("operateData_", this.getRequest().getParameter("operateData_"));
        page.add("operateType_", this.getRequest().getParameter("operateType_"));
        page.add("unlockDate_", getRequest().getParameter("unlockDate_"));
        page.add("endDate_", getRequest().getParameter("endDate_"));
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
        // 获取导出的数据
        LocalService svr = new LocalService(this, "SvrOperationLog");
        if (!svr.exec())
            throw new RuntimeException(svr.getMessage());
        List<Record> records = svr.getDataOut().getRecords();
        List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
        Map<String, Object> map = new HashMap<>();
        for (int i = 0; i < records.size(); i++) {
            map.put("日期/时间", records.get(i).getString("operateData_"));
            map.put("类型", records.get(i).getString("operateType_"));
            map.put("操作行为", records.get(i).getString("operate_"));
            map.put("操作人", records.get(i).getString("operateUser_"));
            map.put("操作IP", records.get(i).getString("operateAdress_"));
            map.put("详情", records.get(i).getString("operateDetail_"));
            dataList.add(map);
            map = new HashMap<>();
        }
        String[] headers = { "日期/时间", "类型", "操作行为", "操作人", "操作IP", "详情" };
        String sheetName = "后台日志表";
        String exportExcelName = "QueryLog";
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
        return new RedirectPage(this, "FrmOperationLog");
    }

    @Override
    public boolean logon() {
        return true;
    }
}
