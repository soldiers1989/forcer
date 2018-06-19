package com.huagu.product.services;

import java.util.List;
import java.util.UUID;

import org.apache.log4j.Logger;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.DataSetState;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;



public class SvrProType extends CustomService {
	private static final Logger log = Logger.getLogger(SvrProType.class);
	

	/**
	 * 添加分类
	 * @Title: insertProType 
	 * @Description: TODO 
	 * @author 乔晨光
	 * @param @return
	 * @param @throws DataValidateException    
	 * @return boolean
	 */
	public boolean insertProType() throws DataValidateException {
		Record head = this.getDataIn().getHead();
		//向分类表里插入数据
		SqlQuery ds1 = new SqlQuery(this);
		ds1.add("select UID_,createDate_,createUser_,updateDate_,updateUser_,"
				+ "fristName_,fristNameId_,fristState_,fristDel_,twoName_,twoNameId_,"
				+ "twoState_,twoDel_,twoImgUrl_,fristImgUrl_");
		ds1.add("from %s where 1=1",appdb.T_Protype);
		if(head.getString("fristNameId_")!=null&&head.getString("fristNameId_")!=""){
			ds1.add(" and fristNameId_='%s'",head.getString("fristNameId_"));
		}
		ds1.open();
		if(!ds1.eof()){
			String fristImgUrl_ = ds1.getString("fristImgUrl_");
			String fristName_ = ds1.getString("fristName_");
			String fristName_Id_ = ds1.getString("fristNameId_");
			SqlQuery ds2 = new SqlQuery(this);
			ds2.add("select UID_,createDate_,createUser_,updateDate_,updateUser_,"
					+ "fristName_,fristNameId_,fristState_,fristDel_,twoName_,twoNameId_,"
					+ "twoState_,twoDel_,twoImgUrl_,fristImgUrl_");
			ds2.add("from %s",appdb.T_Protype);
			ds2.add("where fristName_='%s'",head.getString("fristName_"));
			if(head.getString("twoName_")!=null&&head.getString("twoName_")!=""){
				ds2.add("and twoName_='%s'",head.getString("twoName_"));
			}
			ds2.open();
			if(!ds2.eof()){
					
			}else{
				//添加二级分类
				if(ds1.getString("twoName_").equals("")){
					String twoNameId_ = UUID.randomUUID().toString();
					ds1.edit();
					ds1.setField("createDate_", TDateTime.Now());
					ds1.setField("createUser_", this.getUserCode());
					ds1.setField("fristName_", fristName_);
					ds1.setField("twoImgUrl_", head.getString("path"));
					ds1.setField("fristNameId_", fristName_Id_);
					ds1.setField("fristImgUrl_", fristImgUrl_);
					ds1.setField("fristState_", "0");
					ds1.setField("twoName_", head.getString("twoName_"));
					ds1.setField("twoNameId_", twoNameId_);
					ds1.setField("fristImgUrl_", fristImgUrl_);
					ds1.setField("twoState_", "0");
					ds1.setField("fristDel_", "0");
					ds1.setField("twoDel_", "0");
					ds1.post();
				}else{
					String twoNameId_ = UUID.randomUUID().toString();
					ds1.append();
					ds1.setField("createDate_", TDateTime.Now());
					ds1.setField("createUser_", this.getUserCode());
					ds1.setField("fristName_", fristName_);
					ds1.setField("twoImgUrl_", head.getString("path"));
					ds1.setField("fristNameId_", fristName_Id_);
					ds1.setField("fristImgUrl_", fristImgUrl_);
					ds1.setField("fristState_", "0");
					ds1.setField("twoName_", head.getString("twoName_"));
					ds1.setField("twoNameId_", twoNameId_);
					ds1.setField("twoState_", "0");
					ds1.setField("fristDel_", "0");
					ds1.setField("twoDel_", "0");
					ds1.post();
				}
		      }
		}else{
			//添加一级分类
				String fristNameId_ = UUID.randomUUID().toString();
				ds1.append();
				ds1.setField("createDate_", TDateTime.Now());
				ds1.setField("createUser_", this.getUserCode());
				ds1.setField("fristName_", head.getString("fristName_"));
				ds1.setField("fristImgUrl_", head.getString("path"));
				ds1.setField("fristNameId_", fristNameId_);
				ds1.setField("fristState_", "0");
				ds1.setField("fristDel_", "0");
				ds1.post();
			}
		return true; 
		
	}
	
	public boolean queryById() throws DataValidateException {
		Record head = this.getDataIn().getHead();
		SqlQuery ds = new SqlQuery(this);
		ds.add("select UID_,createDate_,createUser_,updateDate_,updateUser_,"
				+ "fristName_,fristNameId_,fristState_,fristDel_,twoName_,twoNameId_,"
				+ "twoState_,twoDel_,twoImgUrl_,fristImgUrl_");
		ds.add("from %s",appdb.T_Protype);
		ds.add("where fristDel_=%s",0);
		if(head.getString("fristNameId_")!=null&&head.getString("fristNameId_")!=""){
			ds.add("and fristNameId_='%s'",head.getString("fristNameId_"));
		}
		if(head.getString("twoNameId_")!=null&&head.getString("twoNameId_")!=""){
			ds.add("and twoNameId_='%s'",head.getString("twoNameId_"));
		}
		ds.add("group by fristNameId_");
		ds.open();
		if(!ds.eof())
			dataOut.appendDataSet(ds);
			return true;
	}
	
	/**
	 * 查询一级分类
	 * @Title: queryProType 
	 * @Description: TODO 
	 * @author 乔晨光
	 * @param @return
	 * @param @throws DataValidateException    
	 * @return boolean
	 */
	public boolean queryProTypes() throws DataValidateException {
		Record head = this.getDataIn().getHead();
		SqlQuery ds = new SqlQuery(this);
		String proName_=head.getString("proName_");
		String fristNameId_=head.getString("fristNameId_");
		String twoNameId_=head.getString("twoNameId_");
		if(fristNameId_.equals("请选择")){
			fristNameId_ = "";
		}if(twoNameId_.equals("请选择")){
			twoNameId_ = "";
		}
		ds.add("select UID_,createDate_,createUser_,updateDate_,updateUser_,"
				+ "fristName_,fristNameId_,fristState_,fristDel_,twoName_,twoNameId_,"
				+ "twoState_,twoDel_,twoImgUrl_,fristImgUrl_");
		ds.add("from %s",appdb.T_Protype);
		ds.add("where 1=1 and fristDel_=%s",0);
		if(head.hasValue("fristNameId_")){
			ds.add("and fristNameId_ like '%s' ",new String("%"+fristNameId_+"%"));
		}
		if(head.hasValue("twoNameId_")){
			ds.add("and twoNameId_ like '%s' ",new String("%"+twoNameId_+"%"));
		}
		if(head.hasValue("proName_")){
			ds.add("and fristName_ like '%s' ",new String("%"+proName_+"%"));
		}
//		if(head.hasValue("proName_")){
//			ds.add("or twoName_ like '%s') ",new String("%"+proName_+"%"));
//		}
		ds.add("group by fristNameId_");
		ds.add("order by createDate_");
		ds.open();
		if(!ds.eof())
			dataOut.appendDataSet(ds);
			return true;
		
	}
	
	/**
	 * 查询分类
	 * @Title: queryType 
	 * @Description: TODO 
	 * @author 乔晨光
	 * @param @return
	 * @param @throws DataValidateException    
	 * @return boolean
	 */
	public boolean queryType() throws DataValidateException {
		Record head = this.getDataIn().getHead();
		SqlQuery ds = new SqlQuery(this);
		ds.add("select UID_,createDate_,createUser_,updateDate_,updateUser_,"
				+ "fristName_,fristNameId_,fristState_,fristDel_,twoName_,twoNameId_,"
				+ "twoState_,twoDel_,twoImgUrl_,fristImgUrl_ ");
		ds.add("from %s where 1=1",appdb.T_Protype);
		ds.add("and twoDel_ ='%s'",0);
		ds.add("and fristDel_ ='%s'",0);
		ds.add("and fristNameId_ ='%s'",head.getString("fristNameId_"));
		ds.add("group by twoNameId_");
		ds.open();
		if(!ds.eof()){
			SqlQuery ds1 = new SqlQuery(this);
			ds1.add("select UID_,createDate_,createUser_,updateDate_,updateUser_,"
					+ "fristName_,fristNameId_,fristState_,fristDel_,twoName_,twoNameId_,"
					+ "twoState_,twoDel_,proModel_,proModelId_,proModelState_,proDel_,fristImgUrl_");
			ds1.add("from %s",appdb.T_Protype);
			ds1.add("where fristNameId_ ='%s'",ds.getString("fristNameId_"));
			if(!head.getString("twoNameId_").equals("")){
				ds1.add("and twoNameId_ ='%s'",head.getString("twoNameId_"));
				ds.add("and twoDel_=%s",0);
				ds1.open();
				if(!ds1.eof()){
					dataOut.appendDataSet(ds1);
				}
			}
			dataOut.appendDataSet(ds);
		}
		return true;
	}
	
	//修改分类
	public boolean updateType() throws DataValidateException {
		Record head = this.getDataIn().getHead();
		if(head.getString("fristNameId_")!=null&&head.getString("fristNameId_")!=""){
			SqlQuery query = new SqlQuery(this);
			query.add("select UID_,updateDate_,updateUser_,"
					+ "fristName_,fristNameId_,fristState_,fristDel_,twoName_,twoNameId_,"
					+ "twoState_,twoDel_,twoImgUrl_,fristImgUrl_");
			query.add("from %s",appdb.T_Protype);
			query.add("where fristNameId_='%s'",head.getString("fristNameId_"));	
			query.open();
			if(!query.eof()){
				query.setBatchSave(true);
				for(int i=0; i<query.getRecNo(); i++){
					query.edit();
					query.getRecords().get(i).setState(DataSetState.dsEdit);
					query.getRecords().get(i).setField("fristName_", head.getString("fristName_"));
					query.getRecords().get(i).setField("fristImgUrl_", head.getString("path"));
					query.getRecords().get(i).setField("updateDate_", TDateTime.Now());
					query.getRecords().get(i).setField("updateUser_", this.getUserCode());
					query.save();
				}}
			/*if(!query.eof()){
				query.edit();
				query.setField("fristName_", head.getString("fristName_"));
				query.setField("fristImgUrl_", head.getString("path"));
				query.setField("updateDate_", TDateTime.Now());
				query.setField("updateUser_", this.getUserCode());
				query.post();
			}*/
		} if(head.getString("twoNameId_")!=null&&head.getString("twoNameId_")!=""){
				SqlQuery ds1 = new SqlQuery(this);
				ds1.add("select UID_,updateDate_,updateUser_,"
						+ "fristName_,fristNameId_,fristState_,fristDel_,twoName_,twoNameId_,"
						+ "twoState_,twoDel_,twoImgUrl_,fristImgUrl_");
				ds1.add("from %s",appdb.T_Protype);
				ds1.add("where twoNameId_='%s'",head.getString("twoNameId_"));	
				ds1.open();
				if(!ds1.eof()){
						ds1.edit();
						ds1.setField("twoName_", head.getString("twoName_"));
						ds1.setField("twoImgUrl_", head.getString("path"));
						ds1.setField("updateDate_", TDateTime.Now());
						ds1.setField("updateUser_", this.getUserCode());
						ds1.post();
					}			
			}
		return true;
	}
	
	//删除分类
	public boolean delType() throws DataValidateException {
		Record head = this.getDataIn().getHead();
		if(head.getString("fristNameId_")!=null&&head.getString("fristNameId_")!=""){
			//删除一级分类
			SqlQuery ds1 = new SqlQuery(this);
			ds1.add("select UID_,updateDate_,updateUser_,"
					+ "fristName_,fristNameId_,fristState_,fristDel_,twoName_,twoNameId_,"
					+ "twoState_,twoDel_");
			ds1.add("from %s",appdb.T_Protype);
			ds1.add("where fristNameId_='%s'",head.getString("fristNameId_"));	
			ds1.open();
			if(!ds1.eof()){
				List<Record> list = ds1.getRecords();
				ds1.edit();
				ds1.setBatchSave(true);
				for(int i=0;i<list.size();i++){
					list.get(i).setState(DataSetState.dsEdit);
					list.get(i).setField("fristDel_","1");
					list.get(i).setField("twoDel_","1");
					list.get(i).setField("updateDate_", TDateTime.Now());
					list.get(i).setField("updateUser_", this.getUserCode());
					
				}
				ds1.save();
			}
		}else if(head.getString("twoNameId_")!=null&&head.getString("twoNameId_")!=""){
			//删除二级分类
			SqlQuery ds = new SqlQuery(this);
			ds.add("select UID_,createDate_,createUser_,updateDate_,updateUser_,"
					+ "fristName_,fristNameId_,fristState_,fristDel_,twoName_,twoNameId_,"
					+ "twoState_,twoDel_");
			ds.add("from %s",appdb.T_Protype);
			ds.add("where twoNameId_='%s'",head.getString("twoNameId_"));	
			ds.open();
			if(!ds.eof()){
				ds.edit();
				ds.setField("twoDel_","1");
				ds.setField("updateDate_", TDateTime.Now());
				ds.setField("updateUser_", this.getUserCode());
				ds.post();
			}
	    }
		return true;
	}
	
    public IStatus querySecondType(DataSet dataIn, DataSet dataOut) {
        Record head = dataIn.getHead();
        String fristNameId = head.getString("fristNameId_");
        /*if (!head.hasValue("fristNameId_")) {
            SqlQuery dsType = new SqlQuery(this);
            dsType.add("select fristNameId_ from %s", appdb.T_Protype);
            dsType.add("where 1=1 and fristDel_=%s", 0);
            dsType.add("group by fristNameId_");
            dsType.setMaximum(1);
            dsType.open();
            if (!dsType.eof()) {
                fristNameId = dsType.getString("fristNameId_");
            }
        }*/
        SqlQuery dsProduct = new SqlQuery(this);
        if(fristNameId == null || fristNameId.length()<=0){
             dsProduct.add("select * from %s", appdb.T_Protype);
             dsProduct.add("where twoDel_=0");
             dsProduct.add("group by twoNameId_");
             dsProduct.open();
             if (!dsProduct.eof()) {
                 dataOut.appendDataSet(dsProduct);
             }
             dataOut.getHead().setField("fristNameId", fristNameId);
             return this.success();
        }else{
        	  dsProduct.add("select * from %s", appdb.T_Protype);
              dsProduct.add("where fristNameId_='%s'", fristNameId);
              dsProduct.add("and twoDel_=0");
              dsProduct.add("group by twoNameId_");
              dsProduct.open();
              if (!dsProduct.eof()) {
                  dataOut.appendDataSet(dsProduct);
              }
              dataOut.getHead().setField("fristNameId", fristNameId);
        }
      
        return this.success();
    }
	
}
