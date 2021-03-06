<%@ taglib uri="/WEB-INF/html.tld" prefix="tbl" %>
<%@ taglib uri="logic" prefix="lgc" %>
<%@ taglib uri="osstags" prefix="d" %>
<%@ taglib uri="bookmark" prefix="bk" %>
<%@ page import="com.dtv.oss.util.Postern" %> 
 <%@ page import="com.dtv.oss.web.util.WebUtil" %>
 <%@ page import="com.dtv.oss.dto.*" %> 
 <%@ page import="com.dtv.oss.service.util.CryptoUtility" %> 

<script language=javascript>
function check_frm()
{
	
 	
    if (check_Blank(document.frmPost.txtOperatorName, true, "操作员姓名"))
	    return false;
    if (check_Blank(document.frmPost.txtLevel, true, "授权级别"))
	    return false;	    
    if (check_Blank(document.frmPost.txtLoginPwd, true, "密码"))
	    return false;
   if (check_Blank(document.frmPost.txtLoginID, true, "登录帐号"))
	    return false;
	    
	    
     return true;
}
 
function confirm_password()
{
	
 	
    if (document.frmPost.txtLoginPwd.value == document.frmPost.txtSecondLoginPwd.value)
	    return true;
    else {
     alert("密码不一致,请重新输入");
     document.frmPost.txtLoginPwd.focus();
     return false;
     }
}  
 
 
function operator_modify_submit(){
 if (window.confirm('您确认要修改该操作员吗?')){
  if (check_frm() && confirm_password()){
	    document.frmPost.action="modify_operator.do";
	    document.frmPost.Action.value="MODIFY";
	    document.frmPost.submit();
	  }
}
}
 
</script>
 
 
 
<table  border="0" align="center" cellpadding="0" cellspacing="10" >
 <tr>
    <td colspan="2" height="8"></td>
  </tr>
  <tr>
    <td><img src="img/list_tit.gif" width="19" height="19"></td>
    <td class="title">操作员修改</td>
  </tr>
</table>
<table width="98%"  border="0" align="center" cellpadding="0" cellspacing="0" background="img/line_01.gif">
  <tr>
    <td><img src="img/mao.gif" width="1" height="1"></td>
  </tr>
</table>
<br>
 
<form name="frmPost" method="post" >   
 <lgc:bloop requestObjectName="ResponseQueryResult" item="oneline" > 
 
 <input type="hidden" name="txtInternalUserFlag"   value="<tbl:write name="oneline" property="internalUserFlag" />">
 <table width="98%"  border="0" align="center" cellpadding="5" cellspacing="1" class="list_bg">
 
  
   <%
     OperatorDTO dto = (OperatorDTO) pageContext.getAttribute("oneline");
     String internalFlag= dto.getInternalUserFlag();
     
     String enPwd = dto.getLoginPwd();
     String originalPwd = CryptoUtility.depwd(enPwd);
     int orgID = dto.getOrgID();
     String orgName = Postern.getOrgNameByOrgID(orgID);
     if (orgName == null) orgName ="";
      System.out.println("******************"+internalFlag);
      if("Y".equals(internalFlag)){
   %>
     <tr> 
         <td  class="list_bg2"><div align="right">操作员ID</div></td>         
          <td class="list_bg1" align="left">
           <input type="text" name="txtOperatorID" size="25"  class="textgray" readonly value="<tbl:write name="oneline" property="OperatorID"/>" class="textgray" readonly>
           </td>  
           <td class="list_bg2"><div align="right">系统内部用户标志</div></td>
           <td class="list_bg1" align="left" >
            <input type="text" name="txtInternalUserFlagName"   size="25"  class="textgray" readonly value="<d:getcmnname typeName="SET_G_YESNOFLAG" match="oneline:internalUserFlag"/>" >
          </td>  
       </tr>
       <tr>
          <td  class="list_bg2"><div align="right">操作员姓名*</div></td>         
          <td class="list_bg1" align="left">
           <input type="text" name="txtOperatorName" size="25" maxlength="50" class="textgray" readonly value="<tbl:write name="oneline" property="OperatorName"/>" >
           </td>  
         <td class="list_bg2"><div align="right">登录帐号*</div></td>
           <td class="list_bg1" align="left">
          <input type="text" name="txtLoginID"  size="25" maxlength="50"  class="textgray" readonly value="<tbl:write name="oneline" property="LoginID"/>">
          </td>
          
      </tr>
      
      <tr>
          <td class="list_bg2"><div align="right">密&nbsp;&nbsp;码*</div></td>
           <td class="list_bg1" align="left">
           <input name="txtLoginPwd" type="password" class="text" maxlength="50" value="<%=originalPwd%>" style="width:187px;"></td>
          
          <td class="list_bg2"><div align="right">密码确认</div></td>
           <td class="list_bg1" align="left">
           <input name="txtSecondLoginPwd" type="password"  size="25"   value="<%=originalPwd%>" style="width:150px;"></td>
           
         
      </tr>
      
      <tr>
       <td class="list_bg2"><div align="right">授权级别</div></td>
           <td class="list_bg1" align="left" >
           <input type="text" name="txtLevelName" size="25"   class="textgray" readonly
           value="<d:getcmnname  typeName="SET_S_OPERATORLEVEL" match="oneline:levelID"/>" ></td>
              <input type="hidden" name="txtLevel"   value="<tbl:write name="oneline" property="levelID" />">
          </td>     
        <td class="list_bg2" align="right">所属组织</td>
            <td class="list_bg1">
    	    <input type="hidden" name="txtOrgID" value="<tbl:write name="oneline" property="orgID"/>">
	    <input type="text" name="txtOrgName" size="25" maxlength="50" readonly  class="textgray" value="<tbl:WriteOrganizationInfo name="oneline" property="orgID"/>" >
         </td>   
        
         
      </tr>
       <tr>
            <td class="list_bg2"><div align="right">状态</div></td>
           <td class="list_bg1" align="left">
            <input type="text" name="txtStatusName" size="25"   class="textgray" readonly
           value="<d:getcmnname  typeName="SET_G_GENERALSTATUS" match="oneline:Status"/> "> </td>
         <input type="hidden" name="txtStatus"  value="<tbl:write name="oneline" property="status" />">
         
          <td class="list_bg2"><div align="right">操作员描述</div></td>
           <td class="list_bg1" align="left">
          <input type="text" name="txtOperatorDesc" maxlength="100" size="25"  readonly  class="textgray"  value="<tbl:write name="oneline" property="OperatorDesc"/>">
          </td>    
          
         
      </tr>
       <%} else {%>
      
      <tr> 
         <td  class="list_bg2"><div align="right">操作员ID</div></td>         
          <td class="list_bg1" align="left">
           <input type="text" name="txtOperatorID" size="25" value="<tbl:write name="oneline" property="OperatorID"/>" class="textgray" readonly>
           </td>  
           <td class="list_bg2"><div align="right">系统内部用户标志</div></td>
           <td class="list_bg1" align="left" >
            <input type="text" name="txtInternalUserFlagName"   size="25"  class="textgray" readonly value="<d:getcmnname typeName="SET_G_YESNOFLAG" match="oneline:internalUserFlag"/>" >
            
          </td>     
       </tr>
       <tr>
          <td  class="list_bg2"><div align="right">操作员姓名*</div></td>         
          <td class="list_bg1" align="left">
           <input type="text" name="txtOperatorName" size="25" maxlength="50" value="<tbl:write name="oneline" property="OperatorName"/>" >
           </td>  
         <td class="list_bg2"><div align="right">登录帐号*</div></td>
           <td class="list_bg1" align="left">
          <input type="text" name="txtLoginID"  size="25" maxlength="50"  value="<tbl:write name="oneline" property="LoginID"/>">
          </td>
          
      </tr>
      
      <tr>
          <td class="list_bg2"><div align="right">密&nbsp;&nbsp;码*</div></td>
           <td class="list_bg1" align="left">
           <input name="txtLoginPwd" type="password"  size="25"  maxlength="50" value="<%=originalPwd%>" style="width:187px;"></td>
         
           <td class="list_bg2"><div align="right">密码确认</div></td>
           <td class="list_bg1" align="left">
           <input name="txtSecondLoginPwd" type="password"  size="25"  maxlength="50" value="<%=originalPwd%>" style="width:187px;"></td>
           
         
          </tr>
      
      <tr>
      <td class="list_bg2"><div align="right">授权级别</div></td>
           <td class="list_bg1" align="left" >
           <d:selcmn name="txtLevel" mapName="SET_S_OPERATORLEVEL" match="oneline:levelID" width="23" /></td>
              
         <td class="list_bg2"><div align="right">所属组织</div></td>
           <td class="list_bg1" align="left">
          <input type="text" name="txtOrgName"  maxlength="22" size="25"   value="<%=orgName%>" class="textgray" readonly>
          </td>
         
      </tr>
       <tr>
        <td class="list_bg2"><div align="right">状态</div></td>
           <td class="list_bg1" align="left">
           <d:selcmn name="txtStatus" mapName="SET_G_GENERALSTATUS" match="oneline:Status" width="23" />
         </td>
          <td class="list_bg2"><div align="right">操作员描述</div></td>
           <td class="list_bg1" align="left">
          <input type="text" name="txtOperatorDesc" maxlength="100" size="25"   value="<tbl:write name="oneline" property="OperatorDesc"/>">
          </td>    
          
         
      </tr>
     
       <%}%> 

 </table>
 
 <input type="hidden" name="func_flag" value="197" >
  <input type="hidden" name="Action" value=""/>
  <input type="hidden" name="txtOrgID" value="<%=orgID%>" >
   <input type="hidden" name="txtFrom" size="20" value="1">
    <input type="hidden" name="txtTo" size="20" value="10">
     <input type="hidden" name="txtDtLastmod"   value="<tbl:write name="oneline" property="DtLastmod" />">
      <input type="hidden" name="txtInternalUserFlag"   value="<tbl:write name="oneline" property="internalUserFlag" />">
  
<br>
 <table align="center" border="0" cellspacing="0" cellpadding="0">
        <tr>
         <td><img src="img/button2_r.gif" border="0" ></td>
          <td background="img/button_bg.gif"><a href="<bk:backurl property="operator_query.do/all_operator_query_result.do" />" class="btn12">返&nbsp;回</a></td>
          <td><img src="img/button2_l.gif" border="0" ></td>
          <td width="20" ></td>
         
           <td><img src="img/button_l.gif" border="0" ></td>
           <td background="img/button_bg.gif"><a href="javascript:operator_modify_submit()" class="btn12">修&nbsp;改</a></td>
           <td><img src="img/button_r.gif" border="0" ></td>
           
            <td width="20" ></td>
             <%
           if(!"Y".equals(internalFlag)){
          
          %>
            <td><img src="img/button_l.gif" border="0" ></td>
              
            <td background="img/button_bg.gif"><a href="operator_to_group_config.screen?txtOrgName=<%=orgName%>&txtOperatorID=<tbl:write name="oneline" property="operatorID"/>
&txtOperatorName=<tbl:write name="oneline" property="operatorName"/>&txtOperatorDesc=<tbl:write name="oneline" property="operatorDesc"/>" class="btn12">所属操作员组</a></td>
            <td><img src="img/button_r.gif" border="0" ></td>  
            <%}%>
           
	
        </tr>
      </table>   
  
      <table width="98%"  border="0" align="center" cellpadding="0" cellspacing="0" background="img/line_01.gif">
        <tr>
          <td><img src="img/mao.gif" width="1" height="1"></td>
        </tr>
      </table>
       <br>      
    </lgc:bloop>      
</form>
