package com.atguigu.crud.controller;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.MSG;
import com.atguigu.crud.service.DepaertmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @Author:bing
 * @Date: 2018/11/7 14:18
 * @Version 1.0
 * @todo
 */

@Controller
public class DepartmentController {
    @Autowired
    private DepaertmentService depaertmentService;

    @RequestMapping("/depts")
    @ResponseBody
    public MSG getDepts(){
        List<Department> list = depaertmentService.findAllDepts();
        return MSG.success().add("depts",list);
    }
}
