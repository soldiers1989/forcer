package com.huagu.box.front.services;

import com.huagu.common.enums.CabinetStatus;
import com.huagu.common.global.appdb;
import com.huagu.common.util.Distribution;
import com.huagu.common.util.StringUtils;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jbean.core.ServerConfig;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.FieldDefs;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.BuildQuery;

public class SvrMyBoxGroupfind extends CustomService {
    // 附近柜模糊查询
    // public boolean findGroup() throws DataValidateException {
    // SqlQuery sql = new SqlQuery(this);
    // Record head = dataIn.getHead();
    // sql.add("select * from %s where address_ like '%s'", appdb.CABINET,
    // "%" + head.getString("address_").trim() + "%");
    // sql.open();
    // if (!sql.eof())
    // dataOut.appendDataSet(sql);
    // return true;
    // }
    //

    public boolean findGroup() throws DataValidateException {
        Record headIn = getDataIn().getHead();
        DataValidateException.stopRun("传入当前经度", !headIn.hasValue("curlongitude"));
        DataValidateException.stopRun("传入当前纬度", !headIn.hasValue("curlatitude"));
        double curlongitude = headIn.getDouble("curlongitude");
        double curlatitude = headIn.getDouble("curlatitude");

        BuildQuery f = new BuildQuery(this);
        f.byField("status_", CabinetStatus.JOINUP.ordinal());
        f.byField("joinStatus_", CabinetStatus.JOINUP.ordinal());
        f.byLink(new String[] { "address_" }, headIn.getString("address_"));
        f.add("select * from %s ", appdb.CABINET);
        DataSet cabinets = f.open();
        DataSet result = getDataOut();
        if (!cabinets.eof()) {
            for (Record cabinet : cabinets) {
                double longitude = cabinet.getDouble("x_");
                double latitude = cabinet.getDouble("y_");
                if (StringUtils.isEmpty(longitude + "") || StringUtils.isEmpty(latitude + "")) {
                    continue;
                }

                double cabinetSearchDistance = Double
                        .parseDouble(new ServerConfig().getProperty("cabinet.searchDistance", "1000") + "");

                Distribution start = new Distribution();
                start.setLongitude(curlongitude);
                start.setDimensionality(curlatitude);
                Distribution end = new Distribution();
                end.setLongitude(longitude);
                end.setDimensionality(latitude);
                double distance = new Distribution().getDistance(start, end);

                if (distance > cabinetSearchDistance) {
                    continue;
                }

                cabinet.setField("distance", distance);
                result.append();
                FieldDefs fd = new FieldDefs();
                fd.add("id_", "communityName_", "communityNum_", "address_", "distance");
                result.copyRecord(cabinet, fd);
                System.out.println(result);
            }
        }
        return true;
    }
}
