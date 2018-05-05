package net.jeeshop.core.pay.fuiuo.client.txn;

import java.io.IOException;
import java.io.PrintStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpClientParams;

public class HttpPoster
{
    private String responseString = "";

    public String post(String url, Map parameters)
            throws IOException
    {
        int responseStatCode = 0;
        HttpClient httpclient = new HttpClient();
        httpclient.setConnectionTimeout(30000);
        PostMethod xmlpost = new PostMethod(url);
        httpclient.getParams().setParameter(
                "http.protocol.content-charset", "UTF-8");
        try
        {
            NameValuePair[] nameValuePairs = new NameValuePair[parameters.size()];
            Iterator keyIterator = parameters.keySet().iterator();
            int i = 0;
            while (keyIterator.hasNext())
            {
                Object key = keyIterator.next();
                String value = (String)parameters.get(key);
                NameValuePair name = new NameValuePair((String)key, value);
                nameValuePairs[i] = name;
                i++;
            }

            xmlpost.setRequestBody(nameValuePairs);
            responseStatCode = httpclient.executeMethod(xmlpost);
            this.responseString = xmlpost.getResponseBodyAsString();
        }
        catch (IOException ex2) {
            System.out.println("报文发送到[" + url + "]失败:" + ex2.getMessage());
            throw ex2;
        }
        System.out.println("HTTP返回码=" + responseStatCode);
        System.out.println("应答数据=" + this.responseString);
        return this.responseString;
    }

    public String getResponseString()
    {
        return this.responseString;
    }
    public static void main(String[] args) {
        Map map = new HashMap();
        map.put("ResMessage", "魏晓敏");
        HttpPoster poster = new HttpPoster();
        try {
            System.out.println(poster.post("http://localhost:8080/paytest/1.jsp", map));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
