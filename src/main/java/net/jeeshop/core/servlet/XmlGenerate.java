package net.jeeshop.core.servlet;

import net.jeeshop.core.ceb.build.BuildOrderXML;
import net.jeeshop.core.util.FileUtils;
import net.jeeshop.core.util.Path;
import net.jeeshop.core.util.Utils;
import net.jeeshop.services.manage.order.impl.OrderServiceImpl;
import net.jeeshop.services.manage.orderdetail.bean.Orderdetail;
import net.jeeshop.services.manage.orderdetail.impl.OrderdetailServiceImpl;
import net.sf.json.JSONObject;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.XMLWriter;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

/**
 * jQuery文件上传插件
 * @author Administrator
 *
 */
public class XmlGenerate extends HttpServlet{
    private static final long serialVersionUID = 1L;
    SimpleDateFormat sdfFolder = new SimpleDateFormat("yyyyMMdd");
    /**
     * 实现多文件的同时上传 
     */
    public void doGet(HttpServletRequest request,
                      HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");
        ApplicationContext ctx = WebApplicationContextUtils.getRequiredWebApplicationContext(this.getServletContext());
        OrderdetailServiceImpl orderdetailService =  (OrderdetailServiceImpl)ctx.getBean("orderdetailServiceManage");
        Document document = DocumentHelper.createDocument();
        String fileName = null;
        if("ceb311".equals(type)){
            fileName = "CEB311_"+request.getParameter("orderNo")+".xml";
            BuildOrderXML.buildCEB311Message(request, orderdetailService);
        }else if("ceb621".equals(type)){
            fileName = "CEB621_"+request.getParameter("orderNo")+".xml";
            BuildOrderXML.buildCEB621Message(request, orderdetailService);
        }else if("ceb623".equals(type)){
            fileName = "CEB623_"+request.getParameter("orderNo")+".xml";
            BuildOrderXML.buildCEB623Message(request, orderdetailService);
        }else{
            String cbeCode = request.getParameter("cbeCode");
            String cbeName = request.getParameter("cbeName");
            String ecpCode = request.getParameter("ecpCode");
            String ecpName = request.getParameter("ecpName");
            String orderNo = request.getParameter("orderNo");
            String charge = request.getParameter("charge");
            String goodsValue = request.getParameter("goodsValue");
            String freight = request.getParameter("freight");
            String other = request.getParameter("other");
            String tax = request.getParameter("tax");
            String customer = request.getParameter("customer");
            String shipper = request.getParameter("shipper");
            String shipperAddress = request.getParameter("shipperAddress");
            String shipperTelephone = request.getParameter("shipperTelephone");
            String shipperCountry = request.getParameter("shipperCountry");
            String consignee = request.getParameter("consignee");
            String consigneeAddress = request.getParameter("consigneeAddress");
            String consigneeTelephone = request.getParameter("consigneeTelephone");
            String consigneeCountry = request.getParameter("consigneeCountry");
            String idType = request.getParameter("idType");
            String customerId = request.getParameter("customerId");
            String ieType = request.getParameter("ieType");
            String batchNumbers = request.getParameter("batchNumbers");
            String totalLogisticsNo = request.getParameter("totalLogisticsNo");
            String tradeCountry = request.getParameter("tradeCountry");
            String agentCode = request.getParameter("agentCode");
            String agentName = request.getParameter("agentName");
            String wrapType = request.getParameter("wrapType");
            String modifyMark = request.getParameter("modifyMark");
            String Note = request.getParameter("Note");
            String paymentCode = request.getParameter("paymentCode");
            String paymentName = request.getParameter("paymentName");
            String paymentType = request.getParameter("paymentType");
            String paymentNo = request.getParameter("paymentNo");
            String logisticsCode = request.getParameter("logisticsCode");
            String logisticsName = request.getParameter("logisticsName");
            String logisticsNo = request.getParameter("logisticsNo");
            String trackNo = request.getParameter("trackNo");

            document.setXMLEncoding("gb2312");
            Element root = document.addElement("Order");
            Element cebOrderHead = root.addElement("OrderHead");
            cebOrderHead.addElement("cbeCode").setText(cbeCode);
            cebOrderHead.addElement("cbeName").setText(cbeName);
            cebOrderHead.addElement("ecpCode").setText(ecpCode);
            cebOrderHead.addElement("ecpName").setText(ecpName);
            cebOrderHead.addElement("orderNo").setText(orderNo);
            cebOrderHead.addElement("charge").setText(charge);
            cebOrderHead.addElement("goodsValue").setText(goodsValue);
            cebOrderHead.addElement("freight").setText(freight);
            cebOrderHead.addElement("other").setText(other);
            cebOrderHead.addElement("tax").setText(tax);
            cebOrderHead.addElement("customer").setText(customer);;
            cebOrderHead.addElement("shipper").setText(shipper);
            cebOrderHead.addElement("shipperAddress").setText(shipperAddress);
            cebOrderHead.addElement("shipperTelephone").setText(shipperTelephone);
            cebOrderHead.addElement("shipperCountry").setText(shipperCountry);
            cebOrderHead.addElement("consignee").setText(consignee);
            cebOrderHead.addElement("consigneeAddress").setText(consigneeAddress);
            cebOrderHead.addElement("consigneeTelephone").setText(consigneeTelephone);
            cebOrderHead.addElement("consigneeCountry").setText(consigneeCountry);
            cebOrderHead.addElement("idType").setText(idType);
            cebOrderHead.addElement("customerId").setText(customerId);
            cebOrderHead.addElement("ieType").setText(ieType);
            cebOrderHead.addElement("batchNumbers").setText(batchNumbers);
            cebOrderHead.addElement("totalLogisticsNo").setText(totalLogisticsNo);
            cebOrderHead.addElement("tradeCountry").setText(tradeCountry);
            cebOrderHead.addElement("agentCode").setText(agentCode);
            cebOrderHead.addElement("agentName").setText(agentName);
            cebOrderHead.addElement("wrapType").setText(wrapType);
            cebOrderHead.addElement("modifyMark").setText(modifyMark);
            cebOrderHead.addElement("Note").setText(Note);

            Orderdetail orderdetail = new Orderdetail();
            orderdetail.setOrderID(Integer.valueOf(orderNo));
            List<Orderdetail> orderdetailList = orderdetailService.selectList(orderdetail);
            if(null != orderdetailList){
                int index = 1;
                for(Orderdetail od : orderdetailList){
                    String itemNo = request.getParameter("itemNo"+index);
                    String goodsNo = request.getParameter("goodsNo"+index);
                    String describe = request.getParameter("describe"+index);
                    String codeTs = request.getParameter("codeTs"+index);
                    String goodsName = request.getParameter("goodsName"+index);
                    String goodsModel = request.getParameter("goodsModel"+index);
                    String taxCode = request.getParameter("taxCode"+index);
                    String price = request.getParameter("price"+index);
                    String currency = request.getParameter("currency"+index);
                    String quantity = request.getParameter("quantity"+index);
                    String priceTotal = request.getParameter("priceTotal"+index);
                    String unit = request.getParameter("unit"+index);
                    String discount = request.getParameter("discount"+index);
                    String flag = request.getParameter("flag"+index);
                    String country = request.getParameter("country"+index);
                    String purposeCode = request.getParameter("purposeCode"+index);
                    String wasteMaterials = request.getParameter("wasteMaterials"+index);
                    String wrapTyped = request.getParameter("wrapType"+index);
                    String packNum = request.getParameter("packNum"+index);
                    String shelfGoodsName = request.getParameter("shelfGoodsName"+index);
                    index++;
                    Element cebOrderList = root.addElement("OrderList");
                    cebOrderList.addElement("itemNo").setText(itemNo);
                    cebOrderList.addElement("goodsNo").setText(goodsNo);
                    cebOrderList.addElement("shelfGoodsName").setText(shelfGoodsName);
                    cebOrderList.addElement("describe").setText(describe);
                    cebOrderList.addElement("codeTs").setText(codeTs);
                    cebOrderList.addElement("goodsName").setText(goodsName);
                    cebOrderList.addElement("goodsModel").setText(goodsModel);
                    cebOrderList.addElement("taxCode").setText(taxCode);
                    cebOrderList.addElement("price").setText(price);
                    cebOrderList.addElement("currency").setText(currency);
                    cebOrderList.addElement("quantity").setText(quantity);
                    cebOrderList.addElement("priceTotal").setText(priceTotal);
                    cebOrderList.addElement("unit").setText(unit);
                    cebOrderList.addElement("discount").setText(discount);
                    cebOrderList.addElement("flag").setText(flag);
                    cebOrderList.addElement("country").setText(country);
                    cebOrderList.addElement("purposeCode").setText(purposeCode);
                    cebOrderList.addElement("wasteMaterials").setText(wasteMaterials);
                    cebOrderList.addElement("wrapType").setText(wrapType);
                    cebOrderList.addElement("packNum").setText(packNum);
                }
            }
            Element orderPaymentLogistics = root.addElement("OrderPaymentLogistics");
            orderPaymentLogistics.addElement("paymentCode").setText(paymentCode);
            orderPaymentLogistics.addElement("paymentName").setText(paymentName);
            orderPaymentLogistics.addElement("paymentType").setText(paymentType);
            orderPaymentLogistics.addElement("paymentNo").setText(paymentNo);
            orderPaymentLogistics.addElement("logisticsCode").setText(logisticsCode);
            orderPaymentLogistics.addElement("logisticsName").setText(logisticsName);
            orderPaymentLogistics.addElement("logisticsNo").setText(logisticsNo);
            orderPaymentLogistics.addElement("trackNo").setText(trackNo);

            fileName = "CEB"+orderNo+"Message.xml";
            OutputStream out = null;
            boolean error = false;
            File file = new File(Path.WEB_INF_PATH + "kuajingtong/"+fileName);
            try {
                File pfile = file.getParentFile();
                if (!pfile.exists()) {
                    pfile.mkdirs();
                }
                out = new BufferedOutputStream(new FileOutputStream(file));
                OutputFormat outFormat = OutputFormat.createPrettyPrint();
                outFormat.setIndent(" ");
                outFormat.setIndentSize(1);
                outFormat.setExpandEmptyElements(false);
                outFormat.setLineSeparator("\r\n");
                outFormat.setEncoding("gb2312");
                XMLWriter outputter = new XMLWriter(out, outFormat);
                outputter.write(document);

            }catch (Exception e) {
                e.printStackTrace();
                error = true;
            }
            finally {
                try {
                    out.close();
                }
                catch (Exception e) {
                    e.printStackTrace();
                    error = true;
                }
            }
        }



        //File f = new File("d:/范例.xml");
        File file = new File(Path.WEB_INF_PATH + "kuajingtong/"+fileName);
        FileInputStream  fis = new FileInputStream(file);
        String filename = URLEncoder.encode(file.getName(), "utf-8"); //解决中文文件名下载后乱码的问题
        byte[] b = new byte[fis.available()];
        fis.read(b);
        response.setCharacterEncoding("utf-8");
        response.setHeader("Content-Disposition","attachment; filename="+filename+"");
        //获取响应报文输出流对象
        ServletOutputStream sout =response.getOutputStream();
        //输出
        sout.write(b);
        sout.flush();
        sout.close();
    }

    public void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp);
    }

}
