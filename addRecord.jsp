<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%
    request.setCharacterEncoding("UTF-8");

    String username = (String) session.getAttribute("username");
    String date = request.getParameter("date1");
    String problem = request.getParameter("problem");
    String hospital = request.getParameter("hospital");
    String doctor = request.getParameter("doctor");
    String medicines = request.getParameter("medicines");
    String bp = request.getParameter("bp");
    String sugar = request.getParameter("sugar");
    String blood_group = request.getParameter("blood_group");

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "myuser", "mypassword");

        String sql = "INSERT INTO user_records (username, date1, problem, hospital, doctor, medicines, bp, sugar) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, username);
        ps.setDate(2, java.sql.Date.valueOf(date));
        ps.setString(3, problem);
        ps.setString(4, hospital);
        ps.setString(5, doctor);
        ps.setString(6, medicines);
        ps.setString(7, bp);
        ps.setString(8, sugar);


        ps.executeUpdate();

        ps.close();
        conn.close();

        response.sendRedirect("menu.jsp");
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
