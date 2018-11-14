<%--
  Created by IntelliJ IDEA.
  User: bing
  Date: 2018/11/6
  Time: 16:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>--%>
<%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<html>
<head>
    <title>员工列表</title>
    <%--不以/开始的相对路径，找资源，从当前资源的路径为基准--%>
    <%--以/开始的相对路径，找资源，从服务器的跟目录开始，需要加上项目名称--%>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="http://cdn.bootcss.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap.min.css">
    <%--<link rel="stylesheet" href="${APP_PATH }/static/bootstrap-4.1.3-dist/css/bootstrap.min.css">--%>
    <%--<script type="text/javascript" src="${APP_PATH }/static/bootstrap-4.1.3-dist/js/bootstrap.js" ></script>--%>

</head>
<body>
<!-- emp修改模态框框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="emp_update_form">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static" ></p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@bin.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="f" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="m"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-md-4">
                            <select class="form-control" name="dId" id="depts_update_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">修改</button>
            </div>
        </div>
    </div>
</div>

<!-- emp增加模态框框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="emp_save_form">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="empName" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@bin.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="f" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="m"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-md-4">
                            <select class="form-control" name="dId" id="depts_add_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <H1>SSM-CRUD</H1>
        </div>
    </div>
    <%--工具栏安按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary btn-sm" id="emp_add_modal">新增</button>
            <button class="btn btn-danger btn-sm" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <%--表格展示数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <td>
                            <input type="checkbox" id="check_all" />
                        </td>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                </thead>

                <%--表数据显示--%>
                <tbody>

                </tbody>

            </table>
        </div>
    </div>
    <%--<!--下导航栏-->--%>
    <div class="row">
        <div class="col-md-6" id="page_info_area">

        </div>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>

</div>

        <script type="text/javascript">
            var totalRecord,currentPage;

            // 1.页面加载完成后，发送ajax请求
            $(function(){
               to_page(1);
            });

            //跳到第几页（方法抽取，添加刷新，删除刷新，首页，末页，下一页）
            function to_page(pn){
                $.ajax({
                    url:"${APP_PATH }/emps",
                    data:"pn="+pn,
                    type:"GET",
                    success:function (result) {
                        // console.log(result);
                        //1.解析员工数据
                        build_emps_table(result);
                        //2解析并显示分页信息
                        build_page_info(result);
                        //3解析显示分页条数
                        build_page_nav(result);
                    }
                });
            }

            //查询数据，填充到table中,填充按键
            function build_emps_table(result) {
                //清空数据
                $("#emps_table tbody").empty();

                var emps = result.extend.pageInfo.list;
                $.each(emps,function (index,item) {
                    // alert(item.empName);
                    //动态创建行信息，在页面加载完之后，发送ajax请求
                    var checkBoxTd =$("<td><input type='checkBox' class='check_item' /></td>")
                    var empIdTd = $("<td></td>").append(item.empId);
                    var empNameTd = $("<td></td>").append(item.empName);
                    var empGenderTd = $("<td></td>").append(item.gender=='m'?'女':'男');
                    var empEmailTd = $("<td></td>").append(item.email);
                    var deptNameTd = $("<td></td>").append(item.department.deptName);
                    var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                        .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                        .append("编辑");
                    // 创建按钮时，为编辑按钮自定义属性
                    editBtn.attr("edit-id",item.empId);
                    // 改按钮样式
                    var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                        .append($("<span></span>").addClass("glyphicon glyphicon-remove"))
                        .append("删除");
                    delBtn.attr("del-id",item.empId);
                    var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
                    //append方法执行完之后，还是返回原来的元素
                    $("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(empGenderTd)
                        .append(empEmailTd).append(deptNameTd).append(btnTd)
                        .appendTo("#emps_table tbody");

                });
            }

            // 查询导航数据 首页末页
            function build_page_nav(result) {
                //清空本身的导航信息，再写入新的导航信息。
                $("#page_info_area").empty();
                $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页,总共"+
                    result.extend.pageInfo.pages+"页，总共"+result.extend.pageInfo.total+" 条记录");
                totalRecord = result.extend.pageInfo.total;
                currentPage = result.extend.pageInfo.pageNum;
            }

            // 记录页数，记录总数信息
            function build_page_info(result) {
                $("#page_nav_area").empty();
                var ul = $("<ul></ul>").addClass("pagination");

                //构建首页，上一页元素
                var firstPageLi = $("<li></li>").append($("<a></a>").append("首页"));
                var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));

                // 如果没有上一页，则无法点击
                if (result.extend.pageInfo.hasPreviousPage == false) {
                    firstPageLi.addClass("disabled");
                    prePageLi.addClass("disabled");
                }

                // 添加调到首页事件  上一页事件
                firstPageLi.click(function () {
                    to_page(1);
                });
                prePageLi.click(function (result) {
                    to_page(result.extend.pageInfo.pageNum-1);
                });


                var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
                var lastPageLi = $("<li></li>").append($("<a></a>").append("末页"));
                nextPageLi.click(function () {
                    to_page(result.extend.pageInfo.pageNum+1);
                })
                lastPageLi.click(function () {
                    to_page(result.extend.pageInfo.pages);
                })
                if (result.extend.pageInfo.hasNextPage == false) {
                    nextPageLi.addClass("disabled");
                    lastPageLi.addClass("disabled");

                }
                ul.append(firstPageLi).append(prePageLi);
                //循环取出页码号
                $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
                    var numLi = $("<li></li>").append($("<a></a>").append(item));//navigatepageNums
                    if (result.extend.pageInfo.pageNum == item) {//一个页码
                        numLi.addClass("active");//当前页码变色
                    }
                    numLi.click(function () {//添加时间
                        to_page(item);
                    });
                    ul.append(numLi);
                });
                ul.append(nextPageLi).append(lastPageLi);
                $("#page_nav_area").append($("<nav></nav>").append(ul));
            }

            //重置表单
            function reset_form(ele){
                $(ele)[0].reset();//jquery中没有重置，取出dom元素再进行重置
                $(ele).find("*").removeClass("has-success has-error");
                $(ele).find(".help-block").text("");

            }

            // 点击新增按钮，弹出模态框
            $("#emp_add_modal").click(function () {

                //清空表单 表单重置
                reset_form("#empAddModal form");
                //查询部门
                getDepts("#empAddModal select");

                //默认弹出框
                $('#empAddModal').modal({backdrop:"static"});

            });

            // 获取部门信息
            function getDepts(ele) {
                $(ele).empty();
                $.ajax({
                    url:"${APP_PATH }/depts",
                    type:"GET",
                    success:function (result) {
                        // console.log(result);
                        $.each(result.extend.depts,function () {
                            var optionEle = $("<option></option>").append(this.deptName)//this = result.extend.depts
                                .attr("value",this.deptId);//value为返回数据库的值
                            optionEle.appendTo(ele);//#empAddModal select
                        })
                    }
                });
            }

            // 校验表单数据
            function validata_add_form(){
                // 名字校验  使用正则 ^任意开始 ｛,｝字数范围
                var empName = $("#empName_add_input").val();
                var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
                if(!regName.test(empName)){
                    // alert("用户名过短！！");
                    show_avalidata_msg("#empName_add_input","error","用户名过短！！");
                    return false;
                }else{
                    show_avalidata_msg("#empName_add_input","success","");
                }

                //邮箱校验
                var email = $("#email_add_input").val();
                var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
                if(!regEmail.test(email)){
                    // alert("邮箱不合法！");?方法抽取
                    show_avalidata_msg("#email_add_input","error","邮箱不合法！");
                    return false;
                }else{
                    show_avalidata_msg("#email_add_input","success","邮箱不合法！");
                }

            return true;
            }

            //显示节点（邮箱，名字）错误信息
            function show_avalidata_msg(ele,status,msg){
                //清除之前的校验状态
                $(ele).parent().removeClass("has-success has-error");
                if("success"==status){
                    $(ele).parent().addClass("has-success");
                    $(ele).next("span").text("");
                }else if("error"==status){
                    $(ele).parent().addClass("has-error");
                    $(ele).next("span").text(msg);
                }
            }

            //s数据库校验用户名是否可用
            $("#empName_add_input").change(function () {
                var empName = this.value;//javascript获取值
               //文本框改变对数据库发送ajax请求
               $.ajax({
                   url:"${APP_PATH }/checkuser",
                   data:"empName="+empName,
                   type:"POST",
                   success:function (result) {
                       if(result.code==100){
                           show_avalidata_msg("#empName_add_input","success","用户名可用");
                            $("#emp_save_btn").attr("ajax-va","success");//给这个按钮添加属性
                       }else{
                           show_avalidata_msg("#empName_add_input","error",result.extend.va_msg);
                           $("#emp_save_btn").attr("ajax-va","error");//给这个按钮添加属性
                       }
                   }
               });
            });

            // 员工保存
            $("#emp_save_btn").click(function() {
                // $("emp_save_form").empty();
                // alert($("#emp_save_form").serialize());

                // 1前端校验数据,用户名 邮箱，模拟可以绕过这验证
                if(!validata_add_form()){
                    return false;
                }

                // 判断ajax状态
                if($(this).attr("ajax-va")=="error")
                {
                    return false;
                }

                // 2.填写模态框的数据保存
                $.ajax({
                    url:"${APP_PATH }/emp",
                    type:"POST",
                    data:$("#emp_save_form").serialize(),
                    success:function(result) {

                        if(result.code==100){
                            // 1，关闭模态框
                            $("#empAddModal").modal("hide");
                            alert(result.msg);
                            // 2.显示最后一页数据 totalRecord全局变量
                            to_page(totalRecord);
                        }else{
                            //显示失败信息  后端jsr校验
                            // console.log(result)

                            if(undefined != result.extend.errorField.email){
                                //邮箱有错误信息
                                show_avalidata_msg("#email_add_input","error",result.extend.errorField.email);

                            }
                            if(undefined != result.extend.errorField.empName){
                                //员工名有错误信息
                                show_avalidata_msg("#empName_add_input","error",result.extend.errorField.empName);
                            }
                        }
                    }
                });
            });

            //创建按钮之前，就绑定click事件，不会器作用
            //jQuery1.7后使用on来绑定  $（父元素）.on(事件，选择器，data，function)
            $(document).on("click",".edit_btn",function () {

                // 查询部门信息
                getDepts("#empUpdateModal select");

                //查出员工信息 编辑按钮上的信息
                getEmp($(this).attr("edit-id"));

                //把员工id从编辑按钮  传到模态框的 更新按钮上
                $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
                //默认弹出框
                $('#empUpdateModal').modal({backdrop:"static"});
            });

            //获取员工信息
            function getEmp(id) {
                $.ajax({
                    url:"${APP_PATH }/emp/"+id,
                    type:"GET",
                    success:function (result) {
                        var empData = result.extend.emp;
                        $("#empName_update_static").text(empData.empName);
                        $("#email_update_input").val(empData.email);
                        $("#empUpdateModal input[name=gender]").val([empData.gender]);
                        $("#empUpdateModal select").val([empData.dId]);
                    }
                })
            }

            $("#emp_update_btn").click(function () {
                //邮箱校验
                var email = $("#email_update_input").val();
                var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
                if(!regEmail.test(email)){
                    // alert("邮箱不合法！");?方法抽取
                    show_avalidata_msg("#email_update_input","error","邮箱不合法！");
                    return false;
                }else{
                    show_avalidata_msg("#email_update_input","success","邮箱不合法！");
                }

                //发送ajax请求保存更新的员工数据
                $.ajax({
                    url:"${APP_PATH }/emp/"+$(this).attr("edit-id"),
                    type:"PUT",
                    data:$("#emp_update_form").serialize(),//serialize()，jQuery封装的获取表单数据序列化函数
                    //ajax支持发put请求+"&_method=PUT",
                    success:function (result) {
                        // alert(result.msg);
                        $("#empUpdateModal").modal("hide");
                        to_page(currentPage);//更新数据
                    }
                })
            });

            //单个删除
            $(document).on("click",".delete_btn",function () {
                var empName = $(this).parents("tr").find("td:eq(2)").text();
                var empId = $(this).attr("del-id");
                if(confirm("确认删除【"+empName+"】吗?")){
                    $.ajax({
                        url:"${APP_PATH}/emp/"+empId,
                        type:"DELETE",
                        success:function (result) {
                            alert(result.msg);
                            to_page(currentPage);
                        }
                    })
                }
            })

            // 全选框
            $("#check_all").click(function () {
                //attr修改自定义属性值，prop修改原生dom属性
                $(".check_item").prop("checked",$(this).prop("checked"))
            })

            // 单选框
            $(document).on("click",".check_item",function () {
                var flag = $(".check_item:checked").length==$(".check_item").length;

                $("#check_all").prop("checked",flag);

            })

            //批量删除、
            $("#emp_delete_all_btn").click(function () {
                var empName = "";
                var empId = "";
                $.each($(".check_item:checked"),function () {
                    empName += $(this).parents("tr").find("td:eq(2)").text()+",";
                    empId += $(this).parents("tr").find("td:eq(1)").text()+"-";
                })
                //取出员工名字
                empName = empName.substring(0,empName.length-1);

                // 取出员工id
                empId = empId.substring(0,empId.length-1);
                if(confirm("确认删除【"+empName+"】吗？")){
                    $.ajax({
                        url:"${APP_PATH}/emp/"+empId,
                        type:"DELETE",
                        success:function (reslut) {
                            alert(reslut.msg);
                            to_page(currentPage);
                        }
                    })
                }
            })

        </script>
</body>
</html>

