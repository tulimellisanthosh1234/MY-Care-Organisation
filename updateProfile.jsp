<%@ page import="java.sql.*" %>
<%
    String username = request.getParameter("username");
    String bloodGroup = request.getParameter("blood_group");
    String dob = request.getParameter("dob");

    String action = request.getParameter("action"); // "save" or "update"

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "myuser", "mypassword");

        if ("update".equals(action)) {
            PreparedStatement ps = conn.prepareStatement(
                "UPDATE users SET blood_group = ?, dob = ? WHERE username = ?"
            );
            ps.setString(1, bloodGroup);
            ps.setString(2, dob);
            ps.setString(3, username);
            ps.executeUpdate();
            ps.close();
        } else if ("save".equals(action)) {
            // optional: handle insert if needed
        }

        conn.close();

        // ✅ Redirect back to menu.jsp to reload updated data
        response.sendRedirect("menu.jsp");

    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error updating profile: " + e.getMessage());
    }
%>