package test.com;

import java.io.IOException;
import java.sql.*;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws IOException {

        String phone = request.getParameter("phone");
        String password = request.getParameter("password");

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection conn = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "myuser", "mypassword"
            );

            String sql = "SELECT username FROM users WHERE phone = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, phone);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String username = rs.getString("username");
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                response.sendRedirect("menu.jsp");
            } else {
            	 response.sendRedirect("menu.html");
            }

            rs.close(); stmt.close(); conn.close();
        } catch (Exception e) {
        	 e.printStackTrace();
             response.getWriter().write("Database error: " + e.getMessage());
        }
    }
}
