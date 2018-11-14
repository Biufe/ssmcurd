<%--
  Created by IntelliJ IDEA.
  User: bing
  Date: 2018/11/6
  Time: 16:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<html>
<head>
    <title>员工列表</title>
    <%--不以/开始的相对路径，找资源，从当前资源的路径为基准--%>
    <%--以/开始的相对路径，找资源，从服务器的跟目录开始，需要加上项目名称--%>
    <script type="text/javascript" href="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="http://cdn.bootcss.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap.min.css">
    <%--<link rel="stylesheet" href="${APP_PATH }/static/bootstrap-4.1.3-dist/css/bootstrap.min.css">--%>
    <%--<script type="text/javascript" src="${APP_PATH }/static/bootstrap-4.1.3-dist/js/bootstrap.js" ></script>--%>

</head>
<body>
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
                <button class="btn btn-primary btn-sm">新增</button>
                <button class="btn btn-danger btn-sm">删除</button>
            </div>
        </div>
        <%--表格展示数据--%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover">
                    <tr>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>

                    <c:forEach items="${pageInfo.list }" var="emp">
                        <tr>
                            <th>${emp.empId }</th>
                            <th>${emp.empName }</th>
                            <th>${emp.gender!="m"?"男":"女" }</th>
                            <th>${emp.email }</th>
                            <th>${emp.department.deptName }</th>
                            <th>
                                <button class="btn btn-primary btn-sm">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
                                </button>
                                <button class="btn btn-danger btn-sm">
                                    <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
                                </button>
                            </th>
                        </tr>
                    </c:forEach>

                </table>
            </div>
        </div>
        <%--<!--下导航栏-->--%>
        <div class="row">
            <div class="col-md-6">
                当前${pageInfo.pageNum }页,总共${pageInfo.pages }页，总共${pageInfo.total }条记录
            </div>
            <div class="col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li><a href="${APP_PATH }/emps?pn=1">首页</a></li>
                        <c:if test="${pageInfo.hasPreviousPage }">
                            <li>
                                <a href="${APP_PATH }/emps/?${pageInfo.pageNum-1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>

                        <c:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
                            <c:if test="${page_Num == pageInfo.pageNum }">
                                <li class="active"><a href="#">${page_Num }</a></li>
                            </c:if>
                            <c:if test="${page_Num != pageInfo.pageNum }">
                                <li ><a href="${APP_PATH }/emps?pn=${page_Num }">${page_Num }</a></li>
                            </c:if>

                        </c:forEach>
                        <c:if test="${pageInfo.hasNextPage }">
                            <li>
                                <a href="${APP_PATH }/emps?pn=${pageInfo.pageNum+1 }" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <li><a href="${APP_PATH }/emps?pn=${pageInfo.pages}">末页</a></li>
                    </ul>
                </nav>
            </div>
        </div>

    </div>
</body>
</html>
