package news;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.json.JSONArray;
import org.json.JSONObject;

import com.opensymphony.xwork2.ActionSupport;

import java.sql.*;
 

public class seeComments extends ActionSupport implements ServletRequestAware {
	private JSONArray content;	
	private String newsId;
	
	public JSONArray getContent() {
		return content;
	}

	public void setContent(JSONArray content) {
		this.content = content;
	}

	public String getNewsId() {
		return newsId;
	}

	public void setNewsId(String newsId) {
		this.newsId = newsId;
	}

	public String execute() throws Exception {
		
		Class.forName("com.mysql.jdbc.Driver");
		
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/newsBulletinNew?useSSL=true","root","");
		Statement stmt = con.createStatement();
		ResultSet rs=null;
		//System.out.println(this.getNewsId());
		String StringId=this.getNewsId();
		int id=Integer.parseInt(StringId.replaceAll("button", ""));
		//System.out.println(id);
		
		
		
		
		
		
		rs=stmt.executeQuery(" select comments.*, user1.name as pUserName, user2.name as userName from comments left join "
				+ "user as user1 on (comments.pUserId=user1.id) left join "
				+ "user as user2 on (comments.uId=user2.id) where comments.nId="+id+" order by id;");
		
		this.setContent(JsonConvert.convertToJSON(rs));

		
		
	   //	System.out.println(content);
	   
		return "success";
	}

	@Override
	public void setServletRequest(HttpServletRequest request) {
		// TODO Auto-generated method stub
		//this.request=request;
		
	}

	
}






