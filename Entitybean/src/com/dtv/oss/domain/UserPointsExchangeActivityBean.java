package com.dtv.oss.domain;

import java.sql.Timestamp;

import javax.ejb.CreateException;
import javax.ejb.EntityBean;
import javax.ejb.EntityContext;
import javax.ejb.RemoveException;

import com.dtv.oss.dto.UserPointsExchangeActivityDTO;
import com.dtv.oss.util.EntityBeanAutoUpdate;

abstract public class UserPointsExchangeActivityBean implements EntityBean {
  EntityContext entityContext;
  public java.lang.Integer ejbCreate(java.lang.Integer id) throws CreateException {
    //setId(id);
    return null;
  }
  public java.lang.Integer ejbCreate(UserPointsExchangeActivityDTO dto) throws CreateException {
  	  setName(dto.getName());
      setDescr(dto.getDescr());
      setDateStart(dto.getDateStart());
      setDateEnd(dto.getDateEnd());
      setStatus(dto.getStatus());
      setDtCreate(new Timestamp(System.currentTimeMillis()));
	  setDtLastmod(new Timestamp(System.currentTimeMillis()));
    return null;
  }
  public void ejbPostCreate(java.lang.Integer id) throws CreateException {
    /**@todo Complete this method*/
  }
  public void ejbPostCreate(UserPointsExchangeActivityDTO dto) throws CreateException {
    /**@todo Complete this method*/
  }
  public void ejbRemove() throws RemoveException {
    /**@todo Complete this method*/
  }
  public abstract void setId(java.lang.Integer id);
  public abstract void setName(java.lang.String name);
  public abstract void setDescr(java.lang.String descr);
  public abstract void setDateStart(java.sql.Timestamp dateStart);
  public abstract void setDateEnd(java.sql.Timestamp dateEnd);
  public abstract void setStatus(java.lang.String status);
  public abstract void setDtCreate(java.sql.Timestamp dtCreate);
  public abstract void setDtLastmod(java.sql.Timestamp dtLastmod);
  public abstract java.lang.Integer getId();
  public abstract java.lang.String getName();
  public abstract java.lang.String getDescr();
  public abstract java.sql.Timestamp getDateStart();
  public abstract java.sql.Timestamp getDateEnd();
  public abstract java.lang.String getStatus();
  public abstract java.sql.Timestamp getDtCreate();
  public abstract java.sql.Timestamp getDtLastmod();
  public void ejbLoad() {
    /**@todo Complete this method*/
  }
  public void ejbStore() {
    /**@todo Complete this method*/
  }
  public void ejbActivate() {
    /**@todo Complete this method*/
  }
  public void ejbPassivate() {
    /**@todo Complete this method*/
  }
  public void unsetEntityContext() {
    this.entityContext = null;
  }
  public void setEntityContext(EntityContext entityContext) {
    this.entityContext = entityContext;
  }
  public int ejbUpdate(UserPointsExchangeActivityDTO dto) {
	/** @todo Complete this method */
	if (dto.getDtLastmod() == null) {
		return -1;
	}

	if (!dto.getDtLastmod().equals(getDtLastmod())) {

		return -1;
	} else {
		try {
			EntityBeanAutoUpdate.update(dto, this);
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
		setDtLastmod(new java.sql.Timestamp(System.currentTimeMillis()));
		return 0;
	}
}

}