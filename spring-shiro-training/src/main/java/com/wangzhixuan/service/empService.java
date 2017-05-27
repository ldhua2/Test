package com.wangzhixuan.service;

import java.util.List;

import com.baomidou.mybatisplus.service.IService;
import com.wangzhixuan.commons.result.PageInfo;
import com.wangzhixuan.model.Emp;

public interface empService extends IService<Emp>{

	void selectDataGrid(PageInfo pageInfo);

	Object insertAll(String string);

}
