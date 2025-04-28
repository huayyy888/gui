<%-- 
    Document   : editProd
    Created on : Apr 16, 2025, 11:34:53 PM
    Author     : Mei Yen
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Product" %>

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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Product</title>
        <style>
            body{
                background-color: #f9f9f9;
            }
            
            .h1-wrapper{
                margin-left: 150px;
                margin-right: 150px;
                margin-top: 60px;
            }

            h1{
                font-size: 32px;
                font-weight: bold;
                color: #333;
            }

            .form-container {
                display: flex;
                gap: 30px; /* space between left and right */
                flex-wrap: wrap; /* allows them to stack on small screens */
                margin: auto auto;
                margin-left: 150px;
                margin-right: 150px;

              }
              
            .left {
                flex: 1; /* smaller portion */
                max-width: 30%;
                padding: 25px;
                border: 1px solid #ccc;
                background-color: white;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2),
                            0 6px 20px rgba(0, 0, 0, 0.19);

            }

            .right {
                flex: 2;
                max-width: 70%;
                padding: 25px;
                border: 1px solid #ccc;
                background-color: white;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2),
                            0 6px 20px rgba(0, 0, 0, 0.19);
            }
            
            .prodImage{
                height:300px;
                width:300px;  
                display: block;
                margin-left: auto;
                margin-right: auto;
            }
            
            input[type=text],input[type=number], select, textarea {
                width: 95%;
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 3px;
            }
            
            select{
                width: 98%;
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 4px;
                resize: vertical;
            }
            
            label{
                margin: 12px 12px 10px 0;
                display: inline-block;
            }
            
            .button-container{
                margin: auto auto;
                margin-top: 50px;
                margin-left: 150px;
                margin-right: 150px;
            }
            
            input[type="submit"],
            input[type="button"]{
                width:49.5%;
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
        
        <%Product prod = (Product) session.getAttribute("editProd");%>
        <div class="h1-wrapper">
            
        <h1>Update Product</h1></div>
        <form action="EditProdServlet" class="form" enctype="multipart/form-data" method="post">
            <div class="form-container">
            <%--show prod image--%>
            <div class="left">
                <h2>Product Image</h2><br>
                <img src="imgUpload/<%=prod.getImglocation()%>" alt="Current Image" class="prodImage" border="1"></img><br>

                <label for="prodImage" >Upload New Image of Product:</label><br>
                <span style="color: #787878">***Original product image will be replace by new uploaded image</span></br></br>
                <input type="file" id="prodImage" name="prodImage" accept="image/png, image/gif, image/jpeg"></br></br>
            
            
                <%-- when user doesn't upload anything --%>
                <input type="hidden" id="oldProdImage" name="oldProdImage" value="<%=prod.getImglocation()%>">
            </div>
            
            <%--input field--%>
            <div class="right">
                <h2>Product Details</h2><br>
                <label for="prodId">Product ID:</label>
                <input type="text" id="prodId" name="prodId" value="<%=prod.getProductid()%>" required maxlength="15" readonly></br>

                <label for="prodName">Name:</label>
                <input type="text" id="prodName" name="prodName" value="<%=prod.getProductname()%>" required maxlength="50"></br>

                <label for="prodPrice">Price:</label>
                <input type="number" id="prodPrice" name="prodPrice" value="<%=prod.getPrice()%>" min="1" max="5000" step=any required></br>

                <label for="prodStock">Stock:</label>
                <input type="number" id="prodStock" name="prodStock" value="<%=prod.getQuantity()%>" min="1" max="5000" step="1" required></br>

                <label for="prodCat">Category</label>
                <select id="prodCat" name="prodCat">
                    <option disabled>Choose an option</option>
                    <option value="Make Up" <%= "Make Up".equals(prod.getCategory()) ? "selected" : "" %>>Make Up</option>
                    <option value="Skincare" <%= "Skincare".equals(prod.getCategory()) ? "selected" : "" %>>Skincare</option>

                </select></br>

                <label for="prodDesc">Description:</label>
                <textarea id="prodDesc" name="prodDesc" required><%=prod.getProductdescription()%></textarea></br>

                <label for="prodStatus">Status:</label>
                <select id="prodStatus" name="prodStatus">
                    <option disabled>Choose an option</option>
                    <option value="1" <%= prod.getStatus() == 1 ? "selected" : "" %>>Show</option>
                    <option value="0" <%= prod.getStatus() == 0 ? "selected" : "" %>>Hide</option>
                </select></br>   
            </div>
            </div>
            <div class="button-container">
                <input type="button" value="CANCEL" onclick="window.location.href='viewProd.jsp'">
                <input type="submit" value="UPDATE">
            </div>
        </form>

    </body>
</html>
