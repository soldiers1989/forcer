package com.huagu.common.util;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IForm;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.IHandle;
import cn.cerc.jdb.core.Record;
import net.sf.json.JSONObject;

public class ParamUtil {

    /**
     * 将request中的所有非数组参数转换为dataset
     * 
     * @author rick_zhou
     * @param form
     * @param headIn
     */
    public static void ParamToHeadIn(IForm form, DataSet dataIn) {
        Record headIn = dataIn.getHead();
        Enumeration<?> enu = form.getRequest().getParameterNames();
        while (enu.hasMoreElements()) {
            String paraName = (String) enu.nextElement();
            headIn.setField(paraName, form.getRequest().getParameter(paraName));
        }
    }

    /**
     * 将request中的jsonObject字符串转换为dataset
     * 
     * @author rick_zhou
     * @param jsonObject
     * @param headIn
     */
    public static void ParamToHeadIn(String json, DataSet dataIn) {
        Record headIn = dataIn.getHead();
        JSONObject jsonobject = JSONObject.fromObject(json);
        @SuppressWarnings("rawtypes")
        Iterator iterator = jsonobject.keys();
        while (iterator.hasNext()) {
            String key = (String) iterator.next();
            headIn.setField(key, jsonobject.getString(key));
        }
    }

    /**
     * 将request中的jsonObject字符串转换为dataset
     * 
     * @author rick_zhou
     * @param jsonObject
     * @param headIn
     */
    public static List<Map<String, Object>> dataOutToList(DataSet dataOut) {
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        for (Record record : dataOut.getRecords()) {
            list.add(record.getItems());
        }
        return list;
    }

    /**
     * 添加日志
     * 
     */

    public static void addLog(IHandle handle, String operateType_, String operate_, String operateDetail_)
            throws Exception {
        LocalService svr = new LocalService(handle, "SvrManageLog");
        if (!svr.exec("operateType_", operateType_, "operate_", operate_, "operateDetail_", operateDetail_))
            throw new RuntimeException(svr.getMessage());
    }
}
