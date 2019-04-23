package news;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.opensymphony.xwork2.ActionSupport;

public class replyOfComments extends ActionSupport {
	int userId;
	int newsId;
	int pCUId;
	int parentCommentId;
	String reply;
	
	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getNewsId() {
		return newsId;
	}

	public void setNewsId(int newsId) {
		this.newsId = newsId;
	}

	public int getpCUId() {
		return pCUId;
	}

	public void setpCUId(int pCUId) {
		this.pCUId = pCUId;
	}

	public int getParentCommentId() {
		return parentCommentId;
	}

	public void setParentCommentId(int parentCommentId) {
		this.parentCommentId = parentCommentId;
	}

	public String getReply() {
		return reply;
	}

	public void setReply(String reply) {
		this.reply = reply;
	}

	public String execute() {
		String ret="error";
		int views=0;
		/*System.out.println("userId -"+userId);
		System.out.println("newsId -"+newsId);
		System.out.println("parentCommentId -"+parentCommentId);
		System.out.println("reply -"+reply);
		System.out.println("pUserId -"+pCUId);
		ret="success";*/
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/newsBulletinNew?useSSL=true", "root", "");   
			Statement stmt=con.createStatement();
			String querry="insert into comments (nId,pCommentId, pUserId,  uId, comment) values ('"+newsId+"','"+parentCommentId+"','"+pCUId+"','"+userId+"','"+reply+"');";
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












