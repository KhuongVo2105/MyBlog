<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="Model.User" %>
<%--
  Created by IntelliJ IDEA.
  User: khuongvo
  Date: 13/02/2024
  Time: 15:16
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
    <title>Blog</title>
    <link rel="icon" href="<%=webUrl%>/Resources/logo.svg" type="images/svg">
    <!--Bootstrap v5.3-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
            crossorigin="anonymous"></script>
    <!--My CSS-->
    <link rel="stylesheet" href="<%=webUrl%>/style.css">
    <!--jQuery-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<%
    Object obj = request.getSession().getAttribute("user");
    User user = null;
    if (obj != null && !(obj instanceof String)) {
        user = (User) obj;
    }
%>
<body>
<jsp:include page="/header.jsp"></jsp:include>
<main>

    <section class="py-5 text-center container">
        <div class="row py-lg-5">
            <div class="col-lg-6 col-md-8 mx-auto">
                <h1 class="fw-light">Album example</h1>
                <p class="lead text-body-secondary">Something short and leading about the collection below—its contents,
                    the creator, etc. Make it short and sweet, but not too short so folks don’t simply skip over it
                    entirely.</p>
                <div class="d-flex m-auto justify-content-center ">
                    <a href="#content" class="btn btn-primary m-2">Scroll down
                        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" viewBox="0 0 24 24">
                            <path fill="currentColor" d="M5 19v-6h2v4h4v2zm12-8V7h-4V5h6v6z"/>
                        </svg>
                    </a>
                    <c:if test="${user==null}">
                        <button class="btn btn-secondary m-2 d-flex align-items-center" data-bs-toggle="modal"
                                data-bs-target="#subscribe">
                            <p class="m-0 me-2">Subscribe now</p>
                            <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" viewBox="0 0 24 24">
                                <path fill="currentColor"
                                      d="M10 21h4a2 2 0 0 1-2 2a2 2 0 0 1-2-2m11-2v1H3v-1l2-2v-6c0-3.1 2.03-5.83 5-6.71V4a2 2 0 0 1 2-2a2 2 0 0 1 2 2v.29c2.97.88 5 3.61 5 6.71v6zm-4-8a5 5 0 0 0-5-5a5 5 0 0 0-5 5v7h10zm2.75-7.81l-1.42 1.42A8.982 8.982 0 0 1 21 11h2c0-2.93-1.16-5.75-3.25-7.81M1 11h2c0-2.4.96-4.7 2.67-6.39L4.25 3.19A10.96 10.96 0 0 0 1 11"/>
                            </svg>
                        </button>
                    </c:if>
                    <c:if test="${user!=null}">
                        <!--For admin-->
                        <a href="Create.jsp" class="btn btn-secondary m-2 d-flex align-items-center">
                            <p class="m-0 me-2">Create now</p>
                            <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" viewBox="0 0 24 24">
                                <path fill="currentColor"
                                      d="M21 14v5a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5v2H5v14h14v-5z"></path>
                                <path fill="currentColor" d="M21 7h-4V3h-2v4h-4v2h4v4h2V9h4z"/>
                            </svg>
                        </a>
                    </c:if>
                </div>
            </div>
        </div>
    </section>

    <div id="content" class="album pt-5 pb-2 bg-body-tertiary">
        <div class="container">

            <div id="card" class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                <%--                <div class="col">--%>
                <%--                    <div class="card shadow-sm">--%>
                <%--                        <div class="box-img"><img src="<%=webUrl%>/Resources/thumbnail-default.jpg" alt=""></div>--%>
                <%--                        <div class="card-body">--%>
                <%--                            <p class="card-text">This is a wider card with supporting text below as a natural lead-in to--%>
                <%--                                additional content. This content is a little bit longer.</p>--%>
                <%--                            <input type="hidden" name="content_id" value="1"/>--%>
                <%--                            <div class="d-flex justify-content-between align-items-center">--%>
                <%--                                <div class="btn-group">--%>
                <%--                                    <a href="<%=webUrl%>/document?action=detail&content_id=1"--%>
                <%--                                       class="btn btn-sm btn-outline-success">View</a>--%>
                <%--                                    <button type="button" class="btn btn-sm btn-outline-primary">Edit</button>--%>
                <%--                                </div>--%>
                <%--                                <small class="text-body-secondary">9 mins</small>--%>
                <%--                            </div>--%>
                <%--                        </div>--%>
                <%--                    </div>--%>
                <%--                </div>--%>
            </div>


        </div>
    </div>
    <div class="d-flex justify-content-center align-items-center w-100 my-3">
        <button id="load-more" type="button" class="btn btn-outline-success">Load more</button>
    </div>

</main>
<jsp:include page="/footer.jsp"></jsp:include>

<!--Subscribe-->
<div id="subscribe" class="modal fade" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body position-relative d-flex align-items-center">
                <input class="form-control me-2 rounded-pill" type="text" placeholder="Enter your email address"
                       aria-label="Search">
                <button class="rounded-pill btn btn-sm btn-outline-primary position-absolute top-50 translate-middle-y"
                        type="button">Subscribe
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        loadmore()
        $('button#load-more').click(loadmore);
        $('button.btn-outline-success').click(view_more);
    })

    let limit = 6;

    function loadmore() {
        $.ajax({
            url: "<%=webUrl%>/document",
            type: "get",
            data: {
                action: "load-more",
                offset: countElements(),
                limit: limit
            },
            success: function (data) {
                console.log("data: " + data)
                // 1. Parse JSON data and handle potential errors:
                let dataArray;
                try {
                    dataArray = JSON.parse(data);
                } catch (error) {
                    console.error("Error parsing JSON data:", error);
                    return; // Early exit in case of parsing errors
                }

                // 2. Select the target container element:
                const cardContainer = $("div#card");

                if (dataArray != null || dataArray.length != 0) {
                    if (dataArray.length<limit){
                        hide_load_more();
                    }
                    // 3. Iterate over each article and create the HTML structure:
                    dataArray.forEach((article, index) => {
                        // 4. Create the card structure using template literals for clarity:
                        const e1 = $("<div></div>").addClass('col')
                        const e2 = $('<div></div>').addClass('card shadow-sm')
                        const e3 = $('<div></div>').addClass('box-img')
                        const e4 = $('<img>').attr('src', '<%=webUrl%>/Resources/' + article.thumbnail).attr('alt', '')
                        const e5 = $('<div></div>').addClass('card-body')
                        const e6 = $('<p></p>').addClass('card-text').html(article.title)
                        const e7 = $('<input>').attr('type', 'hidden').attr('name', 'content_id').attr('value', article.id)
                        const e8 = $('<div></div>').addClass('d-flex justify-content-between align-items-center');
                        // Tạo nhóm nút bấm (btn-group)
                        const e9 = $('<div></div>').addClass('btn-group');
                        // Tạo nút "View"
                        const e10 = $('<a></a>')
                            .addClass('btn btn-sm btn-outline-success')
                            .attr('href', `<%=webUrl%>/document?action=detail&content_id=`+article.id)
                            .text('View');
                        // Tạo nút "Edit"
                        const e11 = $('<button></button>')
                            .addClass('btn btn-sm btn-outline-primary')
                            .text('Edit');
                        // Thêm nút "View" và "Edit" vào nhóm nút
                        e9.append(e10, e11);
                        // Thêm nhóm nút và thời gian vào div d-flex
                        e8.append(e9, $('<small></small>').addClass('text-body-secondary').text(article.time));
                        // Thêm tất cả vào card-body
                        e5.append(e6, e7, e8);
                        // Thêm card-body vào thẻ img
                        e2.append(e3.append(e4), e5);
                        // Thêm thẻ img vào thẻ col
                        e1.append(e2);
                        // Thêm thẻ col vào container
                        cardContainer.append(e1);
                    });
                } else {
                    hide_load_more();
                }
            },
            error: function () {
                console.error()
            }
        })
    }

    // Function to handle the "view more" action. No parameters or return types.
    // This code defines a function called view_more that is triggered by a "view more" action.
    // It finds the nearest div with the class card-body, then finds an input of type hidden within it
    function view_more() {
        const content_id = $(this).closest('div.card-body').find('input[type=hidden]').val()
        console.log(content_id)
        return false
        // $.ajax({
        //     url: "document",
        //     type: "GET",
        //     data: {
        //         action: "detail",
        //         content_id: content_id
        //     },
        //     success: function (data) {
        //
        //     },
        //     error: function () {
        //
        //     }
        // })
    }

    function hide_load_more(){
        $('button#load-more').hide()
    }

    function countElements() {
        return $('.container div.col').length
    }
</script>
</body>
</html>