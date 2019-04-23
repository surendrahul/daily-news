package news;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.interceptor.ServletRequestAware;

import com.opensymphony.xwork2.ActionSupport;

public class logout extends ActionSupport implements ServletRequestAware {
	HttpServletRequest request;
	String userName;
	int uId=0;
	
	public HttpServletRequest getServletRequest() {
		return request;
	}

	@Override
	public void setServletRequest(HttpServletRequest request) {
		// TODO Auto-generated method stub
		this.request=request;
		
	}
	
	public String execute() {
		//System.out.println("logout");
		HttpSession session=request.getSession();
		userName=(String)session.getAttribute("userName");
		uId=(int)session.getAttribute("uId");
		//System.out.println(uId);
		session.setAttribute("userName", null);
		session.setAttribute("uId", 0);
		uId=(int)session.getAttribute("uId");
		//System.out.println("after delete "+uId);
		
		return "success";
	}
	

}
