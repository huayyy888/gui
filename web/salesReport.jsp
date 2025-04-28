<%-- 
    Document   : salesReport
    Created on : Apr 22, 2025, 8:38:56 PM
    Author     : Mei Yen
--%>

<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.ProductDa" %>
<%@include file="staffHeader.jsp" %>
<%
    if (role == null || role!="manager") {
        response.sendRedirect("NoAccess.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sales Report</title>
        <style>
            .content-area {
                flex: 2;
                padding: 10px;
                width:100%;
                margin-left: 250px;
                margin-right: 50px;
            }
            
            table {
              border-collapse: collapse;
              width: 100%;
            }

            th,td {
                border-bottom: 1px solid gray;
                padding: 12px;
                text-align: center;
            }

            tr:nth-child(even) {
                background-color: #f2f2f2;
            }          
            
        </style>
    </head>
    <body>
        <div class="content-area">
        <h1>Sales Report</h1>
        
        <% 
        if (session.getAttribute("rs_salesRecord") == null) {
            response.sendRedirect("ReportServlet");
        }   
  
         ResultSet rs_salesRecord = (ResultSet) session.getAttribute("rs_salesRecord");        
         String startDate = (String) session.getAttribute("startDate");
         String endDate = (String) session.getAttribute("endDate");
         
         Boolean userClicked = (Boolean) session.getAttribute("userClicked");
        %>
        
        <form action="ReportServlet" method="post" onsubmit="return validateDates()">
            <label for="startDate">Start Date:</label>
            <input type="date" id="startDate" name="startDate"  value="<%= startDate %>" >
            <br><br>
            
            <label for="endDate">End Date:</label>
            <input type="date" id="endDate" name="endDate" value="<%= endDate %>" >
            <br><br>
            <%--checking--%>
            <input type="hidden" name="userClicked" value="true">
            <input type="submit" value="Generate Report">
        </form>
    
    <p>Querying sales from <%= startDate %> to <%= endDate %></p>
    <hr>
    <br>
    
    <table>
        <tr>
            <th>Product ID</th>
            <th>Name</th>
            <th>Category</th>
            <th>Price</th>
            <th>Units Sold</th>
            <th>Total Sales (RM)</th>
        </tr>

        <%
            if (rs_salesRecord != null) {
                while (rs_salesRecord.next()) {
        %>
        <tr>
            <td><%= rs_salesRecord.getString("productId") %></td>
            <td><%= rs_salesRecord.getString("productName") %></td>
            <td><%= rs_salesRecord.getString("category") %></td>
            <td><%= rs_salesRecord.getDouble("price") %></td>
            <td><%= rs_salesRecord.getInt("Units_Sold") %></td>
            <td><%= String.format("%.2f", rs_salesRecord.getDouble("Total_Sales")) %></td>
        </tr>
        <%
                }
            }
        %>
    </table>
    </div> 
    
        <%--script--%>
        <script type="text/javascript">
            function validateDates() {
                const startDate = new Date(document.getElementById('startDate').value);
                const endDate = new Date(document.getElementById('endDate').value);
                
                console.log(startDate);
                console.log(endDate);

                if (startDate > endDate) {
                    alert("End date must be greater than or equal to start date!");
                    return false;
                }
                return true;
            }
        </script>
    
    
    </body>
</html>
