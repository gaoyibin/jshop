<%@page import="net.jeeshop.core.FrontContainer"%>
<%@page import="net.jeeshop.services.front.order.bean.Order"%>
<%@page import="net.jeeshop.services.front.order.OrderService"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="org.slf4j.*"%>
<%@page import="org.apache.commons.beanutils.BeanUtils" %>
<%@page import="net.jeeshop.core.pay.fuiuo.client.txn.NewOrderData" %>
<%@page import="net.jeeshop.core.pay.fuiuo.client.util.MD5" %>

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="net.jeeshop.core.pay.fuiuo.client.config.FuiouConfig" %>
<%

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
    String mchnt_cd = FuiouConfig.mchnt_cd;
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
    String mchnt_key = FuiouConfig.mchnt_key;
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
        //判断该笔订单是否在商户网站中已经做过处理
        //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
        //请务必判断请求时的total_fee、seller_id与通知时获取的total_fee、seller_id为一致的
        //如果有做过处理，不执行商户的业务程序

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
<%

      }else{
//        out.println("支付失败");
        result = order_pay_error;
          out.println(result);
      }

    }else{
//      out.println("验证失败");
      result = order_pay_error;
          out.println(result);
    }
    System.out.println("signDataStr===" + signDataStr);
    System.out.println("md5===" + md5);

  } catch (Exception e) {
    e.printStackTrace();
    out.print(e.getMessage());
  }
%>
