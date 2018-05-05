package net.jeeshop.core.pay.fuiuo.client.util;

import java.util.List;

public class StringUtils
{
    public static boolean isNotEmpty(String aStr)
    {
        return (aStr != null) && (aStr.length() > 0);
    }

    public static boolean isEmpty(String aStr)
    {
        return (aStr == null) || (aStr.trim().length() == 0);
    }

    public static boolean isNumeric(String aStr)
    {
        if ((aStr == null) || (aStr.trim().length() == 0)) {
            return false;
        }
        int tSz = aStr.length();
        for (int i = 0; i < tSz; i++) {
            if (!Character.isDigit(aStr.charAt(i))) {
                return false;
            }
        }
        return true;
    }

    public static boolean isLetter(String aStr)
    {
        if ((aStr == null) || (aStr.getBytes().length == 0)) {
            return false;
        }
        int tSz = aStr.getBytes().length;
        for (int i = 0; i < tSz; i++) {
            if (!Character.isLetter(aStr.charAt(i))) {
                return false;
            }
        }
        return true;
    }

    public static boolean isLetterOrNumeric(String aStr)
    {
        if ((aStr == null) || (aStr.getBytes().length == 0)) {
            return false;
        }
        int tSz = aStr.getBytes().length;
        for (int i = 0; i < tSz; i++) {
            if (!Character.isLetterOrDigit(aStr.charAt(i))) {
                return false;
            }
        }
        return true;
    }

    public static String leftPadWithZero(String aStr, int aSize)
    {
        return leftPad(aStr, aSize, "0");
    }

    public static String leftPad(String aStr, int aSize, String aDelim)
    {
        aSize = (aSize - aStr.length()) / aDelim.length();
        if (aSize > 0)
        {
            aStr = repeat(aDelim, aSize) + aStr;
        }
        return aStr;
    }

    public static String repeat(String aStr, int aRepeat)
    {
        StringBuffer tBuffer = new StringBuffer(aRepeat * aStr.length());
        for (int i = 0; i < aRepeat; i++)
        {
            tBuffer.append(aStr);
        }
        return tBuffer.toString();
    }

    public static String rightPad(String aStr, int aSize, String aDelim)
    {
        aSize = (aSize - aStr.length()) / aDelim.length();
        if (aSize > 0)
        {
            aStr = aStr + repeat(aDelim, aSize);
        }
        return aStr;
    }

    public static String rightPadWithSpace(String aStr, int aSize) {
        return rightPad(aStr, aSize, " ");
    }
    public static String delZeroFromLeft(String src) {
        StringBuffer sb = new StringBuffer(src);
        for (int i = 0; i < sb.length(); i++) {
            if (sb.charAt(0) == '0')
                sb.deleteCharAt(0);
            else
                return sb.toString();
        }
        return sb.toString();
    }
    public static boolean isContain(String str, List list) {
        if ((list == null) || (list.size() < 1) || (str == null) || ("".equals(str)))
            return false;
        for (int i = 0; i < list.size(); i++) {
            if (str.equals(list.get(i)))
                return true;
        }
        return false;
    }
    public static String formatAmt(String str) {
        if ((str == null) || ("".equals(str)))
            return "0.00";
        if (str.length() == 1)
            return "0.0" + str;
        if (str.length() == 2) {
            return "0." + str;
        }
        return str.substring(0, str.length() - 2) + "." + str.substring(str.length() - 2);
    }

    public static String nvl(String aStr) {
        if (aStr == null) {
            return "";
        }
        return aStr;
    }
}