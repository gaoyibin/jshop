<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.apache.commons.beanutils.BeanUtils"%>
<%@page import="net.jeeshop.core.pay.fuiuo.client.txn.NewOrderData" %>
<%@page import="net.jeeshop.core.pay.fuiuo.client.util.MD5" %>
<%@page import="net.jeeshop.core.pay.fuiuo.client.util.StringUtils" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>提交到富友交易系统</title>
</head>
<script type="text/javascript">
function submitForm(){
	document.getElementById("form").submit();
}
</script>
<%
String xml ="";
try{
request.setCharacterEncoding("UTF-8");

String mchnt_cd = StringUtils.nvl(request.getParameter("mchnt_cd"));
String order_id = StringUtils.nvl(request.getParameter("order_id"));
String order_amt = StringUtils.nvl(request.getParameter("order_amt"));
String order_pay_type = StringUtils.nvl(request.getParameter("order_pay_type"));
String page_notify_url = StringUtils.nvl(request.getParameter("page_notify_url"));
String back_notify_url = StringUtils.nvl(request.getParameter("back_notify_url"));
String iss_ins_cd = StringUtils.nvl(request.getParameter("iss_ins_cd"));
String customs_flag = StringUtils.nvl(request.getParameter("customs_flag"));
String customs_code = StringUtils.nvl(request.getParameter("customs_code"));
String ic_name = StringUtils.nvl(request.getParameter("ic_name"));
String ic_number = StringUtils.nvl(request.getParameter("ic_number"));
String payer_ecommerce_id = StringUtils.nvl(request.getParameter("payer_ecommerce_id"));
String payer_tel = StringUtils.nvl(request.getParameter("payer_tel"));
String order_type = StringUtils.nvl(request.getParameter("order_type"));
String rem = StringUtils.nvl(request.getParameter("rem"));
String reserved1 = StringUtils.nvl(request.getParameter("reserved1"));
String reserved2 = StringUtils.nvl(request.getParameter("reserved2"));
String ver = StringUtils.nvl(request.getParameter("ver"));
String mchnt_key = StringUtils.nvl(request.getParameter("mchnt_key")); //32位的商户密钥

String signDataStr =
mchnt_cd + "|"+
order_id + "|"+
order_amt + "|"+
order_pay_type + "|"+
page_notify_url + "|"+
back_notify_url + "|"+
iss_ins_cd + "|" +
customs_flag + "|" +
customs_code + "|" +
ic_name + "|"+
ic_number + "|"+
payer_ecommerce_id + "|"+
payer_tel + "|"+
order_type + "|"+
rem + "|"+
reserved1 + "|"+
reserved2 + "|"+
ver + "|"+
mchnt_key;

                     
String md5 = MD5.MD5Encode(signDataStr);
System.out.println("signDataStr==="+signDataStr);
System.out.println("md5==="+md5);
%>

<body onload="javascript:submitForm();">
<form name="pay" method="post" action="http://www-1.fuiou.com:8888/wg1_run/PayBCGate.do" id = "form">
<input  value = '<%=md5%>' name="md5"/>
<input  value = '<%=mchnt_cd%>' name="mchnt_cd"/>
<input  value = '<%=order_id%>' name="order_id"/>
<input  value = '<%=order_amt%>' name="order_amt"/>
<input  value = '<%=order_pay_type%>' name="order_pay_type"/>
<input  value = '<%=page_notify_url%>' name="page_notify_url"/>
<input  value = '<%=back_notify_url%>' name="back_notify_url"/>
<input  value = '<%=iss_ins_cd%>' name="iss_ins_cd"/>
<input  value = '<%=customs_flag%>' name="customs_flag"/>
<input  value = '<%=customs_code%>' name="customs_code"/>
<input  value = '<%=ic_name%>' name="ic_name"/>
<input  value = '<%=ic_number%>' name="ic_number"/>
<input  value = '<%=payer_ecommerce_id%>' name="payer_ecommerce_id"/>
<input  value = '<%=payer_tel%>' name="payer_tel"/>
<input  value = '<%=order_type%>' name="order_type"/>
<input  value = '<%=rem%>' name="rem"/>
<input  value = '<%=reserved1%>' name="reserved1"/>
<input  value = '<%=reserved2%>' name="reserved2"/>
<input  value = '<%=ver%>' name="ver"/>
</form>
</body>
<%}catch(Exception e){
	e.printStackTrace();
	out.print(e.getMessage());
} %>
<body>
</body>
</html>