package net.jeeshop.core.util;

import java.io.*;
import java.util.ArrayList;
import java.util.Enumeration;

import com.github.junrar.Archive;
import com.github.junrar.rarfile.FileHeader;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipFile;
import org.apache.tools.zip.ZipOutputStream;
/**
 * Created by Administrator on 2016/8/7.
 */
public class FileUtils {
    static final int BUFFER = 1024;
    /*
     * 解压缩zip文件
     *
     * @param fileName
     *            要解压的文件名 包含路径 如："c:\\test.zip"
     * @param destFilePath
     *            解压后存放文件的路径 如："c:\\temp"
     * @throws Exception
     */
    public static void unZip(String fileName, String destFilePath)
            throws Exception {
        ZipFile zipFile = new ZipFile(fileName, "GB18030"); // 以“GBK”编码创建zip文件，用来处理winRAR压缩的文件。
        Enumeration emu = zipFile.getEntries();
        while (emu.hasMoreElements()) {
            ZipEntry entry = (ZipEntry) emu.nextElement();
            if (entry.isDirectory()) {
                File dir = new File(destFilePath + File.separator + entry.getName());
                if (!dir.exists()) {
                    dir.mkdirs();
                }
                continue;
            }
            BufferedInputStream bis = new BufferedInputStream(zipFile
                    .getInputStream(entry));

            File file = new File(destFilePath + File.separator + entry.getName());
            File parent = file.getParentFile();
            if (parent != null && (!parent.exists())) {
                parent.mkdirs();
            }
            FileOutputStream fos = new FileOutputStream(file);
            BufferedOutputStream bos = new BufferedOutputStream(fos, BUFFER);
            byte[] buf = new byte[BUFFER];
            int len = 0;
            while ((len = bis.read(buf, 0, BUFFER)) != -1) {
                fos.write(buf, 0, len);
            }
            bos.flush();
            bos.close();
            bis.close();
            System.out.println("解压文件：" + file.getName());
        }
        zipFile.close();
    }

    public static void unRar(String srcRarPath, String dstDirectoryPath) {
        if (!srcRarPath.toLowerCase().endsWith(".rar")) {
            System.out.println("非rar文件！");
            return;
        }
        File dstDiretory = new File(dstDirectoryPath);
        if (!dstDiretory.exists()) {// 目标目录不存在时，创建该文件夹
            dstDiretory.mkdirs();
        }
        Archive a = null;
        try {
            a = new Archive(new File(srcRarPath));
            if (a != null) {
                a.getMainHeader().print(); // 打印文件信息.
                FileHeader fh = a.nextFileHeader();
                while (fh != null) {
                    if (fh.isDirectory()) { // 文件夹
                        File fol = new File(dstDirectoryPath + File.separator
                                + fh.getFileNameString());
                        fol.mkdirs();
                    } else { // 文件
                        File out = new File(dstDirectoryPath + File.separator
                                + fh.getFileNameString().trim());
                        //System.out.println(out.getAbsolutePath());
                        try {// 之所以这么写try，是因为万一这里面有了异常，不影响继续解压.
                            if (!out.exists()) {
                                if (!out.getParentFile().exists()) {// 相对路径可能多级，可能需要创建父目录.
                                    out.getParentFile().mkdirs();
                                }
                                out.createNewFile();
                            }
                            FileOutputStream os = new FileOutputStream(out);
                            a.extractFile(fh, os);
                            os.close();
                        } catch (Exception ex) {
                            ex.printStackTrace();
                        }

                    }
                    fh = a.nextFileHeader();
                }
                a.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) throws Exception{
        unRar("d:/test/aaa.rar", "d:/test/");
    }
}
