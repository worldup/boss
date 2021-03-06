<%@ taglib uri="/WEB-INF/html.tld" prefix="tbl" %>
<%@ taglib uri="logic" prefix="lgc" %>
<%@ taglib uri="osstags" prefix="d" %>
<%@ taglib uri="bookmark" prefix="bk" %>

<%@ page import="com.dtv.oss.dto.BidimConfigSettingDTO" %>
<%@ page import="java.util.*" %>
<%@ page import="com.dtv.oss.dto.BidimConfigSettingValueDTO" %>
<%@ page import="com.dtv.oss.dto.BidimConfigSettingWithValueDTO" %>
<%@ page import="com.dtv.oss.util.Postern" %>

<%
	    String editingType = (String)request.getAttribute("editing_type");
	    if(editingType==null)
	     editingType="";
	    String backUrl = (String)request.getAttribute("back_url");
  	  if (backUrl==null || backUrl.trim().length()==0){
  	    	backUrl="bidim_config_query.do?query_type=entrance";
 	    }
 	     

%>
  
<script language=javascript>
var newFlag=<%= editingType.equals("new_config") %>;
var deleteValuesString="";
var newAppendedValuesString="";
var valueSeperator="@*@";
var itemSeperator="@@";
 
function check_frm(){
	if (check_Blank(document.frmPost.txtName, true, "配置名称")){
    	return false;
    	}    
	if (check_Blank(document.frmPost.txtConfigType, true, "配置类型")){
    	return false;
    	}
	if (check_Blank(document.frmPost.txtValueType, true, "取值类型")){
		return false;
	} 
	if (check_Blank(document.frmPost.txtStatus, true, "状态")){
		return false; 
	}	
	if (check_Blank(document.frmPost.txtAllowNull, true, "允许为空")){
		return false;
	}
	return true;
}

function config_modify_submit(){
	if(newFlag){
		config_new_submit();
	}else{
		config_update_submit();
	}
}

function config_new_submit(){
	if (check_frm()){			
		document.frmPost.new_appended_values.value=newAppendedValuesString;
		document.frmPost.to_be_deleted_values.value=deleteValuesString;
    document.frmPost.modify_type.value="new";
    }else{
       	return;
    }
    document.frmPost.submit();
}

function config_update_submit(){	
    if (window.confirm('您确认要修改该配置信息吗?')){
       	if (check_frm()){
      	    document.frmPost.modify_type.value="update";  
      	    document.frmPost.new_appended_values.value=newAppendedValuesString;
			document.frmPost.to_be_deleted_values.value=deleteValuesString;          
    	}else{
    		return;
    	}
    	document.frmPost.submit();
    }	   	
}

function config_delete_submit(){
	if (window.confirm('您确认要删除该配置信息吗?')){	
    	document.frmPost.modify_type.value="delete";
        document.frmPost.submit();
    }   
}
 
function changePrefed(){
	if (document.frmPost.txtValueType.value =="M"||document.frmPost.txtValueType.value =="D"){       
       	document.all("prefered").style.display ="none";   
       	document.all("valuesTable").style.display ="none";      
  } else{
      	document.all("prefered").style.display ="";
  } 
}

function changeSubType(){    
	document.FrameUS.submit_update_select('configsubtype', document.frmPost.txtConfigType.value, 'txtConfigSubType', '');   
}

function addOneValue(){
	var strCode=document.frmPost.txtValueCode.value;
	var strDescription=document.frmPost.txtValueDescription.value
	var strStatus=document.frmPost.txtValueStatus.value
	var strDefalt=document.frmPost.txtDefaltValue.value;
	var strPriority=document.frmPost.txtPriority.value;
        
	
	
        if (!check_Num(document.frmPost.txtPriority, true, "排列顺序"))
		return false;
	if(strCode==null || strCode==""){
		alert("取值代码不能为空！");
		return;
	}
	if(strStatus==null || strStatus==""){
		alert("状态不能为空！");
		return;
	}
	if(strDescription==null || strDescription==""){
		alert("描述信息不能为空！");
		return;
	}
	if(strDefalt==null || strDefalt==""){
		alert("默认值不能为空！");
		return;
	}
	 
 
  
	var valuesString=valueSeperator+"";
	valuesString+=itemSeperator+strCode;
	valuesString+=itemSeperator+strDescription;
	valuesString+=itemSeperator+strStatus;
	valuesString+=itemSeperator+strPriority;
	valuesString+=itemSeperator+strDefalt;
	
	newAppendedValuesString=newAppendedValuesString+valuesString;

	var newRow=document.createElement("<tr class=\"list_bg1\" onmouseover=\"this.className=\'list_over\'\" onmouseout=\"this.className=\'list_bg1\'\">");
	document.all.valuesTable.tBodies[0].appendChild(newRow);

	var newCell0=document.createElement("<td align=center></td>");
	newRow.appendChild(newCell0);
	newCell0.innerText="";

	var newCell1=document.createElement("<td align=center></td>");
	newRow.appendChild(newCell1);
	newCell1.innerText=strCode;

	var newCell2=document.createElement("<td align=center></td>");
	newRow.appendChild(newCell2);
	newCell2.innerText=strDescription;

	var newCell3=document.createElement("<td align=center></td>");
	newRow.appendChild(newCell3);
	if(strStatus=="V"){
		newCell3.innerText="有效";
	}else{
		newCell3.innerText="无效";
	}
       
	var newCell4=document.createElement("<td align=center></td>");
	newRow.appendChild(newCell4);
	newCell4.innerText=strPriority;
	 var newCell5=document.createElement("<td align=center></td>");
	newRow.appendChild(newCell5);
	if(strDefalt=="Y"){
		newCell5.innerText="是";
	}else{
		newCell5.innerText="否";
	} 	
	var newCell6=document.createElement("<td align=center></td>");
	newRow.appendChild(newCell6);	
	var delBtn=document.createElement("<input type=\"button\" value=\"删&nbsp;除\" onclick=\"javascript:deleteOneValue()\"/>");	
	newCell6.appendChild(delBtn);	
}

function deleteOneValue(){
  if (window.confirm('您确认要删除该配置信息吗?')){ 
	  var curRow=event.srcElement.parentElement.parentElement;
	  var txtID=curRow.cells(0).innerText;
	  var txtCode=curRow.cells(1).innerText;
	  var txtDescription=curRow.cells(2).innerText;
	  var txtValueStatus=curRow.cells(3).innerText;
	  if(txtValueStatus=="有效"){
		  txtValueStatus="V";
	  }else{
		  txtValueStatus="I";
	  }
	 
	  var txtPriority=curRow.cells(4).innerText;
	    
	  var txtDefaltValue=curRow.cells(5).innerText;
	  
	  if(del_defaultBlank(txtDefaltValue)=="是"){
		  txtDefaltValue="Y";
	  }else{
		  txtDefaltValue="N";
	  }		
	  
	  var varValueString=valueSeperator+txtID;
	  varValueString+=itemSeperator+txtCode;
	  varValueString+=itemSeperator+txtDescription;
	  varValueString+=itemSeperator+txtValueStatus;
	  varValueString+=itemSeperator+txtPriority;
	  varValueString+=itemSeperator+txtDefaltValue;
	  if(txtID==null || txtID==""){<!-- for new appended rows-->		
		var index1=newAppendedValuesString.indexOf(varValueString);		
		if((index1>-1) && (index1<newAppendedValuesString.length-1)){			
			var index2=index1+varValueString.length;			
			var subOne=newAppendedValuesString.substring(0,index1);			
			var subTwo=newAppendedValuesString.substring(index2,newAppendedValuesString.length);			
			newAppendedValuesString=subOne+subTwo;			
		}
	}else{<!-- for already exist rows-->
		deleteValuesString+=varValueString;	
		 
	}	
	 document.all.valuesTable.deleteRow(curRow.rowIndex);
 }
}

function del_defaultBlank(myInput)
 {
 var myValue="";
  for(var i=0; i<myInput.length;i++)
    {
      var c=myInput.charAt(i);
      if (c!=' ') myValue=myValue+c;	
    }
   return myValue; 
}
</script>

<div id="updselwaitlayer" style="position:absolute; left:650px; top:170px; width:250px; height:24px; display:none">
<table width="100%" border="0" cellspacing="1" cellpadding="3">
	<tr>
		<td width="100%"><div align="center">
			<font size="2">	正在获取内容... </font>
		</td>
	</tr>
</table>
</div>

<iframe SRC="update_select.screen" name="FrameUS" width="0" height="0" frameborder="0" scrolling="0"  >
</iframe>

<table width="820" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<table  border="0" align="center" cellpadding="0" cellspacing="10" >
  				<tr>
    				<td><img src="img/list_tit.gif" width="19" height="19"></td>
    				<td class="title">配置详细信息 </td>
  				</tr>
			</table>
			<table width="98%"  border="0" align="center" cellpadding="0" cellspacing="0" background="img/line_01.gif">
				<tr>
			    	<td><img src="img/mao.gif" width="1" height="1"></td>
			  	</tr>
			</table>
			<br>			 
			<form name="frmPost" method="post" action="bidim_config_modify.do" >  
			<lgc:bloop requestObjectName="ResponseQueryResult" item="oneline" IsOne="true"> 
				<%
			 	 	  System.out.println(pageContext.findAttribute("oneline").getClass());
			 	 	
			     	BidimConfigSettingWithValueDTO dto = (BidimConfigSettingWithValueDTO) pageContext.findAttribute("oneline");
			    	Map nameMap = null;
			     	nameMap=Postern.getAllService();
			     	int id = dto.getId();
			     	pageContext.setAttribute("SERVNAME",nameMap);
			     	long dtLastmod = (dto.getDtLastmod()==null)? 0 : dto.getDtLastmod().getTime();
			     	long dtCreate = (dto.getDtCreate()==null)? 0 : dto.getDtCreate().getTime();		   
			     	boolean preferedFlag = "M".equals(dto.getValueType())||"D".equals(dto.getValueType());  	
			     
				%>
				<table width="98%"  border="0" align="center" cellpadding="5" cellspacing="1" class="list_bg">
					<tr>
						 <td class="list_bg2"><div align="right"> 配置ID </div></td>
						 <td class="list_bg1" align="left">
						<%
 					   	if (editingType.equals("new_config")){
 					  %>
 							 <input type="text" name="txtID" size="25"  value="" class="textgray" readonly />
 						<%	
 						  }else{
 						%>
					     <input type="text" name="txtID" size="25"  value="<tbl:write name="oneline" property="Id" />" class="textgray" readonly />
					  <%
					    }
					  %>
					   </td>
					   <td class="list_bg2"><div align="right"> 配置名称* </div></td>
					   <td class="list_bg1" align="left">
					    	<input type="text" name="txtName" size="25" maxlength="25"  value="<tbl:write name="oneline" property="name" />" >
					   </td>
					</tr>
					<tr> 
						<td class="list_bg2"><div align="right"> 配置类型* </div></td>
					 	<td class="list_bg1" align="left">
					 	  <%
					    	 if(editingType.equals("new_config")){
					    %>
					 		<d:selcmn name="txtConfigType" mapName="SET_C_BIDIMCONFIGSETTINGCONFIGTYPE" match="oneline:configType" width="23" onchange="changeSubType()"/>
					 		<%	}else{%>
					 	<input type="text" name="txtConfigTypeShow"  size="25" value="<d:getcmnname  typeName="SET_C_BIDIMCONFIGSETTINGCONFIGTYPE" match="oneline:configType" />" class="textgray" readonly >
					 	<input type="hidden" name="txtConfigType" value="<tbl:write name="oneline" property="configType" />"> 
					 	<%}%>	
					 	</td>
						<td class="list_bg2"><div align="right"> 配置子类型 </div></td>
					 	<td class="list_bg1" align="left">
					 	  <%
					    	 if(editingType.equals("new_config")){
					    %>
					  		 <select name="txtConfigSubType"><option value="" >-----------------------</option></select>			  		
					  	<%	}else{%>
					  	 <input type="text" name="txtConfigSubTypeShow"  size="25" value="<d:getcmnname  typeName="SET_C_BIDIMCONFIGSETTINGCONFIGSUBTYPE" match="oneline:configSubType"/>" class="textgray" readonly >
					  	 <input type="hidden" name="txtConfigSubType" value="<tbl:write name="oneline" property="configSubType" />"> 
					  	<% }%>
					 	</td>
					</tr>  
					<tr> 
					 	<td class="list_bg2"><div align="right"> 业务类型 </div></td>
					 	<td class="list_bg1" align="left">        
					     	<tbl:select name="txtServiceId" set="SERVNAME" match="oneline:serviceId" width="23" /> 
					 	</td>
						<td class="list_bg2"><div align="right"> 取值类型* </div></td>
					 	<td class="list_bg1" align="left">
					  		<d:selcmn name="txtValueType" mapName="SET_C_BIDIMCONFIGSETTINGVALUETYPE" match="oneline:valueType" width="23" onchange="changePrefed()"/>
					  	</td>
					</tr>
					<tr>
						<td class="list_bg2"><div align="right"> 状态* </div></td>
						<td class="list_bg1" align="left">
					 		<d:selcmn name="txtStatus" mapName="SET_G_GENERALSTATUS" match="oneline:Status" width="23" />
						</td>
						<td class="list_bg2"><div align="right"> 允许为空* </div></td>
						<td class="list_bg1" align="left">
					 		<d:selcmn name="txtAllowNull" mapName="SET_G_YESNOFLAG" match="oneline:allowNull" width="23" />
						</td>
					</tr>
					<tr>   
						<td class="list_bg2"><div align="right"> 描述 </div></td>
						<td class="list_bg1"  align="left" colspan="3"> 
					 		<input type="text" name="txtDescription" size="83"  maxlength="120" value="<tbl:write name="oneline" property="description" />" >
						</td>
					</tr>
				</table>  
				<br>
				<table width="98%"  border="0" align="center" cellpadding="0" cellspacing="0" background="img/line_01.gif">
				<tr>
			    	<td><img src="img/mao.gif" width="1" height="1"></td>
			  	</tr>
			        </table>
			<br>
			<table id="prefered" width="98%"  border="0" align="center" cellpadding="5" cellspacing="1" class="list_bg" <% if (preferedFlag) {%> style="display:none" <%} %> >
					<tr> 
						<td colspan="5" class="import_tit" align="center"><font size="3">配置选项值 </font></td>
					</tr>
					<tr>
					   	<td class="list_bg2"><div align="right"> 取值代码* </div></td>
					   	<td class="list_bg1">
					   		<input type="text" name="txtValueCode" maxlength="25" size="25" value="" >
					   	</td>
					  	<td class="list_bg2"><div align="right">状态* </div></td>
					  	<td class="list_bg1"> 
					   		<d:selcmn name="txtValueStatus" mapName="SET_G_GENERALSTATUS" match="txtStatus" width="23" />
					  	</td>
					  	<td class="list_bg1"> 
					   		<input type="button" name="addButton" value="添&nbsp;加" onclick="javascript:addOneValue()"/>
					  	</td>
					</tr>
					<tr>   
						<td class="list_bg2"><div align="right"> 取值描述* </div></td>
						<td class="list_bg1" > 
							<input type="text" name="txtValueDescription" size="25" maxlength="250" value="" />  
						</td>
						<td class="list_bg2"><div align="right"> 是否默认值* </div></td>
						<td class="list_bg1" > 
							<d:selcmn name="txtDefaltValue" mapName="SET_G_YESNOFLAG" match="txtDefaltValue" width="23" />
						</td>
						<td class="list_bg1" > </td> 
					</tr>
					<tr>   
						<td class="list_bg2"><div align="right">排列顺序</div></td>
						<td class="list_bg1" colspan="3"> 
							<input type="text" name="txtPriority" size="25" maxlength="10" value="" />  
						</td>
						 
						<td class="list_bg1" > </td> 
					</tr>
			 </table>  
			 <table id="valuesTable" width="98%"  border="0" align="center" cellpadding="5" cellspacing="1" class="list_bg">    
					<tr class="list_head">
					    <td class="list_head">ID </td>
					    <td class="list_head">取值代码 </td>
					    <td class="list_head">取值描述 </td>
					    <td class="list_head">状态 </td>
					    <td class="list_head">排列顺序 </td>
					     <td class="list_head">是否默认值 </td>
					    <td class="list_head">操作 </td>
					</tr>
				<%
					Collection col=dto.getValueList();
					if(col!=null && !col.isEmpty()){
						Iterator valueIter=col.iterator();
						
						while(valueIter.hasNext()){
							Object o = valueIter.next();
							System.out.println(o.getClass());
							BidimConfigSettingValueDTO valueDto=(BidimConfigSettingValueDTO)o;
							 
							 
							pageContext.setAttribute("detailLine",valueDto); 
							
				%>
					<tbl:printcsstr style1="list_bg1" style2="list_bg2" overStyle="list_over" > 
						<td align="center"><tbl:write name="detailLine" property="Id"/></td>
						<td align="center"><tbl:write name="detailLine" property="code"/></td>
						<td align="center"><tbl:write name="detailLine" property="description"/></td>
						<td align="center"><d:getcmnname typeName="SET_G_GENERALSTATUS" match="detailLine:Status"/></td>  
						<td align="center"><tbl:write name="detailLine" property="priority"/></td> 
						<td align="center"><d:getcmnname typeName="SET_G_YESNOFLAG" match="detailLine:defaultOrNot"/> </td> 
						<td align="center"><input type="button" value="删&nbsp;除" onclick="javascript:deleteOneValue()"/></td>          
					</tbl:printcsstr>
				<% } %>
				     
				
				<%
					}
				%>
				</table>
				<input type="hidden" name="new_appended_values" value=""/>
				<input type="hidden" name="to_be_deleted_values" value=""/>
				<input type="hidden" name="modify_type" value=""/>
				<input type="hidden" name="editing_type" value="<%=editingType%>"/>
				<input type="hidden" name="dt_lastmod_time" value="<%=dtLastmod%>"/>
				<input type="hidden" name="dt_create_time" value="<%=dtCreate%>"/>
				<input type="hidden" name="back_url" value="<%=backUrl%>"/>

				<br>
				</lgc:bloop>   
				<table align="center" border="0" cellspacing="0" cellpadding="0">
					<tr>
					   
                                            
						<td><img src="img/button2_r.gif" width="22" height="20"></td>
					    <td background="img/button_bg.gif"><a href="<%=backUrl%>"  class="btn12">返&nbsp;回 </a></td>
					     <td><img src="img/button2_l.gif" width="11" height="20"></td>
					<% if(!editingType.equals("new_config")){ %>
						<!--
					    <td><img src="img/button_l.gif" border="0" ></td>
					    <td background="img/button_bg.gif"><a href="javascript:config_delete_submit()" class="btn12"  >删&nbsp;除 </a></td>
					    <td><img src="img/button_r.gif" border="0" ></td>
					    -->
					<% } %>
					    <td width="20" ></td>          
					    <td><img src="img/button_l.gif" border="0" ></td>
					    <td background="img/button_bg.gif"><a href="javascript:config_modify_submit()" class="btn12">确&nbsp;认</a></td>
					    <td><img src="img/button_r.gif" border="0" ></td>
					</tr>
				</table>
				 
				 
			
			 
			</form>
		</td>
	</tr>
</table>

