package com.dtv.oss.service.component;

import java.util.Collection;
import java.util.Iterator;

import javax.ejb.CreateException;
import javax.ejb.EJBException;
import javax.ejb.FinderException;
import javax.ejb.RemoveException;

import com.dtv.oss.domain.OpToGroup;
import com.dtv.oss.domain.OpToGroupHome;
import com.dtv.oss.domain.OpToGroupPK;
import com.dtv.oss.dto.OpToGroupDTO;
import com.dtv.oss.log.LogLevel;
import com.dtv.oss.log.LogUtility;
import com.dtv.oss.service.ServiceContext;
import com.dtv.oss.service.ServiceException;
import com.dtv.oss.service.factory.HomeFactoryException;
import com.dtv.oss.service.util.HomeLocater;
import com.dtv.oss.service.util.SystemLogRecorder;

public class ConfigGroupMemberService extends AbstractService {

	ServiceContext context=null;
	private static Class clazz=ConfigGroupMemberService.class;
	
	public ConfigGroupMemberService(ServiceContext s){
		this.context=s;
	}
	
	public void deleteOpGroup2Member(Collection col)throws ServiceException{
		
		 if (col == null || col.size() == 0) {
		 	LogUtility.log(clazz,LogLevel.WARN,"传入的参数为空!");
			return;
        }
		 try{
		    Iterator iter = col.iterator();
	        OpToGroupHome og2pHome = HomeLocater.getOpToGroupHome();
	        while (iter.hasNext()) {
	        	OpToGroupDTO dto = (OpToGroupDTO) iter.next();
	        	 
	        	OpToGroupPK pk = new OpToGroupPK(dto.getOperatorId(), dto.getOpGroupId());
	        	OpToGroup opToGroup = og2pHome.findByPrimaryKey(pk);
	            opToGroup.remove();
				   
				 
	            SystemLogRecorder.createSystemLog(PublicService.getRemoteHostAddress(context), 
		    			PublicService.getCurrentOperatorID(context), 0, 
						SystemLogRecorder.LOGMODULE_CONFIG,"删除", 
						"删除操作员组成员信息 OPGROUPID为:" + dto.getOpGroupId() +",OPERATORID为:" + dto.getOperatorId(), 
						
						SystemLogRecorder.LOGCLASS_NORMAL, SystemLogRecorder.LOGTYPE_APP);
	        }
	        
	    }
		catch(HomeFactoryException e){
			LogUtility.log(clazz,LogLevel.WARN, "定位出错");
    		throw new ServiceException("定位出错");
		} catch (FinderException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}catch (EJBException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		 catch (RemoveException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
	}
	
	public void addOpGroup2Member(Collection col)throws ServiceException{
		 if (col == null || col.size() == 0) {
		 	LogUtility.log(clazz,LogLevel.WARN,"传入的参数为空!");
			return;
        }
		
		 try{
		    Iterator iter = col.iterator();
		    OpToGroupHome og2pHome = HomeLocater.getOpToGroupHome();
	        while (iter.hasNext()) {
	        	OpToGroupDTO dto = (OpToGroupDTO) iter.next();
	            og2pHome.create(dto);
	           
				   
				 
	            SystemLogRecorder.createSystemLog(PublicService.getRemoteHostAddress(context), 
		    			PublicService.getCurrentOperatorID(context), 0, 
						SystemLogRecorder.LOGMODULE_CONFIG, "新增",
						"新增操作员组成员信息OPGROUPID为:" + dto.getOpGroupId()+",OPERATORID为:" + dto.getOperatorId(), 
						 
						SystemLogRecorder.LOGCLASS_NORMAL, SystemLogRecorder.LOGTYPE_APP);
	        }
	        
	    }
		catch(HomeFactoryException e){
			LogUtility.log(clazz,LogLevel.WARN, "定位出错");
    		throw new ServiceException("定位出错");
		} catch (CreateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}catch (EJBException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		 
	}
	 
	 
	 
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
