package news;

import java.sql.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.interceptor.ServletRequestAware;

import com.opensymphony.xwork2.ActionSupport;

public class login extends ActionSupport implements ServletRequestAware {
	private String email;
	private String password;
	HttpServletRequest request;
	
	
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


	public String execute() {
		
		String userName=null;
		int uId=0;
		String ret="error";
		try{ 
	         Class.forName("com.mysql.jdbc.Driver");
	         Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/newsBulletinNew?useSSL=true","root","");
	         Statement stmt=conn.createStatement();
	         String query="select * from user where email = ? and password= ? ;";
	         PreparedStatement pstmt=conn.prepareStatement(query);
	         //System.out.println(email);
	         //System.out.println(password);
	         pstmt.setString(1, email);
	         pstmt.setString(2, password);
	         
	         //System.out.println(query);
	         ResultSet rs=pstmt.executeQuery();
	         while(rs.next()) {
	        	 userName=rs.getString("name");
	        	 uId=rs.getInt("id");
	        	 
	         }
	         //System.out.println(userName+"  "+uId);
	         if (rs.last()) {
	        	
				HttpSession session=request.getSession();
	        	 session.setAttribute("userName", userName);
	        	 session.setAttribute("uId", uId);
               conn.close();
               ret="success";
	        	// response.sendRedirect("index.jsp");
	         }else{  
	        	// out.println(" Sorry, username or password error!"); 
	        	 System.out.println("error by else statement in login page ");
	        	 ret="error";
	        	
	         }
		}catch(ClassNotFoundException se) {
		   // out.println("Class not found .... exception ..."+se.getMessage());
			
			se.printStackTrace();
			ret="error";
		}catch(SQLException e) { 
	         //out.println("SQL Exception thrown");
			e.printStackTrace();
			ret="error";
	         
		} 
		//  out.close();
		
		
		return ret;
	}
	@Override
	public void setServletRequest(HttpServletRequest request) {
		// TODO Auto-generated method stub
		this.request=request;
		
	}
	
}
