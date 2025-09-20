<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%
    // Ensure user is logged in
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Take Quiz</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #121212;
            color: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
            padding: 30px;
        }

        .container {
            width: 100%;
            max-width: 800px;
            background-color: #1e1e1e;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 0px 25px rgba(0, 255, 255, 0.4);
            animation: fadeIn 1s ease-in-out;
        }

        h2 {
            color: #00e5ff;
            margin-bottom: 20px;
            text-align: center;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .question {
            margin: 20px 0;
            padding: 15px;
            border-left: 5px solid #00e5ff;
            background-color: #2a2a2a;
            border-radius: 8px;
        }

        .question h3 {
            margin: 0 0 10px 0;
            color: #ffffff;
        }

        label {
            display: block;
            padding: 8px;
            margin: 5px 0;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.2s;
        }

        input[type="radio"] {
            margin-right: 8px;
        }

        label:hover {
            background-color: #333;
        }

        input[type="submit"] {
            width: 100%;
            padding: 14px;
            margin-top: 25px;
            border: none;
            border-radius: 8px;
            background: linear-gradient(45deg, #00e5ff, #00bcd4);
            color: #121212;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            transition: transform 0.2s ease-in-out;
        }

        input[type="submit"]:hover {
            transform: scale(1.05);
            background: linear-gradient(45deg, #00bcd4, #00e5ff);
        }

        .welcome {
            text-align: right;
            margin-bottom: 20px;
            font-size: 14px;
            color: #bbb;
        }

        .logout {
            color: #ff4d4d;
            text-decoration: none;
            font-weight: bold;
            margin-left: 10px;
        }

        .logout:hover {
            text-decoration: underline;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="welcome">
            Welcome, <strong><%= username %></strong> |
            <a class="logout" href="QuizServlet?action=logout">Logout</a>
        </div>

        <h2>Take the Quiz</h2>
        <form action="QuizServlet" method="post">
            <input type="hidden" name="action" value="submitQuiz">

            <%
                try (Connection conn = com.quizapp.DBConnection.getConnection()) {
                    Statement st = conn.createStatement();
                    ResultSet rs = st.executeQuery("SELECT * FROM questions");
                    int qno = 1;
                    while (rs.next()) {
            %>
                        <div class="question">
                            <h3>Q<%= qno %>. <%= rs.getString("question_text") %></h3>
                            <label><input type="radio" name="q<%= qno %>" value="1"> <%= rs.getString("option1") %></label>
                            <label><input type="radio" name="q<%= qno %>" value="2"> <%= rs.getString("option2") %></label>
                            <label><input type="radio" name="q<%= qno %>" value="3"> <%= rs.getString("option3") %></label>
                            <label><input type="radio" name="q<%= qno %>" value="4"> <%= rs.getString("option4") %></label>
                        </div>
            <%
                        qno++;
                    }
                } catch (Exception e) {
                    out.println("<p style='color:red;'>Error loading quiz questions: " + e.getMessage() + "</p>");
                }
            %>

            <input type="submit" value="Submit Quiz">
        </form>
    </div>
</body>
</html>
