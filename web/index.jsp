<%-- 
    Document   : index
    Created on : Apr 13, 2025, 2:47:48 PM
    Author     : Huay
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home - Unstoppable</title>
        <style>
        .popup-box {
            position: fixed;
            top: 20px;
            right: 30px;
            background-color: #4CAF50;
            color: white;
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0,0,0,0.2);
            z-index: 999;
            animation: fadeInOut 3s ease-in-out;
        }
        @keyframes fadeInOut {
            0% {
                opacity: 0;
                transform: translateY(-10px);
            }
            10% {
                opacity: 1;
                transform: translateY(0);
            }
            90% {
                opacity: 1;
            }
            100% {
                opacity: 0;
                transform: translateY(-10px);
            }
        }
        </style>
    </head>
    
    <body>
        <%@include file="header.jsp" %>
        <%@include file="banner.jsp" %>
        <%@include file="Promotion.jsp" %>
        <%@include file="home_product.jsp" %>
        <%@include file="about.jsp"%>
        <%
            String loginStatus = request.getParameter("login");
 
            if ("success".equals(loginStatus) ) {
        %>
        <div id="login-success-popup" class="popup-box">✅ Login Successful!</div>
        <script>
            setTimeout(() => {
                document.getElementById("login-success-popup").style.display = 'none';
            }, 3000);
        </script>
        <%
            }
        %>
        <%@include file="footer.jsp"%>
     </body>
</html>
