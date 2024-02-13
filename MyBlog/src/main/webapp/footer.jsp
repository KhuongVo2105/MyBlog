<%--
  Created by IntelliJ IDEA.
  User: khuongvo
  Date: 13/02/2024
  Time: 10:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%
    String webUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
%>
<!--Footer-->
<div class="container">
    <footer class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top">
        <div class="col-md-4 d-flex align-items-center">
            <a href="/" class="mb-3 me-2 mb-md-0 text-body-secondary text-decoration-none lh-1">
                <img src="<%=webUrl%>/Resources/logo.svg" height="40" alt="Home" srcset="">
            </a>
            <span class="mb-3 mb-md-0 text-body-secondary">© 2023 Company, Inc</span>
        </div>

        <ul class="nav col-md-4 justify-content-end list-unstyled d-flex">
            <li class="ms-3"><a class="text-body-secondary" href="#">
                <img src="<%=webUrl%>/Resources/icons--instagram.svg" height="24" alt="my instagram" srcset="">
            </a></li>
            <li class="ms-3"><a class="text-body-secondary" href="#">
                <img src="<%=webUrl%>/Resources/icons--linkedin.svg" height="24" alt="my linkedin" srcset="">
            </a></li>
            <li class="ms-3"><a class="text-body-secondary" href="#">
                <img src="<%=webUrl%>/Resources/logos--facebook.svg" height="24" alt="my facebook" srcset="">
            </a></li>
            <li class="ms-3"><a class="text-body-secondary" href="#">
                <img src="<%=webUrl%>/Resources/logos--github.svg" height="24" alt="my github" srcset="">
            </a></li>
        </ul>
    </footer>
</div>
