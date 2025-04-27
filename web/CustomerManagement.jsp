<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@include file="staffHeader.jsp" %>

<%
    // Simulate login session (remove this block in actual implementation)
//    // session.setAttribute("role", "manager"); // or "staff"
//
//    String role = (String) session.getAttribute("role");
    if (role == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String keyword = request.getParameter("search");
    String deleteId = request.getParameter("delete");

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection("jdbc:derby://localhost:1527/ass", "nbuser", "nbuser");

        // Delete logic (only for manager)
        if ("manager".equals(role) && deleteId != null && !deleteId.isEmpty()) {
            stmt = conn.prepareStatement("DELETE FROM Customer WHERE custId = ?");
            stmt.setString(1, deleteId);
            stmt.executeUpdate();
            stmt.close();
        }

        // Search query
        String sql = "SELECT * FROM Customer";
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " WHERE custId LIKE ? OR custName LIKE ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + keyword + "%");
            stmt.setString(2, "%" + keyword + "%");
        } else {
            stmt = conn.prepareStatement(sql);
        }

        rs = stmt.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Management</title>
    <style>
        
            .content-area {
                flex: 2;
                padding: 10px;
                width:100%;
                margin-left: 250px;
                margin-right: 50px;
            }
            
            table {
                font-family: arial, sans-serif;
                border-collapse: collapse;
                width: 100%;
                
              }
              
              thead{
                  background-color: #f2f2f2;
                  font-weight: bold;
              }

              td, th {
                border: 1px solid #dddddd;
                text-align: left;
                padding: 8px;
              }

              .edit-btn{
                background-color:#8cd98c;
                color:#ffffff;
                border: 1px solid green;
                padding: 10px 20px;
                text-align: center;
                text-decoration: none;
                font-weight: bold;
                display: inline-block;
              }
              
              .delete-btn{
                background-color:#ff704d;
                color:#ffffff;
                border: 1px solid green;
                padding: 10px 20px;
                text-align: center;
                text-decoration: none;
                font-weight: bold;
                display: inline-block;
              }

              .search{
                display: flex;
                justify-content: flex-end;
                margin-bottom: 15px;
              }
              
              
              #searchText{
                height:30px;
              }
              
              #search-btn,#filter{
                height:35px;
              }
              
              .btn-add{
                background-color:#5c85d6;
                color:#ffffff;
                border: 1px solid green;
                padding: 10px 20px;
                text-align: center;
                text-decoration: none;
                font-weight: bold; 
                display: inline-block;
                align-items: center;
                justify-content: center;
                height: 55px;
              }
              
            .filter {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .role-banner{ 
                text-align: center; 
                margin-bottom: 10px; 
                color: darkblue; 
                font-weight: bold; 
            }
            
    </style>
</head>
<body>
    
<div class="content-area">
   
<h1>Customer List</h1>

<%--filter--%>
<div class="filter">
    
    <div style="text-align: center; margin-bottom: 20px; display: flex; align-items: center; justify-content: center;">
        <% if ("manager".equals(role)) { %>
        <form action="AddCustomer.jsp" method="get">
            <button type="submit" class="btn-add">
                Add Customer
            </button>
        </form>
        <% }%>
    </div>

<div class="search">
    
<!-- Search Form -->
<form method="get">
    <input type="text" id="searchText" name="search" placeholder="Search by ID or Name" value="<%= (keyword != null ? keyword : "") %>">
    <input type="submit" value="Search" id="search-btn">
</form>
</div>
</div>

<!-- Customer Table -->

<table>
    <thead>
        <tr style="height:70px">
            <th>ID</th>
            <th>Name</th>
            <th>Contact No</th>
            <th>Email</th>
            <th>Username</th>
            <% if ("manager".equals(role)) { %>
                <th>Password</th>
            <% } else { %>
                <th>Password</th>
            <% } %>
            <th colspan="2">Action</th>
        </tr>
    </thead>
    <tbody>
        <%
            boolean hasData = false;
            while (rs.next()) {
                hasData = true;
        %>
        <tr>
            <td><%= rs.getString("custId") %></td>
            <td><%= rs.getString("custName") %></td>
            <td><%= rs.getString("custContactNo") %></td>
            <td><%= rs.getString("custEmail") %></td>
            <td><%= rs.getString("custUserName") %></td>
            <td>
                <% if ("manager".equals(role)) { %>
                    <%= rs.getString("custPswd") %>
                <% } else { %>
                    ••••••••
                <% } %>
            </td>
            
            <% if ("manager".equals(role)) { %>
            <td style="text-align:center; vertical-align:middle;">

                    <!-- Edit Button -->
                    <form action="EditCustomer.jsp" method="get" style="display:inline;">
                        <input type="hidden" name="custId" value="<%= rs.getString("custId") %>">
                        <input type="submit" value="Edit" class="edit-btn">
                    </form>
            </td>
            <td style="text-align:center; vertical-align:middle;">
                    <!-- Delete Button -->
                    <form method="get" style="display:inline;">
                        <input type="hidden" name="delete" value="<%= rs.getString("custId") %>">
                        <input type="submit" value="Delete" class="delete-btn" onclick="return confirm('Are you sure?')" style="text-align:center; vertical-align:middle;">
                    </form>
            </td>
            <% } else { %>
            <td colspan="2"><em>View Only</em></td>
            <% } %>
            
        </tr>
        <%
            }
            if (!hasData) {
        %>
        <tr><td colspan="8">No customers found.</td></tr>
        <%
            }
        %>
    </tbody>
</table>
</div>
</body>
</html>

<%
    } catch (Exception e) {
        out.println("<p style='color:red; text-align:center;'>Error: " + e.getMessage() + "</p>");
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception ignored) {}
        if (stmt != null) try { stmt.close(); } catch (Exception ignored) {}
        if (conn != null) try { conn.close(); } catch (Exception ignored) {}
    }
%>
