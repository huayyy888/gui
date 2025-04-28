<%-- 
    Document   : addProduct
    Created on : Apr 13, 2025, 4:41:05 PM
    Author     : Mei Yen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Product"%>
<%@page import="model.ProductDa"%>

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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <title>Add Product</title>
        
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
            
            input[type=text],input[type=number], select, textarea {
                width: 95%;
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 3px;
            }
            
            select{
                width: 100%;
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 4px;
                resize: vertical;
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
            
            <span onclick="window.location.href='AddProdServlet';" style="float:right; cursor:pointer;"><i class="fa fa-times" aria-hidden="true" style='font-size:25px'></i></span>
            <h1>Add Product</h1>
            
            
            <form action="AddProdServlet" id="prodForm" enctype="multipart/form-data" method="post">

                <% ProductDa pda = new ProductDa();%>
                <label for="prodId">Product ID:</label>
                <input type="text" id="prodId" name="prodId" value="<%=pda.autoProdId()%>" required maxlength="15" readonly></br>

                <label for="prodName">Name:</label>
                <input type="text" id="prodName" name="prodName" required maxlength="50"></br>

                <label for="prodPrice">Price:</label>
                <input type="number" id="prodPrice" name="prodPrice" min="1" max="5000" step=any required></br>

                <label for="prodStock">Stock:</label>
                <input type="number" id="prodStock" name="prodStock" min="1" max="5000" step="1" required></br>

                <label for="prodCat">Category</label>
                <select id="prodCat" name="prodCat" required>
                    <option value="" selected disabled>Choose an option</option>
                    <option value="Make Up">Make Up</option>
                    <option value="Skincare">Skincare</option>
                </select></br>

                <label for="prodDesc">Description:</label>
                <textarea id="prodDesc" name="prodDesc" required></textarea></br>

                <label for="prodStatus">Status:</label>
                <select id="prodStatus" name="prodStatus" required>
                    <option value="" disabled>Choose an option</option>
                    <option value="1" selected>Show</option>
                    <option value="0">Hide</option>
                </select></br>

                <label for="prodImage">Upload Product Image:</label></br>
                <input type="file" id="prodImage" name="prodImage" accept="image/png, image/gif, image/jpeg" required></br></br>

                <input type="reset" value="RESET" class="shadow">
                <input type="submit" value="ADD PRODUCT" class="shadow">

                <div>
                    <% String error = request.getParameter("error");
                        if (error != null) {
                    %>
                            <p style="color: red;font-size: 20px;font-weight: bold;"><%=error%></p>
                    <%}%>
                </div>
                
            </form>
                
        </div>

    </body>
</html>
