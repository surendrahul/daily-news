<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>newsError</title>
<link href="https://fonts.googleapis.com/css?family=Fira+Sans" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="news.css">
<style type="text/css">
body{
	background-color: #ffd4ffc2;
}
.errorSection{
    position: relative;
    top: 170px;
    word-spacing: 20px;
    line-height: 1.5;
    font-family: cursive;
}
 h1{
	font-family: cursive;
    color: #5ad8c6;
    font-size: 42px;
	
}
h3{
	font-family: cursive;
	color:red;
	font-size: 30px;
	
}
#sadImage{
	box-shadow: 0px 0px 25px blue;
    height: 300px;
    width: 400px;
    position: relative;
    top: 250px;
    border-radius: 15px;
}

</style>
</head>
<body>
	<header>
<%
	String userName;
	int uId=0;
	int nId=0;
	
	//System.out.println( date);
	HttpSession sessionId=request.getSession();
	userName=(String)sessionId.getAttribute("userName");
	
	//System.out.println(uId);
	if(userName==null){
		userName="world!!!";
		sessionId.setAttribute("userName","world!!!");
		
	}
%>
<img alt="icon" src="myImg/news2.png" id="icon1">
<span id="news">NEWS</span>
<%
if(userName.equals("world!!!")){	
%>
	<a  id="addNewsButton" href=index.jsp >Back</a>
<% 
}else{
	uId=(int)sessionId.getAttribute("uId");
%>
	<a  id="addNewsButton" href="index.jsp">Back</a>
<%
}	
%>
<span class=welcomSpan>Hello <%=userName %></span>
</header>
<section class=errorSection>
	<center>
		<h1>Oops!<br> Nothing to<br> see here.</h1><br>
		<h3>YOU FOUND A ERROR!!!</h3>
		
	</center>
</section>

<center>
	<img alt="sad" src="myImg/dog.jpg" id=sadImage>
</center>

	
</body>
</html>












