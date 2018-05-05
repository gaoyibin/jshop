<%@page import="net.jeeshop.core.FrontContainer"%>
<%@page import="net.jeeshop.services.front.order.bean.Order"%>
<%@page import="net.jeeshop.services.front.order.OrderService"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="org.slf4j.*"%>
<%@page import="org.apache.commons.beanutils.BeanUtils" %>
<%@page import="net.jeeshop.core.pay.fuiuo.client.txn.NewOrderData" %>
<%@page import="net.jeeshop.core.pay.fuiuo.client.util.MD5" %>

<%
  /* *
  功能：支付宝页面跳转同步通知页面
  版本：3.2
  日期：2011-03-17
  说明：
  以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
  该代码仅供学习和研究支付宝接口使用，只是提供一个参考。

  //***********页面功能说明***********
  该页面可在本机电脑测试
  可放入HTML等美化页面的代码、商户业务逻辑程序代码
  TRADE_FINISHED(表示交易已经成功结束，并不能再对该交易做后续操作);
  TRADE_SUCCESS(表示交易已经成功结束，可以对该交易做后续操作，如：分润、退款等);
  //********************************
   * */
%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Map"%>
<!DOCTYPE html>
<html class="no-js">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>富友支付页面跳转同步通知页面</title>
  <%@ include file="/resource/common_html_meat.jsp"%>
  <%@ include file="/resource/common_css.jsp"%>
</head>
<body>
<%
  /**
   * 需要再支付宝回调方法中 如果支付成功的话，则清空购物车。
   */
  request.getSession().setAttribute(FrontContainer.myCart, null);//清空购物车

  Logger logger = LoggerFactory.getLogger(OrderService.class);
  //获取富友GET过来反馈信息
  Map<String, String> params = new HashMap<String, String>();
  Map requestParams = request.getParameterMap();
  logger.error("同步通知request.getParameterMap()=" + requestParams);


  String xml = "";
  String result = null;
  try {
    request.setCharacterEncoding("UTF-8");
    //商户代码
    String mchnt_cd = net.jeeshop.core.pay.fuiuo.client.util.StringUtils.nvl(request.getParameter("mchnt_cd"));
    //商户订单号
    String order_id = net.jeeshop.core.pay.fuiuo.client.util.StringUtils.nvl(request.getParameter("order_id"));
    //交易金额
    String order_amt = net.jeeshop.core.pay.fuiuo.client.util.StringUtils.nvl(request.getParameter("order_amt"));
    //订单日期
    String order_date = net.jeeshop.core.pay.fuiuo.client.util.StringUtils.nvl(request.getParameter("order_date"));
    //订单状态
    //‘00’ – 订单已生成(初始状态) ‘01’ – 订单已撤消 ‘02’ – 订单已合并 ‘03’ – 订单已过期 ‘04’ – 订单已确认(等待支付) ‘05’ – 订单支付失败 ‘11’ – 订单已支付 ‘18’ – 已发货 ‘19’ – 已确认收货
    String order_st = net.jeeshop.core.pay.fuiuo.client.util.StringUtils.nvl(request.getParameter("order_st"));
    //错误代码 0000表示成功 其他失败
    String order_pay_code = net.jeeshop.core.pay.fuiuo.client.util.StringUtils.nvl(request.getParameter("order_pay_code"));
    //错误中文描述
    String order_pay_error = net.jeeshop.core.pay.fuiuo.client.util.StringUtils.nvl(request.getParameter("order_pay_error"));
    //是保留字段
    String resv1 = net.jeeshop.core.pay.fuiuo.client.util.StringUtils.nvl(request.getParameter("resv1"));
    //富友流水号
    String fy_ssn = net.jeeshop.core.pay.fuiuo.client.util.StringUtils.nvl(request.getParameter("fy_ssn"));
    //MD5摘要数据
    String md5 = net.jeeshop.core.pay.fuiuo.client.util.StringUtils.nvl(request.getParameter("md5"));
    String mchnt_key = "";
    String signDataStr =
            mchnt_cd + "|" + order_id + "|" + order_date + "|" + order_amt + "|" + order_st + "|" +
                    order_pay_code + "|" +
                    order_pay_error + "|" +
                    resv1 + "|" +
                    fy_ssn + "|" + mchnt_key;


    String md5Sign = MD5.MD5Encode(signDataStr);
    //签名校验通过
    if(net.jeeshop.core.pay.fuiuo.client.util.StringUtils.isNotEmpty(md5Sign) && md5Sign.equals(md5)){
      //请求成功
      if(net.jeeshop.core.pay.fuiuo.client.util.StringUtils.isNotEmpty(order_pay_code) && "0000".equals(order_pay_code)){
        out.println("买家已付款，等待卖家发货" + "<br />");
        //本系统的业务逻辑处理，把订单更新为已成功付款状态
        WebApplicationContext app = WebApplicationContextUtils
                .getWebApplicationContext(request.getSession()
                        .getServletContext());
        OrderService orderService = (OrderService) app
                .getBean("orderServiceFront");
        if (orderService.foiuoNotify(order_pay_code, null,
                order_id, fy_ssn)) {
          out.println("修改订单状态为【已付款】成功" + "<br />");
          result = "支付成功！";
        } else {
          result = "订单支付异常，请联系客服！";
          out.println("修改订单状态为【已付款】失败！，请检查" + "<br />");
        }

      }else{
        out.println("支付失败");
        result = order_pay_error;
      }

    }else{
      out.println("验证失败");
      result = order_pay_error;
    }
    System.out.println("signDataStr===" + signDataStr);
    System.out.println("md5===" + md5);
  } catch (Exception e) {
    e.printStackTrace();
    out.print(e.getMessage());
  }
  //session.setAttribute("pay_result", result);
  //转到首页
  response.sendRedirect(SystemManager.getInstance().getSystemSetting().getWww()+"/order/paySuccess.html");
  if(true){
    return;
  }
%>

<div class="container">
  <div class="row">
    <%=result%>
  </div>
</div>
</body>
</html>