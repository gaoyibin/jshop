package net.jeeshop.core.util;

/**
 * Created by Administrator on 2016/8/22.
 */
public class Utils {
    public static boolean isEmpty(String str){
        return null == str || "".equals(str.trim());
    }

    public static String getNoNullStr(String str){
        return isEmpty(str) ? "" : str;
    }
}
