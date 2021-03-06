package com.dtv.oss.web.action.config;

import javax.servlet.http.HttpServletRequest;

import com.dtv.oss.dto.ServiceDTO;
import com.dtv.oss.service.ejbevent.EJBEvent;
import com.dtv.oss.service.ejbevent.config.ConfigQueryEJBEvent;

import com.dtv.oss.web.action.QueryWebAction;
import com.dtv.oss.web.exception.WebActionException;
import com.dtv.oss.web.util.WebUtil;

public class QueryServiceInfoWebAction extends QueryWebAction {
	
	protected EJBEvent encapsulateData(HttpServletRequest request) throws WebActionException {
		ServiceDTO dto =new ServiceDTO();
		dto.setServiceID(WebUtil.StringToInt(request.getParameter("txtServiceID")));	
		
		if (request.getParameter("txtFrom")==null){
			pageFrom =1;
		}
		
		if (request.getParameter("txtTo") ==null){
			pageTo =10;
		}
		
		return new ConfigQueryEJBEvent(dto,pageFrom,pageTo,ConfigQueryEJBEvent.CONFIG_SERVICEINFO_QUERY);	
	}
    
}
