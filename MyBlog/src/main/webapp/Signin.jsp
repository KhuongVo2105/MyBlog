<%@ page import="Model.User" %><%--
  Created by IntelliJ IDEA.
  User: khuongvo
  Date: 13/02/2024
  Time: 09:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%
    String webUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Signin</title>
    <link rel="icon" href="<%=webUrl%>/Resources/logo.svg" type="images/png">
    <!--Bootstrap v5.3-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
            crossorigin="anonymous"></script>
    <!--My CSS-->
    <link rel="stylesheet" href="style.css">
    <!--jQuery-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<%
    Object obj = request.getSession().getAttribute("user");
    User user = null;
    if (obj != null && !(obj instanceof  String)) {
        user = (User) obj;
    }
    if (user == null) {
        String err = request.getAttribute("err") == null ? "" : request.getAttribute("err").toString(),
                email = request.getAttribute("email") == null ? "" : request.getAttribute("email").toString();
%>
<body>
<div class="container-fluid h-100 bg-light">
    <div class="row d-flex justify-content-center align-items-center h-100">
        <form class="col-lg-4 col border p-5 rounded-4 shadow" action="signin" method="post">
            <a href="index.html"><img class="mb-4" src="<%=webUrl%>/Resources/logo.svg" alt="" width="72"
                                      height="57"></a>
            <div class="mb-3"><h1 class="h3 mb-0 fw-normal ">Please sign in</h1>
                <div class="text-danger fs-6"><%=err%>
                </div>
            </div>

            <div class="form-floating ">
                <input type="email" class="form-control" id="floatingInput" placeholder="name@example.com" name="email"
                       value="<%=email%>"
                       required>
                <label for="floatingInput">Email address</label>
            </div>
            <div class="form-floating ">
                <input type="password" class="form-control" id="floatingPassword" placeholder="Password" name="password"
                       required>
                <label for="floatingPassword">Password</label>
            </div>
            <button class="btn btn-primary w-100 py-2" type="submit">Sign in</button>
            <p class="mt-5 mb-3 text-body-secondary">© 2023–2024 Company, Inc</p>
        </form>
    </div>
</div>
</body>
<%
    } else {
        response.sendRedirect(webUrl + "/index.jsp");
    }
%>
</html>
