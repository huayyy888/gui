<%-- 
    Document   : adminDashboard
    Created on : Apr 25, 2025, 6:40:31 PM
    Author     : Mei Yen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Product"%>
<%@page import="model.ProductDa"%>
<%@ page import="java.sql.*" %>
<%@include file="staffHeader.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Admin Dashboard</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
  <style>

    .content-area {
        flex: 2;
        padding: 10px;
        width:100%;
        margin-left: 250px;
        margin-right: 50px;
    }

    .header {
      background-color: white;
      padding: 20px;
      border-radius: 8px;
      margin-bottom: 20px;
      box-shadow: 0 0 10px rgba(0,0,0,0.05);
    }

    .header h1 {
      font-size: 28px;
    }

    .box-wrapper {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
      gap: 20px;
    }

    .box {
        background-color: white;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        text-align: center;
        display: flex;
        justify-content: space-between;
    }
    
    .box > div{
        margin: 15px;
        text-align: right;
    }

    .box h3 {
      font-size: 18px;
      color: #808080;
    }

    .box i {
      font-size: 45px;
      color: #3498db;
    }

    .box p {
      font-size: 22px;
      font-weight: bold;
      color: #2c3e50;
      margin-top: 10px;
    }
    
    table{
      width: 100%;
      border-collapse: collapse;
      font-size: 15px;
      margin-top: 20px;
    }
    
    .table-wrapper{
        background-color: #fff;
        padding: 25px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
        margin-top: 50px;
    }
    
    thead tr{
        background-color: #f4f6f9; 
        color: #2c3e50; 
        text-align: left;
    }
    
    thead th{
        padding: 12px 15px;
    }

  </style>
</head>
<body>

    <% 
        ProductDa pda = new ProductDa(); 
        int totalOrder=pda.countRecord("receiptid","receipt");
        int totalUser=pda.countRecord("custid","customer");
        double totalRevenue=pda.totalRevenue();
        int totalProductSold=pda.totalProductSold();
    %>
  
  <div class="content-area">
    <div class="header">
      <h1>Dashboard</h1>
    </div>

    <div class="box-wrapper">
        
      <div class="box">
        <div class="i-wrap">
        <i class='fas fa-hand-holding-usd'></i>
        </div>
          
        <div class="content-wrap">
        <h3>Total Revenue</h3>
        <p>RM <%=totalRevenue%></p>
        </div>
      </div>
        
      <div class="box">
        <div class="i-wrap">
        <i class="fas fa-shopping-cart"></i>
        </div>

        <div class="content-wrap">
        <h3>Total Orders</h3>
        <p><%=totalOrder%></p>
        </div>
      </div>
        
      <div class="box">
        <div class="i-wrap">
        <i class="fas fa-users"></i>
        </div>
         
        <div class="content-wrap">
        <h3>Total Users</h3>
        <p><%=totalUser%></p>
        </div>
      </div>
        
      <div class="box">
        <div class="i-wrap">
        <i class='fas fa-box'></i>
        </div>
        
        <div class="content-wrap">
        <h3>Products Sold</h3>
        <p><%=totalProductSold%></p>
        </div>
      </div>
    </div>
        
        <%--recent order--%>
<div class="table-wrapper">
  <h2>Recent Orders</h2>
  
  <div style="overflow-x: auto;">
    <table>
      <thead>
        <tr>
          <th>Order ID</th>
          <th>Customer Name</th>
          <th>Product Purchased</th>
          <th>Quantity</th>
          <th>Total Price</th>
          <th>Order Date</th>
        </tr>
      </thead>
      
      <tbody>
        <%--access the top sales product record--%>
        <% 
            ResultSet rs=pda.recentOrder();

            boolean hasData = false;
            while(rs.next()){
                hasData = true;
        %>

        <tr>
          <td style="padding: 10px 15px;"><%=rs.getString(1)%></td>
          <td style="padding: 10px 15px;"><%=rs.getString(2)%></td>
          <td style="padding: 10px 15px;"><%=rs.getString(3)%></td>
          <td style="padding: 10px 15px;"><%=rs.getInt(4)%></td>
          <td style="padding: 10px 15px;"><%=rs.getDouble(5)%></td>
          <td style="padding: 10px 15px;"><%=rs.getString(6)%></td>
        </tr>
        <% 
            }
            if (hasData==false) {
        %>
        
        <tr>
            <td colspan="6" style="text-align:center; font-weight:bold; color:#808080;">No Record found!</td>
        </tr>
        <%
            }
        %>
        
      </tbody>
    </table>
  </div>
</div>

        
  </div>

</body>
</html>
