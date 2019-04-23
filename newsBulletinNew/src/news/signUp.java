package news;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.opensymphony.xwork2.ActionSupport;

public class signUp extends ActionSupport {
	String name;
	String email;
	String password;
	int mobileNo;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getMobileNo() {
		return mobileNo;
	}
	public void setMobileNo(int mobileNo) {
		this.mobileNo = mobileNo;
	}
	
	public String execute() {
		/*System.out.println(name);
		System.out.println(email);
		System.out.println(mobileNo);
		System.out.println(password);*/
		String ret="error";
		
		try{ 
	         Class.forName("com.mysql.jdbc.Driver");
	         Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/newsBulletinNew?useSSL=true","root","");
	         Statement stmt=conn.createStatement();
	         String query="insert into user (name,email,mobileNo,password) values (?,?, ?,?);";
	         PreparedStatement pstmt=conn.prepareStatement(query);
	         //System.out.println(email);
	         //System.out.println(password);
	         pstmt.setString(1, name);
	         pstmt.setString(2, email);
	         pstmt.setInt(3, mobileNo);
	         pstmt.setString(4, password);
	         
	         //System.out.println(query);
	         pstmt.executeUpdate();
	         ret="success";
	        
             
	        	
	         
		}catch(ClassNotFoundException se) {
		   // out.println("Class not found .... exception ..."+se.getMessage());
			
			se.printStackTrace();
			ret="error";
		}catch(SQLException e) { 
	         //out.println("SQL Exception thrown");
			e.printStackTrace();
			ret="error";
	         
		} 
		
		return ret;
	}

}
