package news;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.opensymphony.xwork2.ActionSupport;

public class unlikeNews extends ActionSupport {
	int userId;
	int newsId;
	
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

	public String execute() {
		//System.out.println(userId);
		//System.out.println(newsId);
		String ret="error";
		
try{ 
			
		    
				 int result=0;
				 int views=0;
				    
			     Class.forName("com.mysql.jdbc.Driver");
			     Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/newsBulletinNew?useSSL=true","root","");
			     Statement stmt=conn.createStatement();
			     String query="select * from likedUnliked where nId="+newsId+" and uId="+userId+";";
			    
			    // System.out.println(query);
			     ResultSet rs=stmt.executeQuery(query);
			     while(rs.next()) {
			    	//System.out.println(rs.getInt("result"));
			    	result=rs.getInt("result");
			    	 
			     }
			     Statement stmt1=conn.createStatement();
			     String query1=null;
			     if(rs.last()) {
			    	 if (result==0 || result==1) {
				    	 //System.out.println(result);
				    	 query1="update likedUnliked set result=-1 where nId="+newsId+" and uId="+userId+";";
				    	// System.out.println(query1);
				    	 stmt1.executeUpdate(query1);
				    	 ret ="success";
				        
				     }else if(result==-1) {
				    	//System.out.println(result);
				    	 query1="update likedUnliked set result=0 where nId="+newsId+" and uId="+userId+";";
				    	// System.out.println(query1);
				    	 stmt1.executeUpdate(query1);
				    	 ret ="success";
				     }
			     }
			     else{ 
			    	//System.out.println("not result");
			    	 query1="insert into likedUnliked(nId, uId,result) values ("+newsId+","+userId+",-1);";
			    	// System.out.println(query1);
			    	 stmt1.executeUpdate(query1);
			    	 ret="success";
			       }
			     Statement stmtView=conn.createStatement();
		         ResultSet vRs= stmtView.executeQuery("select view from news where id="+newsId+";");
		         while(vRs.next()) {
		        	// System.out.println(vRs.getInt("view"));
		        	 views=vRs.getInt("view");
		        	 views++;
		        	// System.out.println(views);
		         }
		         stmtView.executeUpdate("update news set view="+views+" where id="+newsId+";");
		         
		   } 
			catch(ClassNotFoundException se) {
		        se.printStackTrace();
		        ret="error";
		    
		    }
			catch(SQLException e) {
		         
		         e.printStackTrace();
		         ret="error";
		      } 
			
		
		
		return ret;
	}

}
