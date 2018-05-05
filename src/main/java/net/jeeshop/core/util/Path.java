package net.jeeshop.core.util;

import net.jeeshop.core.task.SystemAutoNotifyTask;

/**
 * Created by gaoyibin on 2016/8/3.
 */
public class Path {

    public static  String CLASS_PATH;
    public static String WEB_INF_PATH;
    public static String APP_PATH;
    public static String ROOT_PATH;

    public static final String UPLOAD = "upload";

    static{
        String currentPath = getPath(Path.class);//Thread.currentThread().getContextClassLoader().getResource("").toString();
        if(currentPath.indexOf(".jar!/")>-1 || currentPath.indexOf("classes")>-1){
            String classPath = currentPath.replaceAll("/./","/");
//            classPath=classPath.replace("file:", "");
//            classPath=classPath.substring(1); //去掉第一个\,如 \D:\JavaWeb..
            classPath = classPath.replaceAll("/lib/([^\''])!/","/classes/");
            classPath = classPath.split("/classes/")[0]+"/classes/";
            if(classPath.indexOf(':')<0){
                classPath = '/'+classPath;
            }
            CLASS_PATH = classPath;

        }else{
            CLASS_PATH = Path.class.getClassLoader().getResource(".").getPath().substring(1);
        }
        WEB_INF_PATH = CLASS_PATH.substring(0,CLASS_PATH.substring(0,CLASS_PATH.lastIndexOf('/')).lastIndexOf('/')+1);
        APP_PATH = WEB_INF_PATH.substring(0,WEB_INF_PATH.substring(0,WEB_INF_PATH.lastIndexOf('/')).lastIndexOf('/')+1);
        ROOT_PATH = CLASS_PATH.substring(0,CLASS_PATH.indexOf('/')+1);

    }

    private static String getPath(Class<?> cls) {
        String t = getAbsoluteFile(cls);
        return t.substring(0,t.lastIndexOf('/')+1).replaceAll("(file:/)|(file:)|(wsjar:)|(jar:)|(zip:)","");
    }

    private static String getAbsoluteFile(Class<?> cls) {
        return cls.getResource(cls.getSimpleName()+".class").toString().replaceAll("%20"," ");
    }

    public static void main(String[] agrs){
        System.out.println(WEB_INF_PATH);
        System.out.println(APP_PATH);
        System.out.println(ROOT_PATH);
    }
}
