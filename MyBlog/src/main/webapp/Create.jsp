<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="Model.User" %>
<%@ page import="Model.Article" %><%--
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
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
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
    <script src="<%=webUrl%>/Resources/tinymce/js/tinymce/tinymce.min.js"
            referrerpolicy="origin"></script>
</head>
<%
    Object obj = request.getSession().getAttribute("user");
    User user = null;
    if (obj != null && !(obj instanceof String)) {
        user = (User) obj;
    }
    Article article = (Article) request.getAttribute("article");
%>
<c:if test="${user !=null}">
    <body>
    <form action="document" method="post" class="container-lg py-5" enctype="multipart/form-data"
          accept-charset="UTF-8">
        <div class="form-floating mb-3">
            <input type="text" id="title" name="title" class="form-control"
                   placeholder="Enter title"
                   value="<c:if test="${article !=null}"><c:out value="${fn:trim(article.title)}"></c:out></c:if>">
            <label for="title">Enter title</label>
        </div>
        <input type="hidden" name="action"
               value="<c:if test="${article!=null}">update</c:if><c:if test="${article ==null}">post</c:if>">
        <c:if test="${article !=null}">
            <input type="hidden" name="id" value="<c:out value="${article.id}"/>">
        </c:if>
        <textarea id="mytextarea" name="content" class="tinymce" rows="40"><c:if test="${article !=null}"><c:out
                value="${article.content}"></c:out></c:if>
        </textarea>
        <input type="submit" class="btn btn-outline-primary" value="Post it">
            <%--        <button type="button">Click</button>--%>
    </form>
    <script>

        // $(document).ready(function () {
        //     $('button[type=button]').click(function () {
        //         var content = tinymce.get("mytextarea").getContent();
        //         console.log(content)
        //     })
        // })

        //     TinyMCE
        tinymce.init({
            selector: '#mytextarea',
            plugins: 'anchor link image table lists bold italic underline strikethrough removeformat',
            toolbar: 'undo redo | link image table | bullist numlist | formatselect fontselect fontsizeselect | bold italic underline strikethrough | removeformat',
            language: 'vi', // Ngôn ngữ tiếng Việt
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
