package com.dtv.oss.web.action.statistics;

import javax.servlet.http.HttpServletRequest;

import com.dtv.oss.dto.custom.CommonQueryConditionDTO;
import com.dtv.oss.service.ejbevent.EJBEvent;
import com.dtv.oss.service.ejbevent.statistics.StatQueryEJBEvent;
import com.dtv.oss.web.action.QueryWebAction;
import com.dtv.oss.web.exception.WebActionException;
import com.dtv.oss.web.util.WebUtil;

/**
 * 帐单统计
 * date       : 2007-1-17
 * description:
 * @author  
 *
 */
public class BillStatWebAction extends QueryWebAction {

	protected EJBEvent encapsulateData(HttpServletRequest request)
			throws Exception {
		//DTO封装参数说明
		//------------------用于 帐单-------
		//SpareStr1:客户类型
		//SpareStr2:所在区域
		//SpareStr3:帐户类型
		//SpareStr4:帐务周期
		//SpareStr5:付费类型
		//SpareTime1:创建时间1
		//SpareTime2:创建时间2
		
		
		
		CommonQueryConditionDTO	dto = new CommonQueryConditionDTO();
		//SpareStr1:客户类型
		if(WebUtil.StringHaveContent(request.getParameter("txtCustType")))
			dto.setSpareStr1(request.getParameter("txtCustType"));	
		//SpareStr2:所在区域
		if(WebUtil.StringHaveContent(request.getParameter("txtDistrictID")))
			dto.setSpareStr2(request.getParameter("txtDistrictID"));
		//SpareStr3:帐户类型
		if(WebUtil.StringHaveContent(request.getParameter("txtAcctType")))
			dto.setSpareStr3(request.getParameter("txtAcctType"));
		//SpareStr4:帐务周期
		if(WebUtil.StringHaveContent(request.getParameter("txtInvoiceCycle")))
			dto.setSpareStr4(request.getParameter("txtInvoiceCycle"));
		//SpareStr5:付费类型
		if(WebUtil.StringHaveContent(request.getParameter("txtMOP")))
			dto.setSpareStr5(request.getParameter("txtMOP"));
		//SpareTime1:创建时间1
		if(WebUtil.StringHaveContent(request.getParameter("txtCreateTime1")))
			dto.setSpareTime1(WebUtil.StringToTimestampWithDayBegin(request.getParameter("txtCreateTime1")));
		//SpareTime2:创建时间2
		if(WebUtil.StringHaveContent(request.getParameter("txtCreateTime2")))
			dto.setSpareTime2(WebUtil.StringToTimestampWithDayEnd(request.getParameter("txtCreateTime2")));
		
		
		return new StatQueryEJBEvent(dto,pageFrom,pageTo,StatQueryEJBEvent.QUERY_TYPE_STAT_BILL);
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
