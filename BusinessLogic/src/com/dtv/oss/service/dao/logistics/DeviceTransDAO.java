package com.dtv.oss.service.dao.logistics;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.dtv.oss.dto.DeviceTransitionDTO;
import com.dtv.oss.service.dao.GenericDAO;
import com.dtv.oss.util.DtoFiller;

/**
 * <p>Title: BOSS_P5 for SCN</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: SHDV</p>
 * @author chenjiang
 * @version 2.0
 */

public class DeviceTransDAO extends GenericDAO {
  protected List prepareResult(ResultSet rs) throws SQLException {
  ArrayList list = new ArrayList();
  while(rs.next()) {

      DeviceTransitionDTO dto = new DeviceTransitionDTO();
      dto=DtoFiller.fillDeviceTransitionDTO(rs);
      list.add(dto);
                  
  }
  return list;
}

}