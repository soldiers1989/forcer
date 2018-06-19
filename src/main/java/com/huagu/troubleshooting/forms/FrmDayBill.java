package com.huagu.troubleshooting.forms;

import java.text.Format;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.huagu.common.util.ParamUtil;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jbean.other.BufferType;
import cn.cerc.jbean.other.MemoryBuffer;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jexport.excel.ExportExcel;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.AbstractJspPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jpage.grid.MutiPage;

/**
 * 日账单
 * 
 * @author xiaofei-pc
 *
 */
public class FrmDayBill extends AbstractForm {

	@Override
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "troubleshooting/dayBill.jsp");
		LocalService getBill = new LocalService(this, "SvrGetDayBill");
        Record record = getBill.getDataIn().getHead();
        record.setField("unlockDate_", this.getRequest().getParameter("unlockDate_"));
        record.setField("endDate_", this.getRequest().getParameter("endDate_"));
		if (!getBill.exec()) {
			throw new RuntimeException(getBill.getMessage());
		}

		ParamUtil.addLog(this, "查询", "查询后台日账单列表", "查询后台日账单列表");
        page.add("values", this.setPage(page, getBill.getDataOut()));
        page.add("unlockDate_", this.getRequest().getParameter("unlockDate_"));
        page.add("endDate_", this.getRequest().getParameter("endDate_"));
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
    
    /**
     * 导出excel表格
     */
    public IPage excel() throws Exception {
        ExportExcel export = new ExportExcel(getResponse());
        export.setHandle(this);
        export.setTemplateId(getRequest().getParameter("templateId"));
        String service = getRequest().getParameter("service");
        String exportKey = getRequest().getParameter("exportKey");
        LocalService svr = new LocalService(this);
		ParamUtil.addLog(this, "导出", "导出后台日账单列表", "导出后台日账单列表");
        svr.setService(service);
        try (MemoryBuffer buff = new MemoryBuffer(BufferType.getExportKey, this.getUserCode(), exportKey)) {
            svr.getDataIn().close();
            svr.getDataIn().setJSON(buff.getString("data"));
        }
        if (svr.exec()) {
            export.getTemplate().setDataSet(svr.getDataOut());
            export.export();
        } else {
            export.export(svr.getMessage());
        }
        return null;
    }
    
	public static void main(String[] args) {
		System.out.println("--------------当前日期下一周的每一天--------------");
		List<String> lst = getALlweekDays();// 获取当前日期下，一周的每一天
		for (String s : lst) {
			System.out.println(s);
		}
		List<String> lst2 = getAllDaysMonth();// 获取当前日期下，一个月的每一天
		System.out.println("--------------一个月的每一天--------------");
		for (String s2 : lst2) {
			System.out.println(s2);
		}
		System.out.println("--------------根据特定的日期‘2014-8-1’获取特定日期所在一周的每一天--------------");
		Date d = FrmDayBill.paraseStringToDate("2014-8-1");
		List<String> lst3 = FrmDayBill.getAllweekDays(d);
		for (String s3 : lst3) {
			System.out.println(s3);
		}
		System.out.println("--------------根据特定的日期‘2014-8-1’获取特定日期所在一个月的每一天--------------");
		Date d2 = FrmDayBill.paraseStringToDate("2014-8-1");
		List<String> lst4 = FrmDayBill.getAllDaysMonthByDate(d2);
		for (String s3 : lst4) {
			System.out.println(s3);
		}
	}

	private static final int FIRST_DAY = Calendar.MONDAY;
	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

	public String getMonthStart()// 获取月初日期
	{
		Date d = new Date();
		// 月初
		// System.out.println("月初" + sdf.format(getMonthStart(d)));
		return sdf.format(getMonthStart(d));
	}

	public static String getMonthStartStr(Date d)// 根据传入日期来获取一个月的开始时间
	{
		return sdf.format(getMonthStart(d));
	}

	public static String getMonthEndStr(Date d)// 根据传入时间获取一个月月末时间
	{

		return sdf.format(getMonthEnd(d));
	}

	public static List<String> getAllDaysMonthByDate(Date d)// 根据传入的日期获取所在月份所有日期
	{
		List<String> lst = new ArrayList();
		Date date = getMonthStart(d);
		Date monthEnd = getMonthEnd(d);
		while (!date.after(monthEnd)) {
			// System.out.println(sdf.format(date));
			lst.add(sdf.format(date));
			date = getNext(date);
		}
		return lst;
	}

	public static Date paraseStringToDate(String timestr)// 将字符串转化为日期
	{
		Date date = null;

		Format f = new SimpleDateFormat("yyyy-MM-dd");
		try {
			date = (Date) f.parseObject(timestr);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return date;
	}

	public String getMonthEnd()// 获取月末日期
	{
		Date d = new Date();
		return sdf.format(getMonthEnd(d));
	}

	public static List<String> getAllDaysMonth() {
		List<String> lst = new ArrayList();
		Date d = new Date();
		// 月初
		// System.out.println("月初" + sdf.format(getMonthStart(d)));
		// 月末
		// System.out.println("月末" + sdf.format(getMonthEnd(d)));

		Date date = getMonthStart(d);
		Date monthEnd = getMonthEnd(d);
		while (!date.after(monthEnd)) {
			// System.out.println(sdf.format(date));
			lst.add(sdf.format(date));
			date = getNext(date);
		}
		return lst;
	}

	private static Date getMonthStart(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		int index = calendar.get(Calendar.DAY_OF_MONTH);
		calendar.add(Calendar.DATE, (1 - index));
		return calendar.getTime();
	}

	private static Date getMonthEnd(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.MONTH, 1);
		int index = calendar.get(Calendar.DAY_OF_MONTH);
		calendar.add(Calendar.DATE, (-index));
		return calendar.getTime();
	}

	private static Date getNext(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.DATE, 1);
		return calendar.getTime();
	}

	public static String getWeekStartDay(Date d) {// 根据日期来获取一周的第一天
		Calendar c = Calendar.getInstance();
		List<String> lst = new ArrayList();
		c.setTime(d);
		setToFirstDay(c);
		for (int i = 0; i < 7; i++) {
			String day = printDay(c);
			lst.add(day);
			c.add(Calendar.DATE, 1);
		}
		return lst.get(0);
	}

	public static String getWeekEndtDay(Date d) {// 根据日期来获取一周的最后一天
		Calendar c = Calendar.getInstance();
		List<String> lst = new ArrayList();
		c.setTime(d);
		setToFirstDay(c);
		for (int i = 0; i < 7; i++) {
			String day = printDay(c);
			lst.add(day);
			c.add(Calendar.DATE, 1);
		}
		return lst.get(6);
	}

	public static List<String> getAllweekDays(Date d) {// 根据日期来获取其所在周的每一天
		Calendar c = Calendar.getInstance();
		List<String> lst = new ArrayList();
		c.setTime(d);
		setToFirstDay(c);
		for (int i = 0; i < 7; i++) {
			String day = printDay(c);
			lst.add(day);
			c.add(Calendar.DATE, 1);
		}
		return lst;
	}

	public static List<String> getALlweekDays() {
		List<String> lst = new ArrayList();
		Calendar calendar = Calendar.getInstance();
		setToFirstDay(calendar);
		for (int i = 0; i < 7; i++) {
			String day = printDay(calendar);
			lst.add(day);
			calendar.add(Calendar.DATE, 1);
		}
		return lst;
	}

	private static void setToFirstDay(Calendar calendar) {
		while (calendar.get(Calendar.DAY_OF_WEEK) != FIRST_DAY) {
			calendar.add(Calendar.DATE, -1);
		}
	}

	private static String printDay(Calendar calendar) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		return dateFormat.format(calendar.getTime());
	}

	@Override
	public boolean logon() {
		return true;
	}

}
