package com.wangzhixuan.controller;

import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import javax.validation.constraints.Pattern.Flag;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.mysql.fabric.xmlrpc.base.Data;
import com.wangzhixuan.commons.base.BaseController;
import com.wangzhixuan.commons.result.PageInfo;
import com.wangzhixuan.commons.utils.JsonUtils;
import com.wangzhixuan.commons.utils.StringUtils;
import com.wangzhixuan.model.Emp;
import com.wangzhixuan.service.empService;
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

/**
 * @param <E>
 * @description：员工管理
 * @author：Andy
 */
@Controller
@RequestMapping("/emp")
public class EmpController<E> extends BaseController {
    @Autowired
    private empService empService;
    
    /**
     * 员工管理页
     *
     * @return
     */
    @GetMapping("/manager")
    public String manager() {
        return "admin/emp/emp";
    }

    /**
     * emp管理列表
     * @return
     */
    @PostMapping("/dataGrid")
    @ResponseBody
    public Object dataGrid(Emp emp, Integer page, Integer rows, String sort, String order) {
    	
    	PageInfo pageInfo = new PageInfo(page, rows, sort, order);
    	Map<String, Object> condition = new HashMap<String, Object>();
    	
    	if (StringUtils.isNotBlank(emp.getName())) {
			condition.put("name", emp.getName());
		}
    	/*if (emp.getCreateTime() != null) {
			condition.put("createTime", emp.getCreateTime());
		}
*/    	pageInfo.setCondition(condition);
    	System.out.println("======================");
    	System.out.println(emp);
    	empService.selectDataGrid(pageInfo);
        return pageInfo;
    }

    /**
     * 添加emp页
     * @return
     */
    @GetMapping("/addPage")
    public String addPage() {
        return "admin/emp/empAdd";
    }

    /**
     * 添加emp
     * @param emp
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    public Object add(@Valid Emp emp, BindingResult result) {
    	if (result.hasErrors()) {
            return renderError(result);
        }
    	empService.insert(emp);
        return renderSuccess("添加成功");
    }
    
    /**
     * 添加Excel页
     */
    @GetMapping("/addExcelPage")
    public String add() {
        return "admin/emp/excelAdd";
    }
    
    
    @PostMapping("/addExcel")
    public Object addExcel(@RequestParam(value = "excel") MultipartFile uploadExcel){
    	// List<String[]> list = new ArrayList<String[]>();
    	Emp emp = new Emp();
    	
    	SimpleDateFormat Format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	java.util.Date date = null;
    	// 成功插入的数据数
    	int flag = 0;
    	try {
    		// 获得输入流
			InputStream in = uploadExcel.getInputStream();
			// 获取Excel文件对象
			Workbook workbook = Workbook.getWorkbook(in);
			// 获取文件的指定工作表 默认第一个
			Sheet sheet = workbook.getSheet(0);
			
			// String string = "";
			// 行数
			for (int i = 0; i < sheet.getRows(); i++) {
				//创建一个数组 存储每一列的值
				String[] str = new String[sheet.getColumns()];
				Cell cell = null; // 单元格
				for (int j = 0; j < sheet.getColumns(); j++) {
					cell = sheet.getCell(j,i);
					str[j] = cell.getContents();
				}
				
				emp.setId((long)Integer.parseInt(str[0]));
				emp.setName(str[1]);
				emp.setDept(str[2]);
				emp.setJob(str[3]);
				emp.setAge(Integer.parseInt(str[4]));
				emp.setSex(Integer.valueOf(str[5]));
				emp.setHeight(Integer.valueOf(str[6]));
				emp.setPhone(str[7]);
				emp.setEmpType(Integer.valueOf(str[8]));
				emp.setStatus(Integer.valueOf(str[9]));
				// 转换时间格式
				date = Format.parse(str[10]);
				// java.sql.Date date2 = new java.sql.Date(date.getTime());
				emp.setCreateTime(date);
				empService.insert(emp);
				flag += 1;
				System.out.println("成功插入了"+flag+"条数据。");
				//empService.insertAll(string);
			}
		} catch (Exception e) {
			System.out.println("-----------excel读写异常------------");
			e.printStackTrace();
		} 
    	// 写到控制台
    	/*for(int i=0;i<list.size();i++){  
             String[] str = (String[])list.get(i);  
             for(int j=0;j<str.length;j++){  
              System.out.print(str[j]+'\t');
             }  
             System.out.println();  
         }  */
    	return null;
    }
    
    
    /**
     * 编辑emp页
     *
     * @param id
     * @param model
     * @return
     */
    @GetMapping("/editPage")
    public String editPage(Model model, Long id) {
    	Emp emp = empService.selectById(id);
    	model.addAttribute("emp",emp);
    	System.out.println(emp);
        return "admin/emp/empEdit";
    }

    /**
     * 编辑员工
     *
     * @param emp
     * @return
     */
    // @RequiresRoles(value = {"admin","andy"},logical = Logical.OR)
    @PostMapping("/edit")
    @ResponseBody
    public Object edit(@Valid Emp emp, BindingResult result) {
    	if (result.hasErrors()) {
			return renderError(result);
		}
    	empService.updateById(emp);
    	System.out.println("-----------------");
    	System.out.println(emp);
        return renderSuccess("修改成功！");
    }

    /**
     * 删除emp
     *
     * @param id
     * @return
     */
    @PostMapping("/delete")
    @ResponseBody
    public Object delete(Long id) {
    	empService.deleteById(id);
        return renderSuccess("删除成功！");
    }
}
