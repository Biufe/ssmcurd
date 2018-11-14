package com.atguigu.crud.controller;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.MSG;
import com.atguigu.crud.bean.WithDeptResultMap;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import sun.applet.resources.MsgAppletViewer;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author:bing
 * @Date: 2018/11/6 16:49
 * @Version 1.0
 * @todo
 */

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 批量删除：1-2-3
     * 单个删除：1
     * @param ids
     * @return
     */

    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    public MSG deleteEmpById(@PathVariable(value = "ids") String ids){
        //批量
        if(ids.contains("-")){
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            for (String str_id : str_ids) {
                del_ids.add(Integer.parseInt(str_id));
            }
            employeeService.deleteBatch(del_ids);
            return MSG.success();
        }else {
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmpById(id);
            return MSG.success();
        }
    }

    /**
     * 员工更新
     */
    @ResponseBody
    @RequestMapping(value = "emp/{empId}",method = RequestMethod.PUT)
    public MSG saveEmp(Employee employee){
        System.out.println(employee);
        employeeService.updateEmp(employee);
        return MSG.success();
    }


    /**
     * 员工查询
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    public MSG getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
        return MSG.success().add("emp",employee);
    }

    //检查是否存在该员工
    @ResponseBody
    @RequestMapping("/checkuser")
    public MSG checkuser(@RequestParam("empName") String empName){
        //判断用户名是否合法
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if(!empName.matches(regx)){
            return MSG.fail().add("va_msg","用户名过短。。。后端");
        }

        boolean b = employeeService.checkuser(empName);
        if(b){
            return MSG.success();
        }else {
            return MSG.fail().add("va_msg","用户名不可用，后端。。");
        }
    }

    /**
     * jsr303校验实现
     * @param employee
     * @param result
     * @return
     */
    //保存员工
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public MSG saveEmp(@Valid Employee employee, BindingResult result){
//        System.out.println("save......");
        if(!result.hasErrors()){
            employeeService.saveEmp(employee);
            return MSG.success();
        }else{
            Map<String,Object> map = new HashMap<>();
            List<FieldError> fieldErrors = result.getFieldErrors();//获取所有错误字段
            for (FieldError fieldError : fieldErrors) {
                map.put(fieldError.getField(),fieldError.getDefaultMessage());//错误字段 信息
            }
            return MSG.fail().add("errorField",map);
        }


    }

    @RequestMapping("/emps")
    @ResponseBody
    public MSG getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
        //引入分页插件 pageHelper，结合mabatis使用
        //查询之前只要传入页码，每页的大小。只查出一页数据显示
        PageHelper.startPage(pn,3);
        //startPage后面跟的这个查询就是一个分页查询
        List<WithDeptResultMap> emps = employeeService.getAll();
        //使用pageinfo包装查询后的结果，只需要pageInfo交给页面就行了,显示页面连续显示的页面数 5
        PageInfo page = new PageInfo(emps,3);
        return MSG.success().add("pageInfo",page);
    }


    //@RequestMapping("/emps")//接受请求 pn 为get的参数，默认为1，用model返回pageInfo
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn,
                          Model model){
        //引入分页插件 pageHelper，结合mabatis使用
        //查询之前只要传入页码，每页的大小。只查出一页数据显示
        PageHelper.startPage(pn,3);
        //startPage后面跟的这个查询就是一个分页查询
        List<WithDeptResultMap> emps = employeeService.getAll();
        //使用pageinfo包装查询后的结果，只需要pageInfo交给页面就行了,显示页面连续显示的页面数 5
        PageInfo page = new PageInfo(emps,3);
        model.addAttribute("pageInfo",page);
        return "list";
    }
}
