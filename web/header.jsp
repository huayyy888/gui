<%-- 
    Document   : header
    Created on : Apr 13, 2025, 7:31:04 PM
    Author     : Huay
--%>
<%@page import="java.sql.Blob"%>
<%@page import="java.util.List"%>
<%@page import="model.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Customer customer = (Customer) session.getAttribute("customer");
    String role = (String) session.getAttribute("role");
    String username = (String) session.getAttribute("username");
    String currentCategory = request.getParameter("category");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <!-- CSS -->
        <link rel="stylesheet" type="text/css" href="src/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="src/css/style.css">
        <link rel="stylesheet" href="src/css/responsive.css">
        <link rel="stylesheet" href="src/css/jquery.mCustomScrollbar.min.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/owl-carousel/1.3.3/owl.carousel.css" rel="stylesheet" />

        <!-- Fonts -->
        <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">
        <link href="https://fonts.googleapis.com/css?family=Poppins:400,700&display=swap" rel="stylesheet">
    </head>

    <body>
        <!-- Header Section -->
        <div class="header_section">
            <div class="container-fluid">
                <nav class="navbar navbar-expand-lg navbar-light bg-light">
                    <a class="logo" href="index.jsp"><img src="src/image/logo.png" alt="Logo"></a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" 
                            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <!-- Navigation Links -->
                        <ul class="navbar-nav mr-auto">
                            <li class="nav-item active">
                                <a class="nav-link" href="index.jsp">Home</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="ProductPage.jsp">Product</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="ProductReviewDisplay.jsp">Review</a>
                            </li>
                            
                        </ul>

                        <!-- User Functions -->
                        <form class="form-inline my-2 my-lg-0">
                            <div class="login_menu">
                                <ul>
                                    <% if (username != null && role != null) { %>
                                    <li>
                                        <div class="profile-wrapper">
                                            <a class="nav-link profile-container"
                                               href="<%="manager".equals(role) ? "StaffManagerDashboard.jsp"
                                                    : "staff".equals(role) ? "StaffManagerDashboard.jsp"
                                                    : "CustomerDashboard.jsp"%>">
                                                <span>
                                                    <%
                                                        String displayRole = "";
                                                        if ("manager".equals(role)) {
                                                            displayRole = "Manager ";
                                                        } else if ("staff".equals(role)) {
                                                            displayRole = "Staff ";
                                                        } else {
                                                            displayRole = "Customer ";
                                                        }
                                                    %>
                                                    <%= "Profile " + displayRole + username%>
                                                </span>
                                            </a>
                                            <div class="logout-dropdown">
                                                <a href="Logout">Logout</a>
                                            </div>
                                        </div>
                                    </li>
                                    <% } else { %>
                                    <li>
                                        <a href="CustomerLogin.jsp">
                                            <img src="src/image/user-icon.png" alt="Login">
                                        </a>
                                    </li>
                                    <% } %>
                                    
                                    <% if (username == null || role == null) { %>
                                    <li>
                                        <a href="#" onclick="showLoginFirst(); return false;">
                                            <img src="src/image/trolly-icon.png" alt="Cart">
                                        </a>
                                    </li>
                                    <% } else { %>
                                    <li>
                                        <a href="ShoppingCart.jsp">
                                            <img src="src/image/trolly-icon.png" alt="Cart">
                                        </a>
                                    </li>
                                    <% } %>

                                    <!-- Search Form -->
                                    <li>
                                        <div style="display: flex; align-items: center;">
                                            <input type="text" id="searchInput" placeholder="Search products..." 
                                                   style="padding: 5px; font-size: 14px;" />

                                            <button type="button" onclick="goToProductPage()" style="margin-left: 8px; border: none; background: none; cursor: pointer;">
                                                <img src="src/image/search-icon.png" alt="Search" style="width: 20px; height: 20px;">
                                            </button>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </form>
                    </div>
                </nav>
            </div>
        </div>
        
        <script>
            function showLoginFirst() {
                alert("Please login first to view your cart.");
                window.location.href = "CustomerLogin.jsp";
            }
            
            function goToProductPage() {
                var searchValue = document.getElementById("searchInput").value.trim();
                if (searchValue) {
                    window.location.href = "ProductPage.jsp?search=" + encodeURIComponent(searchValue);
                } else {
                    // Optional: If empty, still go to ProductPage.jsp
                    window.location.href = "ProductPage.jsp";
                }
            }           
        </script>
    </body>
</html>
