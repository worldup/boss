<%@ page import="com.dtv.oss.dto.JobCardProcessDTO,
                 com.dtv.oss.util.Postern,
                 com.dtv.oss.web.util.WebUtil"%>
                 
<%@ taglib uri="/WEB-INF/html.tld" prefix="tbl" %>
<%@ taglib uri="osstags" prefix="d" %>
<%@ taglib uri="bookmark" prefix="bk" %>
<%@ taglib uri="logic" prefix="lgc" %>
<%@ taglib uri="resultset" prefix="rs" %>


<form name="frmPost" method="post" action="job_card_process_log.do">
     <table align="center" width="810" border="0" cellspacing="1" cellpadding="1" class="list_bg" >
       <tr> 
           <td align="center" class="title">
            <img src="img/list_tit.gif" width="19" height="19">&nbsp����������ʷ��Ϣ
           </td>
        </tr>
       <tr><td>
         <table width="98%"  border="0" align="center" cellpadding="0" cellspacing="0" background="img/line_01.gif">
           <tr>
             <td><img src="img/mao.gif" width="1" height="1"></td>
           </tr>
         </table>
       </td></tr>
      </table>
      <BR>

      <table width="100%" align="center" border="0" cellpadding="5" cellspacing="1" class="list_bg" >
        <tr class="list_head">
          <td width="7%"  align="center" class="list_head">���</td>
          <td width="10%" align="center" class="list_head">�������</td>
          <td width="10%"  align="center" class="list_head">��������</td>  
           <td width="10%"  align="center" class="list_head">�������</td>   
           <td width="15%"  align="center" class="list_head">�������ԭ��</td>       
          <td width="15%" align="center" class="list_head">����ʱ��</td>
          <td width="10%" align="center" class="list_head">����Ա</td>
          <td width="20%" align="center" class="list_head">����</td>
          
        </tr>
        
<lgc:bloop requestObjectName="ResponseQueryResult" item="oneline" >
<%
     JobCardProcessDTO dto = (JobCardProcessDTO)pageContext.getAttribute("oneline");
      
     pageContext.setAttribute("process", dto);
     String CreOprName = Postern.getOperatorNameByID(dto.getCurrentOperatorId());
     if (CreOprName==null) CreOprName="";    
%>
       <input type="hidden" name="txtJobCardID" size="20" value="<tbl:write name="process" property="JcId" />">
          <tbl:printcsstr style1="list_bg1" style2="list_bg2" overStyle="list_over" >
               <td align="center" ><tbl:writenumber name="process" property="SeqNo" digit="7" /></td>
               <td align="center" ><tbl:write name="process" property="JcId" /></td>
               <td align="center"><d:getcmnname typeName="SET_W_JOBCARDLOGTYPE" match="process:action"/></td>
               <td align="center"><d:getcmnname typeName="SET_W_JOBWORKRESULT" match="process:workResult" /></td> 
                <td align="center"><d:getcmnname typeName="SET_W_JOBRESULTREASON" match="process:workResultReason" /></td>                   
               <td align="center" ><tbl:writedate name="process" property="ActionTime" includeTime="true" /></td>                
               <td align="center" ><%=CreOprName%></td>                 
               <td align="center" ><tbl:write name="process" property="Memo"/></td>
         </tbl:printcsstr>
</lgc:bloop>                 
  <tr>
    <td colspan="8" class="list_foot"></td>
  </tr>               
                 
 <rs:hasresultset>
        <tr class="trline" >
              <td align="right" class="t12" colspan="8" >
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
 </rs:hasresultset>         
       <tr class="trline" >
         <td colspan="8">
          
       </td></tr>
      </table>      
       
      <table align="center" width="50" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td><img src="img/button2_r.gif" width="22" height="20"></td>
            <td background="img/button_bg.gif"  height="20" >
            <a href="<bk:backurl property="job_card_view.do/ci_view_for_close.do/job_card_view_by_agent.do/catv_job_card_view.do" />" class="btn12">��&nbsp;��</a></td>
            <td><img src="img/button2_l.gif" width="13" height="20"></td>
        </tr>
      </table>
      
<input type="hidden" name="txtFrom" size="20" value="1">
<input type="hidden" name="txtTo" size="20" value="10">
<input type="hidden" name="txtType" size="20" value="I">

      
</form>