package com.wangzhixuan.commons.exception;
/**
 * Excel导入导出异常类，用来处理数据源为空，重复行等问题
 * @author Andy
 *
 */
public class ExcelException extends Exception {  
    
    public ExcelException() {  
        // TODO Auto-generated constructor stub  
    }  
  
    public ExcelException(String message) {  
        super(message);  
        // TODO Auto-generated constructor stub  
    }  
  
    public ExcelException(Throwable cause) {  
        super(cause);  
        // TODO Auto-generated constructor stub  
    }  
  
    public ExcelException(String message, Throwable cause) {  
        super(message, cause);  
        // TODO Auto-generated constructor stub  
    }  
  
  
}  
