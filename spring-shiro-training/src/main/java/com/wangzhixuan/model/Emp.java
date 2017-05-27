package com.wangzhixuan.model;

import java.io.Serializable;
import java.util.Date;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.enums.IdType;
import com.wangzhixuan.commons.utils.JsonUtils;

public class Emp implements Serializable{
	private static final long serialVersionUID = -6185821740152652194L;
	
	@TableId(type = IdType.AUTO)
	private Long id;
	@NotBlank
	@Length(min=4,max=64)
	private String name;

	private String dept;
	
	private String job;
	
	private Integer age;

	private Integer sex;
	
	private Integer height;

	@TableField(value = "emp_Type")
	private Integer empType;

	private Integer status;
	
	private String phone;
	@TableField(value = "create_time")
 	private Date createTime;
	
 	
	public Emp() {
	}

	
	public Date getCreateTime() {
		return createTime;
	}


	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}


	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}

	public Integer getSex() {
		return sex;
	}


	public void setSex(Integer sex) {
		this.sex = sex;
	}


	public Integer getAge() {
		return age;
	}


	public void setAge(Integer age) {
		this.age = age;
	}


	public Integer getStatus() {
		return status;
	}


	public void setStatus(Integer status) {
		this.status = status;
	}


	public String getDept() {
		return dept;
	}


	public void setDept(String dept) {
		this.dept = dept;
	}


	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getJob() {
		return job;
	}
	
	
	public void setJob(String job) {
		this.job = job;
	}
	
	
	public Integer getHeight() {
		return height;
	}
	
	
	public void setHeight(Integer height) {
		this.height = height;
	}
	
	
	public Integer getEmpType() {
		return empType;
	}
	
	
	public void setEmpType(Integer empType) {
		this.empType = empType;
	}
	
	
	@Override
	public String toString() {
		return JsonUtils.toJson(this);
	}

}
