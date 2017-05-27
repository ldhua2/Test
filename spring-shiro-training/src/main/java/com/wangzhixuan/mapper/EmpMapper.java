package com.wangzhixuan.mapper;

import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.wangzhixuan.model.Emp;

public interface EmpMapper extends BaseMapper<Emp>{

	List<Map<String, Object>> selectEmpPage(Pagination page, Map<String, Object> params);

	Object insertAll(String string);
	
}
