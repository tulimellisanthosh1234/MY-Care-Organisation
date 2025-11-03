<%@ page import="java.sql.*" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String username = request.getParameter("username");
    String bp = request.getParameter("bp");
    String sugar = request.getParameter("sugar");
    String blood_group = request.getParameter("blood_group");

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "myuser", "mypassword");

        PreparedStatement ps = conn.prepareStatement(
            "INSERT INTO patient_health_info (username, bp, sugar, blood_group) VALUES (?, ?, ?, ?)"
        );
        ps.setString(1, username);
        ps.setString(2, bp);
        ps.setString(3, sugar);
        ps.setString(4, blood_group);

        int inserted = ps.executeUpdate();

        ps.close();
        conn.close();

        if (inserted > 0) {
            response.sendRedirect("menu.jsp");
        } else {
            out.println("Insert failed.");
        }

    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
