package net.jeeshop.core.ceb.analysis;

import net.jeeshop.core.ceb.analysis.vo.Ceb312;
import net.jeeshop.core.ceb.analysis.vo.Ceb622;
import net.jeeshop.core.ceb.analysis.vo.Ceb624;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by gaoyibin on 2016/7/24.
 */
public class AnalysisReceipt {
    static String relativelyPath = System.getProperty("user.dir");
    /**
     * 电子订单数据回执
     */
    public static void analysisCEB312Message(Element rootNode){

        try {
            Element orderReturn =  rootNode.element("OrderReturn");
            String guid = orderReturn.elementText("guid");
            String ebpCode = orderReturn.elementText("ebpCode");
            String ebcCode = orderReturn.elementText("ebcCode");
            String orderNo = orderReturn.elementText("orderNo");
            String returnStatus = orderReturn.elementText("returnStatus");
            String returnInfo = orderReturn.elementText("returnInfo");
            String returnTime = orderReturn.elementText("returnTime");
            Ceb312 ceb312 = new Ceb312();
            ceb312.setGuid(guid);
            ceb312.setEbpCode(ebpCode);
            ceb312.setEbcCode(ebcCode);
            ceb312.setOrderNo(orderNo);
            ceb312.setReturnStatus(returnStatus);
            ceb312.setReturnInfo(returnInfo);
            ceb312.setReturnTime(returnTime);

        }catch (Exception e){
            e.printStackTrace();
        }

    }

    /**
     * 进口清单数据回执
     */
    public static void analysisCEB622Message(Element rootNode){
        try {
            Element inventoryReturn =  rootNode.element("InventoryReturn");
            String guid = inventoryReturn.elementText("guid");
            String customsCode = inventoryReturn.elementText("customsCode");
            String ebpCode = inventoryReturn.elementText("ebpCode");
            String ebcCode = inventoryReturn.elementText("ebcCode");
            String agentCode = inventoryReturn.elementText("agentCode");
            String copNo = inventoryReturn.elementText("copNo");
            String preNo = inventoryReturn.elementText("preNo");
            String returnStatus = inventoryReturn.elementText("returnStatus");
            String returnInfo = inventoryReturn.elementText("returnInfo");
            String returnTime = inventoryReturn.elementText("returnTime");
            Ceb622 ceb622 = new Ceb622();
            ceb622.setGuid(guid);
            ceb622.setCustomsCode(customsCode);
            ceb622.setEbpCode(ebpCode);
            ceb622.setEbcCode(ebcCode);
            ceb622.setAgentCode(agentCode);
            ceb622.setCopNo(copNo);
            ceb622.setPreNo(preNo);
            ceb622.setReturnStatus(returnStatus);
            ceb622.setReturnInfo(returnInfo);
            ceb622.setReturnTime(returnTime);

        }catch (Exception e){
            e.printStackTrace();
        }
    }

    /**
     * 撤销申请单数据回执
     */
    public static void analysisCEB624Message(Element rootNode){
        try {
            Element invtCancelReturn =  rootNode.element("InvtCancelReturn");
            String guid = invtCancelReturn.elementText("guid");
            String customsCode = invtCancelReturn.elementText("customsCode");
            String ebpCode = invtCancelReturn.elementText("ebpCode");
            String ebcCode = invtCancelReturn.elementText("ebcCode");
            String agentCode = invtCancelReturn.elementText("agentCode");
            String copNo = invtCancelReturn.elementText("copNo");
            String preNo = invtCancelReturn.elementText("preNo");
            String invtNo = invtCancelReturn.elementText("invtNo");
            String returnStatus = invtCancelReturn.elementText("returnStatus");
            String returnInfo = invtCancelReturn.elementText("returnInfo");
            String returnTime = invtCancelReturn.elementText("returnTime");
            Ceb624 ceb624 = new Ceb624();
            ceb624.setGuid(guid);
            ceb624.setCustomsCode(customsCode);
            ceb624.setEbpCode(ebpCode);
            ceb624.setEbcCode(ebcCode);
            ceb624.setAgentCode(agentCode);
            ceb624.setCopNo(copNo);
            ceb624.setPreNo(preNo);
            ceb624.setInvtNo(invtNo);
            ceb624.setReturnStatus(returnStatus);
            ceb624.setReturnInfo(returnInfo);
            ceb624.setReturnTime(returnTime);

        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public static void analysisXml(String xmlFilePath){
        try {
            // 创建saxReader对象
            SAXReader reader = new SAXReader();
            // 通过read方法读取一个文件 转换成Document对象
            Document document = reader.read(new File(xmlFilePath));
            //获取根节点元素对象
            Element rootNode = document.getRootElement();
            List<Element> eList = rootNode.elements();
            String fName = eList.get(0).getName();
            if("OrderReturn".equals(fName)){
                analysisCEB312Message(rootNode);
            }else if("InventoryReturn".equals(fName)){
                analysisCEB622Message(rootNode);
            }else if("InvtCancelReturn".equals(fName)){
                analysisCEB624Message(rootNode);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public static String[] analysisRecSample(String xmlFilePath){
        try {
            // 创建saxReader对象
            SAXReader reader = new SAXReader();
            // 通过read方法读取一个文件 转换成Document对象
            Document document = reader.read(new File(xmlFilePath));
            //获取根节点元素对象
            Element rootNode = document.getRootElement();
            String orderNo = rootNode.elementText("orderNo");
            String status = rootNode.elementText("status");
            String detail = rootNode.elementText("detail");
            return new String[]{orderNo, status, detail};
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }


    public static void main(String[] args){
        AnalysisReceipt.analysisXml(relativelyPath + File.separator + "cebfile" + File.separator + "CEB624Message.xml");
    }
}
