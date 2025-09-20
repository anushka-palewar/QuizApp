package com.quizapp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;

@WebServlet("/QuizServlet")
public class QuizServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Prevent blank page on GET request
        response.getWriter().println("QuizServlet is running. Please use forms to register, login, or take the quiz.");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.isEmpty()) {
            response.getWriter().println("No action provided!");
            return;
        }

        // --- USER REGISTRATION ---
        if ("register".equals(action)) {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            try (Connection conn = DBConnection.getConnection()) {
                PreparedStatement ps = conn.prepareStatement(
                        "INSERT INTO users(username, email, password) VALUES(?,?,?)");
                ps.setString(1, username);
                ps.setString(2, email);
                ps.setString(3, password);

                int rows = ps.executeUpdate();
                if (rows > 0) {
                    request.setAttribute("msg", "Registration successful! Please login.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                } else {
                    request.setAttribute("msg", "Error in registration!");
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("msg", "Exception: " + e.getMessage());
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        }

        // --- USER LOGIN ---
        else if ("login".equals(action)) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            try (Connection conn = DBConnection.getConnection()) {
                PreparedStatement ps = conn.prepareStatement(
                        "SELECT * FROM users WHERE email=? AND password=?");
                ps.setString(1, email);
                ps.setString(2, password);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    HttpSession session = request.getSession();
                    session.setAttribute("username", rs.getString("username"));
                    response.sendRedirect("quiz.jsp");
                } else {
                    request.setAttribute("msg", "Invalid email or password!");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("msg", "Exception: " + e.getMessage());
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        }

        // --- QUIZ SUBMISSION ---
        else if ("submitQuiz".equals(action)) {
            HttpSession session = request.getSession();
            if (session.getAttribute("username") == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            int score = 0;
            try (Connection conn = DBConnection.getConnection()) {
                Statement st = conn.createStatement();
                ResultSet rs = st.executeQuery("SELECT * FROM questions");
                int qno = 1;
                while (rs.next()) {
                    int correct = rs.getInt("correct_option");
                    String ans = request.getParameter("q" + qno);
                    if (ans != null && Integer.parseInt(ans) == correct) {
                        score++;
                    }
                    qno++;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            request.setAttribute("score", score);
            request.getRequestDispatcher("result.jsp").forward(request, response);
        }

        // --- LOGOUT ---
        else if ("logout".equals(action)) {
            HttpSession session = request.getSession();
            session.invalidate();
            response.sendRedirect("login.jsp");
        }

        // --- INVALID ACTION ---
        else {
            response.getWriter().println("Invalid action: " + action);
        }
    }
}
