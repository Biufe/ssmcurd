package com.atguigu.crud.test;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.WithDeptResultMap;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * @Author:bing
 * @Date: 2018/11/6 17:28
 * @Version 1.0
 * @todo
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration//@Aatuo只能获取容器里面的bean，不能获取本身，所以要使用这个注解
@ContextConfiguration(locations = {"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class MvcTest {
    @Autowired
    WebApplicationContext context;

    //虚拟mvc请求
    MockMvc mockMvc;

    @Before
    public void initMock(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        //模拟get（或者post等请求）发送请求
            MvcResult result = mockMvc.perform(
                    MockMvcRequestBuilders.get("/emps").
                            param("pn", "1")).andReturn();//参数设置
        //成功发送后，请求域会有pageInfo返回
        MockHttpServletRequest request = result.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("页数："+pageInfo.getPageNum());
        System.out.println("总记录数："+pageInfo.getTotal());
        pageInfo.getNavigatepageNums();
        //获取员工信息
        List<WithDeptResultMap> list = pageInfo.getList();
        for (WithDeptResultMap emp : list
                ) {
            System.out.println(emp.getdId()+" "+emp.getEmpName());
        }
    }
}
