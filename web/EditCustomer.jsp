<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Customer, model.CustomerService" %>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if ((username == null || role == null)) {
        response.sendRedirect("login.jsp?error=Please login first.");
        return;
    }else if("customer".equals(role)){
        response.sendRedirect("NoAccess.jsp");
        return;
    }
%>

<%
    String custId = request.getParameter("custId");
    Customer cust = null;

    if (custId != null) {
        try {
            CustomerService service = new CustomerService();
            cust = service.getCustomerById(custId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Customer</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
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

    <script>
        function confirmUpdate() {
            return confirm("Are you sure you want to update this customer?");
        }
    </script>
</head>
<body>
    <div class="form-container">
        <span onclick="window.location.href='CustomerManagement.jsp';" style="float:right; cursor:pointer;"><i class="fa fa-times" aria-hidden="true" style='font-size:25px'></i></span>
        <h2>Edit Customer</h2>
        <% if (cust == null)
                out.println("<p style='color:red;'>Customer not loaded. custId param: " + request.getParameter("custId") + "</p>");%>

        <form action="EditCustomerByAdmin" method="post" onsubmit="return confirmUpdate();">
            <input type="hidden" name="custId" value="<%= cust != null ? cust.getCustid() : "" %>">

            <label>Name:</label>
            <input type="text" name="custName" value="<%= cust != null ? cust.getCustname() : "" %>" required>

            <label>Contact No:</label>
            <input type="text" name="custContactNo" value="<%= cust != null ? cust.getCustcontactno() : "" %>" required>

            <label>Email:</label>
            <input type="email" name="custEmail" value="<%= cust != null ? cust.getCustemail() : "" %>" required>

            <label>Username:</label>
            <input type="text" name="custUserName" value="<%= cust != null ? cust.getCustusername() : "" %>" required>

            <label>Password:</label>
            <input type="text" name="custPswd" value="<%= cust != null ? cust.getCustpswd() : "" %>" required>

            
            <button type="button" onclick="window.location.href='CustomerManagement.jsp'" class="shadow">CANCEL</button>
            <button type="submit" class="shadow">UPDATE</button>
        </form>
    </div>
</body>
</html>
