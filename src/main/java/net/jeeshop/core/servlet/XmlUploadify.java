package net.jeeshop.core.servlet;

import net.jeeshop.core.ceb.analysis.AnalysisReceipt;
import net.jeeshop.core.util.FileUtils;
import net.jeeshop.core.util.Utils;
import net.jeeshop.services.manage.order.bean.Order;
import net.jeeshop.services.manage.order.impl.OrderServiceImpl;
import net.sf.json.JSONObject;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
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
public class XmlUploadify extends HttpServlet{
	private static final long serialVersionUID = 1L;
    SimpleDateFormat sdfFolder = new SimpleDateFormat("yyyyMMdd");
    /** 
     * 实现多文件的同时上传 
     */   
    public void doGet(HttpServletRequest request,  
            HttpServletResponse response) throws ServletException, IOException {
        ApplicationContext ctx = WebApplicationContextUtils.getRequiredWebApplicationContext(this.getServletContext());
        OrderServiceImpl orderService =  (OrderServiceImpl)ctx.getBean("orderServiceManage");
        //设置接收的编码格式  
        request.setCharacterEncoding("UTF-8");

        response.setContentType("text/json; charset=UTF-8");
        //名称  界面编码 必须 和request 保存一致..否则乱码
        String name = request.getParameter("name");  
        String id = request.getParameter("id");  //内容的ID,必须先添加内容，然后才能上传图片

        // 获得容器中上传文件夹所在的物理路径
        String savePath = this.getServletConfig().getServletContext().getRealPath("/") + File.separator + "xmlupload" + File.separator + sdfFolder.format(new Date()) + File.separator;
        System.out.println("路径" + savePath+"; name:"+name);  
        File file = new File(savePath);  
        if (!file.isDirectory()) {  
            file.mkdirs();  
        }  

        List<String> extList = new ArrayList<String>();
        extList.add("xml");
        //extList.add("zip");
        //extList.add("rar");
        try {  
            DiskFileItemFactory fac = new DiskFileItemFactory();  
            ServletFileUpload upload = new ServletFileUpload(fac);  
            upload.setHeaderEncoding("UTF-8");
            System.out.println("request：＝"+request);
            // 获取多个上传文件  
            List fileList = upload.parseRequest(request);
            System.out.println("fileList:"+fileList);
            // 遍历上传文件写入磁盘  
            Iterator it = fileList.iterator();  
            while (it.hasNext()) {  
            	Object obit = it.next();
            	if(obit instanceof DiskFileItem){
	                DiskFileItem item = (DiskFileItem) obit;
	                // 如果item是文件上传表单域     
	                // 获得文件名及路径     
	                String fileName = item.getName();  
	                if (fileName != null) {  
	                    String extName = fileName.substring(fileName.lastIndexOf(".")+1);//获取文件后缀名
                        if(!extList.contains(extName)){
                            //response.setContentType("application/json; charset=utf-8");
                            getWriteMsg("文件后缀名不合法，必须为.xml", response, null);
                            return;
                        }
                        String fileRealPath = savePath + fileName;//+ formatName;//文件存放真实地址
	                    BufferedInputStream in = new BufferedInputStream(item.getInputStream());// 获得文件输入流  
	                    BufferedOutputStream outStream = new BufferedOutputStream(new FileOutputStream(new File(fileRealPath)));// 获得文件输出流  
	                    Streams.copy(in, outStream, true);// 开始把文件写到你指定的上传文件夹  
	                    //上传成功，进行解析
                        if (new File(fileRealPath).exists()) {
                            if("xml".equals(extName)){
                                String[] result = AnalysisReceipt.analysisRecSample(fileRealPath);
                                if(null != result){
                                    if(Utils.isEmpty(result[0])){
                                        getWriteMsg("订单编号不能为空，请检查xml文件", response, null);
                                        return;
                                    }
                                    Order order = orderService.selectById(result[0]);
                                    if(null ==  order){
                                        getWriteMsg("找不到订单编号为【" + result[0] + "】的订单", response, null);
                                        return;
                                    }
                                    order.setKstatus(result[1]);
                                    order.setKdetail(result[2]);
                                    orderService.update(order);
                                    if("1".equals(result[1])){
                                        getWriteMsg("订单编号为【" + result[0] + "】的订单入库成功", response, order);
                                        return;
                                    }else{
                                        getWriteMsg("订单编号为【" + result[0] + "】的订单入库失败", response, order);
                                        return;
                                    }
                                }
                            }else if("zip".equals(extName)){
                                String destFilePath = savePath + System.currentTimeMillis();
                                try {
                                    FileUtils.unZip(fileRealPath, destFilePath);
                                }catch (Exception e){
                                    getWriteMsg("解析失败，请检查zip文件是否符合正确规范", response, null);
                                    return;
                                }
                                File destFile = new File(destFilePath);
                                if(destFile.exists()){
                                    File[] files = destFile.listFiles();
                                    if(null != files){
                                        //压缩文件一级是个文件夹
                                        if(files.length == 1 && files[0].isDirectory()){
                                            File subFile = files[0];
                                            File[] subfiles = subFile.listFiles();
                                            if(null != subfiles){
                                                for(File xf : subfiles){

                                                }
                                            }
                                        }
                                        //压缩文件一级是xml文件
                                        else {
                                            for(File xf : files){

                                            }
                                        }
                                    }

                                }
                            }else if("rar".equals(extName)){
                                String destFilePath = savePath + System.currentTimeMillis();
                                try {
                                    FileUtils.unRar(fileRealPath, destFilePath);
                                }catch (Exception e){
                                    getWriteMsg("解析失败，请检查rar文件是否符合正确规范", response, null);
                                    return;
                                }
                            }
                        }
                    }
            	}
            }   
        } catch (org.apache.commons.fileupload.FileUploadException ex) {
    	   ex.printStackTrace();  
           System.out.println("没有上传文件");  
           return;  
		}
        JSONObject obj = new JSONObject();
        obj.put("error", 0);
        response.getWriter().write(obj.toString());
    }  
   
    public void doPost(HttpServletRequest req, HttpServletResponse resp)  
            throws ServletException, IOException {  
        doGet(req, resp);  
    }

    private void getWriteMsg(String msg, HttpServletResponse response, Order order) throws IOException{
        JSONObject obj = new JSONObject();
        obj.put("error", 1);
        obj.put("msg", msg);
        if(null != order){
            obj.put("id", order.getId());
            obj.put("kstatus", "1".equals(order.getKstatus()) ? "入库成功" : "入库失败");
            obj.put("kdetail", order.getKdetail());
        }
        response.getWriter().write(obj.toString());
    }
}
