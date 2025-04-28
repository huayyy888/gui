<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String dbUrl = "jdbc:derby://localhost:1527/ass";
    String dbUser = "nbuser";
    String dbPass = "nbuser";

    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null || !"staff".equals(role)) {
        response.sendRedirect("login.jsp?error=Please login first.");
        return;
    }

    String staffId = "", stfName = "", stfContact = "", stfEmail = "", stfPswd = "", stfPosition = "";

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);

        String sql = "SELECT * FROM staff WHERE stfUserName = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, username);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            staffId = rs.getString("staffId");
            stfName = rs.getString("stfName");
            stfContact = rs.getString("stfContactNo");
            stfEmail = rs.getString("stfEmail");
            stfPswd = rs.getString("stfPswd");
            stfPosition = rs.getString("stfPosition");
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>

<!DOCTYPE html>
<html>
<head>
    <script>
    function confirmUpdate() {
        return confirm("Are you sure you want to update your profile?");
    }
    
    function goBack() {
        window.location.href = "index.jsp";
    }
    </script>

    <title>Staff Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 40px;
        }

        .container {
            max-width: 700px;
            margin: auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 12px rgba(0,0,0,0.1);
        }

        h2 {
            color: #2c3e50;
            text-align: center;
        }

        .profile-section label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }

        .profile-section input {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            box-sizing: border-box;
        }

        button {
            margin-top: 20px;
            padding: 10px 18px;
            background-color: #0277bd;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        button:hover {
            background-color: #01579b;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Welcome, <%= stfName %>!</h2>

    <div class="profile-section">
        <form action="UpdateStaff" method="post" onsubmit="return confirmUpdate();">
            <input type="hidden" name="staffId" value="<%= staffId %>">

            <label>Name:</label>
            <input type="text" name="stfName" value="<%= stfName %>" required>

            <label>Contact No:</label>
            <input type="text" name="stfContactNo" value="<%= stfContact %>" required>

            <label>Email:</label>
            <input type="email" name="stfEmail" value="<%= stfEmail %>" required>

            <label>Username:</label>
            <input type="text" name="stfUserName" value="<%= username %>" readonly>

            <label>Password:</label>
            <input type="password" name="stfPswd" value="<%= stfPswd %>" required>

            <label>Position:</label>
            <input type="text" name="stfPosition" value="<%= stfPosition %>" required>

            <button type="submit">Update Profile</button>
            <button type="button" onclick="window.location.href='adminDashboard.jsp'">Back</button>
            
            <% String message = request.getParameter("message");
                String error = request.getParameter("error");
                if (message != null) {
             %>
                 <p style="color: green; font-weight: bold;"><%= message %></p>
             <% } else if (error != null) { %>
                 <p style="color: red; font-weight: bold;"><%= error %></p>
             <% } %>
            
        </form>
    </div>
</div>
</body>
</html>