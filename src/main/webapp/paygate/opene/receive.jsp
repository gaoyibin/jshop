<%@ page contentType="text/html; charset=UTF-8" import="com.smartpay.ops.client.PaymentResult"%>
<%@ page import="net.jeeshop.core.pay.opene.OpeneConfig" %>
<%@ page import="org.springframework.web.context.WebApplicationContext" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@page import="net.jeeshop.services.front.order.OrderService"%>
<%@ page import="net.jeeshop.services.front.opene.OpeneService" %>
<%
	System.out.println("Server Receive Confirm...");
	request.setCharacterEncoding("UTF-8");
	String result = "";
	//String cert = "ops-test.cer"; //测试
	String cert = "/data/wwwroot/jshop/paygate/opene/ops-prod.cer";		 //生产
	String key = OpeneConfig.key;//根据实际情况修改
	System.out.println("receive cert " + cert);
	PaymentResult paymentResult = new PaymentResult();
	paymentResult.setMerchantId(request.getParameter("merchantId"));
	System.out.println("merchantId=" + request.getParameter("merchantId"));
	paymentResult.setVersion(request.getParameter("version"));
	System.out.println("version=" + request.getParameter("version"));
	paymentResult.setLanguage(request.getParameter("language"));
	System.out.println("language=" + request.getParameter("language"));
	paymentResult.setSignType(request.getParameter("signType"));
	System.out.println("signType=" + request.getParameter("signType"));
	paymentResult.setPayType(request.getParameter("payType"));
	System.out.println("payType=" + request.getParameter("payType"));
	paymentResult.setIssuerId(request.getParameter("issuerId"));
	System.out.println("issuerId=" + request.getParameter("issuerId"));
	paymentResult.setMchtOrderId(request.getParameter("mchtOrderId"));
	System.out.println("mchtOrderId=" + request.getParameter("mchtOrderId"));
	paymentResult.setOrderNo(request.getParameter("orderNo"));
	System.out.println("orderNo=" + request.getParameter("orderNo"));
	paymentResult.setOrderDatetime(request.getParameter("orderDatetime"));
	System.out.println("orderDatetime=" + request.getParameter("orderDatetime"));
	paymentResult.setOrderAmount(request.getParameter("orderAmount"));
	System.out.println("orderAmount=" + request.getParameter("orderAmount"));
	paymentResult.setPayDatetime(request.getParameter("payDatetime"));
	System.out.println("payDatetime=" + request.getParameter("payDatetime"));
	paymentResult.setExt1(request.getParameter("ext1"));
	System.out.println("ext1=" + request.getParameter("ext1"));
	paymentResult.setExt2(request.getParameter("ext2"));
	System.out.println("ext2=" + request.getParameter("ext2"));
	paymentResult.setPayResult(request.getParameter("payResult"));
	System.out.println("payResult=" + request.getParameter("payResult"));
	paymentResult.setKey(key);
	paymentResult.setSignMsg(request.getParameter("signMsg"));
	System.out.println("signMsg=" + request.getParameter("signMsg"));
	paymentResult.setCertPath(cert);

	boolean verifyResult = paymentResult.verify();
	System.out.println("receive verifyResult :====" + verifyResult);
	if (verifyResult) {

		if("1".equals(paymentResult.getPayResult())){//判断订单状态 1为支付成功
			//——请根据您的业务逻辑来编写程序

			out.println("买家已付款，等待卖家发货" + "<br />");
			//本系统的业务逻辑处理，把订单更新为已成功付款状态
			WebApplicationContext app = WebApplicationContextUtils
					.getWebApplicationContext(request.getSession()
							.getServletContext());
			OrderService orderService = (OrderService) app
					.getBean("orderServiceFront");
			OpeneService openeService = (OpeneService) app
					.getBean("openeService");
			if (orderService.openeNotify(paymentResult.getPayResult(), null,
					paymentResult.getOrderNo(), paymentResult.getMchtOrderId())) {
				out.println("修改订单状态为【已付款】成功" + "<br />");
				result = "支付成功！";
			} else {
				result = "订单支付异常，请联系客服！";
				out.println("修改订单状态为【已付款】失败！，请检查" + "<br />");
			}


			out.println("success"); //请不要修改或删除
		}
	} else {

		out.println("fail");
	}

%>