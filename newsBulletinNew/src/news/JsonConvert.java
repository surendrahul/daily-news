package news;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

public class JsonConvert {
	
	public static JSONArray convertToJSON(ResultSet resultSet)
            throws Exception {
		
        JSONArray jsonArray = new JSONArray();
       
        while (resultSet.next()) {
        	
            int total_rows = resultSet.getMetaData().getColumnCount();
            
            JSONObject obj = new JSONObject();
            
            for (int i = 0; i < total_rows; i++) {
                obj.put(resultSet.getMetaData().getColumnLabel(i + 1)
                        .toLowerCase(), resultSet.getObject(i + 1));
                   
            }
            jsonArray.put(obj);
     
        }
		return jsonArray;
    }
	 



	/*public static void main(String[] arr) throws Exception{
		
			Class.forName("com.mysql.jdbc.Driver");
	
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/NewsBulletin","root","test");
				Statement stmt = con.createStatement();
				
				
				String query = "select * from news";
				ResultSet rs = stmt.executeQuery(query);
				System.out.println(query);
				System.out.println(convertToJSON(rs));
				
				
		
	}*/
}
	

