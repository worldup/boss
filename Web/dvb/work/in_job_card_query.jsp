<%@ taglib uri="/WEB-INF/html.tld" prefix="tbl" %>
<%@ taglib uri="logic" prefix="lgc" %>
<%@ taglib uri="resultset" prefix="rs" %>
<%@ taglib uri="/WEB-INF/oss.tld" prefix="d" %>

<%@ page import="com.dtv.oss.util.Postern" %>
<%@ page import="com.dtv.oss.dto.AddressDTO" %>
<%@ page import="com.dtv.oss.dto.JobCardDTO" %>
<%@ page import="com.dtv.oss.web.util.WebOperationUtil" %>
<script language=javascript>
 
function check_form(){
 
	if (document.frmPost.txtCreateStartDateDatePart.value != ''){
		if (!check_TenDate(document.frmPost.txtCreateStartDateDatePart, true, "��ʼ����")){
			return false;
		}
	}
	 
	if (document.frmPost.txtCreateEndDateDatePart.value != ''){
		if (!check_TenDate(document.frmPost.txtCreateEndDateDatePart, true, "��������")){
			return false;
		}
	}
	 
	if(!compareDate(document.frmPost.txtCreateStartDateDatePart,document.frmPost.txtCreateEndDateDatePart,"�������ڱ�����ڵ��ڿ�ʼ����")){
		
		return false;
	}
	 if (document.frmPost.txtPreferedStartDate.value != ''){
		if (!check_TenDate(document.frmPost.txtPreferedStartDate, true, "��ʼ����")){
			return false;
		}
	}
	if (document.frmPost.txtPreferedEndDate.value != ''){
		if (!check_TenDate(document.frmPost.txtPreferedEndDate, true, "��������")){
			return false;
		}
	}
	if(!compareDate(document.frmPost.txtPreferedStartDate,document.frmPost.txtPreferedEndDate,"�������ڱ�����ڵ��ڿ�ʼ����")){
		
		return false;
	}
	if (document.frmPost.txtFinishedStartDate.value != ''){
		if (!check_TenDate(document.frmPost.txtFinishedStartDate, true, "��ɿ�ʼ����")){
			return false;
		}
	}
	if (document.frmPost.txtFinishedEndDate.value != ''){
		if (!check_TenDate(document.frmPost.txtFinishedEndDate, true, "��ɽ�������")){
			return false;
		}
	}
	if(!compareDate(document.frmPost.txtFinishedStartDate,document.frmPost.txtFinishedEndDate,"�������ڱ�����ڵ��ڿ�ʼ����")){
		
		return false;
	}
	if(!checkPlainNum(document.frmPost.txtJobCardID,true,9,"��װ�����"))
		return false;         
     if(!checkPlainNum(document.frmPost.txtCustomerID,true,9,"�ͻ�֤��"))
		return false;      
	return true;
}

function query_submit()
{
        if (check_form()){
        	if(query_all()){
			document.frmPost.txtQueryType.value = 'queryAll';			
		}else{
			document.frmPost.txtQueryType.value = 'queryPart';
		}        
        	document.frmPost.submit();
        }
}
function view_detail_click(strId)
{
	self.location.href="job_card_view.do?txtJobCardID="+strId;
}
function query_all(){
	if(document.frmPost.queryType.checked == true)
		return true;
	return false;
} 

</script>

<div id="updselwaitlayer" style="position:absolute; left:650px; top:170px; width:250px; height:24px; display:none">
    <table width="100%" border="0" cellspacing="1" cellpadding="3">
        <tr>
          <td width="100%"><div align="center">
          <font size="2">
          ���ڻ�ȡ���ݡ�����
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
    <td class="title">��װ������ѯ</td>
  </tr>
</table>
<table width="98%"  border="0" align="center" cellpadding="0" cellspacing="0" background="img/line_01.gif">
  <tr>
    <td><img src="img/mao.gif" width="1" height="1"></td>
  </tr>
</table>
<br>
<form name="frmPost" action="in_job_card_query_result.do" method="post" >
 <input type="hidden" name="txtQueryType" value="<tbl:writeparam name="txtQueryType"/>">     
<table width="98%"  border="0" align="center" cellpadding="5" cellspacing="1" class="list_bg">
  <tr>
    <td class="list_bg2"><div align="right">��װ�����</div></td>
    <td class="list_bg1">
    <input name="txtJobCardID" type="text" class="text" maxlength="9" size="25" value="<tbl:writeparam name="txtJobCardID" />"></td>
    <td class="list_bg2"><div align="right">�ͻ�֤��</div></td>       
    <td class="list_bg1">
        <input type="text" name="txtCustomerID" maxlength="9" size="25" value="<tbl:writeparam name="txtCustomerID" />" >
    </td>   
  </tr>
  <tr>
     <td class="list_bg2"><div align="right">״̬</div></td>
     <td class="list_bg1">
           <d:selcmn name="txtStatus" mapName="SET_W_JOBCARDSTATUS" match="txtStatus" width="25" /> </td>     
      <td class="list_bg2"><div align="right">�û�����</div></td>
         <td class="list_bg1">
             <d:selcmn name="txtCustomerType" mapName="SET_C_CUSTOMERTYPE" match="txtCustomerType" width="25" />  
         </td>  
    
  </tr>
  <tr>
        
         <td  class="list_bg2"><div align="right">��������</div></td> 
          <td class="list_bg1"  valign="middle">
            <input type="hidden" name="txtCounty" value="<tbl:writeparam name="txtCounty" />">
	    <input type="text" name="txtCountyDesc" size="25" maxlength="50" readonly value="<tbl:WriteDistrictInfo property="txtCounty" />" class="text">
            <input name="selDistButton" type="button" class="button" value="ѡ��" onClick="javascript:sel_district('all','txtCounty','txtCountyDesc')">
         </td>
         <td class="list_bg2"><div align="right">��Դ����</div></td>
    <td class="list_bg1"><d:selcmn name="txtOpenSourceType" match="txtOpenSourceType" mapName="SET_C_CUSTOPENSOURCETYPE" width="25" /></td>
          
  </tr>
   <%Map mapDeviceModel=Postern.getAllDeviceModels();
    pageContext.setAttribute("AllDeviceModel",mapDeviceModel);%>
  <tr>
        
         <td  class="list_bg2"><div align="right">�豸�ͺ�</div></td> 
          <td class="list_bg1"  valign="middle">
         	<tbl:select name="txtDeviceModel" set="AllDeviceModel" match="txtDeviceModel" width="23" />         
         </td>
         <td class="list_bg2"><div align="right">�豸���к�</div></td>
    <td class="list_bg1"><input type="text" name="txtSerialNo" size="25" maxlength="50" value="<tbl:writeparam name="txtSerialNo" />" class="text"></td>
          
  </tr>
   <tr>
          <td  class="list_bg2"><div align="right">����ʱ��</div></td> 
           <td class="list_bg1"> 
                
            <d:datetime name="txtCreateStartDate" size="10" match="txtCreateStartDate" includeHour="true" onclick="MyCalendar.SetDate(this,document.frmPost.txtCreateStartDateDatePart,'Y')" picURL="img/calendar.gif" style="cursor:hand" />            
             - 
             <d:datetime name="txtCreateEndDate" size="10" match="txtCreateEndDate" includeHour="true" onclick="MyCalendar.SetDate(this,document.frmPost.txtCreateEndDateDatePart,'Y')" picURL="img/calendar.gif" style="cursor:hand" />           
             </td> 
              <td  class="list_bg2"><div align="right">ԤԼ����ʱ��</div></td>
            <td class="list_bg1"> 
            <d:datetime name="txtPreferedStartDate" size="10" match="txtPreferedStartDate" onclick="MyCalendar.SetDate(this,document.frmPost.txtPreferedStartDate,'Y')" picURL="img/calendar.gif" style="cursor:hand" />            
             - 
            <d:datetime name="txtPreferedEndDate" size="10" match="txtPreferedEndDate" onclick="MyCalendar.SetDate(this,document.frmPost.txtPreferedEndDate,'Y')" picURL="img/calendar.gif" style="cursor:hand" />
             </td>            
             </tr>
              <tr>
          
            <td  class="list_bg2"><div align="right">���ʱ��</div></td>
            <td  class="list_bg1"> 
            <d:datetime name="txtFinishedStartDate" size="10" match="txtFinishedStartDate" onclick="MyCalendar.SetDate(this,document.frmPost.txtFinishedStartDate,'Y')" picURL="img/calendar.gif" style="cursor:hand" />            
             - 
            <d:datetime name="txtFinishedEndDate" size="10" match="txtFinishedEndDate" onclick="MyCalendar.SetDate(this,document.frmPost.txtFinishedEndDate,'Y')" picURL="img/calendar.gif" style="cursor:hand" />
             </td> 
            <td class="list_bg2"><div align="right">��װʧ��ԭ��</div></td>
    	    <td class="list_bg1"><d:selcmn name="txtWorkResultReason" mapName="SET_W_INSTALLFAILREASON" match="txtWorkResultReason" width="25" /></td>
                      
         </tr>
   	 <tr>
         <td class="list_bg1" colspan="4" align="center"> 
	     <input type="checkbox" name="queryType" >&nbsp��ѯ����   
	     </td>
         </tr>
   
</table>
<table width="98%"  border="0" align="center" cellpadding="5" cellspacing="1" class="list_bg">
	<tr align="center">
	  <td class="list_bg1"><table  border="0" cellspacing="0" cellpadding="0">
		  <tr>
			<td width="11" height="20"><img src="img/button_l.gif" width="11" height="20"></td>
			<td><input name="Submit" type="button" class="button" value="�� ѯ" onclick="javascript:query_submit()"></td>
			<td width="22" height="20"><img src="img/button_r.gif" width="22" height="20"></td>
		  </tr>
	  </table></td>
	</tr>
</table>      
	  <input type="hidden" name="txtFrom" size="22" value="1">
          <input type="hidden" name="txtTo" size="22" value="10">
          <input type="hidden" name="txtType"  value="I">
          <input type="hidden" name="txtPreferedDate"  value="<tbl:write name="oneline" property="PreferedDate" />">
 
 
<table width="98%"  border="0" align="center" cellpadding="0" cellspacing="0" background="img/line_01.gif">
  <tr>
    <td><img src="img/mao.gif" width="1" height="1"></td>
  </tr>
</table>
<br>
 <rs:hasresultset>
<table width="98%"  border="0" align="center" cellpadding="5" cellspacing="1" class="list_bg">
  <tr class="list_head">
    <td class="list_head" nowrap>�������</td>
    <td class="list_head" nowrap>�ͻ�֤��</td>
    <td class="list_head" nowrap>��ϵ��</td>
    <td class="list_head" nowrap>��ϵ�绰</td>
    <td class="list_head" nowrap>��ϵ��ַ</td>
    <td class="list_head" nowrap>��������</td>
    <td class="list_head" nowrap>״̬</td>
  </tr>
<lgc:bloop requestObjectName="ResponseQueryResult" item="oneline" >
<%
     com.dtv.oss.dto.wrap.work.JobCard2JobCardProcessWrap wrap = (com.dtv.oss.dto.wrap.work.JobCard2JobCardProcessWrap)pageContext.getAttribute("oneline");
     JobCardDTO dto=wrap.getJobCardDto();
     pageContext.setAttribute("oneline", wrap.getJobCardDto());
      pageContext.setAttribute("process", wrap.getJobCardProcessDto());
     
     String strAddress = Postern.getAddressById(dto.getAddressId());
     AddressDTO addrDto = Postern.getAddressDtoByID(dto.getAddressId());
     pageContext.setAttribute("custaddr", addrDto);
    if (strAddress == null) strAddress="";
	 
%>
 

 <tr class="list_bg1" onmouseover="this.className='list_over'" onmouseout="this.className='list_bg1'">
    <td align="center"><a href="javascript:view_detail_click('<tbl:write name="oneline" property="JobCardId"/>')" class="link12" ><tbl:writenumber name="oneline" property="JobCardId" digit="7" hideZero="true"/></a></td>
     <td align="center"><tbl:writenumber name="oneline" property="CustId" digit="8" hideZero="true"/></td>
    <td align="center"><tbl:write name="oneline" property="ContactPerson"/></td>
    <td align="center"><tbl:write name="oneline" property="ContactPhone"/></td>  
    <td align="center"><%=strAddress%></td>
     <td align="center"><tbl:WriteDistrictInfo name="custaddr" property="districtID" /></td>
    <td align="center"><d:getcmnname typeName="SET_W_JOBCARDSTATUS" match="oneline:status" /></td>
  </tr>
 

</lgc:bloop>

  <tr>
    <td colspan="8" class="list_foot"></td>
  </tr>
  
            <tr>
              <td align="right" class="t12" colspan="7" >
                 ��<span class="en_8pt"><rs:prop property="curpageno" /></span>ҳ
                 <span class="en_8pt">/</span>��<span class="en_8pt"><rs:prop property="pageamount" />ҳ
                 ����<span class="en_8pt"><rs:prop property="recordcount" /></span>����¼&nbsp;&nbsp;&nbsp;&nbsp;             
                 <rs:notfirst>
                   <img src="img/dot_top.gif" width="17" height="11">
                   <a href="javascript:firstPage_onClick(document.frmPost, <rs:prop property="firstto" />)" >��ҳ </a>
                   <img src="img/dot_pre.gif" width="6" height="11">
                   <a href="javascript:previous_onClick(document.frmPost, <rs:prop property="prefrom" />, <rs:prop property="preto" />)" >��һҳ</a>
                 </rs:notfirst>
          
                <rs:notlast>
                 &nbsp;
                 <img src="img/dot_next.gif" width="6" height="11">
                 <a href="javascript:next_onClick(document.frmPost, <rs:prop property="nextfrom" />, <rs:prop property="nextto" />)" >��һҳ</a>
                 <img src="img/dot_end.gif" width="17" height="11">
                 <a href="javascript:lastPage_onClick(document.frmPost, <rs:prop property="lastfrom" />, <rs:prop property="lastto" />)" >ĩҳ</a>
                </rs:notlast>
                &nbsp;
                ת��
               <input type="text" name="txtPage" class="page_txt">ҳ 
               <a href="javascript:goto_onClick(document.frmPost, <rs:prop property="pageamount" />)" >
                 <input name="imageField" type="image" src="img/button_go.gif" width="28" height="15" border="0">
               </a>
             </td>
         </tr>
</table>   
 
       </rs:hasresultset>         
    
   </form>               
</TD>
</TR>
</TABLE>
<script language=javascript>
function window_open(){
	if(document.frmPost.txtQueryType.value == 'queryAll')
		document.frmPost.queryType.checked = true;
}
window_open();

</script> 