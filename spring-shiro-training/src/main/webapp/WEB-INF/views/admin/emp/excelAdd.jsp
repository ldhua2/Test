<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
		$(function() {
    	 /*  配置导入框  */
    	    	debugger;
    	    $("#uploadExcel").form({
    	        type : 'post',  
    	        url : '${path }/emp/addExcel',  
    	        dataType : "json",  
    	        onSubmit: function() {  
    	            var fileName= $('#excel').filebox('getValue');   
    	              //对文件格式进行校验    
    	             var d1=/\.[^\.]+$/.exec(fileName);  
    	            if (fileName == "") {    
    	                  $.messager.alert('Excel批量用户导入', '请选择将要上传的文件!');   
    	                  return false;    
    	             }else if(d1!=".xls"){  
    	                 $.messager.alert('提示','请选择xls格式文件！','info');    
    	                 return false;   
    	             }  
    	            return true;    
    	        },   
    	        success : function(result) {
    	        	progressClose();
                    result = $.parseJSON(result);
                    if (result.success) {
                        parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
                        parent.$.modalDialog.handler.dialog('close');
                    } else {
                        var form = $('#empAddForm');
                        parent.$.messager.alert('提示', eval(result.msg), 'warning');
                    }
                
    	            /* var result = eval('(' + result + ')');
    	            debugger;
    	            if (result.success) {  
    	                $.messager.alert('提示!', '导入成功','info',  
    	                        function() {  
    	                            $('#importExcel').dialog('close');  
    	                            $('#empDataGrid').datagrid('reload');  
    	                        });  
    	            } else {
    	                $.messager.confirm('提示',"导入失败!");  
    	            } */  
    	        }  
    	    });
    	 
    	});
</script>
        
        <!-- 配置导入框 -->  
    <div id="importExcel"  data-options="modal:true" >  
        <form id="uploadExcel"  method="post" enctype="multipart/form-data" >
            <!-- easyui-filebox标签的名字是作为参数传到后台  后台以流形式接收 -->
            选择文件：　<input id = "excel" name = "excel" class="easyui-filebox" style="width:200px " data-options="prompt:'请选择文件...'" />    
        </form>    
       <!--  <div style="text-align: center; padding: 5px 0;">  
            <a id = "booten" href="javascript:void(0)" class="easyui-linkbutton"  
                onclick="uploadExcel()" style="width: 80px" id="tt">导入</a>  
        </div>  -->
    </div> 
        
