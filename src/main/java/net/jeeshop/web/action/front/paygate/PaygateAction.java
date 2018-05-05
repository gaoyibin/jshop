package net.jeeshop.web.action.front.paygate;

import net.jeeshop.core.front.SystemManager;
import net.jeeshop.services.common.Orderpay;
import net.jeeshop.services.common.Pay;
import net.jeeshop.services.front.order.OrderService;
import net.jeeshop.services.front.order.bean.Order;
import net.jeeshop.services.front.orderdetail.OrderdetailService;
import net.jeeshop.services.front.orderpay.OrderpayService;
import net.jeeshop.services.front.ordership.OrdershipService;
import net.jeeshop.services.front.ordership.bean.Ordership;
import net.jeeshop.web.util.RequestHolder;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * @author dylan
 * @date 16/2/18 22:58
 * Email: dinguangx@163.com
 */
@Controller("frontPaygateAction")
@RequestMapping("paygate")
public class PaygateAction {
    private Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired
    SystemManager systemManager;
    @Autowired
    private OrderService orderService;
    @Autowired
    private OrdershipService ordershipService;
    @Autowired
    private OrderpayService orderpayService;
    @RequestMapping("pay")
    public String pay(String orderId, String orderPayId,String icName,String icNumber,String payerTel,  ModelMap modelMap) {
        Order order = orderService.selectById(orderId);

        if(order == null) {
            throw new NullPointerException("根据订单号查询不到订单信息！");
        }

        Ordership ordership = ordershipService.selectOne(new Ordership(orderId));
        if(ordership==null){
            throw new NullPointerException("根据订单号查询不到配送信息！");
        }
        Orderpay orderpay = orderpayService.selectById(orderPayId);
        if(orderpay==null){
            throw new NullPointerException("根据订单号查询不到配送信息！");
        }
        order.setOrderpayID(orderPayId);
        PayInfo payInfo = createPayInfo(order, ordership);
        payInfo.setIc_name(StringUtils.isBlank(icName)?order.getIcName():icName);
        payInfo.setIc_number(StringUtils.isBlank(icNumber)?order.getIcNumber():icNumber);
        payInfo.setPayer_tel(StringUtils.isBlank(payerTel)?order.getPayerTel():payerTel);
//        RequestHolder.getRequest().setAttribute("payInfo", payInfo);
        modelMap.addAttribute("payInfo", payInfo);

        ///使用的网关
        String paygateType = systemManager.getProperty("paygate.type");
//        if("dummy".equalsIgnoreCase(paygateType)) {
//            return "paygate/dummy/pay";
//        }
        if(Pay.PAY_CODE_ALIPAY.equals(order.getPayType())){
            return "paygate/alipay/alipayapi";
        }else if(Pay.PAY_CODE_FUIOU.equals(order.getPayType())){
            return "paygate/fuiou/bc_send";
        }else if(Pay.PAY_CODE_OPENE.equals(order.getPayType())){
            return "paygate/opene/post";
        }
        return "paygate/dummy/pay";
    }
    /**
     * 创建支付宝的付款信息对象
     * @param order
     */
    private PayInfo createPayInfo(Order order,Ordership ordership) {
        if(order==null || ordership==null){
            throw new NullPointerException("参数不能为空！请求非法！");
        }

        PayInfo payInfo = new PayInfo();
        payInfo.setWIDseller_email(ordership.getPhone());
//		String debug = SystemManager.getInstance().get("system_debug");
        String www = SystemManager.getInstance().getSystemSetting().getWww();

        /**
         * 解决由于本地和线上正式环境提交相同的商户订单号导致支付宝出现TRADE_DATA_MATCH_ERROR错误的问题。
         * 本地提交的商户订单号前缀是test开头，正式环境提交的就是纯粹的支付订单号
         */
//        if(www.startsWith("http://127.0.0.1") || www.startsWith("http://localhost")){
//            payInfo.setWIDout_trade_no("test"+order.getOrderpayID());
//        }else{
            payInfo.setWIDout_trade_no(order.getOrderpayID());
//        }
        payInfo.setWIDsubject(order.getProductName());

        payInfo.setWIDprice(Double.valueOf(order.getPtotal()));
        payInfo.setWIDbody(order.getRemark());
//		payInfo.setShow_url(SystemManager.systemSetting.getWww()+"/product/"+payInfo.getWIDout_trade_no()+".html");
        payInfo.setShow_url(SystemManager.getInstance().getSystemSetting().getWww()+"/order/orderInfo.html?id="+order.getId());
        payInfo.setWIDreceive_name(ordership.getShipname());
        payInfo.setWIDreceive_address(ordership.getShipaddress());
        payInfo.setWIDreceive_zip(ordership.getZip());
        payInfo.setWIDreceive_phone(ordership.getTel());
        payInfo.setWIDreceive_mobile(ordership.getPhone());
        payInfo.setWIDsubject(order.getRemark());

        payInfo.setLogistics_fee(Double.valueOf(order.getFee()));
        payInfo.setLogistics_type(order.getExpressCode());

        logger.debug(payInfo.toString());
        return payInfo;
    }

    @RequestMapping("dummyPay")
    @ResponseBody
    public String dummyPay(String orderId){
        orderService.alipayNotify("WAIT_SELLER_SEND_GOODS",null,orderId,String.valueOf(System.nanoTime()));
        return "{\"success\":1}";
    }
}
