<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.StaffDA" %>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if ((username == null || role == null)) {
        response.sendRedirect("login.jsp?error=Please login first.");
        return;
    }else if("customer".equals(role) || "staff".equals(role)){
        response.sendRedirect("NoAccess.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Add New Staff</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <style>
            body {
                font-family: Arial, sans-serif;
                max-width: 600px;
                margin: 2em auto;
            }
            
            .form-container{
                width: 600px;
                margin: 100px auto;
                padding: 40px;
                border: 1px solid #ccc;
                background-color: white;
                box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            }
            
            input[type=text],input[type=number],input[type=email],input[type=tel],input[type=password] {
                width: 95%;
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 3px;
            }
            
            label{
                margin: 12px 12px 10px 0;
                display: inline-block;
            }
            
            input[type="submit"],
            input[type="reset"]{
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
        <div class="form-container">
        
        <span onclick="window.location.href='StaffManagement.jsp';" style="float:right; cursor:pointer;"><i class="fa fa-times" aria-hidden="true" style='font-size:25px'></i></span>    
        <h1>Add New Staff</h1>

        <form action="RegisterStaffServlet" method="post">
            <label for="stfname">Full Name:</label>
            <input type="text" id="stfname" name="stfName" required />

            <label for="stfemail">Email Address:</label>
            <input type="email" id="stfemail" name="stfEmail" required />

            <label for="stfcontactno">Contact Number:</label>
            <input type="tel" id="stfcontactno" name="stfContactNo"
                   pattern="[0-9\-+\s]+" placeholder="e.g. 0123456789" required />

            <label for="stfposition">Position / Title:</label>
            <input type="text" id="stfposition" name="stfPosition" required />

            <label for="stfusername">Username:</label>
            <input type="text" id="stfusername" name="stfUserName" required />

            <label for="stfpswd">Password:</label>
            <input type="password" id="stfpswd" name="stfPswd" required />

            <input type="reset" value="RESET" class="shadow">
            <input type="submit" value="ADD STAFF" class="shadow">
            
        </form>
        </div>
    </body>
</html>