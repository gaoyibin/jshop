package net.jeeshop.services.front.opene.bean;

import com.alibaba.fastjson.JSON;
import net.jeeshop.services.front.opene.utils.HttpClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.security.MessageDigest;
import java.util.*;

/**
 * Created by gaoyibin on 2017/3/3.
 */
public class WithholdingOrder {

    private static final Logger LOGGER = LoggerFactory.getLogger(WithholdingOrder.class);
    public static String ENCODING="UTF-8"; //固定UTF-8


    /**
     * 海关报关交易发送并解析同步返回内容
     * @param data
     * @param requestUrl
     * @param ops_publicKeyCer
     * @return
     * @throws Exception
     */
    public Map<String, String> sendData(Map<String, String> data, String requestUrl,String md5key) throws Exception {
        LOGGER.info("requestUrl:"+requestUrl+"\nmd5key:"+md5key+"\ndata:"+ JSON.toJSONString(data));
        /**
         * 发送
         */
        HttpClient hc = new HttpClient(requestUrl, 30000, 30000);
        int status = hc.send(data, ENCODING);
        LOGGER.info("return status:"+status);
        if (200 == status) {
            String result=hc.getResult();
            LOGGER.info("return result:"+result);
            String msgContent=getResMsgContent(result);
            LOGGER.info("return msgContent:"+msgContent);
            String signMsg=getResSignMsg(result);
            LOGGER.info("return signMsg:"+signMsg);
            if (isEmpty(msgContent)) {
                LOGGER.info("msgContent is empty");
                throw new Exception("&#x8C03;&#x7528;&#x670D;&#x52A1;&#x5F02;&#x5E38;");//调用服务异常
            }
            Map<String, String> resmap = resToMap(result);
            //正常签名，异常不签名
            if ("0000".equals(resmap.get("retcode"))) {
                //验证签名
                if(!validate(msgContent,signMsg,md5key)){
                    LOGGER.info("return validate: sign failue");
                    throw new Exception("&#x9A8C;&#x8BC1;&#x8FD4;&#x56DE;&#x7B7E;&#x540D;&#x5931;&#x8D25;");//验证返回签名失败
                }
            }
            return resmap;
        }else{
            //调用服务异常
            LOGGER.info("&#x8C03;&#x7528;&#x670D;&#x52A1;&#x5F02;&#x5E38;，Http Response Code ["+status+"]");
            throw new Exception("&#x8C03;&#x7528;&#x670D;&#x52A1;&#x5F02;&#x5E38;，Http Response Code ["+status+"]");
        }
    }
    /**
     * 获取返回的签名
     * @return
     */
    public static String getResSignMsg(String result){
        String signMsg="";
        if (result!=null) {
            int index=result.indexOf("sign_msg=");
            if (index>-1) {
                signMsg=result.substring(index+9);
            }
        }
        return signMsg;
    }
    /**
     * 获取返回的内容
     * @return
     */
    public static String getResMsgContent(String result){
        String msgContent="";
        if (result!=null) {
            int index=result.indexOf("sign_msg=");
            if (index>0) {
                msgContent=result.substring(0,index-1);
            }else{
                msgContent=result;
            }
        }
        return msgContent;
    }
    /**
     * 根据反馈回来的信息，验证签名
     * @return
     * @throws Exception
     */
    public boolean validate(String msgContent,String signMsg, String md5key) throws Exception{
        if (md5key==null||md5key.length()==0) {
            System.out.println("md5key不能为空");
        }
        System.out.println("返回内容："+msgContent);
        System.out.println("返回签名："+signMsg);
        String md5Result=MD5Encode(msgContent+"&key="+md5key);
        return md5Result.equals(signMsg);
    }
    /**
     * 对请求参数进行签名
     * @param parameters
     * @param privateKeyPfx
     * @param password
     * @throws Exception
     */
    public void sign(Map<String,String> parameters,String key) throws Exception{
        if (key==null||key.length()==0) {
            System.out.println("md5key不能为空");
        }
        String src = createLinkString(paraFilter(parameters))+"&key="+key;
        String signMsg =MD5Encode(src);
        parameters.put("sign_msg", signMsg);
    }


    /**
     * 把数组所有元素排序，并按照“参数=参数值”的模式用“&”字符拼接成字符串
     * @param params 需要排序并参与字符拼接的参数组
     * @return 拼接后字符串
     */
    public static String createLinkString(Map<String, String> params) {
        List<String> keys = new ArrayList<String>(params.keySet());
        Collections.sort(keys);
        StringBuffer buffer=new StringBuffer();
        int size=keys.size();
        for (int i = 0; i < size; i++) {
            String key = keys.get(i);
            String value = params.get(key);
            if (i == size - 1) {//拼接时，不包括最后一个&字符
                buffer.append(key);
                buffer.append("=");
                buffer.append(value);
            } else {
                buffer.append(key);
                buffer.append("=");
                buffer.append(value);
                buffer.append("&");
            }
        }

        return buffer.toString();
    }
    /**
     * 除去数组中的空值和签名参数
     * @param sArray 签名参数组
     * @return 去掉空值与签名参数后的新签名参数组
     */
    public static Map<String, String> paraFilter(Map<String, String> sArray) {

        Map<String, String> result = new HashMap<String, String>();

        if (sArray == null || sArray.size() <= 0) {
            return result;
        }

        for (String key : sArray.keySet()) {
            String value = sArray.get(key);
            if (value == null || value.equals("") || key.equalsIgnoreCase("sign_msg")) {
                continue;
            }
            result.put(key, value);
        }

        return result;
    }

    public Map<String, String> resToMap(String resultString) throws UnsupportedEncodingException {
        Map<String, String> resData = new HashMap<String, String>();
        if (null != resultString && !"".equals(resultString)) {
            String str = URLDecoder.decode(resultString, "UTF-8");
            String[] parameters = str.split("&");
            for (int i = 0; i < parameters.length; i++) {
                String msg = parameters[i];
                int index = msg.indexOf('=');
                if (index > 0) {
                    String name = msg.substring(0, index);
                    String value = msg.substring(index + 1);
                    resData.put(name, value);
                }
            }
        }
        return resData;
    }

    public static boolean isEmpty(final String src) {
        if (null == src || "".equals(src)) {
            return true;
        }
        return false;
    }

    /**
     * 对数据做MD5摘要
     *
     * @param aData
     *            源数据
     * @return 摘要结果
     * @throws SecException
     * @author nilomiao
     * @since 2009-11-27
     */
    public static String MD5Encode(String aData) throws Exception {
        String resultString = null;
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            resultString = bytes2HexString(md.digest(aData.getBytes("UTF-8")));
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("MD5运算失败：" + e.getMessage());
            throw new Exception("MD5运算失败");
        }
        return resultString;
    }
    /**
     * Byte数组转十六进制字符串字节间不用空格分隔
     * @param b
     * @return
     */
    public static String bytes2HexString(byte[] b) {
        String ret = "";
        for (int i = 0; i < b.length; i++) {
            String hex = Integer.toHexString(b[i] & 0xFF);
            if (hex.length() == 1) {
                hex = '0' + hex;
            }
            ret += hex.toUpperCase();
        }
        return ret;
    }
}
