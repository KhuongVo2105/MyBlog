<%@ page import="Model.User" %><%--
  Created by IntelliJ IDEA.
  User: khuongvo
  Date: 13/02/2024
  Time: 10:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%
    String webUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
%>
<!--Header-->
<nav class="navbar navbar-expand-lg bg-body-tertiary sticky-top" aria-label="Thirteenth navbar example">
    <div class="container-fluid">
        <button class="navbar-toggler mb-3" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsExample11"
                aria-controls="navbarsExample11" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse d-lg-flex" id="navbarsExample11">
            <a class="navbar-brand col-lg-3 me-0" href="#">
                <img src="<%=webUrl%>/Resources/logo.svg" width="40" alt="" srcset="">
            </a>
            <ul class="navbar-nav col-lg-6 justify-content-lg-center">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="#">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">About</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%=webUrl%>/Blog.jsp">Blog</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Contact</a>
                </li>
            </ul>
            <div class="d-lg-flex col-lg-3 justify-content-lg-around">
                <!--Searching bar-->
                <form class="position-relative d-flex align-items-center mt-3 mb-lg-0 mb-3 mt-lg-0" role="search">
                    <input class="form-control me-2 rounded-pill" type="search" placeholder="Search"
                           aria-label="Search">
                    <button class="position-absolute top-50 end-0 translate-middle-y border-0 bg-light rounded-circle me-3"
                            type="submit">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 512 512">
                            <path fill="currentColor"
                                  d="M456.69 421.39L362.6 327.3a173.81 173.81 0 0 0 34.84-104.58C397.44 126.38 319.06 48 222.72 48S48 126.38 48 222.72s78.38 174.72 174.72 174.72A173.81 173.81 0 0 0 327.3 362.6l94.09 94.09a25 25 0 0 0 35.3-35.3M97.92 222.72a124.8 124.8 0 1 1 124.8 124.8a124.95 124.95 0 0 1-124.8-124.8"></path>
                        </svg>
                    </button>
                </form>

                <!--Donation button-->
                <%
                    Object obj = request.getSession().getAttribute("user");
                    User user = null;
                    if (obj != null && !(obj instanceof String)) {
                        user = (User) obj;
                    }
                    if (user == null) {
                %>
                <button class="justify-content-lg-end btn btn-primary shadow-4 d-flex align-items-end w-auto"
                        data-bs-toggle="modal"
                        data-bs-target="#donation">
                    <p class="m-0 d-lg-none d-inline me-2">Give me a cup of coffee</p>
                    <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 24 24">
                        <path fill="#ffffff" fill-rule="evenodd"
                              d="M2.25 11.88c-.01.177.015.39.065.818l.401 3.428A5.515 5.515 0 0 0 8.193 21h3.614a5.515 5.515 0 0 0 5.028-3.25H19a3.75 3.75 0 1 0 0-7.5h-2.279a1.996 1.996 0 0 0-.618-.22c-.174-.03-.39-.03-.82-.03H4.717c-.43 0-.645 0-.819.03a2 2 0 0 0-1.646 1.85m15.487-.13c.005.043.01.087.012.13c.01.177-.014.39-.064.818l-.401 3.428l-.016.124H19a2.25 2.25 0 0 0 0-4.5zM10.53 1.47a.75.75 0 0 1 0 1.06a.666.666 0 0 0 0 .94a2.164 2.164 0 0 1 0 3.06a.75.75 0 0 1-1.06-1.06c.26-.26.26-.68 0-.94a2.164 2.164 0 0 1 0-3.06a.75.75 0 0 1 1.06 0m-4.5 1.5a.75.75 0 0 1 0 1.06l-.116.116a.691.691 0 0 0-.064.904a2.191 2.191 0 0 1-.204 2.864l-.116.116a.75.75 0 0 1-1.06-1.06l.116-.116a.691.691 0 0 0 .064-.904a2.191 2.191 0 0 1 .204-2.864l.116-.116a.75.75 0 0 1 1.06 0m9.5 0a.75.75 0 0 1 0 1.06l-.116.116a.691.691 0 0 0-.064.904a2.191 2.191 0 0 1-.204 2.864l-.116.116a.75.75 0 1 1-1.06-1.06l.116-.116a.691.691 0 0 0 .064-.904a2.191 2.191 0 0 1 .204-2.864l.116-.116a.75.75 0 0 1 1.06 0"
                              clip-rule="evenodd"/>
                    </svg>
                </button>
                <%
                } else {
                %>
                <%--For Admin--%>
                <div class="dropdown">
                    <button class="justify-content-lg-end btn btn-light d-flex align-items-end w-auto"
                            data-bs-toggle="dropdown">
                        <p class="m-0 d-lg-none d-inline me-2">More</p>
                        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 32 32">
                            <path fill="currentColor"
                                  d="M13 7a3 3 0 1 0 6 0a3 3 0 0 0-6 0m0 9a3 3 0 1 0 6 0a3 3 0 0 0-6 0m0 9a3 3 0 1 0 6 0a3 3 0 0 0-6 0"/>
                        </svg>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a href="#" class="dropdown-item">Donation</a></li>
                        <li><a id="logout" class="dropdown-item text-danger" href="<%=webUrl%>/user?action=log-out">Logout</a></li>
                    </ul>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </div>
</nav>
<!--Donate-->
<div id="donation" class="modal fade" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Give me a cup of coffee</h5>
            </div>
            <div class="modal-body">
                <img src="<%=webUrl%>/Resources/BIDV.jpg" class="w-100" alt="" srcset="">
            </div>
            <!--            <div class="modal-footer">-->
            <!--                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>-->
            <!--                <button type="button" class="btn btn-primary">Save changes</button>-->
            <!--            </div>-->
        </div>
    </div>
</div>
<script>
    $(document).ready(function (){
        $('a#logout').click(function (){
            return (confirm("Do you want to log out?"))
        })
    })

    const myModal = document.getElementById('myModal')
    const myInput = document.getElementById('myInput')

    myModal.addEventListener('shown.bs.modal', () => {
        myInput.focus()
    })
</script>