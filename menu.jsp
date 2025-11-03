<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%
    String username = (session != null) ? (String) session.getAttribute("username") : null;
    if (username == null) {
        response.sendRedirect("login.html");
        return;
    }

    String bp = "", sugar = "", bloodGroup = "";

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "myuser", "mypassword");

        // Get the most recent record (assuming date1 is the latest)
        PreparedStatement ps = conn.prepareStatement(
            "SELECT bp, sugar, blood_group FROM user_records WHERE username = ? AND ROWNUM = 1 ORDER BY date1 DESC"
        );
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            bp = rs.getString("bp");
            sugar = rs.getString("sugar");
            bloodGroup = rs.getString("blood_group");
        }
        rs.close();
        ps.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <link rel="stylesheet" href="style1.css">
    <style>
        .centered-table {
            background-color: #fffdd0;
            padding: 20px;
            border-radius: 10px;
            margin: auto;
            width: 90%;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid #000;
        }
        th, td {
            padding: 10px;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="navbar">
    <div class="logo"><img src="mycarelogo.png" alt="Logo"></div>
    <div class="nav-links">
        <span style="color:white; font-weight:bold;">Welcome, <%= username %></span>
        <a href="#" onclick="document.getElementById('profileModal').style.display='block'">Profile</a>
        <a href="logout.jsp">Logout</a>
    </div>
</div>

<div class="hero">
    <h2>Welcome, <%= username %></h2>
    <p>Your personal medical record system</p>
    
    <button class="btn" onclick="document.getElementById('newEntry').style.display='block'">New</button>
    
    <!-- Blood Group Display -->
    <div class="blood-group-info">
    Blood Group: <%= (bloodGroup != null && !bloodGroup.trim().equals("")) ? bloodGroup : "Not Set" %><br>
    BP: <%= (bp != null && !bp.trim().equals("")) ? bp : "Not Set" %><br>
    Sugar: <%= (sugar != null && !sugar.trim().equals("")) ? sugar : "Not Set" %>
</div> 
</div>


<div class="section">
    <div class="centered-table">
        <h2 style="text-align: center;">Your Records</h2>
        <table>
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Problem</th>
                    <th>Hospital</th>
                    <th>Doctor</th>
                    <th>Medicines</th>
                    <th>BP</th>
                    <th>Sugar</th>
                </tr>
            </thead>
            <tbody>
            <%
                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "myuser", "mypassword");
                    PreparedStatement ps = conn.prepareStatement("SELECT * FROM user_records WHERE username = ?");
                    ps.setString(1, username);
                    ResultSet rs = ps.executeQuery();
                    while (rs.next()) {
            %>
                <tr>
                    <td><%= rs.getString("date1") %></td>
                    <td><%= rs.getString("problem") %></td>
                    <td><%= rs.getString("hospital") %></td>
                    <td><%= rs.getString("doctor") %></td>
                    <td><%= rs.getString("medicines") %></td>
                    <td><%= rs.getString("bp") %></td>
                    <td><%= rs.getString("sugar") %></td>
                </tr>
            <%
                    }
                    rs.close();
                    ps.close();
                    conn.close();
                } catch (Exception e) {
                    out.println("<tr><td colspan='7'>Error loading records: " + e.getMessage() + "</td></tr>");
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<!-- New Entry Modal -->
<div id="newEntry" class="modal">
    <div class="modal-content">
        <span class="close" onclick="document.getElementById('newEntry').style.display='none'">&times;</span>
        <form action="addRecord.jsp" method="post">
            <input type="hidden" name="username" value="<%= username %>">
            <input type="date" name="date1" required>
            <input type="text" name="problem" placeholder="Problem" required>
            <input type="text" name="hospital" placeholder="Hospital Name" required>
            <input type="text" name="doctor" placeholder="Doctor Name" required>
            <input type="text" name="medicines" placeholder="Medicines" required>
            <input type="text" name="bp" placeholder="Blood Pressure" required>
            <input type="text" name="sugar" placeholder="Sugar Level" required>
            <button type="submit">Add Record</button>
            <button type="reset">Reset</button>
        </form>
    </div>
</div>
<!-- Profile Modal -->
<div id="profileModal" class="modal" style="display:none;">
    <div class="modal-content">
        <span class="close" onclick="document.getElementById('profileModal').style.display='none'">&times;</span>
        <h3>Update Profile</h3>
        <form method="post" action="updateProfile.jsp">
            <input type="hidden" name="username" value="<%= username %>">
           
            <label>Blood Group:</label><br>
            <input type="text" name="blood_group" value="<%= bloodGroup %>" required><br><br>
            <button type="submit" name="action" value="save">Save</button>
            <button type="submit" name="action" value="update">Update</button>
        </form>
    </div>
</div>

</body>
</html>
