package com.atguigu.crud.test;

import com.atguigu.crud.bean.Employee;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * @Author:bing
 * @Date: 2018/11/14 11:26
 * @Version 1.0
 * @todo
 */
public class JdbcTest {
    public static void main(String[] args) throws Exception {
        Class.forName("com.mysql.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3366/ssm_crud","root","root");
        Statement stmt = cn.createStatement();
        ResultSet resultSet = stmt.executeQuery("select * from tbl_emp where emp_id = 2");
        Employee employee = new Employee();
        while(resultSet.next()){
            employee.setdId(resultSet.getInt("emp_id"));
        }
        System.out.println(employee);
    }
}
