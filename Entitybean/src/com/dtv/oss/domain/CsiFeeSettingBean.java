package com.dtv.oss.domain;

import javax.ejb.CreateException;
import javax.ejb.EntityBean;
import javax.ejb.EntityContext;
import javax.ejb.RemoveException;

import com.dtv.oss.dto.CsiFeeSettingDTO;
import com.dtv.oss.util.EntityBeanAutoUpdate;

abstract public class CsiFeeSettingBean implements EntityBean {
	EntityContext entityContext;

	public CsiFeeSettingPK ejbCreate(java.lang.String csiType, int eventClass)
			throws CreateException {

		return null;
	}

	public CsiFeeSettingPK ejbCreate(CsiFeeSettingDTO dto)
			throws CreateException {
		setCsiType(dto.getCsiType());
		setEventClass(dto.getEventClass());
		 setStatus(dto.getStatus());
		 setInstallationType(dto.getInstallationType());
		 
		 setDtCreate(new java.sql.Timestamp(System.currentTimeMillis()));
		 setDtLastmod(new java.sql.Timestamp(System.currentTimeMillis()));
		return null;
	}

	public void ejbPostCreate(java.lang.String csiType, int eventClass)
			throws CreateException {
		/** @todo Complete this method */
	}

	public void ejbPostCreate(CsiFeeSettingDTO dto) throws CreateException {
		/** @todo Complete this method */
	}

	public void ejbRemove() throws RemoveException {
		/** @todo Complete this method */
	}

	public abstract void setCsiType(java.lang.String csiType);
	public abstract void setStatus(java.lang.String status);
	public abstract void setEventClass(int eventClass);
	public abstract void setInstallationType(String installationType);
	
	public abstract void setDtCreate(java.sql.Timestamp dtCreate);
	public abstract void setDtLastmod(java.sql.Timestamp dtLastmod);

	public abstract java.lang.String getCsiType();
	public abstract java.lang.String getStatus();
	public abstract java.lang.String getInstallationType();
	public abstract int getEventClass();
	
	 public abstract java.sql.Timestamp getDtCreate();
	 public abstract java.sql.Timestamp getDtLastmod();

	public void ejbLoad() {
		/** @todo Complete this method */
	}

	public void ejbStore() {
		/** @todo Complete this method */
	}

	public void ejbActivate() {
		/** @todo Complete this method */
	}

	public void ejbPassivate() {
		/** @todo Complete this method */
	}

	public void unsetEntityContext() {
		this.entityContext = null;
	}

	public void setEntityContext(EntityContext entityContext) {
		this.entityContext = entityContext;
	}
	public int ejbUpdate(CsiFeeSettingDTO dto) {
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