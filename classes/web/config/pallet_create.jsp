<%@ taglib uri="/WEB-INF/html.tld" prefix="tbl"%>
<%@ taglib uri="logic" prefix="lgc"%>
<%@ taglib uri="resultset" prefix="rs"%>
<%@ taglib uri="/WEB-INF/oss.tld" prefix="d"%>
<%@ taglib uri="bookmark" prefix="bk" %>

<%@ page import="com.dtv.oss.util.Postern,java.util.*"%>
<%@ page import="com.dtv.oss.dto.PalletDTO"%>

<SCRIPT language="JavaScript">
function check_form ()
{
    if (check_Blank(document.frmPost.txtPalletName, true, "货架名称"))
	    return false;
    if (check_Blank(document.frmPost.txtMaxNumber, true, "货架最大存储设备数")||!check_Num(document.frmPost.txtMaxNumber, true, "货架最大存储设备数"))
	    return false;
    if (check_Blank(document.frmPost.txtPalletStatus, true, "货架状态"))
	    return false;
    if (check_Blank(document.frmPost.txtOwner, true, "货架所属仓库"))
	    return false;

	return true;
}

function pallet_create()
{
    if (check_form())
    {
    	
        document.frmPost.submit();
    }
}

function back_submit(){
	url="<bk:backurl property='pallet_query.do'/>";
	if(url=="")
		url="pallet_query.screen";
    document.location.href=url;
}

</SCRIPT>

<form name="frmPost" method="post" action="pallet_create.do">
	<input type="hidden" name="txtFrom" size="20" value="1">
	<input type="hidden" name="txtTo" size="20" value="10">
	<!-- 定义当前操作 -->
	<input type="hidden" name="txtActionType" size="20" value="CREATE">
<table border="0" align="center" cellpadding="0" cellspacing="10">
	<tr>
		<td><img src="img/list_tit.gif" width="19" height="19"></td>
		<td class="title">货架新增</td>
	</tr>
</table>
<table width="100%" border="0" align="center" cellpadding="0"
	cellspacing="0" background="img/line_01.gif">
	<tr>
		<td><img src="img/mao.gif" width="1" height="1"></td>
	</tr>
</table>
<br>

<table width="810" align="center" border="0" cellspacing="1"
	cellpadding="3">
	<tr>
		<td class="list_bg2" align="right" width="17%"></td>
		<td class="list_bg1" width="33%"></td>
		<td class="list_bg2" align="right" width="17%"></td>
		<td class="list_bg1" width="33%"></td>
	</tr>
	<tr>
		<td class="list_bg2" align="right">货架名称*</td>
		<td class="list_bg1"><input name="txtPalletName"
			type="text" class="text" maxlength="25" size="25"
			value="<tbl:writeparam name="txtPalletName" />"></td>
		<td class="list_bg2" align="right">最大存储设备数*</td>
		<td class="list_bg1"><input name="txtMaxNumber"
			type="text" class="text" maxlength="10" size="25"
			value="<tbl:writeparam name="txtMaxNumber" />"></td>
	</tr>
	<tr>
		<td class="list_bg2" align="right">状态*</td>
		<td class="list_bg1"><font size="2"><d:selcmn name="txtPalletStatus"
			mapName="SET_G_GENERALSTATUS" match="txtPalletStatus" width="23" defaultValue="V"/> </font></td>
		<td class="list_bg2" align="right">所属仓库*</td>
		<td class="list_bg1"><d:seldepotbyoper  name="txtOwner" match="txtOwner" width="23" /></td>
	</tr>
	<tr>
		<td class="list_bg2" align="right">货架描述</td>
		<td class="list_bg1" colspan="3"><font size="2"><input name="txtPalletDesc"
			type="text" class="text" maxlength="100" size="83"
			value="<tbl:writeparam name="txtPalletDesc" />"></font></td>
	</tr>
</table>

    <table width="100%"  border="0" align="center" cellpadding="5" cellspacing="1" class="list_bg">
	<tr align="center">
	     <td class="list_bg1">

	  <table align="center"  border="0" cellspacing="0" cellpadding="0">
         <tr>  
            <td><img src="img/button2_r.gif" width="22" height="20"></td>
			<td><input name="Submit" type="button" class="button"
					value="返&nbsp;回" onclick="javascript:back_submit()"></td>
            <td><img src="img/button2_l.gif" width="11" height="20"></td>
            <td width="20" ></td>  

            <td><img src="img/button_l.gif" width="11" height="20"></td>
            <td><input name="Submit" type="button" class="button"
					value="新&nbsp;增" onclick="javascript:pallet_create()"></td>
            <td><img src="img/button_r.gif" width="22" height="20"></td>          
        </tr>
      </table>	
	   </td>
	</tr>
    </table>    

</form>
