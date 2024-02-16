<%@ page import="java.sql.Timestamp" %>
<%@ page import="Model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: khuongvo
  Date: 14/02/2024
  Time: 08:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%
    String webUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Detail</title>
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
    String id = request.getAttribute("id") == null ? "" : request.getAttribute("id").toString(),
            content = request.getAttribute("content") == null ? "" : request.getAttribute("content").toString(),
            title = request.getAttribute("title") == null ? "" : request.getAttribute("title").toString(),
            author = request.getAttribute("author") == null ? "" : request.getAttribute("author").toString();
    Timestamp time = request.getAttribute("time") == null ? null : (Timestamp) request.getAttribute("time");

    Object obj = request.getSession().getAttribute("user");
    User user = null;
    if (obj != null && !(obj instanceof String)) {
        user = (User) obj;
    }
%>
<c:if test="${id eq ''} ">
    <%
        response.sendError(HttpServletResponse.SC_NOT_FOUND);
    %>
</c:if>
<c:if test="${content eq '' || title eq '' || empty time || author eq ''}">
    <%
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    %>
</c:if>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div class="container-lg">
    <div class="row py-4">
        <%--Article--%>
        <div id="article" class="col-lg-8 col-12 border border-danger p-3">
            <div class="w-100 d-flex justify-content-between align-items-center my-2">
                <a href="">Tag</a>
                <p class="fw-light mb-0 text-secondary"><%=time%>
                </p>
            </div>
            <h1 class=""><%=title%>
            </h1>
            <p class="d-inline">By </p>
            <p class="d-inline fw-semibold text-danger"><%=author%>
            </p>
            <input type="hidden" id="content-id" name="content-id" value="<%=id%>">
            <hr>
            <div class="content">
                <!--Overwrite content at here-->
                <%=content%>
            </div>
        </div>
        <%--Relation--%>
        <div id="propose" class="col-lg-4 col-12 d-lg-inline d-flex overflow-x-scroll" id="propose">
            <h3 class="border-start border-5 ps-2 border-danger d-lg-inline d-none">Latest on [Topic]</h3>
            <hr class="w-75 d-lg-block d-none">
            <%--Add more content--%>
        </div>
        <%--Comment--%>
        <div id="comment" class="col-lg-8 col-12 my-5" id="support-more">
            <div>
                <h5 class="border-start border-4 border-danger ps-2">Comment (0)</h5>
                <%--Insert comment--%>
                <form id="insert-comment" class="border p-3 border-danger rounded-2 my-2">
                    <div class="form-floating mb-3">
                        <input type="email" class="form-control" id="email-inp-cmt" placeholder="name@example.com"
                               required>
                        <label for="email-inp-cmt">Email address</label>
                    </div>
                    <div class="form-floating">
                        <textarea class="form-control" placeholder="Leave a comment here"
                                  id="text-inp-cmt" required></textarea>
                        <label for="text-inp-cmt">Comments</label>
                    </div>
                    <div class="w-100 d-flex justify-content-end mt-2">
                        <button id="send-comment" type="button" class="btn btn-sm btn-primary">Comment</button>
                    </div>
                </form>
                <%--Load comment from orther--%>
                <div id="order-comment" class="my-2">
<%--                    <div class="block-comment my-3 position-relative border-top">--%>
<%--                        <p><b>username</b></p>--%>
<%--                        <p class="w-75">this is a comment</p>--%>
<%--                        <div class="position-absolute top-0 end-0 d-flex align-items-center">--%>
<%--                            <p class="mb-0">11/02/2024 07:54 GMT+7</p>--%>
<%--                            <input type="hidden" name="comment_id" value="1">--%>
<%--                            <c:if test="${not empty user}">--%>
<%--                                <button class="btn btn-sm border-0" type="button">--%>
<%--                                    <svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" viewBox="0 0 24 24">--%>
<%--                                        <path fill="currentColor"--%>
<%--                                              d="M2 5.27L3.28 4L20 20.72L18.73 22l-3.08-3.08c-1.15.38-2.37.58-3.65.58c-5 0-9.27-3.11-11-7.5c.69-1.76 1.79-3.31 3.19-4.54zM12 9a3 3 0 0 1 3 3a3 3 0 0 1-.17 1L11 9.17A3 3 0 0 1 12 9m0-4.5c5 0 9.27 3.11 11 7.5a11.79 11.79 0 0 1-4 5.19l-1.42-1.43A9.862 9.862 0 0 0 20.82 12A9.821 9.821 0 0 0 12 6.5c-1.09 0-2.16.18-3.16.5L7.3 5.47c1.44-.62 3.03-.97 4.7-.97M3.18 12A9.821 9.821 0 0 0 12 17.5c.69 0 1.37-.07 2-.21L11.72 15A3.064 3.064 0 0 1 9 12.28L5.6 8.87c-.99.85-1.82 1.91-2.42 3.13"/>--%>
<%--                                    </svg>--%>
<%--                                </button>--%>
<%--                            </c:if>--%>
<%--                        </div>--%>
<%--                    </div>--%>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>
<script>
    $(document).ready(function () {
        // truncate Title With Tooltip
        $('div#propose a>p.title').each(function () {
            var maxLength = 100; // Số lượng ký tự tối đa
            var text = $(this).text();
            if (text.length > maxLength) {
                $(this).text(text.substring(0, maxLength) + '...');
            }
            // Thêm thuộc tính data-bs-title
            $(this).attr('data-bs-toggle', 'tooltip');
            $(this).attr('data-bs-placement', 'top');
            $(this).attr('data-bs-title', text);
        });

        $('div.block-comment button').click(function () {
            const content = $(this).closest('div.block-comment').find('input[type=hidden]').val()
            console.log(content)
            $.ajax({
                url: "document",
                type: "POST",
                data: {
                    action: "delete",
                    content_id: content
                },
                success: function (data) {

                },
                error: function () {

                }
            })
        })

        // Khởi tạo tooltip
        $('[data-bs-toggle="tooltip"]').tooltip();

        $.ajax({
            url: "document",
            type: "get",
            data: {
                action: "load-same",
                topic: ""
            },
            success: function (data) {
                console.log('data: ' + data)
                let dataArray = JSON.parse(data)
                let proposeDiv = $('div#propose')
                dataArray.forEach((article, index) => {
                    // Tạo một thẻ 'a' mới
                    var link = $("<a></a>").addClass("d-flex justify-content-start").attr("href", "<%=webUrl%>/document?action=detail&content_id=" + article.id);

                    // Tạo thẻ 'img' và thêm thuộc tính src và alt
                    var img = $("<img>").attr("src", '<%=webUrl%>/Resources/' + article.thumbnail).attr("alt", "").addClass("rounded-4 w-25 me-3");

                    // Tạo thẻ 'p' và thêm class và nội dung title
                    var title = $("<p></p>").addClass("title text-start w-50").text(article.title);

                    // Gắn thẻ 'img' và 'p' vào thẻ 'a'
                    link.append(img);
                    link.append(title);

                    // Gắn thẻ 'a' vào phần tử 'div' #propose
                    proposeDiv.append(link);
                })
            },
            error: function (xhr) {
                console.error(xhr)
            }
        })

        $('#send-comment').click(function () {
            // Lấy giá trị email và comment từ input và textarea
            let email = $('#email-inp-cmt').val();
            let comment = $('#text-inp-cmt').val();

            // Kiểm tra email hợp lệ
            if (!isValidEmail(email)) {
                alert("Invalid email address. Please enter a valid email.");
                return;
            }

            // Kiểm tra comment hợp lệ
            if (!isValidComment(comment)) {
                alert("Invalid comment. Please enter a valid comment.");
                return;
            }

            // Nếu cả email và comment đều hợp lệ, gửi AJAX request
            insertComment(email, comment);
        });
        loadComment()
    })

    // Hàm kiểm tra email hợp lệ
    function isValidEmail(email) {
        // Sử dụng regex để kiểm tra định dạng email
        let emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    }

    // Hàm kiểm tra comment hợp lệ
    function isValidComment(comment) {
        // Bạn có thể thực hiện các kiểm tra khác cho comment ở đây
        // Ví dụ: độ dài tối thiểu, độ dài tối đa, các ký tự đặc biệt, v.v.
        return comment.trim() !== ''; // Đơn giản kiểm tra xem comment có trống không
    }

    function insertComment() {
        let email = $('input#email-inp-cmt').val(),
            comment = $('textarea#text-inp-cmt').val();

        $.ajax({
            url: "document",
            method: "get",
            data: {
                action: "insert-comment",
                article_id: $('div#article').find($('input#content-id')).val(),
                email: email,
                comment: comment
            },
            success: function (data) {
                console.log(data);
                // Hiển thị thông báo thành công
                alert("Your comment has been submitted!");
                // reload comments
                loadComment()
            },
            error: function (xhr) {
                console.error(xhr);
                // Hiển thị thông báo lỗi khi gửi ajax
                alert("Error submitting comment. Please try again later.");
            }
        });
    }

    function loadComment() {
        $.ajax({
            url: "document",
            method: "get",
            data: {
                action: "load-comment",
                content_id: $('div#article').find($('input#content-id')).val()
            },
            success: function (data) {
                console.log('data: ' + data)

                // delete all old comment
                $('div#order-comment').empty()

                let comments = JSON.parse(data)
                comments.forEach((cmt, index) => {
                    let commentHtml = `<div class="block-comment my-3 position-relative border-top">
                                    <p><b>` + cmt.email + `</b></p>
                                    <p class="w-75">` + cmt.comment + `</p>
                                    <div class="position-absolute top-0 end-0 d-flex align-items-center">
                                        <p class="mb-0">` + cmt.time + `</p>
                                        <input type="hidden" value="` + cmt.article_id + `">
                                        <c:if test="${not empty user}">
                                            <button class="btn btn-sm border-0" type="button">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" viewBox="0 0 24 24">
                                                    <path fill="currentColor"
                                                        d="M2 5.27L3.28 4L20 20.72L18.73 22l-3.08-3.08c-1.15.38-2.37.58-3.65.58c-5 0-9.27-3.11-11-7.5c.69-1.76 1.79-3.31 3.19-4.54zM12 9a3 3 0 0 1 3 3a3 3 0 0 1-.17 1L11 9.17A3 3 0 0 1 12 9m0-4.5c5 0 9.27 3.11 11 7.5a11.79 11.79 0 0 1-4 5.19l-1.42-1.43A9.862 9.862 0 0 0 20.82 12A9.821 9.821 0 0 0 12 6.5c-1.09 0-2.16.18-3.16.5L7.3 5.47c1.44-.62 3.03-.97 4.7-.97M3.18 12A9.821 9.821 0 0 0 12 17.5c.69 0 1.37-.07 2-.21L11.72 15A3.064 3.064 0 0 1 9 12.28L5.6 8.87c-.99.85-1.82 1.91-2.42 3.13"/>
                                                </svg>
                                            </button>
                                        </c:if>
                                    </div>
                                </div>`;
                    $('#order-comment').append(commentHtml);
                })
            },
            error: function (xhr) {
                console.error(xhr)
            }
        })
    }

    //     Bootstrap
    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
    const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))
</script>
</body>
</html>
