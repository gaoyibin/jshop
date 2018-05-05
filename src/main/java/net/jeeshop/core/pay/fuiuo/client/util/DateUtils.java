package net.jeeshop.core.pay.fuiuo.client.util;

import java.io.PrintStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

public class DateUtils
{
    public static String getCurrentDate(String aFormat)
    {
        String tDate = new SimpleDateFormat(aFormat).format(new Date(System.currentTimeMillis()));
        return tDate;
    }

    public static String getCurrentDate() {
        return getCurrentDate("yyyyMMdd");
    }
    public static String getCurrentTime() {
        return getCurrentDate("HHmmss");
    }
    public static String getCurrentDateAndTime() {
        return getCurrentDate("yyyyMMddHHmmss");
    }

    public static String getNewRandomCode(int codeLen)
    {
        Random randomCode = new Random();
        String strCode = "";
        while (codeLen > 0) {
            int charCode = randomCode.nextInt(9);
            strCode = strCode + charCode;
            codeLen--;
        }
        return strCode;
    }

    public static void main(String[] args)
    {
        System.out.println(getNewRandomCode(20));
    }
}
