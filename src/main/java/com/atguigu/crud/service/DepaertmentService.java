package com.atguigu.crud.service;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author:bing
 * @Date: 2018/11/7 14:21
 * @Version 1.0
 * @todo
 */
@Service
public class DepaertmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    /**
     * 查询所有部门
     * @return
     */
    public List<Department> findAllDepts() {
        List<Department> list = departmentMapper.selectByExample(null);
        return list;
    }
}
