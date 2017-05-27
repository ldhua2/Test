package com.wangzhixuan.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.wangzhixuan.commons.result.PageInfo;
import com.wangzhixuan.mapper.EmpMapper;
import com.wangzhixuan.model.Emp;
import com.wangzhixuan.service.empService;

@Service
public class empServiceImpl extends ServiceImpl<EmpMapper, Emp> implements empService{
	@Autowired
	private EmpMapper empMapper;
	
/*	@Override
	public List<Emp> selectAll() {
		EntityWrapper<Emp> wrapper = new EntityWrapper<Emp>();
		wrapper.orderBy("id");
		System.out.println(wrapper.toString());
		return empMapper.selectList(wrapper);
		
	}*/
	
	@Override
	public void selectDataGrid(PageInfo pageInfo) {
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getPagesize());
		page.setOrderByField(pageInfo.getSort());
		page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
		List<Map<String, Object>> list = empMapper.selectEmpPage(page, pageInfo.getCondition());
		pageInfo.setRows(list);
		pageInfo.setTotal(page.getTotal());
	}
		

	@Override
	public Object insertAll(String string) {
		// TODO Auto-generated method stub
		return empMapper.insertAll(string);
	}

}
