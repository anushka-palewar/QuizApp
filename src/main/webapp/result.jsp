<%@ page language="java" %>
<%
    // Ensure user is logged in
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Integer score = (Integer) request.getAttribute("score");
    Integer total = (Integer) request.getAttribute("total");
    if (score == null || total == null) {
        score = 0;
        total = 0;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Quiz Result</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #121212;
            color: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            width: 100%;
            max-width: 600px;
            background-color: #1e1e1e;
            padding: 40px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0px 0px 25px rgba(0, 255, 255, 0.4);
            animation: fadeIn 1s ease-in-out;
        }

        h2 {
            color: #00e5ff;
            margin-bottom: 20px;
            text-transform: uppercase;
        }

        .score {
            font-size: 24px;
            font-weight: bold;
            margin: 20px 0;
        }

        .message {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 30px;
        }

        .btn {
            display: inline-block;
            padding: 12px 25px;
            margin: 10px;
            border: none;
            border-radius: 8px;
            background: linear-gradient(45deg, #00e5ff, #00bcd4);
            color: #121212;
            font-size: 16px;
            font-weight: bold;
            text-decoration: none;
            cursor: pointer;
            transition: transform 0.2s ease-in-out;
        }

        .btn:hover {
            transform: scale(1.05);
            background: linear-gradient(45deg, #00bcd4, #00e5ff);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Quiz Completed 🎉</h2>
        <p class="score">You earned <%= score %> points out of <%= total %></p>

        <%
            if (score >= (total * 0.8)) {
        %>
            <p class="message" style="color:#4caf50;">🔥 Excellent work, <%= username %>! You nailed it!</p>
        <%
            } else if (score >= (total * 0.5)) {
        %>
            <p class="message" style="color:#ffc107;">🙂 Good job, <%= username %>! Keep practicing.</p>
        <%
            } else {
        %>
            <p class="message" style="color:#ff4d4d;">❌ Don’t give up, <%= username %>! Try again.</p>
        <%
            }
        %>

        <a href="quiz.jsp" class="btn">Take Quiz Again</a>
        <a href="QuizServlet?action=logout" class="btn">Logout</a>
    </div>
</body>
</html>
