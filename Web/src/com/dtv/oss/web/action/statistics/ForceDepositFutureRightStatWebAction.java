package com.dtv.oss.web.action.statistics;

import javax.servlet.http.HttpServletRequest;

import com.dtv.oss.dto.custom.CommonQueryConditionDTO;
import com.dtv.oss.service.ejbevent.EJBEvent;
import com.dtv.oss.service.ejbevent.statistics.StatQueryEJBEvent;
import com.dtv.oss.web.action.QueryWebAction;
import com.dtv.oss.web.util.WebUtil;

/**
 * 押金和期权统计
 * author     ：Jason.Zhou 
 * date       : 2007-1-16
 * description:
 * @author 250713z
 *
 */
public class ForceDepositFutureRightStatWebAction extends QueryWebAction {

	protected EJBEvent encapsulateData(HttpServletRequest request)
			throws Exception {
		
		//DTO封装参数说明
		//------------------用于客户统计-------
		//SpareStr1:客户类型
		//SpareStr2:帐户类型
		//SpareStr3:付费方式
		//SpareStr4:区域
		//SpareStr5:帐户状态
		//SpareTime1:创建时间1
		//SpareTime2:创建时间2
		CommonQueryConditionDTO	dto = new CommonQueryConditionDTO();
		
		//SpareStr1:客户类型
		if(WebUtil.StringHaveContent(request.getParameter("txtCustomerType")))
			dto.setSpareStr1(request.getParameter("txtCustomerType"));
		//SpareStr2:帐户类型
		if(WebUtil.StringHaveContent(request.getParameter("txtAccountType")))
			dto.setSpareStr2(request.getParameter("txtAccountType"));
		//SpareStr3:付费方式
		if(WebUtil.StringHaveContent(request.getParameter("txtMopID")))
			dto.setSpareStr3(request.getParameter("txtMopID"));
		//SpareStr4:区域
		if(WebUtil.StringHaveContent(request.getParameter("txtDistrictID")))
			dto.setSpareStr4(request.getParameter("txtDistrictID"));
		//SpareStr5:帐户状态
		if(WebUtil.StringHaveContent(request.getParameter("txtStatus")))
			dto.setSpareStr5(request.getParameter("txtStatus"));
		
		//SpareTime1:创建时间1
		if(WebUtil.StringHaveContent(request.getParameter("txtCreateTime1")))
			dto.setSpareTime1(WebUtil.StringToTimestampWithDayBegin(request.getParameter("txtCreateTime1")));
		//SpareTime2:创建时间2
		if(WebUtil.StringHaveContent(request.getParameter("txtCreateTime2")))
			dto.setSpareTime2(WebUtil.StringToTimestampWithDayEnd(request.getParameter("txtCreateTime2")));		
		
		return new StatQueryEJBEvent(dto,pageFrom,pageTo,StatQueryEJBEvent.QUERY_TYPE_STAT_FORCEDEPOSIT_FUTURERIGHT);
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
