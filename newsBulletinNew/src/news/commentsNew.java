package news;

import java.sql.*;


import com.opensymphony.xwork2.ActionSupport;

public class commentsNew extends ActionSupport {
	int newsId;
	int userId;
	String comment;
	public int getNewsId() {
		return newsId;
	}
	public void setNewsId(int newsId) {
		this.newsId = newsId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String execute() {
		String ret="error";
		int views=0;
		/*System.out.println(userId);
		System.out.println(newsId);
		System.out.println(comment);*/
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/newsBulletinNew?useSSL=true", "root", "");   
			Statement stmt=con.createStatement();
			String querry="insert into comments (nId,uId, comment) values ('"+newsId+"','"+userId+"','"+comment+"');";
			//System.out.println(querry);
			stmt.executeUpdate(querry);
			
			Statement stmtView=con.createStatement();
	         ResultSet vRs= stmtView.executeQuery("select view from news where id="+newsId+";");
	         while(vRs.next()) {
	        	// System.out.println(vRs.getInt("view"));
	        	 views=vRs.getInt("view");
	        	 views++;
	        	// System.out.println(views);
	         }
	         stmtView.executeUpdate("update news set view="+views+" where id="+newsId+";");
	         
			con.close();
			ret="success";
			
		}catch(SQLException e) {
			e.printStackTrace();
			ret="error";
		}catch(ClassNotFoundException ee) {
			ee.printStackTrace();
			ret="error";
		}
		
		return ret;
	}

}
