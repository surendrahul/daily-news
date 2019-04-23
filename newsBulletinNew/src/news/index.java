package news;

//import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.json.JSONArray;
import org.json.JSONObject;
import java.sql.*;
 

public class index implements ServletRequestAware {
	private JSONArray content;	
	HttpServletRequest request;
	
	public JSONArray getContent() {
		return content;
	}

	public void setContent(JSONArray content) {
		this.content = content;
	}

	public String execute() throws Exception {
		
		Class.forName("com.mysql.jdbc.Driver");
		
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/newsBulletinNew?useSSL=true","root","");
		Statement stmt = con.createStatement();
		
		//ArrayList<JSONArray> tableContent=new ArrayList<JSONArray>();
		ResultSet rs=stmt.executeQuery(" select news.*, user.name , unlikeTable.unliked as unliked,"
				+ " likeTable.liked as liked, commentCount.noofcomments as noOfComment from news "
				+ "left join user on (news.userId=user.id) "
				+ "left join ( select nId, count(result) as unliked from likedUnliked where result=-1 group by nId) as unlikeTable on (news.id=unlikeTable.nId) "
				+ "left join ( select nId, count(result) as liked from likedUnliked where result=1 group by nId) as likeTable on (news.id=likeTable.nId)"
				+ " left join ( select news.id , count(nId) as noofcomments from news left join comments on (news.id=comments.nId) group by id) as commentCount on (news.id=commentCount.id)  order by news.id;" );
		//tableContent.add(JsonConvert.convertToJSON(rs));
		
		
		
		this.setContent(JsonConvert.convertToJSON(rs));	
		HttpSession session=request.getSession();
	   	 session.setAttribute("tableData", this.getContent());
	   	// session.setAttribute("commentData", null);
	   
		return "success";
	}

	@Override
	public void setServletRequest(HttpServletRequest request) {
		// TODO Auto-generated method stub
		this.request=request;
		
	}

	
}






