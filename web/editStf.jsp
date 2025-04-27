<%-- 
    Document   : editStf
    Created on : Apr 27, 2025, 7:23:30 PM
    Author     : Mei Yen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Staff" %>
<%@ page import="model.StaffDA" %>
<%@ page import="java.sql.*" %>
<%
    session.getAttribute("role"); // or "staff"

    String role = (String) session.getAttribute("role");
    
    if (role == null) { //not admin and not staff
        response.sendRedirect("NoAccess.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Staff</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <script>
        function confirmUpdate() {
            return confirm("Are you sure you want to update your profile?");
        }

        function goBack() {
            window.location.href = "index.jsp";
        }
        </script>
        
        <style>
            body{
                background-color: #f9f9f9;
            }
            
            .form-container{
                width: 600px;
                margin: 100px auto;
                padding: 40px;
                border: 1px solid #ccc;
                background-color: white;
                box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            }
            
            input[type=text],input[type=number],input[type=email],input[type=password] {
                width: 95%;
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 3px;
            }
           
            label{
                margin: 12px 12px 10px 0;
                display: inline-block;
            }
            
            button {
                width:49%;
                margin:15px 0px;
                box-sizing:border-box;
                height:50px;
                font-weight: bold;
                font-size: 20px;
                background-color: #e3e1e1;
                border: none;
                color: #595959;
            }

            .shadow:hover {
                box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
            }
            
        </style>
        
    </head>
    <body>
        <!--used by admin-->
        
    <%Staff stf = (Staff) session.getAttribute("editStf");%>
    <div class="form-container">
        <span onclick="window.location.href='StaffManagement.jsp';" style="float:right; cursor:pointer;"><i class="fa fa-times" aria-hidden="true" style='font-size:25px'></i></span>
        
        <h1>Edit Staff</h1>
        
        <form action="EditStaffServlet" method="post" onsubmit="return confirmUpdate();">
            <input type="hidden" name="staffId" value="<%= stf.getStaffid() %>">

            <label>Name:</label>
            <input type="text" name="stfName" value="<%= stf.getStfname() %>" required>

            <label>Contact No:</label>
            <input type="text" name="stfContactNo" value="<%= stf.getStfcontactno() %>" required>

            <label>Email:</label>
            <input type="email" name="stfEmail" value="<%= stf.getStfemail() %>" required>

            <label>Username:</label>
            <input type="text" name="stfUserName" value="<%= stf.getStfusername() %>" readonly>

            <label>Password:</label>
            <input type="password" name="stfPswd" value="<%= stf.getStfpswd() %>" required>

            <label>Position:</label>
            <input type="text" name="stfPosition" value="<%= stf.getStfposition() %>" required>

            <button type="button" onclick="window.history.back()" class="shadow">CANCEL</button>
            <button type="submit" class="shadow">UPDATE</button>
            
        </form>
    </div>
    </body>
</html>
