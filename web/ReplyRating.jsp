<%-- 
    Document   : ReplyRating
    Created on : Apr 22, 2025, 4:21:46 PM
    Author     : Huay
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.ReviewService" %>
<%@ page import="java.sql.*" %>

<%
//
    String role = (String) session.getAttribute("role"); //either no login - as a guess
    
    if (role == null) { //not admin and not staff
        response.sendRedirect("NoAccess.jsp");
        return;
    }else if("customer".equals(role)){
        response.sendRedirect("NoAccess.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Reply to Rating</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <style>
            
            .form-container{
                width: 600px;
                margin: 100px auto;
                padding: 40px;
                border: 1px solid #ccc;
                background-color: white;
                box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            }
            
            body {
            font-family: Arial, sans-serif;
            padding: 20px;
            }
            
            textarea {
                width: 95%;
                height: 100px;
                resize: vertical;
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 3px;
                margin-top: 5px;
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

        <%
            String ratingId = request.getParameter("ratingId");
            String comment = request.getParameter("comment");
        %>

        <div class="form-container">
            <span onclick="window.history.back();" style="float:right; cursor:pointer;"><i class="fa fa-times" aria-hidden="true" style='font-size:25px'></i></span>
            
            <h2>Reply to Rating ID: <%= ratingId%></h2>
            <p><strong>Customer Comment:</strong> <%= comment%></p>

            <form method="post" action="SaveReply.jsp">
                <input type="hidden" name="ratingId" value="<%= ratingId%>">
                <label for="reply">Your Reply:</label>
                <textarea name="reply" required></textarea><br><br>
                               
                <input type="reset" value="RESET" class="shadow">
                <input type="submit" value="SUBMIT REPLY" class="shadow">

            </form>
        </div>

    </body>
</html>
