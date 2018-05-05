package net.jeeshop.core.pay.opene;

import net.jeeshop.core.front.SystemManager;

/**
 * Created by gaoyibin on 2016/7/31.
 */
public class OpeneConfig {
    //商户号,数字串，商户在开联申请开户的商户号
    public static String merchantId = "";
    //计算签名的KEY值，在商户管理平台维护
    public static String key = "";
    //默认填1；1代表UTF-8、2代表GBK、3代表GB2312
    public static String inputcharset = "1";
    //客户的取货地址，需http://格式的完整路径，不能加?id=123这类自定义参数,支付成功跳转地址
    public static String pickupUrl = "/paygate/opene/pickup.jsp";
    //服务器接受支付结果的后台地址,交易结果后台通知地址需http://格式的完整路径，不能加?id=123这类自定义参数
    public static String receiveUrl ="/paygate/opene/receive.jsp";
    //网关接收支付请求接口版本,固定为v1.0
    public static String version ="v1.0";
    //网关页面显示语言种类,1代表简体中文、2代表繁体中文、3代表英文
    public static String language ="1";
    //签名类型,默认填1，固定选择值：0、1,0表示订单上送和交易结果通知都使用MD5进行签名,1表示商户用使用MD5算法验签上送订单，开联交易结果通知使用证书签名
    public static String signType ="1";
    //商户在海关备案的编号
    public static String mchtcustomscode = "S20151130171950";
    //商户海关备案名称
    public static String mchtcustomsname = new String("&#x62A5;&#x5173;&#x6D4B;&#x8BD5;&#x5546;&#x6237;");
    public static String idNo = "511702198807288390";
    public static String idname="&#x674E;&#x56DB;";
    //支付提交地址
//    public static String serverUrl ="http://opsweb.koolyun.cn/gateway/index.do?";//测试地址
    public static String serverUrl ="https://pg.openepay.com/gateway/index.do";//生产地址
    //报关地址
//    public static String payUrl ="http://opsweb.koolyun.cn/customs/mcht_customs_declare.do";//测试地址
    public static String payUrl ="https://customs.openepay.com/customs/mcht_customs_declare.do";

//    支付方式,用户在支付时可以使用的支付方式，固定选择值：0-代表全部，即显示该商户开通的所有支付方式
//    1-个人网银支付借记卡
//    4-企业网银
//    11-信用卡支付
//    20-微信扫码支付
//    22-支付宝扫码支付
//    31-银联认证支付
    public static String payType ="0";
    //订单金额币种类型	156代表人民币、840代表美元、344代表港币
    public static String  orderCurrency ="156";

    public static String  customsType = "00002006";

    //计算签名的KEY值，海关报关key
    public static String CustomsDeclareKey = "cvdsGErt5erygdfdhyu8u5rtdHLIUt45";


}
