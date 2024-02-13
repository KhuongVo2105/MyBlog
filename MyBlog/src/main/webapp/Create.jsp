<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="Model.User" %><%--
  Created by IntelliJ IDEA.
  User: khuongvo
  Date: 13/02/2024
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%
    String webUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Create</title>
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
    <!--TinyMCE-->
    <script src="https://cdn.tiny.cloud/1/cey9747ernauvj3m12r00l37wtfjwg9qr0e06msscbd9ea95/tinymce/6/tinymce.min.js"
            referrerpolicy="origin"></script>
</head>
<%
    Object obj = request.getSession().getAttribute("user");
    User user = null;
    if (obj != null && !(obj instanceof String)) {
        user = (User) obj;
    }
%>
<c:if test="${user !=null}">
    <body>
    <form action="document" method="post" class="container-lg py-5">
        <input type="hidden" name="action" value="post">
        <textarea name="content" class="tinymce" rows="20"></textarea>
        <input type="submit" class="btn btn-outline-primary" value="Post it">
    </form>
    <script>

        //     TinyMCE
        tinymce.init({
            selector: '.tinymce',
            plugins: 'ai tinycomments mentions anchor autolink charmap codesample emoticons image link lists media searchreplace table visualblocks wordcount checklist mediaembed casechange export formatpainter pageembed permanentpen footnotes advtemplate advtable advcode editimage tableofcontents mergetags powerpaste tinymcespellchecker autocorrect a11ychecker typography inlinecss',
            toolbar: 'undo redo | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table mergetags | align lineheight | tinycomments | checklist numlist bullist indent outdent | emoticons charmap | removeformat',
            tinycomments_mode: 'embedded',
            tinycomments_author: 'Author name',
            mergetags_list: [
                {value: 'First.Name', title: 'First Name'},
                {value: 'Email', title: 'Email'},
            ],
            ai_request: (request, respondWith) => respondWith.string(() => Promise.reject("See docs to implement AI Assistant")),
        });
    </script>
    </body>
</c:if>
<c:if test="${user ==null}">
<%
  response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
%>
</c:if>
</html>
