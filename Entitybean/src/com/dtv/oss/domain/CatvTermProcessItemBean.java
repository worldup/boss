package com.dtv.oss.domain;

import java.sql.Timestamp;

import javax.ejb.CreateException;
import javax.ejb.EntityBean;
import javax.ejb.EntityContext;
import javax.ejb.RemoveException;

import com.dtv.oss.dto.CatvTermProcessItemDTO;
import com.dtv.oss.util.EntityBeanAutoUpdate;

public abstract class CatvTermProcessItemBean implements EntityBean {
    EntityContext entityContext;
    public Integer ejbCreate(Integer itemNo) throws CreateException {

       // setItemNo(itemNo);
        return null;
    }

    public Integer ejbCreate(CatvTermProcessItemDTO dto) throws CreateException {
    	
    	try {
			EntityBeanAutoUpdate.update(dto, this);
			setDtCreate(new java.sql.Timestamp(System.currentTimeMillis()));
		    setDtLastmod(new java.sql.Timestamp(System.currentTimeMillis()));
		} catch (Exception e) {
			e.printStackTrace();
			 
		}
        return null;
       
    }

    public void ejbPostCreate(Integer itemNo) throws CreateException {
    }

    public void ejbPostCreate(CatvTermProcessItemDTO dto) throws CreateException {
    }

    public void ejbRemove() throws RemoveException {
    }

    public abstract void setItemNo(Integer itemNo);

    public abstract Integer getItemNo();

    public abstract void setBatchId(int batchId);

    public abstract int getBatchId();

    public abstract void setCatvId(String catvId);

    public abstract String getCatvId();

    public abstract void setCreateDate(Timestamp createDate);

    public abstract Timestamp getCreateDate();

    public abstract void setCreateOperatorId(int createOperatorId);

    public abstract int getCreateOperatorId();

    public abstract void setCreateOrgId(int createOrgId);

    public abstract int getCreateOrgId();

    public abstract void setAuditDate(Timestamp auditDate);

    public abstract Timestamp getAuditDate();

    public abstract void setAuditOperatorId(int auditOperatorId);

    public abstract int getAuditOperatorId();

    public abstract void setAuditOrgId(int auditOrgId);

    public abstract int getAuditOrgId();

    public abstract void setStatus(String status);

    public abstract String getStatus();

    public abstract void setComments(String comments);

    public abstract String getComments();

    public abstract void setDtCreate(Timestamp dtCreate);

    public abstract Timestamp getDtCreate();

    public abstract void setDtLastmod(Timestamp dtLastmod);

    public abstract Timestamp getDtLastmod();

    public void ejbLoad() {
    }

    public void ejbStore() {
    }

    public void ejbActivate() {
    }

    public void ejbPassivate() {
    }

    public void unsetEntityContext() {
        this.entityContext = null;
    }

    public void setEntityContext(EntityContext entityContext) {
        this.entityContext = entityContext;
    }
    public int ejbUpdate(CatvTermProcessItemDTO dto) {
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

