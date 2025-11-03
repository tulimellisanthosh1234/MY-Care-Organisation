package test.com;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.Scanner;
public class DBTest {
	public static void main(String[] args) {
		try
		{
			int id;
			String name;
			Scanner sc=new Scanner(System.in);
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("Driver Loaded Success");
			Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","myuser","mypassword");
			System.out.println("Connection Established");
			Statement st=con.createStatement();
			
			boolean n=st.execute("create table users(username varchar2(20) ,email varchar2(20) , phone number(10) , Password varchar2(10))");
			if(n)
				System.out.println("table created");
			else
				System.out.println("NoT created");
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
	}
}
