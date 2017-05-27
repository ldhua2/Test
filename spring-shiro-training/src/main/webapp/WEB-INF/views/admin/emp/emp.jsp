<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var empDataGrid;

    $(function() {
        empDataGrid = $('#empDataGrid').datagrid({
            url : '${path }/emp/dataGrid',
            fit : true,
            striped : true,
            rownumbers : false,
            pagination : true,
            singleSelect : true,
            idField : 'id',
            sortName : 'id',
	        sortOrder : 'asc',
            pageSize : 20,
            pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500 ],
            columns : [ [ {
                width : '40',
                title : '编号',
                field : 'id',
                sortable : true
            }, {
                width : '80',
                title : '姓名',
                field : 'name',
                sortable : true
            },{
                width : '80',
                title : '班级',
                field : 'dept',
                sortable : true
            },{
                width : '80',
                title : '职务',
                field : 'job',
                sortable : true
            },{
                width : '60',
                title : '年龄',
                field : 'age',
                sortable : true
            },{
                width : '40',
                title : '性别',
                field : 'sex',
                sortable : true,
                formatter : function(value, row, index) {
                    switch (value) {
                    case 0:
                        return '男';
                    case 1:
                        return '女';
                    }
                }
            },{
                width : '80',
                title : '身高(cm)',
                field : 'height',
                sortable : true
            }, {
                width : '120',
                title : '电话',
                field : 'phone',
                sortable : true
            }, {
                width : '80',
                title : '用户类型',
                field : 'emp_Type',
                sortable : true,
                formatter : function(value, row, index) {
                    if(value == 0) {
                        return "管理员";
                    }else if(value == 1) {
                        return "用户";
                    }
                    return "未知类型";
                }
            },{
                width : '60',
                title : '状态',
                field : 'status',
                sortable : true,
                formatter : function(value, row, index) {
                    switch (value) {
                    case 0:
                        return '正常';
                    case 1:
                        return '停用';
                    }
                }
            } ,{
            	width : '130',
            	title : '创建时间',
            	field : 'create_time',
            	sortable : true
            }, {
                field : 'action',
                title : '操作',
                width : 130,
                formatter : function(value, row, index) {
                    var str = '';
                        <shiro:hasPermission name="/emp/edit">
                            str += $.formatString('<a href="javascript:void(0)" class="emp-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="editEmpFun(\'{0}\');" >编辑</a>', row.id);
                        </shiro:hasPermission>
                        <shiro:hasPermission name="/emp/delete">
                            str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                            str += $.formatString('<a href="javascript:void(0)" class="emp-easyui-linkbutton-del" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="deleteEmpFun(\'{0}\');" >删除</a>', row.id);
                        </shiro:hasPermission>
                    return str;
                }
            }] ],
            onLoadSuccess:function(data){
                $('.emp-easyui-linkbutton-edit').linkbutton({text:'编辑'});
                $('.emp-easyui-linkbutton-del').linkbutton({text:'删除'});
            },
            toolbar : '#empToolbar'
        });
    });
    
    function addEmpFun() {
        parent.$.modalDialog({
            title : '添加',
            width : 500,
            height : 300,
            href : '${path }/emp/addPage',
            buttons : [ {
                text : '添加',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = empDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    /* empAddForm 方法在empAdd。jsp */
                    var f = parent.$.modalDialog.handler.find('#empAddForm');
                    f.submit();
                }
            } ]
        });
    }
    // 删除方法
    function deleteEmpFun(id) {
        if (id == undefined) {//点击右键菜单才会触发这个
            var rows = empDataGrid.datagrid('getSelections');
            id = rows[0].id;
        } else {//点击操作里面的删除图标会触发这个
            empDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
        }
        parent.$.messager.confirm('询问', '您是否要删除当前用户？', function(b) {
            if (b) {
                progressLoad();
                $.post('${path }/emp/delete', {
                    id : id
                }, function(result) {
                    if (result.success) {
                        parent.$.messager.alert('提示', result.msg, 'info');
                        empDataGrid.datagrid('reload');
                    } else {
                        parent.$.messager.alert('错误', result.msg, 'error');
                    }
                    progressClose();
                }, 'JSON');
            }
        });
    }
    
    function editEmpFun(id) {
        if (id == undefined) {
            var rows = empDataGrid.datagrid('getSelections'); // getSelections	获得所有选项
            id = rows[0].id;
        } else {
        	// unselectAll	取消选择全部
        	// uncheckAll	不打勾全部
            empDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
        }
        parent.$.modalDialog({
            title : '编辑',
            width : 500,
            height : 300,
            href : '${path }/emp/editPage?id=' + id,
            buttons : [ {
                text : '确定',
                handler : function() {
                	// modalDialog	对话框模式
                    parent.$.modalDialog.openner_dataGrid = empDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#empEditForm');
                    f.submit();
                }
            } ]
        });
    }
    
    function searchEmpFun() {
        empDataGrid.datagrid('load', $.serializeObject($('#searchEmpForm')));
    }
    function cleanEmpFun() {
        $('#searchEmpForm input').val('');
        empDataGrid.datagrid('load', {});
    }
    
 /*    function addEmpFun() {
        parent.$.modalDialog({
            title : '添加',
            width : 500,
            height : 300,
            href : '${path }/emp/addPage',
            buttons : [ {
                text : '添加',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = empDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#empAddForm');
                    f.submit();
                }
            } ]
        });
    } */
    
    
     function addExcelFun() {
    	 debugger;
        parent.$.modalDialog({
    	 title : '批量导入数据',
    	 width : 400,
    	 height : 200,
            href : '${path }/emp/addExcelPage',
            buttons : [ {
                text : '导入',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = empDataGrid;
                    /* empAddForm 方法在empAdd。jsp */
                    var f = parent.$.modalDialog.handler.find('#uploadExcel');
                    f.submit();
                }
            } ]
        });
    } 
    
   
    
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="searchEmpForm">
            <table>
                <tr>
                    <th>姓名:</th>
                    <td><input name="name" placeholder="请输入用户姓名"/></td>
                    <th>创建时间:</th>
                    <td>
                        <input name="createTime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />至
                        <input  name="createdateEnd" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="searchEmpFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="cleanEmpFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    
 <!--    <div>
    	<form id="questionTypesManage"  method="post" enctype="multipart/form-data">  
		   选择文件：　<input id="uploadExcel" name="uploadExcel" class="easyui-filebox" style="width:200px" data-options="prompt:'请选择文件...'">  
		       　　<a href="#" class="easyui-linkbutton" style="width:122px" onclick="uploadExcel()" >导入题库</a> 　　     　　　　　      
		</form> 
    </div> -->
    
    <div data-options="region:'center',border:true,title:'用户列表'" >
        <table id="empDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>

<div id="empToolbar" style="display: none;">
    <shiro:hasPermission name="/emp/add">
        <a onclick="addEmpFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-plus icon-green'">添加</a>
        <!-- 批量导入 -->
        <a onclick="addExcelFun();"  href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-plus icon-green'">批量导入</a>
    </shiro:hasPermission>
</div>