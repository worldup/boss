package com.dtv.oss.domain;

import java.sql.Timestamp;

public interface ActivityToMarketSegment extends javax.ejb.EJBLocalObject {
  public void setDtCreate(Timestamp dtCreate);
  public Timestamp getDtCreate();
  public void setDtLastmod(Timestamp dtLastmod);
  public Timestamp getDtLastmod();
  public int getActivityId();
  public int getMarketSegmentId();
}