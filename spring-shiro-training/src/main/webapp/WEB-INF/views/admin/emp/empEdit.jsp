<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
    /*     $('#userEditorganizationId').combotree({
            url : '${path }/organization/tree',
            parentField : 'pid',
            lines : true,
            panelHeight : 'auto',
            value : '${user.organizationId}'
        }); */

      /*   $('#userEditRoleIds').combotree({
            url : '${path }/role/tree',
            parentField : 'pid',
            lines : true,
            panelHeight : 'auto',
            multiple : true,
            required : true,
            cascadeCheck : false, // 是否支持级联选择
        }); */

        $('#empEditForm').form({
            url : '${path }/emp/edit',
            onSubmit : function() {
                progressLoad();
                var isValid = $(this).form('validate');
                if (!isValid) {
                    progressClose();
                }
                return isValid;
            },
            success : function(result) {
                progressClose();
                result = $.parseJSON(result);
                if (result.success) {
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    var form = $('#empEditForm');
                    parent.$.messager.alert('错误', eval(result.msg), 'error');
                }
            }
        });
        // select下拉框需要在jq函数定义$("#id").val('${emp.name}');获取值
        $("#empEditSex").val('${emp.sex}');
        $("#empEditEmpType").val('${emp.empType}');
        $("#empEditStatus").val('${emp.status}');
    });
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <form id="empEditForm" method="post">
            <div class="light-info" style="overflow: hidden;padding: 3px;">
                <div>编号唯一，不可修改！</div>
            </div>
            <table class="grid">
            		<td>编号</td>
            		<!-- disabled="true -->
                    <td><input name="id" type="number"  value="${emp.id}" readonly="true"></td>
                    <td>电话</td>
                    <td>
                        <input type="text" name="phone" class="easyui-numberbox" value="${emp.phone}"/>
                    </td>
                <tr>
                    <td>姓名</td>
                    <td><input name="name" type="text" placeholder="请输入姓名" class="easyui-validatebox" data-options="required:true" value="${emp.name}"></td>
                    <td>身高(cm)</td>
                    <td><input type="text" name="height" value="${emp.height }"/></td>
                </tr>
                <tr>
                    <td>职务</td>
                    <td><input type="text" name="job" value="${emp.job }"/></td>
                    
                    <td>性别</td>
                    <td><select id="empEditSex" name="sex" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                            <option value="0">男</option>
                            <option value="1">女</option>
                    </select></td>
                </tr>
                <tr>
                    <td>年龄</td>
                    <td><input type="text" name="age" value="${emp.age}" class="easyui-numberbox"/></td>
                    <td>用户类型</td>
                    <td><select id="empEditEmpType" name="empType" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                            <option value="0">管理员</option>
                            <option value="1">用户</option>
                    </select></td>
                </tr>
                <tr>
                    <td>班级</td>
                    <td><input name="dept" class="easyui-validatebox" value="${emp.dept }"/></td>
                    <!-- <td>角色</td>
                    <td><input  id="userEditRoleIds" name="roleIds" style="width: 140px; height: 29px;"/></td> -->
                    <td>用户状态</td>
                    <td><select id="empEditStatus" name="status" value="${emp.status}" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'">
                            <option value="0">正常</option>
                            <option value="1">停用</option>
                    </select></td>
                </tr>
            </table>
        </form>
    </div>
</div>