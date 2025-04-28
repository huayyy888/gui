<%-- 
    Document   : staffHeader
    Created on : Apr 21, 2025, 8:23:32 PM
    Author     : Mei Yen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if ((username == null || role == null)) {
        response.sendRedirect("login.jsp?error=Please login first.");
        return;
    }else if("customer".equals(role)){
        response.sendRedirect("NoAccess.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            display: flex;
            background-color: #f9f9f9;
            display: flex;
            flex-wrap: wrap; 
        }

        .sidebar {
            flex: 1;
            background-color: #2c3e50;
            color: white;
            min-height: 100vh;
            padding: 20px;
            max-width: 250px;
            position: fixed;
            left: 0;
            top: 0;
            overflow-y: auto;
        }

        .profile {
            text-align: center;
            margin-bottom: 30px;
        }

        .profile img {
            width: 80px;
            border-radius: 50%;
        }

        .profile h3 {
            margin: 10px 0 0 0;
        }

        .nav-links {
            list-style-type: none;
            padding: 0;
        }

        .nav-links li {
            margin: 20px 0;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }

        .nav-links a:hover {
            text-decoration: underline;
            
        }
        
        ul li:hover{
            background-color: #3b6387;
        }
        
        .fa-caret-down {
            float: right;
            padding-right: 8px;
        }
        
        .dropdown-container {
            display: none;
            background-color: #37495c;
            padding-left: 5px;
        }

        .dropdown-container a {
            color: white;
            text-decoration: none;
            display: block;
            margin: 20px 0;
        }

/*        .dropdown-btn.active {
            background-color: #444;
            color: white;
        }*/

    </style>
</head>
<body>
<div class="sidebar">
    <div class="profile">
        <img src="src/image/profile-manager.jpg" alt="Profile Pic" />
        <h3><%= username %></h3>
        <p><%= role.toUpperCase() %></p>
    </div>

    <div class="nav-wrapper">
    <ul class="nav-links">
        <% if ("staff".equals(role)) { %>
            <li><a href="adminDashboard.jsp">Dashboard</a></li> 
            <li><a href="StaffProfile.jsp">My Profile</a></li>
            <li><a href="CustomerManagement.jsp">Customer Management</a></li>
            <li><a href="AddProdServlet">Product Management</a></li>
            <li><a href="ReviewManagement.jsp">Review Management</a></li>
        <% } else if ("admin".equals(role) || "manager".equals(role)) { %>
            <li><a href="adminDashboard.jsp">Dashboard</a></li> 
            <li><a href="CustomerManagement.jsp">Customer Management</a></li>
            <li><a href="AddProdServlet">Product Management</a></li>
            <li><a href="ReviewManagement.jsp">Review Management</a></li>
            <li><a href="StaffManagement.jsp">Staff Management</a></li>
            <li><a href="#" class="dropdown-btn">Reports <i class="fa fa-caret-down"></i></a></li>
                <div class="dropdown-container">
                    <a href="topSalesReport.jsp" class="dropdown-link">Top 10 Product Report</a>
                    <a href="ReportServlet" class="dropdown-link">Sales Report</a>
                </div>
            
            
        <% } %>
        <li><a href="Logout">Logout</a></li>
    </ul>
    </div>
</div>

    
    <div>
        
    </div>

        <script>
        $(document).ready(function(){
            $(".dropdown-btn").click(function(){
                $(".dropdown-container").toggle();  // Use toggle to show/hide
            });
        });
        </script>

</body>
</html>

