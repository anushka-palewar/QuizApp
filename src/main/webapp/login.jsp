<%@ page language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Login</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #121212; /* Dark background */
            color: #f0f0f0; /* Light text */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            width: 100%;
            max-width: 400px;
            background-color: #1e1e1e;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 0px 20px rgba(0, 255, 255, 0.4);
            text-align: center;
        }

        h2 {
            color: #00e5ff;
            margin-bottom: 20px;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: none;
            border-radius: 8px;
            background-color: #2a2a2a;
            color: #f0f0f0;
            font-size: 14px;
        }

        input[type="text"]:focus, input[type="password"]:focus {
            outline: none;
            border: 2px solid #00e5ff;
            background-color: #333;
        }

        input[type="submit"] {
            width: 100%;
            padding: 12px;
            margin-top: 15px;
            border: none;
            border-radius: 8px;
            background: linear-gradient(45deg, #00e5ff, #00bcd4);
            color: #121212;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: transform 0.2s ease-in-out;
        }

        input[type="submit"]:hover {
            transform: scale(1.05);
            background: linear-gradient(45deg, #00bcd4, #00e5ff);
        }

        p {
            margin-top: 15px;
            font-size: 14px;
        }

        p.error {
            color: #ff4d4d;
            font-weight: bold;
        }

        a {
            color: #00e5ff;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
        }

        .footer-text {
            margin-top: 20px;
            font-size: 13px;
            color: #888;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Welcome Back</h2>
        <form action="QuizServlet" method="post">
            <input type="hidden" name="action" value="login">
            <input type="text" name="email" placeholder="Enter Email" required>
            <input type="password" name="password" placeholder="Enter Password" required>
            <input type="submit" value="Login">
        </form>
        <p class="error"><%= request.getAttribute("msg") != null ? request.getAttribute("msg") : "" %></p>
        <p>New here? <a href="register.jsp">Register Now</a></p>
        <div class="footer-text">
            <p>⚡ Secure Quiz App Login | Dark Mode Enabled</p>
        </div>
    </div>
</body>
</html>

