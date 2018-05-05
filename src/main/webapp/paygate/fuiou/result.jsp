<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="net.jeeshop.core.pay.fuiuo.client.util.MD5" %>
<%@page import="net.jeeshop.core.pay.fuiuo.client.util.StringUtils" %>
<%@ page import="net.jeeshop.core.pay.fuiuo.client.config.FuiouConfig" %>
<%
try{
response.setHeader("Pragma", "No-cache");
response.setHeader("Cache-Control", "no-cache,no-store,max-age=0");
response.setDateHeader("Expires", 0);
request.setCharacterEncoding("UTF-8");

String mchnt_cd = FuiouConfig.mchnt_cd;
String order_id = StringUtils.nvl(request.getParameter("order_id"));
String order_amt = StringUtils.nvl(request.getParameter("order_amt"));
String order_date = StringUtils.nvl(request.getParameter("order_date"));
String order_st = StringUtils.nvl(request.getParameter("order_st"));
String order_pay_code = StringUtils.nvl(request.getParameter("order_pay_code"));
String order_pay_error = StringUtils.nvl(request.getParameter("order_pay_error"));
String fy_ssn = StringUtils.nvl(request.getParameter("fy_ssn"));
String resv1 = StringUtils.nvl(request.getParameter("resv1"));
String md5 = StringUtils.nvl(request.getParameter("md5"));
String mchnt_key = FuiouConfig.mchnt_key;  //32位的商户密钥

String signDataStr = mchnt_cd + "|" + 
                     order_id + "|" + order_date + "|" + order_amt+ "|" +order_st+ "|" +order_pay_code+ "|" +
                     order_pay_error+ "|" + resv1+ "|" +
                     fy_ssn+ "|" + mchnt_key;
String md52 = MD5.MD5Encode(signDataStr);
System.out.println(signDataStr);
System.out.println(md5);
System.out.println(md52);
//为了测试方便暂时去除
//if(!md5.equalsIgnoreCase(md52))
//   throw new Exception("返回数据非法");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>XXX商城</title>
<link href="styles/style.css" rel="stylesheet" type="text/css" />
</head>

<body>
<br/>
<br/>
<table width="70%" border="0" cellspacing="1" cellpadding="0">
  <tr>
    <td width="30%" height="35" align="right"  class="bg_gray">商户代码：&nbsp;&nbsp;</td>
    <td width="70%" class="bg_yellow2" align="left">&nbsp;&nbsp;<%=mchnt_cd %></td>
  </tr>
  <tr>
    <td width="30%" height="35" align="right"  class="bg_gray">商户订单号：&nbsp;&nbsp;</td>
    <td width="70%" class="bg_yellow2" align="left">&nbsp;&nbsp;<%=order_id %></td>
  </tr>
  <tr>
    <td width="30%" height="35" align="right"  class="bg_gray">交易金额：&nbsp;&nbsp;</td>
    <td width="70%" class="bg_yellow2" align="left">&nbsp;&nbsp;<%=order_amt %></td>
  </tr>
  <tr>
    <td width="30%" height="35" align="right"  class="bg_gray">日期：&nbsp;&nbsp;</td>
    <td width="70%" class="bg_yellow2" align="left">&nbsp;&nbsp;<%=order_date %></td>
  </tr>
  <tr>
    <td width="30%" height="35" align="right"  class="bg_gray">订单状态：&nbsp;&nbsp;</td>
    <td width="70%" class="bg_yellow2" align="left">&nbsp;&nbsp;<%=order_st %></td>
  </tr>
  <tr>
    <td width="30%" height="35" align="right"  class="bg_gray">错误代码：&nbsp;&nbsp;</td>
    <td width="70%" class="bg_yellow2" align="left">&nbsp;&nbsp;<%=order_pay_code %></td>
  </tr>
  <tr>
    <td width="30%" height="35" align="right"  class="bg_gray">错误中文描述：&nbsp;&nbsp;</td>
    <td width="70%" class="bg_yellow2" align="left">&nbsp;&nbsp;<%=order_pay_error %></td>
  </tr>
  <tr>
    <td width="30%" height="35" align="right"  class="bg_gray">富友流水号：&nbsp;&nbsp;</td>
    <td width="70%" class="bg_yellow2" align="left">&nbsp;&nbsp;<%=fy_ssn %></td>
  </tr>
 <tr>
    <td width="30%" height="35" align="right"  class="bg_gray">&nbsp;&nbsp;</td>
    <td width="70%" class="bg_yellow2" align="left">&nbsp;&nbsp;</td>
  </tr>
 <tr>
    <td width="30%" height="35" align="right"  class="bg_gray">&nbsp;&nbsp;</td>
    <td width="70%" class="bg_yellow2" align="left">
    	&nbsp;&nbsp;<a href="<%=request.getContextPath()%>/order.jsp"><font color="red">返回重新测试支付</font></a>
    </td>
  </tr>
</table>
</body>
</html>
<%}catch(Exception e){
	e.printStackTrace();
	out.print(e.getMessage());
} %>
<body>
</body>
</html>