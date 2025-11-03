package test.com;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class DBConnection {
public static Connection getConnection()throws Exception
{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	System.out.println("Driver Loaded Success");
	Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","myuser","mypassword");
	System.out.println("Connection Established");
	
	return con;
}
}
