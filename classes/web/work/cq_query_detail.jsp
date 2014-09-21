<%@ taglib uri="osstags" prefix="d" %>
<%@ taglib uri="bookmark" prefix="bk" %>
<%@ taglib uri="logic" prefix="lgc" %>
<%@ taglib uri="privilege" prefix="pri" %>
<%@ taglib uri="/WEB-INF/html.tld" prefix="tbl" %>
<%@ page import="java.util.*"%>
<%@ page import="com.dtv.oss.dto.CustomerProblemDTO"%>
<%@ page import="com.dtv.oss.dto.CustProblemProcessDTO"%>
<%@ page import="com.dtv.oss.dto.AddressDTO"%>
<%@ page import="com.dtv.oss.dto.CustomerDTO"%>
<%@ page import="com.dtv.oss.util.Postern,com.dtv.oss.web.util.LogonWebCurrentOperator,com.dtv.oss.dto.OperatorDTO"%>
<%@ page import="com.dtv.oss.web.util.CurrentLogonOperator"%>
<%@ page import="com.dtv.oss.dto.wrap.work.CustomerProblem2CPProcessWrap" %>
<%@ page import="com.dtv.oss.web.util.CommonKeys" %>
<%@ page import="com.dtv.oss.service.util.CommonConstDefinition" %>

<script language=javascript>

 function historyRecord(){
        var txtID =document.frmPost.txtID.value;
        document.frmPost.action ="cp_process_log.do?txtID="+txtID;
        document.frmPost.submit();
 }
 function repair_adjust(){
       document.frmPost.action ="problem_adjust.do";
       document.frmPost.submit();
 }
 function repair_assign(){
 	document.frmPost.action = "assignrep_query_result.do?fflag=frombutton&&txtCustomerProblemID=" + document.frmPost.txtID.value;
 	document.frmPost.submit();
 } 
 function repair_close(){
 	document.frmPost.action = "cp_query_for_manual_close.do?fflag=frombutton&&txtCustomerProblemID=" + document.frmPost.txtID.value;
 	document.frmPost.submit();
 }
 function repair_terminal(){
 	self.location.href = "teminate_rep.do?txtCustomerProblemID=" + document.frmPost.txtID.value;
 }
 function repair_transfer(){
 	self.location.href = "sheetrep_view.do?txtCustomerProblemID=" + document.frmPost.txtID.value; 	
 }
 function repair_diagnosis(str){
 	document.frmPost.action = "menu_cp_diagnosis.do?fflag=frombutton&&txtCustomerProblemID="+str;
 	document.frmPost.submit();
 }
</script>
<div id="updselwaitlayer" style="position:absolute; left:650px; top:170px; width:250px; height:24px; display:none">
    <table width="100%" border="0" cellspacing="1" cellpadding="3">
        <tr>
          <td width="100%"><div align="center">
          <font size="2">
          正在获取内容。。。
          </font>
          </td>
        </tr>
    </table>
</div>
<TABLE border="0" cellspacing="0" cellpadding="0" width="820" >
<TR>
	<TD>

<iframe SRC="update_select.screen" name="FrameUS" width="0" height="0" frameborder="0" scrolling="0"  >
</iframe>
<table  border="0" align="center" cellpadding="0" cellspacing="10" >
  <tr>
    <td><img src="img/list_tit.gif" width="19" height="19"></td>
    <td class="title">报修单详细信息</td>
  </tr>
</table>
<table width="98%"  border="0" align="center" cellpadding="0" cellspacing="0" background="img/line_01.gif">
  <tr>
    <td><img src="img/mao.gif" width="1" height="1"></td>
  </tr>
</table>
<br>
 
 
<form name="frmPost" method="post">
 
<lgc:bloop requestObjectName="ResponseQueryResult" item="oneline">
  <% 
       
        CustomerProblem2CPProcessWrap wrap = (CustomerProblem2CPProcessWrap)pageContext.getAttribute("oneline");
         
	CustomerProblemDTO dto = wrap.getCpDto();
	//诊断信息
	int txtCustomerProblemID = dto.getId();
	Map firstDiagnosisMap = Postern.getDiagnosisInfoByCon(txtCustomerProblemID,CommonKeys.DIAGNOSIS_INFOR_SOURCE_TYPE_E);
	//System.out.println("firstDiagnosisMap="+firstDiagnosisMap);
	if(firstDiagnosisMap == null) firstDiagnosisMap = new HashMap();
	 pageContext.setAttribute("firstServeyDiagnosisMap",firstDiagnosisMap);
	int txtReferJobCardID = dto.getReferJobCardID();
	Map lastDiagnosisMap = Postern.getDiagnosisInfoByCon(txtCustomerProblemID,CommonKeys.DIAGNOSIS_INFOR_SOURCE_TYPE_A);
	if(lastDiagnosisMap == null) lastDiagnosisMap = new HashMap();
	pageContext.setAttribute("LastServeyDiagnosisMap",lastDiagnosisMap);
	
	String serviceID = Postern.getServiceIDByAcctServiceID(dto.getCustServiceAccountID())+"";
	
	//保修单状态
	String status = dto.getStatus();
	pageContext.setAttribute("oneline", dto);
	 String referType=null;
	int intCustID = dto.getCustID();
	CustomerDTO custDTO=Postern.getCustomerByID(intCustID);
	pageContext.setAttribute("customerDTO", custDTO);
	 
	String strCustName = custDTO.getName();
	AddressDTO addrDto = Postern.getAddressDtoByID(dto.getAddressID());
	pageContext.setAttribute("custaddr", addrDto);
	String strAddress = Postern.getAddressById(dto.getAddressID());
	if (strAddress==null) strAddress="";
	CustProblemProcessDTO cppDto=wrap.getCppDto();
	 
	pageContext.setAttribute("cpp", cppDto);
	
        String strOperName = Postern.getOperatorNameByID(dto.getCreateOpId());
      //  java.util.List diaType = Postern.getDiaTypeByCustProbID(dto.getId());
         int jobCardId = Postern.getJobCardIDByCustProblemId(dto.getId());
         if (jobCardId>0){
           referType = Postern.getReferSourceTypeByID(jobCardId);
         } 
         if (jobCardId == 0){
            referType = Postern.getReferSourceTypeByID(dto.getId());
         }
        
       String flag = dto.getCallBackFlag();
       boolean vflag = Postern.buttonCanBeVisibleForCP(dto.getId(),CurrentLogonOperator.getOperator(request).getOrgID());
       pageContext.setAttribute("canBeVisible", vflag+"");
       System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$"+vflag);
      // Operator op = CurrentLogonOperator.getOperator(request);
         
 %>
 <table width="820"  border="0" align="center" cellpadding="5" cellspacing="1" class="list_bg">
	 <tr>
		<td width="17%" class="list_bg2"><div align="right">客户证号</div></td>
		<td width="33%" class="list_bg1"><font size="2"><input type="text" name="txtCustId" size="25"  value="<tbl:write name="oneline" property="CustID"/>" class="textgray" readonly ></font></td>
		<td width="17%" class="list_bg2"><div align="right">客户姓名</div></td>
		<td width="33%" class="list_bg1"><font size="2">
		  <input type="text" name="txtSurname" size="25"  value="<%=strCustName%>" class="textgray" readonly>
		  <input type="hidden" name="txtCustomerID"   value ="<%=intCustID%>" >
		  <input type="hidden" name="txtAccountID"   value ="<tbl:write name="oneline" property="custAccountID"/>" >
		</font></td> 
	</tr>
	 <tr>
		<td class="list_bg2"><div align="right">业务帐户</div></td>
		<td class="list_bg1"><font size="2"><input type="text" name="txtServiceAccountID" size="25"  value="<tbl:write name="oneline" property="custServiceAccountID"/>" class="textgray" readonly ></font></td>
		<%
		String accountName=Postern.getAcctNameById(dto.getCustAccountID());
		if(accountName==null)
		  accountName="";
		%>
		<td class="list_bg2"><div align="right">帐户名称</div></td>
		<td class="list_bg1"><font size="2">
		  <input type="text" name="txtAccountName" size="25"  value="<%=accountName%>" class="textgray" readonly>
		</font></td> 
	</tr>
 
    <tr>
      <td width="17%" class="list_bg2"><div align="right">报修单编号</div></td>
      <td width="33%" class="list_bg1">
       <input type="text" name="txtID" size="25"  value="<tbl:write name="oneline" property="Id" />" class="textgray" readonly >
      </td>
		<td width="17%" class="list_bg2"><div align="right">报修单状态</div></td>
		<td width="33%" class="list_bg1"><font size="2">
		    <input type="text" name="txtStatusShow" size="25"  value="<d:getcmnname typeName="SET_C_PROBLEMSTATUS" match="oneline:Status"/>" class="textgray" readonly >
		    <input type="hidden" name="txtStatus" value="<tbl:write name="oneline" property="Status" />" >
		</font></td> 
	 </tr>
	<tr>
		<td class="list_bg2"><div align="right">收费类别</div></td>
		<td class="list_bg1"><font size="2"><input type="text" name="txtFeeClass" size="25"  value="<d:getcmnname typeName="SET_C_CPFEECLASS" match="oneline:FeeClass"/>" class="textgray" readonly ></font></td>
		<td class="list_bg2"><div align="right">报修类别</div></td>
		<td class="list_bg1"><font size="2"><input type="text" name="txtProblemCategoryShow" size="25"  value="<d:getcmnname typeName="SET_C_CPPROBLEMCATEGORY" match="oneline:ProblemCategory"/>" class="textgray" readonly ></font></td>
	</tr>
	<tr>
		<td class="list_bg2"><div align="right">当前处理部门</div></td>
		<td class="list_bg1"><font size="2"><input type="text" name="txtCurrentSubcompanyName" size="25"  value="<tbl:WriteOrganizationInfo name="oneline" property="processOrgId" />" class="textgray" readonly ></font></td>
		<td class="list_bg2"><div align="right">客户所在区域</div></td>
		<td class="list_bg1">
		 <input type="text" name="txtDistrictDesc" size="25" maxlength="50" class="textgray" readonly value="<tbl:WriteDistrictInfo name="custaddr" property="DistrictID" />" class="text">
		 <input type="hidden" name="txtAddressId" value="<tbl:write name="oneline" property="addressID"/>">
	</tr>
	<tr>
		<td class="list_bg2"><div align="right">是否手工流转</div></td>
		<td class="list_bg1"><font size="2"><input type="text" name="txtDistrictDesc" size="25" maxlength="50" class="textgray" readonly value="<d:getcmnname typeName="SET_G_YESNOFLAG" match="oneline:isManualTransfer"/>"></font></td>
		<td class="list_bg2"><div align="right">流转前处理部门</div></td>
		<td class="list_bg1">
		 <input type="text" name="txtManualTransferFromOrgID" size="25"  value="<tbl:WriteOrganizationInfo name="oneline" property="manualTransferFromOrgID" />" class="textgray" readonly >
	</tr>  
	<tr>
		<td class="list_bg2"><div align="right">联系人姓名</div></td>
		<td class="list_bg1"><font size="2"><input type="text" name="txtContactName" size="25"  value="<tbl:write name="oneline" property="ContactPerson"/>" class="textgray" readonly ></font></td>
		<td class="list_bg2"><div align="right">地址</div></td>
		<td class="list_bg1"><font size="2"><input type="text" name="txtAddress" size="25"  value="<%=strAddress%>" class="textgray" readonly></font></td>
	</tr>                                  
         <tr>
		<td class="list_bg2"><div align="right">联系电话</div></td>
		<td class="list_bg1"><font size="2"><input type="text" name="txtContactphone" size="25"  value="<tbl:write name="oneline" property="contactphone"/>" class="textgray" readonly ></font></td>
		<td class="list_bg2"><div align="right">当前处理动作</div></td>
		 <td class="list_bg1"><input type="text" name="txtShowAction" size="25"  value="<d:getcmnname typeName="SET_C_CPPROCESSACTION" match="cpp:action"/>" class="textgray" readonly >
	</tr>
	 <tr>
		<td class="list_bg2" align="right" >创建时间</td>
		<td class="list_bg1"><font size="2">
			<input type="text" name="txtCreateDate" size="25"  value="<tbl:writedate name="oneline" property="createDate" includeTime="true" />" class="textgray" readonly >
		</font></td>
		<td class="list_bg2" align="right" >创建操作员</td>
		<td class="list_bg1" ><font size="2">
			<input type="text" name="txtCreateOperName" size="25"  value="<%=strOperName%>" class="textgray" readonly >
		</font></td>
	</tr>
	 <tr>
		<td class="list_bg2" align="right" >回访时间</td>
		<td class="list_bg1"><font size="2">
			<input type="text" name="txtCallBackDate" size="25"  value="<tbl:writedate name="oneline" property="callBackDate" includeTime="true" />" class="textgray" readonly >
		</font></td>
		<td class="list_bg2" align="right" >回访标志</td>
		<td class="list_bg1" ><font size="2">
	        <input type="text" name="txtCallBackFlag" size="25"  value="<d:getcmnname typeName="SET_C_CPCALLBACKFLAG" match="oneline:callBackFlag"/>" class="textgray" readonly ></font></td>
			 
		 
	</tr>
	<tr>
		<td valign="middle" class="list_bg2" align="right" >故障描述</td>
		<td class="list_bg1" colspan="3"><font size="2">
		<textarea name="txtProblemDesc"  class="textareagray" readonly  cols="80" rows=3><tbl:write  name="oneline" property="ProblemDesc" /></textarea>
		</font></td>
	</tr>
	<% 
     if(firstDiagnosisMap!=null && !firstDiagnosisMap.isEmpty()){%>
  
	  <tr>
	    <td colspan="4" class="import_tit" align="center">
						<font size="3">初步诊断信息</font>
			</td>
	  </tr>

	 <tr>
	 <tbl:dynamicservey serviceID="<%=serviceID%>" serveyType="D"  serveySubType="N"  showType="label" tdWordStyle="list_bg2" tdControlStyle="list_bg1"  controlSize="25"  match="firstServeyDiagnosisMap" />
   </tr>
	      
   <%} if(lastDiagnosisMap!=null && !lastDiagnosisMap.isEmpty()) {%>
  <tr>
    	<td colspan="4" class="import_tit" align="center">
						<font size="3">专业诊断信息</font>
			</td>
  </tr>

	 <tr>
	   <tbl:dynamicservey serviceID="<%=serviceID%>" serveyType="D"  serveySubType="P"  showType="label" tdWordStyle="list_bg2" tdControlStyle="list_bg1"  controlSize="25"  match="LastServeyDiagnosisMap" />
   </tr>
     <%}%>
  </table>  

<% 
	java.util.Collection feecol=Postern.getAllFeeListByCsiAndType(dto.getId(),CommonKeys.AIREFERTYPE_P);
  if(feecol!=null&&!feecol.isEmpty()) {
 %>
<tr><td valign="middle"> 
          <table width="810" border="0" align="center">
            <tr> 
              <td  class="import_tit" align="center"><font size="3">应收费用明细</strong></td>
	    </tr>
            <tr ><td align="center"> 
              <iframe SRC="csi_fee_list.do?CSIID=<%=dto.getId()%>&ReferType=<%=CommonKeys.AIREFERTYPE_P%>" id="FrameFeeList" name="FrameFeeList" width="100%" height="146"></iframe>
            </td></tr>
          </table>
   </td></tr>
   <% }
	  feecol=Postern.getAllPaymentListByCsiAndType(dto.getId(),CommonKeys.PAYMENTRECORDSOURCETYPE_REPAIR);
    if(feecol!=null&&!feecol.isEmpty()) {
  %>
   <tr><td valign="middle">
          <table width="810" border="0" align="center">
            <tr> 
              <td  class="import_tit" align="center" ><font size="3">实收费用明细</strong></td>
	    </tr>
	    <tr ><td align="center"> 
               <iframe SRC="csi_payment_list.do?CSIID=<%=dto.getId()%>&SourceType=<%=CommonKeys.PAYMENTRECORDSOURCETYPE_REPAIR%>" id="FramePaymentList" name="FramePaymentList" width="100%" height="146"></iframe>
            </td></tr>
           </table>
    </td></tr>
  <% }
    feecol=Postern.getAllPrepaymentDeductionRecordListByCsiAndType(dto.getId(),CommonKeys.F_PDR_REFERRECORDTYPE_P);
    if(feecol!=null&&!feecol.isEmpty()) {
  %>
    <table width="810" border="0" align="center">
        <tr> 
            <td class="import_tit" align="center" ><font size="3">预存抵扣明细</strong></td>
	     </tr>	    
	     <tr ><td align="center"> 
        <iframe SRC="prepayment_list.do?txtReferRecordID=<%=dto.getId()%>&txtReferRecordType=<%=CommonKeys.F_PDR_REFERRECORDTYPE_P%>" id="FramePaymentList" name="FramePaymentList"  height="130" width="100%"></iframe>
       </td></tr>
    </table>
<% } %>  
<br>
<input type="hidden" name="txtFrom" size="20" value="1">
<input type="hidden" name="txtTo" size="20" value="10">
<table align="center" border="0" cellspacing="0" cellpadding="0">
     <tr> 
           <td><img src="img/button2_r.gif" width="22" height="20"></td>
            <td background="img/button_bg.gif"><a href="<bk:backurl property="job_card_view.do/cp_query_for_terminate.do/cp_query_for_manual_close.do/register_repair_info_query_result.do/assignrep_query_result.do/cp_query_result.do/cp_diagnosis_query.do/rep_job_card_query_result.do" />" class="btn12">返&nbsp;回</a></td>
            <td><img src="img/button2_l.gif" width="11" height="20"></td>
              <td width="20" ></td>
          <td><img src="img/button_l.gif" border="0" ></td>
          <td background="img/button_bg.gif"  ><a href="javascript:historyRecord()"  class="btn12">历史记录</a></td>
          <td><img src="img/button_r.gif" border="0" ></td>
          
       	<d:displayControl id="button_customerproblem_query_detail_jobcard" bean="oneline">
           <td width="20" ></td>	 
          <td><img src="img/button_l.gif" border="0" ></td>
          <td background="img/button_bg.gif">
	   <a href="job_card_view.do?txtJobCardID=<tbl:write name="oneline" property="referJobCardID"/>" class="btn12">相关维修工单</a></td>
          <td><img src="img/button_r.gif" border="0" ></td>
	</d:displayControl>
         
       <% 
       //if(referType!=null){ 
        //     if(referType.equals("E")){
           %>
           <!--
          <td width="20" ></td>
         <td><img src="img/button_l.gif" border="0" ></td>
         <td background="img/button_bg.gif">
	  <a href="diagnosis_info_view_n.do?txtCustomerProblemID=<tbl:write name="oneline" property="id"/>" class="btn12">诊断信息</a></td>
         <td><img src="img/button_r.gif" border="0" ></td>
         -->
       
      <%
     // } else {
      %>
     <!--
       <td width="20" ></td>
       <td><img src="img/button_l.gif" border="0" ></td>
         <td background="img/button_bg.gif">
	  <a href="diagnosis_info_view_p.do?txtReferJobCardID=<tbl:write name="oneline" property="referJobCardID"/>" class="btn12">诊断信息</a></td>
         <td><img src="img/button_r.gif" border="0" ></td>
      -->
     <%
     //} }
     %>
       	<d:displayControl id="button_customerproblem_query_detail_callback_view" bean="oneline">
     
      <td width="20" ></td>
       <td><img src="img/button_l.gif" border="0" ></td>
         <td background="img/button_bg.gif">
	  <a href="cp_callback_detail.do?txtCustomerProblemID=<tbl:write name="oneline" property="id"/>" class="btn12">查看回访信息</a></td>
         <td><img src="img/button_r.gif" border="0" ></td>
				</d:displayControl>
	<pri:authorized name="create_callback_view.do" >
       	<d:displayControl id="button_customerproblem_query_detail_callback_create" bean="oneline,customerDTO">
       <td width="20" ></td>
       <td><img src="img/button_l.gif" border="0" ></td>
         <td background="img/button_bg.gif">
	  <a href="create_callback_view.do?txtCustomerProblemID=<tbl:write name="oneline" property="id"/>" class="btn12">创建回访信息</a></td>
         <td><img src="img/button_r.gif" border="0" ></td>
				</d:displayControl>
	</pri:authorized>
       	<d:displayControl id="button_customerproblem_query_detail_repair_adjust" bean="oneline,customerDTO">
         <td width="20" ></td>
         <td><img src="img/button_l.gif" border="0" ></td>
         <td background="img/button_bg.gif"><a href="javascript:repair_adjust()" class="btn12">报修单调帐</a></td>
         <td><img src="img/button_r.gif" border="0" ></td>
	</d:displayControl>
	<pri:authorized name="assignrep_query_result.do" >
	<d:displayControl id="button_customerproblem_query_detail_repair_assign" bean="oneline,canBeVisible">
         <td width="20" ></td>
         <td><img src="img/button_l.gif" border="0" ></td>
         <td background="img/button_bg.gif"><a href="javascript:repair_assign()" class="btn12">派工</a></td>
         <td><img src="img/button_r.gif" border="0" ></td>
	</d:displayControl>
	</pri:authorized>
	<pri:authorized name="cp_query_for_manual_close.do" >
	<d:displayControl id="button_customerproblem_query_detail_repair_manual_close" bean="oneline,canBeVisible">
         <td width="20" ></td>
         <td><img src="img/button_l.gif" border="0" ></td>
         <td background="img/button_bg.gif"><a href="javascript:repair_close()" class="btn12">手工结束报修</a></td>
         <td><img src="img/button_r.gif" border="0" ></td>
	</d:displayControl>
	</pri:authorized>
	<pri:authorized name="teminate_rep.do" >
	<d:displayControl id="button_customerproblem_query_detail_repair_terminal" bean="oneline,canBeVisible">
         <td width="20" ></td>
         <td><img src="img/button_l.gif" border="0" ></td>
         <td background="img/button_bg.gif"><a href="javascript:repair_terminal()" class="btn12">报修终止</a></td>
         <td><img src="img/button_r.gif" border="0" ></td>
	</d:displayControl>
	</pri:authorized>
	<pri:authorized name="sheetrep_view.do" >
	<d:displayControl id="button_customerproblem_query_detail_repair_transfer" bean="oneline,canBeVisible">
         <td width="20" ></td>
         <td><img src="img/button_l.gif" border="0" ></td>
         <td background="img/button_bg.gif"><a href="javascript:repair_transfer()" class="btn12">手工流转</a></td>
         <td><img src="img/button_r.gif" border="0" ></td>
	</d:displayControl>
	</pri:authorized>
	<pri:authorized name="menu_cp_diagnosis.do" >
        <d:displayControl id="button_customerproblem_query_detail_repair_diagnosis" bean="oneline,canBeVisible">
         <td width="20" ></td>
         <td><img src="img/button_l.gif" border="0" ></td>
         <td background="img/button_bg.gif"><a href="javascript:repair_diagnosis('<tbl:write name="oneline" property="Id" />')" class="btn12">报修诊断</a></td>
         <td><img src="img/button_r.gif" border="0" ></td>
	</d:displayControl>  
	</pri:authorized>
	  </tr> 
</table>
<br>
 
</lgc:bloop>   
</form>
</td></tr></table>