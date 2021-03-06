<%@ taglib uri="/WEB-INF/html.tld" prefix="tbl" %>
<%@ taglib uri="logic" prefix="lgc" %>
<%@ taglib uri="resultset" prefix="rs" %>
<%@ taglib uri="osstags" prefix="d" %>
<%@ page import="com.dtv.oss.util.Postern" %>
<%@ page import="com.dtv.oss.dto.TerminalDeviceDTO,
                 com.dtv.oss.dto.ServiceAccountDTO,
                 com.dtv.oss.dto.ProductDTO" %>
<%@ page import="java.util.*" %>
<%@ page import="com.dtv.oss.web.util.WebUtil,
                 com.dtv.oss.web.util.CommonKeys" %>
                 
<Script language=JavaScript>                 
function back_submit(){
	 document.frmPost.action="batchRenewProtocol_chooseSoftPackage.do";
	 document.frmPost.submit();
}

function frm_submit() {
	  document.frmPost.action ="batch_RenewProtocol_confirm.screen";
	  document.frmPost.submit();
}
</script>
                 
<TABLE border="0" cellspacing="0" cellpadding="0" width="1000" >
<TR>
	<TD>
<table  border="0" align="center" cellpadding="0" cellspacing="10" >
  <tr>
    <td><img src="img/list_tit.gif" width="19" height="19"></td>
    <td class="title">协议客户批量续费--->费用信息</td>
  </tr>
</table>
<table width="1000"  border="0" align="center" cellpadding="0" cellspacing="0" background="img/line_01.gif">
  <tr>
    <td><img src="img/mao.gif" width="1" height="1"></td>
  </tr>
</table>
<br>

<form name="frmPost" action="" method="post" > 

  <table width="1000"  border="0" align="center" cellpadding="5" cellspacing="1" class="list_bg"> 
  	<%
  	  String  packageStr =(request.getParameter("ProductList")==null) ? "" :request.getParameter("ProductList");
  	  String[] packageIds =packageStr.split(";");
  	  for (int i=0;i<packageIds.length;i++){
  	     if ("".equals(packageIds[i])) continue;
  	     String packageName =Postern.getPackagenameByID(Integer.parseInt(packageIds[i]));
  	     String productNames ="";
  	     ArrayList  pdDtoList =Postern.getProductListByProductPackageID(Integer.parseInt(packageIds[i]));
  	     Iterator pdDtoItr =pdDtoList.iterator();
         while (pdDtoItr.hasNext()) {
            ProductDTO pdDto =(ProductDTO)pdDtoItr.next();
            if (productNames.equals("")){
                productNames =pdDto.getProductName();
            }else{
            	  productNames =productNames+";"+pdDto.getProductName();
            }
         }
  	%>     
    <tr>  
      <td class="list_bg2" align="right" width="100">产品包</td>
      <td class="list_bg1" align="left"  width="900">&nbsp;<%=packageName%>(<%=productNames%>)</td>
    </tr>
   <%
     }
   %>
  </table>
  <table width="1000"  border="0" align="center" cellpadding="6" cellspacing="1" class="list_bg">
        <tr class="list_head">
          <td class="list_head" nowrap width="50">业务帐户ID</td>
          <td class="list_head" nowrap width="80">业务名称</td>
          <td class="list_head" nowrap width="30">状态</td>          
          <td class="list_head" nowrap width="80">创建日期</td>
          <td class="list_head" nowrap width="170">设备类型:设备序列号</td>
          <td class="list_head" width="690">产品</td>
        </tr> 

        <% 
           String[] saId_indexs =request.getParameterValues("saId_indexs");
           for (int i=0;i<saId_indexs.length;i++){
               ServiceAccountDTO dto=Postern.getServiceAccountDTOBySaID(saId_indexs[i]);
               int saID=dto.getServiceAccountID();
               int seviceID=dto.getServiceID();
               String serviceName=Postern.getServiceNameByID(seviceID);
               String status=Postern.getStatusByAcctServiceID(saID);
               String packageName=Postern.getPackageNameByServiceAccountID(saID);
        %>
	        <tbl:printcsstr style1="list_bg1" style2="list_bg2" overStyle="list_over" >
      	 	  <td align="center"><%=saID%></td>
      	    <td align="center"><%=serviceName%></td>
      	    <td align="center"><d:getcmnname typeName="SET_C_SERVICEACCOUNTSTATUS" match="<%=status%>" /></td>
      	    <td align="center"><%=WebUtil.TimestampToString(dto.getCreateTime(), "yyyy-MM-dd HH:mm:ss")%> </td>
       	    <td align="center" >
       	    <%
       	       List devList=Postern.getDeviceInfoByServiceAccountID(saID);
               Iterator itr=devList.iterator();
		           while(itr.hasNext()){
		              TerminalDeviceDTO tdto=(TerminalDeviceDTO)itr.next();
		              String dClass = tdto.getDeviceClass();
		              String className="";
		              if(!"C".equals(tdto.getStatus())){      //SET_C_CUSTOMERPRODUCTPSTATUS: C	取消
		              if(dClass!=null)
		                 className = Postern.getClassNameByDeviceClass(dClass);
		        %>
		         <%=className %>  : <%=tdto.getSerialNo()%><br>
	         	<%} }%>
          </td>
          <td align="left"><%=packageName%></td>
    	  </tbl:printcsstr>
       <%
          }
       %>
</table>
<tbl:CommonFeeAndPaymentInfo includeParameter="Fee" payCsiType="<%=CommonKeys.CUSTSERVICEINTERACTIONTYPE_BDP%>" />	
<br>
<table width="100%">
<tr>
<td>
<table align="center" border="0" cellspacing="0" cellpadding="0">
	<tr>
	  	<td><img src="img/button_l.gif" border="0" width="11" height="20"></td>
	   <td><input name="next" type="button" class="button" onClick="javascript:back_submit()" value="上一步"></td>
	   <td><img src="img/button_r.gif" border="0" width="22" height="20"></td>
	   <td width="20" ></td>
	   <td><img src="img/button_l.gif" border="0" width="11" height="20"></td>
	   <td><input name="next" type="button" class="button" onClick="javascript:frm_submit()" value="下一步"></td>
	   <td><img src="img/button_r.gif" border="0" width="22" height="20"></td>
	</tr>
</table>
</td>
</tr>
</table> 
<tbl:hiddenparameters pass="txtCsiType/txtCustomerID/saId_indexs/ProductList/CampaignList/txtAccount" />
<tbl:hiddenparameters pass="txtCustType/txtSoftFlag/txtUsedMonth/txtActionType" />
<tbl:hiddenparameters pass="MutiProductList/SingleProductList/GeneralCampaignList" />
</form> 
 </td>
  </tr>
 
</table>   
 
