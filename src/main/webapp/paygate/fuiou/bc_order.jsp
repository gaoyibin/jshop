<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="net.jeeshop.core.pay.fuiuo.client.util.DateUtils"%>
<%
response.setHeader("Pragma", "No-cache");
response.setHeader("Cache-Control", "no-cache,no-store,max-age=0");
response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>bbc</title>
<link href="styles/style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
table{ 
	margin:0 auto; 
} 
</style>
<script type="text/javascript">
function submitForm(){
	document.getElementById("form").submit();
}
</script>

</head>
<body>
<!--top-->
<br />
<form name="pay" method="post" action="bc_send_back.jsp">
 <table width="70%" cellspacing="0" border="0" cellspacing="1" >
  <tr> 
		<td class="info_title" >模拟bc订单信息</td>
  </tr>
  
  <tr>
   <td width="100%"> 
		<table width="100%" border="0" cellspacing="1">
			
		 <tr>
		    <td width="200" class="bg_gray" align="right" >商户代码：&nbsp;&nbsp;</td>
		    <td class="bg_yellow2"  	align="left"> &nbsp;
			    <input type="text" name="mchnt_cd"  size='30' maxlength = '15' value = '0001000F0040992'/>
		  	</td>
		  </tr>
		  
		   <tr>
		    <td width="200" class="bg_gray" align="right" >商户订单号：&nbsp;&nbsp;</td>
		    <td class="bg_yellow2"  	align="left"> &nbsp;
			    <input type="text" name="order_id"  size='30' maxlength = '15' value = '<%=DateUtils.getCurrentDate("yyMMddHHmmssSSS")+DateUtils.getNewRandomCode(5)%>'/>
		  	</td>
		  </tr>
		  
		  <tr>
		    <td width="200" class="bg_gray" align="right" >交易金额：&nbsp;&nbsp;</td>
		    <td class="bg_yellow2" 	align="left">&nbsp;&nbsp;<input type="text" name="order_amt"  size='30' value = '3970'/></td>
		  </tr>
		  
		  <tr>
		    <td width="200" class="bg_gray" align="right" >支付类型：&nbsp;&nbsp;</td>
		    <td class="bg_yellow2" 	align="left">&nbsp;&nbsp;
		    <select name="order_pay_type">
		     	  		<option value="B2C" >B2C</option>
			 </select>
				</td>
			</tr>	
		  <tr>
		  
		  <tr>
		    <td width="200" class="bg_gray" align="right" >支付成功页面跳转URL：&nbsp;&nbsp;</td>
		    <td class="bg_yellow2" 	align="left">&nbsp;&nbsp;<input type="text" name="page_notify_url"   value = 'http://localhost:8080/paygate/fuiou/fuiouapi_return_url.jsp'/></td>
		  </tr>
		  
		  <tr>
		    <td width="200" class="bg_gray" align="right" >支付成功后台通知URL：&nbsp;&nbsp;</td>
		    <td class="bg_yellow2" 	align="left">&nbsp;&nbsp;<input type="text" name="back_notify_url"  value = 'http://localhost:8080/paygate/fuiou/fuiouapi_notify_url.jsp'/></td>
		  </tr>
		  
		    <td width="200" class="bg_gray" align="right" >银行代码：&nbsp;&nbsp;</td>
		    <td class="bg_yellow2" 	align="left">&nbsp;&nbsp;
		     <select name="iss_ins_cd">
		     	  <option value="0000000000" >富友支付</option> 
		     	  <option value="0803080000" >招商银行</option>  
						<option value="0803010000" >交通银行	</option>
						<option value="0803100000" >上海浦东发展银行</option>
						<option value="0803090000" >兴业银行</option>
						<option value="0803160000" >浙商银行</option>  
						<option value="0801020000" >中国工商银行</option>  
						<option value="0803030000" >中国光大银行</option>  
						<option value="0801050000" >中国建设银行</option>  
						<option value="0803050000" >中国民生银行</option>  
						<option value="0801030000" >中国农业银行</option>  
						<option value="0801040000" >中国银行</option>  
						<option value="0803020000" >中信银行</option>  
						<option value="0803030000" >光大银行</option>
						<option value="0803070000" >深圳发展银行</option>  
						<option value="0801000000" >储蓄银行</option>
						<option value="08G0000001" >CFCA</option>
						<option value="0000000000" >其他银行</option>  
					</select>
				</td>
			</tr>	
			
		  
			<tr>
		    <td width="200" class="bg_gray" align="right" >是否报关：&nbsp;&nbsp;</td>
		    <td class="bg_yellow2" 	align="left">&nbsp;&nbsp;<input type="text" name="customs_flag"  size='30' maxlength = '60' value = '0'/></td>
		  </tr>
		  
		   <tr>
		    <td width="200" class="bg_gray" align="right" >通关口岸：&nbsp;&nbsp;</td>
		    <td class="bg_yellow2" 	align="left">&nbsp;&nbsp;<input type="text" name="customs_code"  size='30' maxlength = '60' value = '01'/></td>
		  </tr>
		  
		  <tr>
		    <td width="200" class="bg_gray" align="right" >姓名：&nbsp;&nbsp;</td>
		    <td class="bg_yellow2" 	align="left">&nbsp;&nbsp;<input type="text" name="ic_name"  size='30' maxlength = '60' value = '徐华丽'/></td>
		  </tr>
		  <tr>
		    <td width="200" class="bg_gray" align="right" >证件号：&nbsp;&nbsp;</td>
		    <td class="bg_yellow2" 	align="left">&nbsp;&nbsp;<input type="text" name="ic_number"  size='30' maxlength = '60' value = '421222199204200127'/></td>
		  </tr>
		   <tr>
		    <td width="200" class="bg_gray" align="right" >付款人电商平台ID：&nbsp;&nbsp;</td>
		    <td class="bg_yellow2" 	align="left">&nbsp;&nbsp;<input type="text" name="payer_ecommerce_id"  size='30' maxlength = '60' value = 'ID007'/></td>
		  </tr>
		  <tr>
		    <td width="200" class="bg_gray" align="right" >付款人电话：&nbsp;&nbsp;</td>
		    <td class="bg_yellow2" 	align="left">&nbsp;&nbsp;<input type="text" name="payer_tel"  size='30' maxlength = '60' value = '13333333333'/></td>
		  </tr>
		  
		  <tr>
		    <td width="200" class="bg_gray" align="right" >业务类型：&nbsp;&nbsp;</td>
		    <td class="bg_yellow2" 	align="left">&nbsp;&nbsp;<input type="text" name="order_type"  size='30' maxlength = '60' value = 'I10'/></td>
		  </tr>
		   <tr>
		    <td width="200" class="bg_gray" align="right" >备注：&nbsp;&nbsp;</td>
		    <td class="bg_yellow2" 	align="left">&nbsp;&nbsp;<input type="text" name="rem"  size='30' maxlength = '60' value = 'nike'/></td>
		  </tr>
		
		 <tr>
		    <td width="200" class="bg_gray" align="right" >reserved1：&nbsp;&nbsp;</td>
		    <td class="bg_yellow2" 	align="left">&nbsp;&nbsp;<input type="text" name="reserved1"  size='30' maxlength = '60' value = 'nike'/></td>
		  </tr>
		  
		   <tr>
		    <td width="200" class="bg_gray" align="right" >reserved2：&nbsp;&nbsp;</td>
		    <td class="bg_yellow2" 	align="left">&nbsp;&nbsp;<input type="text" name="reserved2"  size='30' maxlength = '60' value = 'nike'/></td>
		  </tr>
		  
		  
		  <tr>
		    <td width="200" class="bg_gray" align="right" >  版本号：&nbsp;&nbsp;</td>
		    <td class="bg_yellow2" 	align="left">&nbsp;&nbsp;<input type="text" name="ver"  size='30' maxlength = '60' value = '1.0.0'/></td>
		  </tr>
		  
		  <tr>
		    <td width="200" class="bg_gray" align="right" >商户秘钥-mchnt_key：&nbsp;&nbsp;</td>
		    <td class="bg_yellow2" 	align="left">&nbsp;&nbsp;<input type="text" name="mchnt_key"  size='30' maxlength = '100' value = 'vau6p7ldawpezyaugc0kopdrrwm4gkpu'/></td>
		  </tr>
		  
		  <tr>
		    <td height="50">&nbsp;</td>
		    <td><input type="submit" name="submit" value="确 定" />&nbsp;&nbsp;&nbsp;&nbsp;</td>
		  </tr>
		  
		  </table>
   </td>
  </tr>
</table>
</form>
</body>
</html>
