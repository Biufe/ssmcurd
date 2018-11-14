package com.atguigu.crud.test;

import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmployeeMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * @Author:bing
 * @Date: 2018/11/5 16:48
 * @Version 1.0
 * @todo 测试dao层是否联通数据库
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})//可直接获得容器内的对象
public class mapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Test
    public void testCurd(){
        System.out.println(departmentMapper);
        System.out.println(employeeMapper);

    }
}
