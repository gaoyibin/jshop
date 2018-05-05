<%@ page contentType="text/html; charset=UTF-8" import="com.smartpay.ops.client.PaymentResult"%>
<%@ page import="net.jeeshop.core.pay.opene.OpeneConfig" %>
<%@ page import="org.springframework.web.context.WebApplicationContext" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@page import="net.jeeshop.services.front.order.OrderService"%>
<%@ page import="net.jeeshop.core.front.SystemManager" %>
<%@ page import="net.jeeshop.services.front.opene.OpeneService" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta http-equiv="Content-Language" content="zh-CN"/>
	<meta http-equiv="Expires" CONTENT="0">
	<meta http-equiv="Cache-Control" CONTENT="no-cache">
	<meta http-equiv="Pragma" CONTENT="no-cache">
	<link href="css.css" rel="stylesheet" type="text/css">
	<title>开联网上支付平台-商户接口范例-支付请求确认</title>
</head>
<%
	String result = "";
	request.setCharacterEncoding("UTF-8");
	//String cert = "ops-test.cer"; //测试
	String cert  = "/data/wwwroot/jshop/paygate/opene/ops-prod.cer";		 //生产
	System.out.println("pickup cert " + cert);
	String key = OpeneConfig.key;//根据实际情况修改
	PaymentResult paymentResult = new PaymentResult();
	paymentResult.setMerchantId(request.getParameter("merchantId"));
	paymentResult.setVersion(request.getParameter("version"));
	paymentResult.setLanguage(request.getParameter("language"));
	paymentResult.setSignType(request.getParameter("signType"));
	paymentResult.setPayType(request.getParameter("payType"));
	paymentResult.setIssuerId(request.getParameter("issuerId"));
	paymentResult.setMchtOrderId(request.getParameter("mchtOrderId"));
	paymentResult.setOrderNo(request.getParameter("orderNo"));
	paymentResult.setOrderDatetime(request.getParameter("orderDatetime"));
	paymentResult.setOrderAmount(request.getParameter("orderAmount"));
	paymentResult.setPayDatetime(request.getParameter("payDatetime"));
	paymentResult.setExt1(request.getParameter("ext1"));
	paymentResult.setExt2(request.getParameter("ext2"));
	paymentResult.setPayResult(request.getParameter("payResult"));
	paymentResult.setKey(key);
	paymentResult.setSignMsg(request.getParameter("signMsg"));
	paymentResult.setCertPath(cert);

	boolean verifyResult = paymentResult.verify();
	System.out.println("pickup verifyResult :====" + verifyResult);
	if (verifyResult) {
		result = " 验证签名成功";
	} else {
		result = " 验证签名失败";
	}
	String payResult = request.getParameter("payResult");
	if (null != payResult && payResult.equals("1")){
		result += "--支付成功";
		out.println("买家已付款，等待卖家发货" + "<br />");
		//本系统的业务逻辑处理，把订单更新为已成功付款状态
		WebApplicationContext app = WebApplicationContextUtils
				.getWebApplicationContext(request.getSession()
						.getServletContext());
		OrderService orderService = (OrderService) app
				.getBean("orderServiceFront");
		if (orderService.openeNotify(paymentResult.getPayResult(), null,
				paymentResult.getOrderNo(), paymentResult.getMchtOrderId())) {
			out.println("修改订单状态为【已付款】成功" + "<br />");
			result = "支付成功！";
			response.sendRedirect(SystemManager.getInstance().getSystemSetting().getWww()+"/order/paySuccess.html");
		} else {
			result = "订单支付异常，请联系客服！";
			out.println("修改订单状态为【已付款】失败！，请检查" + "<br />");
		}
	} else if (null == result){
		result += "--支付结果未知";
	}

%>
<div class="container">
	<div class="row">
		<%=result%>
	</div>
</div>
<BODY>
<%--<table width="100%" cellpadding="0">--%>
	<%--<tr bgcolor="eeeeee">--%>
		<%--<td align="right"><strong>商户号：</strong></td>--%>
		<%--<td><%=request.getParameter("merchantId") %></td>--%>
	<%--</tr>--%>
	<%--<tr>--%>
		<%--<td align="right"><strong>订单号：</strong></td>--%>
		<%--<td><%=request.getParameter("orderNo") %></td>--%>
	<%--</tr>--%>
	<%--<tr>--%>
		<%--<td align="right"><strong>订单时间：</strong></td>--%>
		<%--<td><%=request.getParameter("orderDatetime") %></td>--%>
	<%--</tr>--%>

	<%--<tr bgcolor="eeeeee">--%>
		<%--<td align="right"><strong>支付结果：</strong></td>--%>
		<%--<td><strong><b><%=result %></b></strong></td>--%>
	<%--</tr>--%>
	<%--<tr>--%>
		<%--<td align="right"><strong>支付金额：</strong></td>--%>
		<%--<td><%=request.getParameter("orderAmount") %></td>--%>
	<%--</tr>--%>
	<%--<tr>--%>
		<%--<td align="right"><strong>支付时间：</strong></td>--%>
		<%--<td><%=request.getParameter("payDatetime") %></td>--%>
	<%--</tr>--%>
	<%--<tr>--%>
		<%--<td align="right"><strong>公钥证书：</strong></td>--%>
		<%--<td><%=cert%></td>--%>
	<%--</tr>--%>
<%--</table>--%>
</BODY>
</HTML>
