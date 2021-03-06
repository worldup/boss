package com.dtv.oss.service.dao;

import java.util.List;
import java.sql.Connection;
import javax.sql.DataSource;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.dtv.oss.log.LogLevel;
import com.dtv.oss.log.LogUtility;
import com.dtv.oss.service.factory.HomeFactory;
import com.dtv.oss.service.factory.HomeFactoryException;
import com.dtv.oss.service.listhandler.ValueListHandler;

//this class is used to connect scna database
public abstract class GenericDAO4SCNA {
	protected ValueListHandler listHandler;
	public GenericDAO4SCNA() {
	}

	public GenericDAO4SCNA(ValueListHandler listHandler) {
		this.listHandler = listHandler;
	}

    // the methods relevant to the ValueListHandler
    // are shown here.
    // See Data Access Object pattern for other details.
    public List executeSelect(String selectString) throws SQLException {
        Connection con = null;
        Statement stmt= null;
        List list = null;
        boolean none = false;

        try {
            DataSource ds = HomeFactory.getFactory().getDataSource4ScnA();
            con = ds.getConnection();
            //con =  com.dtv.oss.util.BusinessService.getDBConnectionDirect();
            LogUtility.log(GenericDAO4SCNA.class,LogLevel.DEBUG,"in executeSelect method get connection done");
            stmt = con.createStatement();
            LogUtility.log(GenericDAO4SCNA.class,LogLevel.DEBUG,"in executeSelect method statement created.");
            ResultSet rs = stmt.executeQuery(selectString);
            LogUtility.log(GenericDAO4SCNA.class,LogLevel.DEBUG,"in executeSelect method query executed.");
            list = prepareResult(rs);
            LogUtility.log(GenericDAO4SCNA.class,LogLevel.DEBUG,"in executeSelect method prepare results done.");
            stmt.close();
            LogUtility.log(GenericDAO4SCNA.class,LogLevel.DEBUG,"in executeSelect method statement closed.");

        } catch(HomeFactoryException he) {
            he.printStackTrace();
        } finally {
            con.close();
            LogUtility.log(GenericDAO4SCNA.class,LogLevel.DEBUG,"in executeSelect method connection closed.");
        }
        return list;
    }

    protected abstract List prepareResult(ResultSet rs) throws SQLException;

}