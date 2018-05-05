package net.jeeshop.web.action.manage.order;

import net.jeeshop.core.pay.opene.OpeneConfig;

import java.math.BigDecimal;

/**
 * Created by gaoyibin on 2017/3/4.
 */
public class OrderCustomsDeclare {

    private String sign_type="0"; //固定；0代表MD5
    private String service_version="1.0";//固定 1.0
    private String input_charset="UTF-8";
    private String request_id; //请求流水
    private String mcht_id=OpeneConfig.merchantId; //商户在开联通申请开户的商户号
    private String mcht_customs_code=OpeneConfig.mchtcustomscode;//商户在海关备案的编号
    private String mcht_customs_name = OpeneConfig.mchtcustomsname; //商户海关备案名称
    private String openepay_no;//开联通系统支付流水号
    private String sub_order_no;//商户报关商品订单号
    private String sub_order_time;
    private String currency=OpeneConfig.orderCurrency; //币种,暂只支持156(人民币
    private String amount; //订单金额，以分为单位，不拆单时为原订单金额，拆单时为子订单金额且不能超过原订单金额order_fee=transport_fee+product_fee+tax_fee
//        private String transport_amt",orderpay.get; //物流费用，以分为单位，不拆单时为原订单物流费用，拆单时为子订单订单物流费用
//        private String product_amt="9000";//商品费用，以分为单位，不拆单时为原订单商品费用，拆单时为子订单订单商品费用
//        private String tax_amt="0";//关税，以分为单位
//        private String insured_amt="0";//保险费，以分为单位
    private String customs_type=OpeneConfig.customsType;//海关
    private String id_type="01"; //证件类型,暂只支持01身份证
    private String id_no=OpeneConfig.idNo; //证件号
    private String id_name=OpeneConfig.idname; //姓名


    public String getSign_type() {
        return sign_type;
    }

    public void setSign_type(String sign_type) {
        this.sign_type = sign_type;
    }

    public String getService_version() {
        return service_version;
    }

    public void setService_version(String service_version) {
        this.service_version = service_version;
    }

    public String getInput_charset() {
        return input_charset;
    }

    public void setInput_charset(String input_charset) {
        this.input_charset = input_charset;
    }

    public String getRequest_id() {
        return request_id;
    }

    public void setRequest_id(String request_id) {
        this.request_id = request_id;
    }

    public String getMcht_id() {
        return mcht_id;
    }

    public void setMcht_id(String mcht_id) {
        this.mcht_id = mcht_id;
    }

    public String getMcht_customs_code() {
        return mcht_customs_code;
    }

    public void setMcht_customs_code(String mcht_customs_code) {
        this.mcht_customs_code = mcht_customs_code;
    }

    public String getMcht_customs_name() {
        return mcht_customs_name;
    }

    public void setMcht_customs_name(String mcht_customs_name) {
        this.mcht_customs_name = mcht_customs_name;
    }

    public String getOpenepay_no() {
        return openepay_no;
    }

    public void setOpenepay_no(String openepay_no) {
        this.openepay_no = openepay_no;
    }

    public String getSub_order_no() {
        return sub_order_no;
    }

    public void setSub_order_no(String sub_order_no) {
        this.sub_order_no = sub_order_no;
    }

    public String getSub_order_time() {
        return sub_order_time;
    }

    public void setSub_order_time(String sub_order_time) {
        this.sub_order_time = sub_order_time;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getCustoms_type() {
        return customs_type;
    }

    public void setCustoms_type(String customs_type) {
        this.customs_type = customs_type;
    }

    public String getId_type() {
        return id_type;
    }

    public void setId_type(String id_type) {
        this.id_type = id_type;
    }

    public String getId_no() {
        return id_no;
    }

    public void setId_no(String id_no) {
        this.id_no = id_no;
    }

    public String getId_name() {
        return id_name;
    }

    public void setId_name(String id_name) {
        this.id_name = id_name;
    }
}
