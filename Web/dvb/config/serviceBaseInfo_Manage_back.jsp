<%@ taglib uri="/WEB-INF/html.tld" prefix="tbl" %>
<%@ taglib uri="logic" prefix="lgc" %>
<%@ taglib uri="resultset" prefix="rs" %>
<%@ taglib uri="osstags" prefix="d" %>
<%@ page import="com.dtv.oss.dto.ServiceDTO" %>

<script language="javascript" >
<!--
function AllChoose(){
     if (document.frmPost.allchoose.checked){
        if (document.frmPost.partchoose[0]){
            for (i=0 ;i< document.frmPost.partchoose.length ;i++){
              document.frmPost.partchoose[i].checked =true;
           }
       }
       else if(document.frmPost.partchoose!=null){
       		document.frmPost.partchoose.checked =true;
       }
     }
      else {
        if (document.frmPost.partchoose[0]){
            for (i=0 ;i< document.frmPost.partchoose.length ;i++){
               document.frmPost.partchoose[i].checked =false;
            }
       }
       else if(document.frmPost.partchoose!=null){
       		document.frmPost.partchoose.checked =false;
       }
     }   
 }
-->
function add_submit(){
    document.frmPost.action ="config_serviceBaseInfo_add.screen";
    document.frmPost.submit();
}
<!--
function hasSelect(){
    var flag =false;
    if (document.frmPost.partchoose!=null){
    	if(document.frmPost.partchoose.length!=null){
       		for (i=0 ;i< document.frmPost.partchoose.length ;i++){
           		if (document.frmPost.partchoose[i].checked){
               			flag =true;
               			break;
               		}
           	}
       	}
       	else{
       		if (document.frmPost.partchoose.checked){
               		flag =true;
               	}
       	}
    }
    if(!flag){
    	return false;
    }
    return true;
}-->
<!--
function del_submit(){
   if(!hasSelect()){
       alert("û��ѡ��ҵ���壬�����ύ")
       return;
   }
   var serviceIds ="" ;
   var checkedflag =false;
   if (document.frmPost.partchoose[0]){
       for (i=0 ;i< document.frmPost.partchoose.length ;i++){
           if (document.frmPost.partchoose[i].checked){
              if (checkedflag){
                  serviceIds =serviceIds+","+document.frmPost.partchoose[i].value;
              }
              if (checkedflag ==false){
                  serviceIds =document.frmPost.partchoose[i].value;
                  checkedflag =true;
              }  
            }
       }
   } else{
       if (document.frmPost.partchoose.checked){
          serviceIds =document.frmPost.partchoose.value;
       } 
   }
   document.frmPost.txtServiceIds.value =serviceIds;
   document.frmPost.action ="config_serviceInfo_del.do";
   document.frmPost.submit();
}-->
</script>

<table  border="0" align="center" cellpadding="0" cellspacing="10">
  <tr>
    <td align="center"><img src="img/list_tit.gif" width="19" height="19"></td>
    <td class="title">ҵ�������Ϣ����</td>
  </tr>
</table>
<table width="820"  border="0" align="center" cellpadding="0" cellspacing="0" background="img/line_01.gif">
  <tr>
    <td><img src="img/mao.gif" width="1" height="1"></td>
  </tr>
</table>

<br>
<form name="frmPost" method="post" action="config_serviceInfo_query.do" >
    <input type="hidden" name="txtFrom"  value="1">
    <input type="hidden" name="txtTo"  value="10">
    <input type="hidden" name="func_flag" value="20001" >
    <input type="hidden" name="ActionFlag" value="del_service" >
    <!--<input type="hidden" name="txtServiceIds" value="" >-->
   
    <table width="100%"  border="0" align="center" cellpadding="5" cellspacing="1" class="list_bg">
      <tr class="list_head">
        <!--<td class="list_head" width="5%"><div align="center"><input type="checkbox" name="allchoose" value="" onclick="AllChoose()"></div></td>-->
        <td class="list_head" width="19%">ҵ��ID</td>
        <td class="list_head" width="19%">ҵ������</td>
        <td class="list_head" width="19%">ҵ��״̬</td>
        <td class="list_head" width="19%">��Ч��ʼʱ��</td>
        <td class="list_head" width="19%">��Ч����ʱ��</td>
      </tr>
      <lgc:bloop requestObjectName="ResponseQueryResult" item="oneline">
        <%
          ServiceDTO dto =(ServiceDTO)pageContext.getAttribute("oneline");
          String strUrl ="config_serviceInfo_prepare.do?txtServiceID="+dto.getServiceID();
        %>
         <tbl:printcsstr style1="list_bg1" style2="list_bg2" overStyle="list_over" >
            <td align="center" ><a href ="<%=strUrl%>"  class="link12"><tbl:writenumber name="oneline" property="serviceID" digit="7"/></a>
            </td>
            <td align="center" ><tbl:write name="oneline" property="serviceName" /></td>
            <td align="center" ><d:getcmnname typeName="SET_P_SERVICESTATUS" match="oneline:status" /></td>
            <td align="center" ><tbl:writedate name="oneline" property="dateFrom"/></td>
            <td align="center" ><tbl:writedate name="oneline" property="dateTo"/></td>
         </tbl:printcsstr>
      </lgc:bloop>
      <tr>
    	<td colspan="8" class="list_foot"></td>
 	  </tr>
      <rs:hasresultset>
        <tr class="trline" >
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
       </rs:hasresultset>             
       <tr class="trline" >
         <td colspan="6">
         <table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0" background="img/line_01.gif">
          <tr>
            <td><img src="img/mao.gif" width="1" height="1"></td>
          </tr>
         </table>
       </td></tr>
      </table> 
      <BR>  
      <table align="center"  border="0" cellspacing="0" cellpadding="0">
         <tr>  
            <td><img src="img/button_l.gif" width="22" height="20"></td>
	    <td><input name="next" type="button" class="button" onClick="add_submit()" value="�� ��"></td>
            <td><img src="img/button_r.gif" width="11" height="20"></td>
        </tr>
      </table>	
      <input type="hidden" name="confirm_post"  value="true" >
      <tbl:generatetoken /> 
</form>