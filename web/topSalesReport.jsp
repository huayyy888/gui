<%-- 
    Document   : topSalesReport
    Created on : Apr 22, 2025, 1:08:38 PM
    Author     : Mei Yen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
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
        <title>Top 10 Sales Report</title>
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
        <h1>Top 10 Sales Report</h1>
        
        <%--report table--%>
        <table>
            <thead>
                <tr style="height:70px">
                    <th>Rank</th>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Category</th>
                    <th>Unit Price</th>
                    <th>Unit Sold</th>
                </tr>
            </thead>
            
                
                <%--access the top sales product record--%>
                <% 
                    ProductDa pda = new ProductDa(); 
                    ResultSet rs=pda.topSalesProd();
                    int count=1;
                    
                %>

                <%  
                    boolean hasData = false;
                    while(rs.next()){
                        hasData = true;
                    
                %>
                <tr>
                        <td><%=count%></td>
                        <td><%=rs.getString(1)%></td>
                        <td><%=rs.getString(2)%></td>
                        <td><%=rs.getString(3)%></td>
                        <td><%=rs.getDouble(4)%></td>
                        <td><%=rs.getInt(5)%></td>
                </tr>        
                <% 
                        count++;
                    }
                        if (hasData==false) {
                %>
                
                <tr>
                    <td colspan="6" style="text-align:center; font-weight:bold; color:#808080;">No Record found!</td>
                </tr>
                <%
                    }
                %>
                
                
            
        </table>
        </div>
    </body>
</html>
