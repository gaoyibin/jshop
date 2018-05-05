package net.jeeshop.core.util;

import java.io.*;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.*;

import org.dom4j.*;
import org.dom4j.io.*;

/**
 * Created by gaoyibin on 2016/7/24.
 */
public class XMLUtil<T> {
    private String fileName;
    private org.dom4j.Document doc;
    private Map<String,String> propertyCache;
    private static final String ENCODING="UTF-8";
    //  private long shouldWriteTime; //用于控制频繁写入。暂不使用
//  private boolean writed;
//  private static final long minWriteInterval = 100;
    boolean needCache;
    /**
     * 创建一个XMLTools对象
     * @param fileFullName String
     */
    public XMLUtil(String fileFullName) {
        this(fileFullName, true);
    }

    public XMLUtil(String fileFullName, boolean needCache) {
        this.fileName = fileFullName;
        this.needCache = needCache;
        this.readDoc();
        if (needCache) {
            propertyCache = new SizeFixedCache<String,String>(256);
        }
    }

    public XMLUtil(String fileFullName, int cacheSize) {
        this.fileName = fileFullName;
        this.needCache = true;
        this.readDoc();
        propertyCache = new SizeFixedCache<String,String>(cacheSize);
    }

    /**
     * 取得节点值
     * @param name String
     * @return String
     */
    public String getProperty(String name) {
        name = name.replace('.', '/');
        if (needCache && propertyCache.containsKey(name)) {
            return propertyCache.get(name);
        }
        String[] propName = parsePropertyName(name);
        Element root = doc.getRootElement();
        Element element = root;
        for (int i = 0; i < propName.length; i++) {
            if (propName[i] == null || propName[i].equals("") ||
                    (i == 0 && propName[i].equals(root.getQName().getName())) ||
                    (i == 1 && propName[i].equals(root.getQName().getName())) &&
                            (propName[0] == null || propName[0].equals(""))) {
                //如果XPath形式，不管是/root 还是 root 都要忽略掉
                element = root;
            }
            else if (propName[i].startsWith("@")) { //加入对属性的支持
                return element.attributeValue(propName[i].substring(1));
            }
            else {
                element = element.element(propName[i]);
                if (element == null) {
                    return null;
                }
            }
        }

        String value = element.getText();

        if (value == null || "".equals(value)) {
            return value;
        }
        else {
            value = value.trim();
            if (needCache) {
                propertyCache.put(name, value);
            }
            return value;
        }
    }

    /**
     * 取得子节点名
     * @param parent String
     * @return String[]
     */
    public String[] getChildrenProperties(String parent) {
        String[] propName = parsePropertyName(parent);
        Element element = doc.getRootElement();

        for (int i = 0; i < propName.length; i++) {
            element = element.element(propName[i]);
            if (element == null) {
                return new String[0];
            }
        }
        List children = element.elements();
        int childCount = children.size();
        String[] childrenNames = new String[childCount];

        for (int i = 0; i < childCount; i++) {
            childrenNames[i] = ( (Element) children.get(i)).getName();
        }

        return childrenNames;
    }

    /**
     * 设置节点值
     * @param name String
     * @param value String
     */
    public void setProperty(String name, String value) {
        name = name.replace('.', '/');
        if (value == null || value.equals("")) {
            this.deleteProperty(name);
            return;
        }
        if (needCache) {
            if (propertyCache.containsKey(name)) {
                String v = propertyCache.get(name);
                if (v != null && v.equals(value)) {
                    return;
                }
            }
            propertyCache.put(name, value);
        }

        String[] propName = parsePropertyName(name);
        Element root = doc.getRootElement();
        Element element = root;
        Node target = null;
        for (int i = 0; i < propName.length; i++) {
            if (propName[i] == null || propName[i].equals("") ||
                    (i == 0 && propName[i].equals(root.getQName().getName())) ||
                    (i == 1 && propName[i].equals(root.getQName().getName())) &&
                            (propName[0] == null || propName[0].equals(""))) {
                //如果XPath形式，不管是/root 还是 root 都要忽略掉
                element = root;
            }
            else if (propName[i].startsWith("@")) { //加入对属性的支持
                target = element.attribute(propName[i].substring(1));
                if (target == null) {
                    target = element.addAttribute(propName[i].substring(1), value);
                }
            }
            else {
                target = element.element(propName[i]);
                if (target == null) {
                    element = element.addElement(propName[i]);
                    target = element;
                }
                else {
                    element = (Element) target;
                }
            }
        }
        target.setText(value);
        writeDoc(ENCODING);
    }

    /**
     * 删除某个节点
     * @param name String
     */
    public void deleteProperty(String name) {
        if(needCache) propertyCache.remove(name);//LinLW 2011-03-14 修订清空property后缓存没有清空的BUG
        name = name.replace('.', '/');
        String[] propName = parsePropertyName(name);
        Element root = doc.getRootElement();
        Element element = root;

        for (int i = 0; i < (propName.length - 1); i++) {
            if (propName[i] == null || propName[i].equals("") ||
                    (i == 0 && propName[i].equals(root.getQName().getName())) ||
                    (i == 1 && propName[i].equals(root.getQName().getName())) &&
                            (propName[0] == null || propName[0].equals(""))) {
                //如果XPath形式，不管是/root 还是 root 都要忽略掉
                element = root;
            }
            else {
                element = element.element(propName[i]);
                if (element == null) {
                    return;
                }
            }
        }
        if (propName[propName.length - 1].startsWith("@")) { //加入对属性的支持
            element.remove(element.attribute(propName[propName.length -
                    1].substring(1)));
        }
        else {
            element.remove(element.element(propName[propName.length - 1]));
        }
        writeDoc("UTF-8");
    }

    /**
     * 解析路径
     * @param name String
     * @return String[]
     */
    private static String[] parsePropertyName(String name) {
        return name.split("[./]"); //JDK1.4 +
    }

    /**
     * 读取文件内容
     */
    private synchronized void readDoc() {
        try {
            doc = new SAXReader().read(new File(fileName));
        }
        catch (DocumentException ex) {
//      System.out.println("读取XML文件[" + fileName + "]失败,使用空内容代替");
            org.dom4j.DocumentFactory f = new DocumentFactory();
            doc = f.createDocument(f.createElement("datas"));
        }
    }

    /**
     * 写入文件内容
     * @param encoding String
     */
    public synchronized void writeDoc(String encoding) {
        OutputStream out = null;
        boolean error = false;
        File tempFile = null;
        File file = new File(fileName);
        try {
            File pfile = file.getParentFile();
            if (!pfile.exists()) {
                pfile.mkdirs();
            }
            tempFile = new File(
                    file.getParentFile(),
                    file.getName().concat(".tmp"));
            out = new BufferedOutputStream(new FileOutputStream(tempFile));
            OutputFormat outFormat = OutputFormat.createPrettyPrint();
            outFormat.setIndent(" ");
            outFormat.setIndentSize(1);
            outFormat.setExpandEmptyElements(false);
            outFormat.setLineSeparator("\r\n");
            outFormat.setEncoding(encoding);
            XMLWriter outputter = new XMLWriter(out, outFormat);
            doc.setXMLEncoding(encoding);
            outputter.write(doc);
        }
        catch (Exception e) {
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
        if (!error) {
            file.delete();
            tempFile.renameTo(file);
        }
    }

    /**
     * 创建xml
     * @param obj        泛型对象
     * @param entityPropertys 泛型对象的List集合
     * @param Encode     XML自定义编码类型
     * @param XMLPath    XML文件的路径及文件名
     * @date 2011-5-8
     * @author lujan
     */
    public void createXmlDocument(T obj, List<T> entityPropertys, String Encode,
                                  String XMLPath) {
        try {
            XMLWriter writer = null;// 声明写XML的对象
            OutputFormat format = OutputFormat.createPrettyPrint();
            format.setEncoding(Encode);	// 设置XML文件的编码格式 UTF-8

            File file = new File(XMLPath);//获得文件

            if (file.exists()) {
                file.delete();
            }
            // 创建xml文件
            Document document = DocumentHelper.createDocument();
            String rootname = obj.getClass().getSimpleName();  //获得简单类名
            Element root = document.addElement(rootname + "s");//添加根节点
            Field[] properties = obj.getClass().getDeclaredFields();//获得实体类的所有属性
            //赋值
            for (T  t : entityPropertys) {                                //递归实体
                Element element = root.addElement(rootname);            //二级节点
                for (int i = 0; i < properties.length; i++) {
                    //反射get方法
                    Method meth = t.getClass().getMethod("get"+ properties[i].getName().substring(0, 1).toUpperCase() + properties[i].getName().substring(1));
                    //为二级节点添加属性，属性值为对应属性的值
                    element.addElement(properties[i].getName()).setText(meth.invoke(t).toString());
                }
            }
            writer = new XMLWriter(new FileOutputStream(file), format);
            writer.write(document);
            writer.close();
        } catch (Exception e) {
            System.out.println("XML文件写入失败");
            e.printStackTrace();
        }
    }


    /**
     *   解析
     * @param XMLPath XML文件的路径(含名字)
     * @param t     泛型对象
     * @return  List<T>
     * @date 2011-5-8
     * @author lujn
     */
    public List<T> parserXml(String XMLPath, T t) {
        List<T> list = new ArrayList<T>();   //创建list集合
        try {
            File f = new File(XMLPath);	//读取文件
            SAXReader reader = new SAXReader();
            Document doc = reader.read(f);		//dom4j读取
            Element root = doc.getRootElement();//获得根节点
            Element secondElement;				//二级节点
            Field[] properties = t.getClass().getDeclaredFields();//获得实例的属性

            Method setMethod = null;
            for (Iterator i = root.elementIterator(t.getClass().getSimpleName()); i.hasNext();) {
                //遍历t.getClass().getSimpleName()节点
                secondElement = (Element) i.next();			//下一个二级节点
                t = (T)t.getClass().newInstance();			//获得对象的新的实例
                Object[] args = new Object[properties.length];
                for (int j = 0; j < properties.length; j++) {
                    //遍历所有孙子节点
                    //实例的set方法
                    setMethod = t.getClass().getMethod("set"+ properties[j].getName().substring(0, 1).toUpperCase()+ properties[j].getName().substring(1),properties[j].getType());
                    setMethod.invoke(t,secondElement.elementText(properties[j].getName())) ;
                }
                list.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }



}
