<%@ taglib uri="/WEB-INF/html.tld" prefix="tbl" %>
<%@ taglib uri="logic" prefix="lgc" %>
<%@ taglib uri="resultset" prefix="rs" %>
<%@ taglib uri="osstags" prefix="o" %>
<%@ page import="com.dtv.oss.dto.JobCardDTO" %>
<%@ page import="com.dtv.oss.util.Postern" %>

<script language=javascript>
function query_submit()
{
	if(checkDate()){
		document.frmPost.submit();
	}
}

function view_detail_click(strId)
{
	self.location.href="close_repair_info_view.do?txtJobCardID="+strId+"&txtType="+"R"+"&txtStatus="+"F";
}
function view_CustProblem_detail(strId)
{
   window.open('problem_card_view.do?txtCustomerProblemID='+strId,'','toolbar=no,location=no,status=no,menubar=no,scrollbar=no,width=500,height=500');
}
function checkDate(){
 
	if (document.frmPost.txtCreateStartDate.value != ''){
		if (!check_TenDate(document.frmPost.txtCreateStartDate, true, "开始日期")){
			return false;
		}
	}
	 
	if (document.frmPost.txtCreateEndDate.value != ''){
		if (!check_TenDate(document.frmPost.txtCreateEndDate, true, "结束日期")){
			return false;
		}
	}
	 
	if(!compareDate(document.frmPost.txtCreateStartDate,document.frmPost.txtCreateEndDate,"结束日期必须大于等于开始日期")){
		
		return false;
	}
 	 if(!checkPlainNum(document.frmPost.txtJobCardID,true,9,"工单编号"))
		return false; 
	            
	return true;
}

</script>
<table width="820" align="center" cellpadding="0" cellspacing="0">
<tr><td>
<table  border="0" align="center" cellpadding="0" cellspacing="10">
  <tr>
    <td><img src="img/list_tit.gif" width="19" height="19"></td>
    <td  class="title">结束维修--工单查询</td>
  </tr>
  </table>
  <table width="98%"  border="0" align="center" cellpadding="0" cellspacing="0" background="img/line_01.gif">
  <tr>
    <td><img src="img/mao.gif" width="1" height="1"></td>
  </tr>
</table>
<br>

 
<form name="frmPost" method="post" action="close_repair_info_query_result.do" >
<input type="hidden" name="actiontype" value="closerepair">
   <table width="98%"  border="0" align="center" cellpadding="5" cellspacing="1" class="list_bg">
        <tr> 
                 
           <td  class="list_bg2"><div align="right">创建时间</div></td>
           <td class="list_bg1"> 
            <o:datetime name="txtCreateStartDate" size="10" match="txtCreateStartDate" includeHour="false" onclick="MyCalendar.SetDate(this,document.frmPost.txtCreateStartDate,'Y')" picURL="img/calendar.gif" style="cursor:hand" />            
             - 
             <o:datetime name="txtCreateEndDate" size="10" match="txtCreateEndDate" includeHour="false" onclick="MyCalendar.SetDate(this,document.frmPost.txtCreateEndDate,'Y')" picURL="img/calendar.gif" style="cursor:hand" />           
             </td> 
          <td  class="list_bg2"><div align="right">工单编号</div></td> 
          <td class="list_bg1">
           <input type="text" name="txtJobCardID" maxlength="9" size="25" value="<tbl:writeparam name="txtJobCardID" />" >
         </td>
        </tr>
        <tr>
          <td  class="list_bg2"><div align="right">所在区域</div></td>  
          <td class="list_bg1" colspan="3" valign="middle">
         <input type="hidden" name="txtCounty" value="<tbl:writeparam name="txtCounty" />">
	<input type="text" name="txtCountyDesc" size="25" maxlength="50" readonly value="<tbl:WriteDistrictInfo property="txtCounty" />" class="text">
        <input name="selDistButton" type="button" class="button" value="选择" onClick="javascript:sel_district('all','txtCounty','txtCountyDesc')">

         </td>
        </tr> 
      </table>
       <table width="98%"  border="0" align="center" cellpadding="5" cellspacing="1" class="list_bg">
	  <tr align="center">
	  <td class="list_bg1"><table  border="0" cellspacing="0" cellpadding="0">
		  <tr>
			<td width="11" height="20"><img src="img/button_l.gif" width="11" height="20"></td>
			<td><input name="Submit" type="button" class="button" value="查 询" onclick="javascript:query_submit()"></td>
			<td width="22" height="20"><img src="img/button_r.gif" width="22" height="20"></td>
		  </tr>
	  </table> 
	 </td>
  </tr>
  </table>
  <input type="hidden" name="txtFrom"  value="1">
      <input type="hidden" name="txtTo"  value="10">
      <input type="hidden" name="txtStatus"  value="F">
      <input type="hidden" name="txtType"  value="R">
    
       
    
  <rs:hasresultset>
  <table width="98%"  border="0" align="center" cellpadding="0" cellspacing="0" background="img/line_01.gif">
   <tr>
    <td><img src="img/mao.gif" width="1" height="1"></td>
  </tr>
 </table>
  <br>
 <table width="98%"  border="0" align="center" cellpadding="5" cellspacing="1" class="list_bg">
         <tr class="list_head">
          <td class="list_head" nowrap>工单号</td>
          <td class="list_head" nowrap>相关报修单</td>
          <td class="list_head" nowrap>联系人</td>
          <td class="list_head" nowrap>联系地址</td>
          <td class="list_head" width="18%" nowrap>工作内容</td>
          <td class="list_head" nowrap></td>
           
        </tr>

<lgc:bloop requestObjectName="ResponseQueryResult" item="oneline" >
 
<%
         String url = null; 
	 com.dtv.oss.dto.wrap.work.JobCard2JobCardProcessWrap wrap = (com.dtv.oss.dto.wrap.work.JobCard2JobCardProcessWrap)pageContext.getAttribute("oneline");
	 JobCardDTO dto=wrap.getJobCardDto();
	  pageContext.setAttribute("oneline", wrap.getJobCardDto());
           url="job_card_view.do";
	 String strAddress = Postern.getAddressById(dto.getAddressId());
	if (strAddress == null) strAddress="";
	 
%>
	 
				    
 
		<tr class="list_bg1" onmouseover="this.className='list_over'" onmouseout="this.className='list_bg1'">
		    <td align="center"><tbl:writenumber name="oneline" property="JobCardId" digit="7" /></td>
      		    <td align="center"><tbl:writenumber name="oneline" property="ReferSheetId" digit="7" /></td>
      		    <td align="center"><tbl:write name="oneline" property="ContactPerson"/></td>
      		    <td align="center"><%=strAddress%></td>
      		    <td align="center"><tbl:write name="oneline" property="description"/></td>
      		   <td align="center"><a href="javascript:view_detail_click('<tbl:write name="oneline" property="JobCardId"/>')" class="link12" >结束维修工单</a></td>
    		</tr>
</lgc:bloop>  

<tr>
    <td colspan="6" class="list_foot"></td>
  </tr>
 
   <tr>
              <td align="right" class="t12" colspan="7" >
                 第<span class="en_8pt"><rs:prop property="curpageno" /></span>页
                 <span class="en_8pt">/</span>共<span class="en_8pt"><rs:prop property="pageamount" />页
                 共有<span class="en_8pt"><rs:prop property="recordcount" /></span>条记录&nbsp;&nbsp;&nbsp;&nbsp;             
                 <rs:notfirst>
                   <img src="img/dot_top.gif" width="17" height="11">
                   <a href="javascript:firstPage_onClick(document.frmPost, <rs:prop property="firstto" />)" >首页 </a>
                   <img src="img/dot_pre.gif" width="6" height="11">
                   <a href="javascript:previous_onClick(document.frmPost, <rs:prop property="prefrom" />, <rs:prop property="preto" />)" >上一页</a>
                 </rs:notfirst>
          
                <rs:notlast>
                 &nbsp;
                 <img src="img/dot_next.gif" width="6" height="11">
                 <a href="javascript:next_onClick(document.frmPost, <rs:prop property="nextfrom" />, <rs:prop property="nextto" />)" >下一页</a>
                 <img src="img/dot_end.gif" width="17" height="11">
                 <a href="javascript:lastPage_onClick(document.frmPost, <rs:prop property="lastfrom" />, <rs:prop property="lastto" />)" >末页</a>
                </rs:notlast>
                &nbsp;
                转到
               <input type="text" name="txtPage" class="page_txt">页 
               <a href="javascript:goto_onClick(document.frmPost, <rs:prop property="pageamount" />)" >
                 <input name="imageField" type="image" src="img/button_go.gif" width="28" height="15" border="0">
               </a>
             </td>
  </tr>
 </table>
</rs:hasresultset> 
	 
    </td>
  </tr>
</form>  
</table>  
 
