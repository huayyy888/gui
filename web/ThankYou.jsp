
<%@ page import="model.Receipt, model.CartService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>Thank You for Review</title>
    <style>
        body {
            background-color: #f1f2f4;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .thank-you-box {
            background-color: white;
            border-radius: 15px;
            padding: 40px;
            text-align: center;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            width: 400px;
            animation: fadeIn 0.5s ease-in-out;
        }

        .check-icon {
            background: #ffc107;
            border-radius: 50%;
            width: 80px;
            height: 80px;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0 auto 20px auto;
            position: relative;
        }

        .check-icon::after {
            content: '🎁';
            font-size: 36px;
            color: white;
        }

        .check-icon::before {
            content: '';
            position: absolute;
            width: 100px;
            height: 100px;
            background: rgba(255, 193, 7, 0.2);
            border-radius: 50%;
            z-index: -1;
            animation: pulse 1.5s infinite;
        }

        @keyframes pulse {
            0% { transform: scale(1); opacity: 0.6; }
            50% { transform: scale(1.2); opacity: 0.3; }
            100% { transform: scale(1); opacity: 0.6; }
        }

        h2 {
            margin-top: 10px;
            color: #333;
        }

        p {
            color: #888;
            font-size: 14px;
            margin-bottom: 30px;
        }

        .btn-group {
            display: flex;
            justify-content: center;
            gap: 15px;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.2s ease-in-out;
        }

        .btn-view {
            background: white;
            border: 1px solid #ccc;
            color: #333;
        }

        .btn-view:hover {
            background: #f0f0f0;
        }

        .btn-continue {
            background-color:  #ffc107;
            color: black;
        }

        .btn-continue:hover {
            background-color:  #e0a800;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

<div class="thank-you-box">
    <div class="check-icon"></div>
    <h2>Thank you for Support!</h2>
    <p>
        Thank you for your review.<br>
        Your review will be received.<br>
    </p>

    <div class="btn-group">
        <form action="index.jsp" method="get">
            <button class="btn btn-continue" type="submit">Go Back to Home</button>
        </form>
    </div>
</div>

</body>
</html>
