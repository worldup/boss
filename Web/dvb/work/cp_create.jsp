<!-- 创建报修单 -->
<%@ taglib uri="osstags" prefix="d"%>
<%@ taglib uri="/WEB-INF/html.tld" prefix="tbl"%>

<%@ taglib uri="privilege" prefix="pri"%>
<%@ taglib uri="/WEB-INF/oss.tld" prefix="d"%>
<%@ taglib uri="logic" prefix="lgc"%>
<%@ page import="com.dtv.oss.dto.CustomerDTO"%>

<%@ page import="com.dtv.oss.util.Postern,com.dtv.oss.web.util.CommonKeys"%>
<%@ page import="java.util.*"%>
<%@ page import="com.dtv.oss.web.util.*"%>
<%@ page import="com.dtv.oss.dto.wrap.customer.Customer2AddressWrap"%>

<TABLE border="0" cellspacing="0" cellpadding="0" width="820">
	<TR>
		<TD>

			<table border="0" align="center" cellpadding="0" cellspacing="10">
				<tr>
					<td><img src="img/list_tit.gif" width="19" height="19"></td>
					<td class="title">创建报修单</td>
				</tr>
			</table>
			<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0" background="img/line_01.gif">
				<tr>
					<td><img src="img/mao.gif" width="1" height="1"></td>
				</tr>
			</table>

			<form name="frmPost" method="post" action="cp_create_fee.do">
				<input type="hidden" name="confirm_post" value="FALSE">
				<%
				String systemSettingValue = "";
				%>
				<lgc:bloop requestObjectName="ResponseQueryResult" item="oneline" isOne="true">

					<%
							com.dtv.oss.dto.wrap.customer.Customer2AddressWrap wrap = (com.dtv.oss.dto.wrap.customer.Customer2AddressWrap) pageContext
							.getAttribute("oneline");
							pageContext.setAttribute("cust", wrap.getCustDto());
							CustomerDTO dto = wrap.getCustDto();
							ArrayList list = new ArrayList();
							pageContext.setAttribute("custaddr", wrap.getAddrDto());
							Map mapOrgName = Postern
							.getOrgNameMapByOrgRole(CommonKeys.ORGANIZATION_ROLE_REPAIR);
							if (mapOrgName != null)
								pageContext.setAttribute("ServiceRepOrg", mapOrgName);
					%>
					<input type="hidden" name="txtAddressId" value="<%=dto.getAddressID()%>">
					<input type="hidden" name="txtCustType" value="<tbl:write name="cust" property="customerType"/>">
					<tbl:hiddenparameters pass="txtServiceAccountID/txtDeviceId/txtCatvId" />
					<table width="98%" border="0" align="center" cellpadding="5" cellspacing="1" class="list_bg">
						<tr>
							<td colspan="4" class="import_tit" align="center">
								<font size="3">客户基本信息</font>
							</td>
						</tr>
						<tr>
							<td class="list_bg2">
								<div align="right">
									客户姓名
								</div>
							</td>
							<td class="list_bg1">
								<input type="text" name="txtContactPerson" class="textgray" readonly size="25"
									value="<tbl:write name="cust" property="Name" />">
							</td>
							<td class="list_bg2">
								<div align="right">
									客户地址*
								</div>
							</td>
							<td class="list_bg1">
								<input type="text" name="txtDetailAddress" size="25"
									value="<tbl:write name="custaddr" property="DetailAddress" />">
							</td>

						</tr>
						<%
								String[] deviceId = request.getParameterValues("txtDeviceId");
								if (deviceId != null) {
									int deviceIdCount = deviceId.length;
									for (int i = 0; i < deviceIdCount; i++) {

								Map deviceMap = Postern
										.getDeviceModelByDeviceId(WebUtil
										.StringToInt(deviceId[i]));
								list.add(deviceMap);

									}

									if (list.size() == 1) {
								Map deviceMap = null;
								deviceMap = (Map) list.get(0);
								Iterator itBank = deviceMap.entrySet().iterator();
								while (itBank.hasNext()) {
									Map.Entry deviceMapSet = (Map.Entry) itBank.next();
						%>
						<tr>
							<td class="list_bg2">
								<div align="right">
									<%=deviceMapSet.getKey()%>
								</div>
							</td>
							<input type="hidden" name="label" value="<%=deviceMapSet%>">
							<td class="list_bg1" colspan="3">
								<input type="text" name="txtDeviceModel" size="25" class="textgray" readonly
									value="<%=deviceMapSet.getValue()%>">
							</td>

						</tr>

						<%
									}
									} else if (list.size() == 2) {
								Map deviceMap1 = null;
								Map deviceMap2 = null;
								deviceMap1 = (Map) list.get(0);
								deviceMap2 = (Map) list.get(1);
								Iterator itBank1 = deviceMap1.entrySet().iterator();
								Iterator itBank2 = deviceMap2.entrySet().iterator();

								while (itBank1.hasNext()) {
									Map.Entry deviceMapSet1 = (Map.Entry) itBank1
									.next();
						%>
						<tr>
							<td class="list_bg2">
								<div align="right">
									<%=deviceMapSet1.getKey()%>
								</div>
							</td>
							<input type="hidden" name="label" value="<%=deviceMapSet1%>">
							<td class="list_bg1">
								<input type="text" name="txtDeviceModel1" size="25" class="textgray" readonly
									value="<%=deviceMapSet1.getValue()%>">
							</td>
							<%
									}
									while (itBank2.hasNext()) {
										Map.Entry deviceMapSet2 = (Map.Entry) itBank2
										.next();
							%>
							<td class="list_bg2">
								<div align="right">
									<%=deviceMapSet2.getKey()%>
								</div>
							</td>
							<input type="hidden" name="label" value="<%=deviceMapSet2%>">
							<td class="list_bg1">
								<input type="text" name="txtDeviceModel2" size="25" class="textgray" readonly
									value="<%=deviceMapSet2.getValue()%>">
							</td>

						</tr>
						<%
									}
									}
								}
						%>
						<tr>
							<td class="list_bg2">
								<div align="right">
									联系人*
								</div>
							</td>
							<td class="list_bg1">
								<input type="text" name="txtContactPersonBak" size="25" value="<tbl:write name="cust" property="Name" />">
							</td>
							<td class="list_bg2">
								<div align="right">
									联系电话*
								</div>
							</td>
							<td class="list_bg1">
								<input type="text" name="txtContactPhone" size="25" value="<tbl:write name="cust" property="telephone" />">
							</td>

						</tr>
						<tr>
							<td class="list_bg2">
								<div align="right">
									付费帐户*
								</div>
							</td>
							<td class="list_bg1" colspan="3">
								<d:selAccByCustId name="txtAccount" mapName="self" canDirect="true" match="txtAccount" empty="false" width="23" />
							</td>
						</tr>
						<tr>
							<td colspan="4" class="import_tit" align="center">
								<font size="3">报修信息</font>
							</td>
						</tr>
						<input type="hidden" name="txtProblemLevel" value="S">

						<tr>
							<td class="list_bg2">
								<div align="right">
									报修类别*
								</div>
							</td>
							<td class="list_bg1">
								<d:selcmn name="txtProblemCategory" mapName="SET_C_CPPROBLEMCATEGORY" match="txtProblemCategory" width="23" />
							</td>
							<td class="list_bg2">
								<div align="right">
									收费类别*
								</div>
							</td>
							<td class="list_bg1">
								<d:selcmn name="txtFeeClass" mapName="SET_C_CPFEECLASS" match="txtFeeClass" width="23" />
							</td>
						</tr>
						<tr>
							<td class="list_bg2">
								<div align="right">
									故障现象
							</td>
							<td class="list_bg1" colspan="3" >
								<font size="2">
								<d:selcmn name="txtProblemPhenomena" mapName="SET_C_CPPROBLEMPHENOMENA" match="txtProblemPhenomena" width="23" />
								</font>
							</td>
						</tr>
						<tr>
							<td class="list_bg2">
								<div align="right">
									故障描述
							</td>
							<td class="list_bg1" colspan="3" >
								<font size="2">
								<textarea name="txtProblemDesc" cols=82 rows=3 ><tbl:writeparam name="txtProblemDesc" /></textarea>
								</font>
							</td>
						</tr>
						<%
								int saId = WebUtil.StringToInt(request
								.getParameter("txtServiceAccountID"));
								int serviceID = Postern.getServiceIDByAcctServiceID(saId);
								systemSettingValue = Postern
								.getSystemsettingValueByName("SET_W_DIAGIMME");
								if (systemSettingValue != null
								&& ("Y").equals(systemSettingValue)) {
						%>


						<tr>
							<td colspan="4" class="import_tit" align="center"><font size="3">初步诊断信息</font></td>
						</tr>

						<tr>
							<td>
								<tbl:dynamicservey serveyName="txtDiaName" serviceID="<%=String.valueOf(serviceID)%>" serveyType="D"
									serveySubType="N" showType="text" tdWordStyle="list_bg2" tdControlStyle="list_bg1" controlSize="25"
									checkScricptName="check_Bidimconfig()" />
							</td>
						</tr>
						<%
						}
						%>

					</table>
					<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0" background="img/line_01.gif">
						<tr>
							<td><img src="img/mao.gif" width="1" height="1"></td>
						</tr>
					</table>
					<br>

					<input type="hidden" name="txtCustomerID" value="<tbl:write name="cust" property="CustomerID" />">
				</lgc:bloop>
				<table border="0" cellspacing="0" cellpadding="0" align=center>
					<tr>
						<td><img src="img/button_l.gif" border="0"></td>
						<td background="img/button_bg.gif"><a href="javascript:create_submit();" class="btn12">下一步</a></td>
						<td><img src="img/button_r.gif" border="0"></td>
					</tr>
				</table>

			</form>

			<br>


		</TD>
	</TR>
</TABLE>

<script language=javascript>
function check_frm(){
	if (check_Blank(document.frmPost.txtProblemCategory, true, "报修类别"))
		return false;
       if (check_Blank(document.frmPost.txtContactPersonBak, true, "联系人"))
		return false;	
	 
	
	if (check_Blank(document.frmPost.txtDetailAddress, true, "客户地址"))
		return false;	
	if (check_Blank(document.frmPost.txtContactPhone, true, "联系电话"))
		return false;	
	if (check_Blank(document.frmPost.txtProblemLevel, true, "报修级别"))
		return false;			
	if (check_Blank(document.frmPost.txtFeeClass, true, "收费类别"))
		return false;		
  systemSettingValue ='<%=systemSettingValue%>';
  if ('Y' ==systemSettingValue){
	   if (!check_Bidimconfig()) return false;
	}
	return true;
}

 
 
function create_submit(){
	if (check_frm()) {
			document.frmPost.submit();
	}
}
</script>
