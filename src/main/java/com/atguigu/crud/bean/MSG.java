package com.atguigu.crud.bean;

import com.github.pagehelper.PageInfo;

import java.util.HashMap;
import java.util.Map;

/**
 * @Author:bing
 * @Date: 2018/11/7 8:57
 * @Version 1.0
 * @todo
 */
public class MSG {
    //100 成功  200 失败
    private String code;
    private String msg;
    private Map<String,Object> extend = new HashMap<>();


    public static MSG success(){
        MSG msg = new MSG();
        msg.setCode("100");
        msg.setMsg("success");
        return msg;
    }

    public static MSG fail(){
        MSG msg = new MSG();
        msg.setCode("200");
        msg.setMsg("fail");
        return msg;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }

    //返回她本身，可以进行链式擦操作
    public MSG add(String key, Object page) {
        this.getExtend().put(key,page);
        return this;
    }
}
