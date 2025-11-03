<%@ page import="java.sql.*" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Registration</title>
</head>
<body>
<%
String username = request.getParameter("username");
String email = request.getParameter("email");
String phone = request.getParameter("phone");
String password = request.getParameter("password");

// Debugging output (Remove after testing)
out.println("Username: " + username + "<br>");
out.println("Email: " + email + "<br>");
out.println("Phone: " + phone + "<br>");
out.println("Password: " + password + "<br>");

// Basic validation
if (username == null || email == null || phone == null || password == null ||
    username.trim().isEmpty() || email.trim().isEmpty() || phone.trim().isEmpty() || password.trim().isEmpty()) {
    out.println("All fields are required.");
} else {
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "myuser", "mypassword");

        PreparedStatement ps = con.prepareStatement("INSERT INTO users(username, email, phone, password) VALUES (?, ?, ?, ?)");
        ps.setString(1, username);
        ps.setString(2, email);
        ps.setString(3, phone);
        ps.setString(4, password);  // Consider hashing this!

        int result = ps.executeUpdate();

        if (result > 0) {
        	out.println("Registration");
            response.sendRedirect("menu.html");
        } else {
            out.println("Registration failed.");
        }

        ps.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    }
}
%>
</body>
</html>
