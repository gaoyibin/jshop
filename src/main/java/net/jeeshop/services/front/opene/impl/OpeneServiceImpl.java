package net.jeeshop.services.front.opene.impl;

import net.jeeshop.core.pay.opene.OpeneConfig;
import net.jeeshop.services.front.opene.OpeneService;
import net.jeeshop.services.front.opene.bean.WithholdingOrder;
import net.jeeshop.services.front.opene.utils.LogUtil;
import net.jeeshop.services.front.orderpay.bean.Orderpay;
import net.jeeshop.services.front.orderpay.dao.OrderpayDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by gaoyibin on 2017/3/3.
 */
@Service("openeService")
public class OpeneServiceImpl implements OpeneService {

    @Autowired
    private OrderpayDao orderpayDao;

    @Override
    public void customsDeclare(String no, String orderNo) {
        Orderpay orderpay = orderpayDao.selectById(no);
        if(orderpay==null){
            throw new NullPointerException("根据支付记录号查询不到支付记录信息！");
        }
        String dateTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        Map<String,String> parameters = new HashMap<String,String>();
        parameters.put("sign_type", "0"); //固定；0代表MD5
        parameters.put("service_version", "1.0");//固定 1.0
        parameters.put("input_charset", "UTF-8");
        parameters.put("request_id", no); //请求流水
        parameters.put("mcht_id", OpeneConfig.merchantId); //商户在开联通申请开户的商户号
        parameters.put("mcht_customs_code", OpeneConfig.mchtcustomscode);//商户在海关备案的编号
        parameters.put("mcht_customs_name",OpeneConfig.mchtcustomsname); //商户海关备案名称
        parameters.put("openepay_no",orderNo);//开联通系统支付流水号
        parameters.put("sub_order_no",no);//商户报关商品订单号
        parameters.put("sub_order_time",dateTime);
        parameters.put("currency", OpeneConfig.orderCurrency); //币种,暂只支持156(人民币)
        parameters.put("amount", new BigDecimal(orderpay.getPayamount()).multiply(new BigDecimal(100)).intValue()+""); //订单金额，以分为单位，不拆单时为原订单金额，拆单时为子订单金额且不能超过原订单金额order_fee=transport_fee+product_fee+tax_fee
//        parameters.put("transport_amt",orderpay.get); //物流费用，以分为单位，不拆单时为原订单物流费用，拆单时为子订单订单物流费用
//        parameters.put("product_amt", "9000");//商品费用，以分为单位，不拆单时为原订单商品费用，拆单时为子订单订单商品费用
//        parameters.put("tax_amt", "0");//关税，以分为单位
//        parameters.put("insured_amt", "0");//保险费，以分为单位
        parameters.put("customs_type", "00000000");//海关
        parameters.put("id_type", "01"); //证件类型,暂只支持01身份证
        parameters.put("id_no", OpeneConfig.idNo); //证件号
        parameters.put("id_name", OpeneConfig.idname); //姓名
//        parameters.put("business_type", "I10"); //业务类型,I20:保税进口 ,I10：直邮进口 如果不填，默认为I20, 保税进口
//        parameters.put("notify_url", receiveUrl);
//        parameters.put("is_split", "Y");
        WithholdingOrder order = new WithholdingOrder();

        Map<String,String> receive = null;
        try{
            order.sign(parameters, OpeneConfig.key);
            receive = order.sendData(parameters, OpeneConfig.payUrl,OpeneConfig.key);
            String retcode = receive.get("retcode");
            String retmsg=receive.get("retmsg");
            LogUtil.writeLog("返回码：" + retcode + ",消息：" + retmsg);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
