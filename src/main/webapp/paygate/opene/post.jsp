<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" import="com.smartpay.ops.client.SecurityUtil, com.smartpay.ops.client.TrxException, com.smartpay.ops.client.web.MerchantClient, com.smartpay.ops.client.*,org.apache.commons.httpclient.methods.PostMethod,org.apache.commons.httpclient.*" errorPage="" %>
<%@ page import="net.jeeshop.core.pay.opene.OpeneConfig" %>
<%@ page import="net.jeeshop.web.action.front.paygate.PayInfo" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="net.jeeshop.core.front.SystemManager" %>
<%@ page import="org.slf4j.Logger" %>
<%@ page import="org.slf4j.LoggerFactory" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta http-equiv="Content-Language" content="zh-CN"/>
	<meta http-equiv="Expires" CONTENT="0">
	<meta http-equiv="Cache-Control" CONTENT="no-cache">
	<meta http-equiv="Pragma" CONTENT="no-cache">
	<title>开联网上支付平台-商户接口范例-支付请求确认</title>
</head>

<%
	Logger logger = LoggerFactory.getLogger(OpeneConfig.class);
	request.setCharacterEncoding("UTF-8");
	PayInfo payInfo = (PayInfo)request.getAttribute("payInfo");


	//商户订单号，商户网站订单系统中唯一订单号，必填
	String out_trade_no = new String(payInfo.getWIDout_trade_no().getBytes("ISO-8859-1"),"UTF-8");

	//订单名称，必填
	String subject = payInfo.getWIDsubject();

	//付款金额，必填
	String total_fee = new String(String.valueOf((new BigDecimal(payInfo.getWIDprice()).
			add(new BigDecimal(payInfo.getLogistics_fee())).multiply(new BigDecimal(100)) .intValue())).getBytes("ISO-8859-1"), "UTF-8");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
	//商品描述，可空
	String body = payInfo.getWIDbody();
	String key= OpeneConfig.key;
	String version=OpeneConfig.version;
	String language=OpeneConfig.language;
	String inputCharset= OpeneConfig.inputcharset;
	String merchantId=OpeneConfig.merchantId;
	String pickupUrl= SystemManager.getInstance().getSystemSetting().getWww()+OpeneConfig.pickupUrl;
	String receiveUrl=SystemManager.getInstance().getSystemSetting().getWww()+OpeneConfig.receiveUrl;
	String payType=OpeneConfig.payType;
	String signType=OpeneConfig.signType;
	String orderNo=out_trade_no;
	//以分为单位
	String orderAmount=total_fee;
	String orderDatetime=sdf.format(new Date());
	String orderCurrency=OpeneConfig.orderCurrency;
//	String orderExpireDatetime=request.getParameter("orderExpireDatetime");
//	String payerTelephone=request.getParameter("payerTelephone");
//	String payerEmail=request.getParameter("payerEmail");
//	String payerName=request.getParameter("payerName");
	String productName=payInfo.getWIDsubject();
//	String productId=request.getParameter("productId");
//	String productNum=request.getParameter("productNum");
//	String productPrice=request.getParameter("productPrice");
//	String productDesc=request.getParameter("productDesc");
//	String ext1=request.getParameter("ext1");
//	String ext2= request.getParameter("ext2");
//	String extTL=request.getParameter("extTL");
//	String issuerId=request.getParameter("issuerId");

	String sign="";
	String error = "";
	String signSrc="";
	String serverUrl="";
	try {
		RequestOrder order = new RequestOrder();
//		order.setExtTL(extTL);
		order.setInputCharset(Integer.parseInt(inputCharset));
		order.setPickupUrl(pickupUrl);
		order.setReceiveUrl(receiveUrl);
		order.setVersion(version);
		order.setLanguage(Integer.parseInt(language));
		order.setSignType(Integer.parseInt(signType));
		order.setMerchantId(merchantId);
//		order.setPayerName(payerName);
//		order.setPayerEmail(payerEmail);
//		order.setPayerTelephone(payerTelephone);
		order.setOrderNo(orderNo);
		order.setOrderAmount(Long.parseLong(orderAmount));
		order.setOrderCurrency(orderCurrency);
		order.setOrderDatetime(orderDatetime);
//		order.setOrderExpireDatetime(orderExpireDatetime);
		order.setProductName(productName);
//		order.setProductPrice(Long.parseLong(productPrice));
//		order.setProductNum(Integer.parseInt(productNum));
//		order.setProductId(productId);
//		order.setProductDesc(productDesc);
//
//		order.setExt1(ext1);
//		order.setExt2(ext2);
		order.setPayType(Integer.parseInt(payType));
//		order.setIssuerId(issuerId);
		order.setKey(key);
		signSrc = new MerchantClient().generateSignSrc(order);
		logger.info("signSrc:"+signSrc);
		sign = new MerchantClient().sign(order);
		logger.info("sign:"+sign);
		serverUrl = OpeneConfig.serverUrl;
		logger.info("serverUrl:"+serverUrl);
	} catch (Exception e) {
		error = e.toString();
		logger.error(e.getMessage(),e);
	}

%>
<body  onload="javascript:submitForm();">
<form name="form2" action="<%=serverUrl%>" method="post" id="form">
	<input type="hidden" name="inputCharset" id="inputCharset" value="<%=inputCharset%>"/>
	<input type="hidden" name="inputCharset" value="<%=inputCharset%>"/>
	<input type="hidden" name="pickupUrl" value="<%=pickupUrl%>"/>
	<input type="hidden" name="receiveUrl" value="<%=receiveUrl%>" />
	<input type="hidden" name="version" value="<%=version %>"/>
	<input type="hidden" name="language" value="<%=language %>" />
	<input type="hidden" name="signType" value="<%=signType%>"/>
	<input type="hidden" name="merchantId" value="<%=merchantId%>" />
	<%--<input type="hidden" name="payerName" value="<%=payerName%>"/>--%>
	<%--<input type="hidden" name="payerEmail" value="<%=payerEmail%>" />--%>
	<%--<input type="hidden" name="payerTelephone" value="<%=payerTelephone %>" />--%>
	<input type="hidden" name="orderNo" value="<%=orderNo%>" />
	<input type="hidden" name="orderAmount" value="<%=orderAmount %>"/>
	<input type="hidden" name="orderCurrency" value="<%=orderCurrency%>" />
	<input type="hidden" name="orderDatetime" value="<%=orderDatetime%>" />
	<%--<input type="hidden" name="orderExpireDatetime" value="<%=orderExpireDatetime %>"/>--%>
	<input type="hidden" name="productName" value="<%=productName%>" />
	<%--<input type="hidden" name="productPrice" value="<%=productPrice%>" />--%>
	<%--<input type="hidden" name="productNum" value="<%=productNum %>"/>--%>
	<%--<input type="hidden" name="productId" value="<%=productId%>" />--%>
	<%--<input type="hidden" name="productDesc" value="<%=productDesc%>" />--%>
	<%--<input type="hidden" name="ext1" value="<%=ext1%>" />--%>
	<%--<input type="hidden" name="ext2" value="<%=ext2%>" />--%>
	<%--<input type="hidden" name="extTL" value="<%=extTL%>" />--%>
	<input type="hidden" name="payType" value="<%=payType%>" />
	<%--<input type="hidden" name="issuerId" value="<%=issuerId%>" />--%>
	<input type="hidden" name="signMsg" value="<%=sign %>" />
</form>
<script type="text/javascript">
	function submitForm() {
		document.getElementById("form").submit();
	}
</script>

</body>
</html>
