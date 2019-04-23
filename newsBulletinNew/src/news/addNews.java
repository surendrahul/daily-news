package news;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

import com.opensymphony.xwork2.ActionSupport;

public class addNews extends ActionSupport {
	String title;
	int userId;
	String updateDate;
	String content;
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String execute() {
		/*System.out.println(title);
		System.out.println(user);
		System.out.println(updateDate);
		System.out.println(content);*/
		String ret="error";
		
		try{ 
	         Class.forName("com.mysql.jdbc.Driver");
	         Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/newsBulletinNew?useSSL=true","root","");
	         Statement stmt=conn.createStatement();
	         String query="insert into news (title, content, userId, updateDate) values (?,?, ?,?);";
	         PreparedStatement pstmt=conn.prepareStatement(query);
	         //System.out.println(email);
	         //System.out.println(password);
	         pstmt.setString(1, title);
	         pstmt.setString(2, content);
	         pstmt.setInt(3, userId);
	         pstmt.setString(4, updateDate);
	         
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
