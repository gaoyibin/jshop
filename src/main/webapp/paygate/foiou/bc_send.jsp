<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="org.apache.commons.beanutils.BeanUtils" %>
<%@page import="net.jeeshop.core.pay.fuiuo.client.txn.NewOrderData" %>
<%@page import="net.jeeshop.core.pay.fuiuo.client.util.MD5" %>
<%@page import="net.jeeshop.core.pay.fuiuo.client.util.StringUtils" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>提交到富友交易系统</title>
</head>
<script type="text/javascript">
    function submitForm() {
        document.getElementById("form").submit();
    }
</script>
<%
    String xml = "";
    try {
        request.setCharacterEncoding("UTF-8");
        //商户代码
        String mchnt_cd = StringUtils.nvl(request.getParameter("mchnt_cd"));
        //商户订单号
        String order_id = StringUtils.nvl(request.getParameter("order_id"));
        //交易金额
        String order_amt = StringUtils.nvl(request.getParameter("order_amt"));
        //支付类型
        String order_pay_type = StringUtils.nvl(request.getParameter("order_pay_type"));
        //页面跳转URL
        String page_notify_url = StringUtils.nvl(request.getParameter("page_notify_url"));
        //后台通知URL
        String back_notify_url = StringUtils.nvl(request.getParameter("back_notify_url"));
        //银行代码
        String iss_ins_cd = StringUtils.nvl(request.getParameter("iss_ins_cd"));
        //是否报关
        String customs_flag = StringUtils.nvl(request.getParameter("customs_flag"));
        //通关口岸
        String customs_code = StringUtils.nvl(request.getParameter("customs_code"));
        //付款人姓名
        String ic_name = StringUtils.nvl(request.getParameter("ic_name"));
        //付款人身份证
        String ic_number = StringUtils.nvl(request.getParameter("ic_number"));
        //付款人电商平台ID
        String payer_ecommerce_id = StringUtils.nvl(request.getParameter("payer_ecommerce_id"));
        //付款人电话
        String payer_tel = StringUtils.nvl(request.getParameter("payer_tel"));
        //业务类型
        String order_type = StringUtils.nvl(request.getParameter("order_type"));
        //备注
        String rem = StringUtils.nvl(request.getParameter("rem"));
        //预留字段1
        String reserved1 = StringUtils.nvl(request.getParameter("reserved1"));
        //预留字段2
        String reserved2 = StringUtils.nvl(request.getParameter("reserved2"));
        //版本号
        String ver = StringUtils.nvl(request.getParameter("ver"));
        //交易金额
        String mchnt_key = StringUtils.nvl(request.getParameter("mchnt_key")); //32位的商户密钥

        String signDataStr =
                mchnt_cd + "|" +
                        order_id + "|" +
                        order_amt + "|" +
                        order_pay_type + "|" +
                        page_notify_url + "|" +
                        back_notify_url + "|" +
                        iss_ins_cd + "|" +
                        customs_flag + "|" +
                        customs_code + "|" +
                        ic_name + "|" +
                        ic_number + "|" +
                        payer_ecommerce_id + "|" +
                        payer_tel + "|" +
                        order_type + "|" +
                        rem + "|" +
                        reserved1 + "|" +
                        reserved2 + "|" +
                        ver + "|" +
                        mchnt_key;


        String md5 = MD5.MD5Encode(signDataStr);
        System.out.println("signDataStr===" + signDataStr);
        System.out.println("md5===" + md5);
%>

<body onload="javascript:submitForm();">
<form name="pay" method="post" action="http://www-1.fuiou.com:8888/wg1_run/PayBCGate.do" id="form">
    <input value='<%=md5%>' name="md5"/>
    <input value='<%=mchnt_cd%>' name="mchnt_cd"/>
    <input value='<%=order_id%>' name="order_id"/>
    <input value='<%=order_amt%>' name="order_amt"/>
    <input value='<%=order_pay_type%>' name="order_pay_type"/>
    <input value='<%=page_notify_url%>' name="page_notify_url"/>
    <input value='<%=back_notify_url%>' name="back_notify_url"/>
    <input value='<%=iss_ins_cd%>' name="iss_ins_cd"/>
    <input value='<%=customs_flag%>' name="customs_flag"/>
    <input value='<%=customs_code%>' name="customs_code"/>
    <input value='<%=ic_name%>' name="ic_name"/>
    <input value='<%=ic_number%>' name="ic_number"/>
    <input value='<%=payer_ecommerce_id%>' name="payer_ecommerce_id"/>
    <input value='<%=payer_tel%>' name="payer_tel"/>
    <input value='<%=order_type%>' name="order_type"/>
    <input value='<%=rem%>' name="rem"/>
    <input value='<%=reserved1%>' name="reserved1"/>
    <input value='<%=reserved2%>' name="reserved2"/>
    <input value='<%=ver%>' name="ver"/>
</form>
</body>
<%
    } catch (Exception e) {
        e.printStackTrace();
        out.print(e.getMessage());
    }
%>
<body>
</body>
</html>