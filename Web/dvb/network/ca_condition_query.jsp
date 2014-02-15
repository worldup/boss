<%@ taglib uri="/WEB-INF/html.tld" prefix="tbl"%>
<%@ taglib uri="logic" prefix="lgc"%>
<%@ taglib uri="resultset" prefix="rs"%>
<%@ taglib uri="/WEB-INF/oss.tld" prefix="d"%>

<%@ page import="com.dtv.oss.util.Postern,java.util.*"%>
<%@ page import="com.dtv.oss.dto.CAConditionDTO"%>

<SCRIPT language="JavaScript">
function ca_condition_create()
{
	location.href = "ca_condition_create.screen";
}

function back_submit(){
	url="ca_info_index.screen";
    document.location.href= url;

}
</SCRIPT>

<form name="frmPost" method="post" action="ca_condition_query.do"><input
	type="hidden" name="txtFrom" size="20" value="1"> <input type="hidden"
	name="txtTo" size="20" value="10">

	<input type="hidden" name="queryFlag" size="20" value="condition">
	<br>
	<br>
<table border="0" align="center" cellpadding="0" cellspacing="10">
	<tr>
		<td><img src="img/list_tit.gif" width="19" height="19"></td>
		<td class="title">CA�����б�</td>
	</tr>
</table>
 
<table width="100%" border="0" align="center" cellpadding="0"
	cellspacing="0" background="img/line_01.gif">
	<tr>
		<td><img src="img/mao.gif" width="1" height="1"></td>
	</tr>
</table>
<br>

<rs:hasresultset>
<%
Map mapCAHost=Postern.getAllCAHost();
%>
       
	<table width="100%" border="0" align="center" cellpadding="5" cellspacing="1" class="list_bg">
		<tr class="list_head">
			<td width="5%" nowrap class="list_head">����ID</td>
			<td width="20%" nowrap class="list_head">�������� </td>
			<td width="10%" nowrap class="list_head">CA���� </td>
			<td width="30%" nowrap class="list_head">�������� </td>
			<td width="35%" nowrap class="list_head">���� </td>
		</tr>
		<lgc:bloop requestObjectName="ResponseQueryResult" item="oneline">
		<%
				CAConditionDTO dto=(CAConditionDTO)pageContext.getAttribute("oneline");
				String hostName=(String)mapCAHost.get(dto.getHostID()+"");
				if(hostName==null)hostName="";
				%>
			<tbl:printcsstr style1="list_bg1" style2="list_bg2" overStyle="list_over" >
				
				<td ><a href="ca_condition_detail.do?queryFlag=cacondition&OPConditionID=<tbl:write name="oneline" property="condID"/>"><tbl:writenumber name="oneline" property="condID" digit="8"/></a></td>
				<td ><tbl:write name="oneline" property="condName" /></td>
				<td ><%=hostName%></td>
				<td ><tbl:write name="oneline" property="condString" /></td>
				<td ><tbl:write name="oneline" property="description" /></td>
			</tbl:printcsstr>
		</lgc:bloop>
		<tr>
        <td colspan="5" class="list_foot"></td>
        </tr>
 
            <tr>
              <td align="right" class="t12" colspan="5" >
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

	  <table align="center"  border="0" cellspacing="0" cellpadding="0">
         <tr>  
            <td><img src="img/button2_r.gif" width="22" height="20"></td>
			<td><input name="Submit" type="button" class="button"
					value="��&nbsp;��" onclick="javascript:back_submit()"></td>
            <td><img src="img/button2_l.gif" width="11" height="20"></td>

            <td width="20" ></td>  

            <td><img src="img/button_l.gif" width="11" height="20"></td>
            <td><input name="Submit" type="button" class="button"
					value="��&nbsp;��" onclick="javascript:ca_condition_create()"></td>
            <td><img src="img/button_r.gif" width="22" height="20"></td>      
        </tr>
      </table>	
</form>