/**
 * 
 */
package com.devops.suc.util;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;


public class TextFileWrite {
	private File file;
	public TextFileWrite(String fileName){
		file = new File(fileName);
	}
  
    public void writeFile(String content) {
        writeFile(content, "UTF-8");

    }

    public void writeFile(String content, String strCode) {
        FileWriter fw = null;
        try {
            fw = new FileWriter(this.file);
            BufferedWriter bw = new BufferedWriter(fw);
            bw.write(new String(content.getBytes(strCode)));
            bw.flush(); 
        }
        catch (IOException ex) {
            ex.printStackTrace();
        }
        finally {
            if (fw != null)
                try {
                    fw.close();
                }
                catch (IOException e) {
                    e.printStackTrace();
                }
        }

    }


}
