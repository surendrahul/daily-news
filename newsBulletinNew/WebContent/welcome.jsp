
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="java.util.Date" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>news</title>
<link href="https://fonts.googleapis.com/css?family=Fira+Sans" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="news.css">
</head>
<body onload="welcome()">
     

	<header>
<%
	String userName;
	int uId=0;
	int nId=0;
	 Date date=new Date(); 
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
	<button  id="addNewsButton" onclick="login()" >Add News</button>
	<a  id="addNewsButton" onclick="login()" >Login</a>
<% 
}else{
	uId=(int)sessionId.getAttribute("uId");
%>
	<button  id="addNewsButton" onclick="addNews()">Add News</button>
	<!-- <a  id="addNewsButton" href="logOut">Log Out</a> -->
	<form action=logout id=logoutForm style="display:inline;"><input  id="addNewsButton"  type=submit value="Log Out"></form>
<%
}	
%>
<span class=welcomSpan>Hello <%=userName %></span>
</header>
<section class=section1>

</section>


<section class=addNewsSection>
<center>
<input type="button" value="X" onclick="cancle('addNewsSection')" id=cancleNewsAdd>
<form action="addNews" method=get class=addNewsForm>
	<input type="text" name="title" placeholder="enter the title " required><br>
	<input type="hidden" name="userId" value="<%=uId %>" >
	<input type="hidden" name="updateDate" value="<%=date %>" >
	<textarea rows="6" cols="100" name=content placeholder="write here something!!!! use \' at the place of '." required></textarea><br>
	<input type=submit id=finalAddNews value=Submit>
</form>
</center>
</section>

<section class=loginSection>
<center>
<input type="button" value="X" onclick="cancle('loginSection')" id=cancleLogginButton>
<form action="login" method=get class=loginForm>
	<br><br>
	<input type="email" name="email" placeholder="enter your phone or email" required><br>
	<input type="password" name="password" placeholder="password" required><br>
	<input type=submit id=loginButton value=Login><br><br>
</form>
<button id=newAccountButton onclick="signUp()">create a new account</button>
</center>
</section>


<section class=signUpSection>
<center>
<input type="button" value="X" onclick="cancle('signUpSection')" id=cancleSignUpButton>
<form action="signUp" method=get class=signUpForm>
	<br>
	<input type="text" name="name" placeholder="enter your name" required><br>
	<input type="email" name="email" placeholder="enter your email" required><br>
	<input type="tel" name="mobileNo" placeholder="enter your mobileNo" required><br>
	<input type="password" name="password" placeholder="password" required><br>
	<input type=submit id=submitNewAccount value=submit><br>
</form>
</center>
</section>
	
</body>
<script>

var userName='<%= session.getAttribute("userName")%>';
var uId='<%= session.getAttribute("uId") %>';

function welcome(){
	var news=JSON.parse("<s:property value='%{#session.tableData}'/>".replace(/&quot;/g,'"'));
	//console.log(a);
	//var news=a;
	//console.log(news);
	
	//var commentTable=a[1];
	//console.log(commentTable);
	/* 
	var userTable=a[2];
	console.log(userTable);
	
	var likedUnlikedTable=a[3];
	console.log(likedUnlikedTable);
	 */
	
	
	
	
	
	//console.log(userName+", "+uId);
	/* "<s:property value ='content'/>" */
	
	var parent=document.getElementsByClassName("section1")[0];
	//console.log(parent.className);
	for(var i=0; i<news.length; i++){
		var currentNews=news[i];
		
			
		if(currentNews.liked==undefined){
			currentNews.liked=0;
		}
		if(currentNews.unliked==undefined){
			currentNews.unliked=0;
		}
		if(currentNews.view==undefined){
			currentNews.view=0;
		}
			
		
		
		
		
		var newsTable= document.createElement("table");
		var tableBody=document.createElement("tbody");
		tableBody.setAttribute("id", "tbody"+currentNews.id);
		
		
		
		
		for(var j=1; j<=4; j++){
			var tr=document.createElement("tr");
			
			var td=document.createElement("td");
			
			
			if(j==1){
				td.setAttribute("class","td"+j);
				var titleSpan=document.createElement("span");
				titleSpan.setAttribute("class","newsTitle");
				titleSpan.innerText=news[i].title;
				td.appendChild(titleSpan);
				var br=document.createElement("br");
				td.appendChild(br);
				var userSpan=document.createElement("span");
				userSpan.setAttribute("class","user");
				userSpan.innerText="by: "+currentNews.name+" | ";
				td.appendChild(userSpan);
				var updateDateSpan=document.createElement("span");
				updateDateSpan.setAttribute("class","updateDate");
				updateDateSpan.innerText="updated date: "+currentNews.updatedate;
				td.appendChild(updateDateSpan);
			}
			if(j==2){
				td.setAttribute("class","td"+j);
				td.innerText=currentNews.content;
			}
			if(j==3){
				td.setAttribute("class","td"+j);
				if(userName==="world!!!"){
					var likeSpan=document.createElement("span");
					likeSpan.innerHTML="like &nbsp;&nbsp; "+currentNews.liked;
					likeSpan.setAttribute("onclick", "login()");
					td.appendChild(likeSpan);
					
					var unLikeSpan=document.createElement("span");
					unLikeSpan.innerHTML="unlike &nbsp;&nbsp; "+currentNews.unliked;
					unLikeSpan.setAttribute("onclick", "login()");
					td.appendChild(unLikeSpan);
					
					var viewSpan=document.createElement("span");
					viewSpan.innerHTML="view &nbsp;&nbsp; "+currentNews.view;
					viewSpan.setAttribute("onclick", "login()");
					td.appendChild(viewSpan);
					
					var commentsSpan=document.createElement("span");
					commentsSpan.innerHTML="comments &nbsp;&nbsp; "+currentNews.noofcomment;
					commentsSpan.setAttribute("onclick", "login()");
					td.appendChild(commentsSpan);
					
				}else{
					var likeSpan=document.createElement("span");
					
					var likeForm=document.createElement("form");
					likeForm.setAttribute("action","likeNews")
					var inputnId=document.createElement("input");
					inputnId.setAttribute("type","hidden");
					inputnId.setAttribute("name","newsId");
					inputnId.setAttribute("value",currentNews.id);
					likeForm.appendChild(inputnId);
					
					var inputuId=document.createElement("input");
					inputuId.setAttribute("type","hidden");
					inputuId.setAttribute("name","userId");
					inputuId.setAttribute("value",uId );
					likeForm.appendChild(inputuId);
					
					var submit=document.createElement("input");
					submit.setAttribute("type","submit");
					submit.setAttribute("value","like  "+currentNews.liked );
					likeForm.appendChild(submit);
					likeSpan.appendChild(likeForm);
					td.appendChild(likeSpan);
					
					var unlikeSpan=document.createElement("span");
					var unlikeForm=document.createElement("form");
					unlikeForm.setAttribute("action","unlikeNews")
					var inputnId=document.createElement("input");
					inputnId.setAttribute("type","hidden");
					inputnId.setAttribute("name","newsId");
					inputnId.setAttribute("value", currentNews.id);
					unlikeForm.appendChild(inputnId);
					
					var inputuId=document.createElement("input");
					inputuId.setAttribute("type","hidden");
					inputuId.setAttribute("name","userId");
					inputuId.setAttribute("value",uId );
					unlikeForm.appendChild(inputuId);
					
					var submit=document.createElement("input");
					submit.setAttribute("type","submit");
					submit.setAttribute("value","unlike  "+currentNews.unliked );
					unlikeForm.appendChild(submit);
					unlikeSpan.appendChild(unlikeForm);
					td.appendChild(unlikeSpan);
					
					var viewSpan=document.createElement("span");
					viewSpan.innerHTML="view &nbsp; "+currentNews.view;
					//viewSpan.setAttribute("onclick", "login()");
					td.appendChild(viewSpan);
					
					var commentsSpan=document.createElement("span");
					commentsSpan.innerHTML="comments &nbsp;&nbsp; "+currentNews.noofcomment;
					commentsSpan.setAttribute("onclick", "newComments(this)");
					commentsSpan.setAttribute("id",currentNews.id);
					td.appendChild(commentsSpan);
					
					var div=document.createElement("div");
					div.setAttribute("class","commentsSection");
					var center=document.createElement("center");
					div.appendChild(center);
					var cButton=document.createElement("input");
					cButton.setAttribute("type","button");
					cButton.setAttribute("value","x");
					cButton.setAttribute("onclick","cancle('commentsSection')");
					cButton.setAttribute("id","cancleComments");
					center.appendChild(cButton);
					
					//var commetSpan=document.createElement("span");
					var commentForm=document.createElement("form");
					commentForm.setAttribute("action","commentsNew");
					commentForm.setAttribute("class","commentsForm");
					
					var br=document.createElement("br");
					commentForm.appendChild(br);
					
					var inputnId=document.createElement("input");
					inputnId.setAttribute("type","hidden");
					inputnId.setAttribute("name","newsId");
					inputnId.setAttribute("value", currentNews.id);
					commentForm.appendChild(inputnId);
					
					var inputuId=document.createElement("input");
					inputuId.setAttribute("type","hidden");
					inputuId.setAttribute("name","userId");
					inputuId.setAttribute("value",uId );
					commentForm.appendChild(inputuId);
					
					
					
					var commentContent=document.createElement("textarea");
					commentContent.setAttribute("rows",4);
					commentContent.setAttribute("cols",50);
					commentContent.setAttribute("name","comment");
					commentContent.setAttribute("required","true");
					commentContent.setAttribute("placeholder","write here comments!! for single quote use backward slash and ' " );
					commentForm.appendChild(commentContent);
					var br=document.createElement("br");
					commentForm.appendChild(br);
					
					var submit=document.createElement("input");
					submit.setAttribute("type","submit");
					submit.setAttribute("value","submit" );
					submit.setAttribute("class","finalAddComments" );
					commentForm.appendChild(submit);
					
					var br=document.createElement("br");
					commentForm.appendChild(br);
					var br=document.createElement("br");
					commentForm.appendChild(br);
					
					center.appendChild(commentForm);
					div.appendChild(center); 
					td.appendChild(div);
				}
			}
			
			
			if(j==4){
				
				td.setAttribute("class","allCommentsHeader");
				var center=document.createElement("center");
				center.innerText="All Comments";
				 
				var span=document.createElement("span");
				span.setAttribute("id","button"+(currentNews.id));
				span.setAttribute("class","seeCommentsButton");
				span.setAttribute("onclick","seeComments(this)");
				span.innerText="show comments";
				center.appendChild(span); 
				/* 
				var seeCommentForm=document.createElement("form");
				seeCommentForm.setAttribute("action","seeComments");
				var inputNId=document.createElement("input");
				inputNId.setAttribute("value",currentNews.id);
				inputNId.setAttribute("name","newsId");
				inputNId.setAttribute("type","hidden");
				//inputNId.setAttribute("class","seeCommentsButton");
				//inputNId.setAttribute("id",)
				seeCommentForm.appendChild(inputNId);
				
				var submit=document.createElement("input");
				submit.setAttribute("type","submit");
				submit.setAttribute("value","show comments" );
				submit.setAttribute("class","seeCommentsButton" );
				seeCommentForm.appendChild(submit);
				center.appendChild(seeCommentForm);

				
				*/
				
				
				var hr=document.createElement("hr");
				center.appendChild(hr);
				
				td.appendChild(center);
				
				
			}
			tr.appendChild(td);
			tableBody.appendChild(tr);
			
			
			
		}
		
		//console.log(comments);
		
		/* 	
		for(var cc=0; cc<commentTable.length ; cc++){
			if(commentTable[cc].nid==currentNews.id){
				var currentComment=commentTable[cc];
				//console.log(currentComment.uid+", "+currentComment.id+", "+currentComment.comment+", "+currentComment.pcommentid+", pUserId:"+currentComment.puserid);
				//  userTable[(currentComment.uid)-1].name;
				
				
				if(currentComment.puserid==undefined){
					//console.log("hello");
					var tr=document.createElement("tr");
					var td=document.createElement("td");
					var hr=document.createElement("hr");
					td.innerText=currentComment.username+" :  "+currentComment.comment;  
					td.setAttribute("class","allCommentsbutton"+(currentNews.id)+" allComments");
					if(userName==="world!!!"){
						var replyButtonSpan=document.createElement("span");
						replyButtonSpan.setAttribute("class","replyButton");
						replyButtonSpan.setAttribute("onclick","login()");
						replyButtonSpan.innerText="reply";
						td.appendChild(replyButtonSpan);
					}else{
						var replyButtonSpan=document.createElement("span");
						replyButtonSpan.setAttribute("class","replyButton");
						replyButtonSpan.setAttribute("onclick","reply(this)");
						replyButtonSpan.setAttribute("id","commentId"+currentComment.id);
						replyButtonSpan.innerText="reply";
						td.appendChild(replyButtonSpan);
						
						
							
							 var replyDiv=document.createElement("div");
							replyDiv.setAttribute("class","replySection commentId"+currentComment.id);
							//replyDiv.setAttribute("id", "commentId"+currentComment.id);
							var center=document.createElement("center");
							replyDiv.appendChild(center);
							var cButton=document.createElement("input");
							cButton.setAttribute("type","button");
							cButton.setAttribute("value","x");
							cButton.setAttribute("onclick","cancle('replySection')");
							cButton.setAttribute("id","cancleReply");
							center.appendChild(cButton);
							
							//var commetSpan=document.createElement("span");
							var replyForm=document.createElement("form");
							replyForm.setAttribute("action","replyOfComments");
							replyForm.setAttribute("class","replyForm");
							
							var br=document.createElement("br");
							replyForm.appendChild(br);
							
							var inputnId=document.createElement("input");
							inputnId.setAttribute("type","hidden");
							inputnId.setAttribute("name","pCUId");
							inputnId.setAttribute("value",currentComment.uid);
							replyForm.appendChild(inputnId);
							
							var inputnId=document.createElement("input");
							inputnId.setAttribute("type","hidden");
							inputnId.setAttribute("name","newsId");
							inputnId.setAttribute("value", currentComment.nid);
							replyForm.appendChild(inputnId);
							
							var parentId=document.createElement("input");
							parentId.setAttribute("type","hidden");
							parentId.setAttribute("name","parentCommentId");
							parentId.setAttribute("value", currentComment.id);
							replyForm.appendChild(parentId);
							
							var inputuId=document.createElement("input");
							inputuId.setAttribute("type","hidden");
							inputuId.setAttribute("name","userId");
							inputuId.setAttribute("value",uId );
							replyForm.appendChild(inputuId);
							
							
							
							var commentContent=document.createElement("textarea");
							commentContent.setAttribute("rows",4);
							commentContent.setAttribute("cols",50);
							commentContent.setAttribute("name","reply");
							commentContent.setAttribute("required","true");
							commentContent.setAttribute("placeholder","write here reply!! for single quote use backward slash and ' " );
							replyForm.appendChild(commentContent);
							var br=document.createElement("br");
							replyForm.appendChild(br);
							
							var submit=document.createElement("input");
							submit.setAttribute("type","submit");
							submit.setAttribute("value","submit" );
							submit.setAttribute("class","finalReplyComments" );
							replyForm.appendChild(submit);
							
							var br=document.createElement("br");
							replyForm.appendChild(br);
							var br=document.createElement("br");
							replyForm.appendChild(br);
							
							center.appendChild(replyForm);
							replyDiv.appendChild(center); 
							td.appendChild(replyDiv);
							
							
					}  */
					
					 /*  var seeReplySpan=document.createElement("span");
					 seeReplySpan.innerText="view reply";
					 seeReplySpan.setAttribute("onclick", "seeReply(this)");
					// seeReplySpan.setAttribute("id","masterCommentId");               
					 seeReplySpan.setAttribute("class","seeReplyButton");
					 td.appendChild(seeReplySpan);  */
					 
					 /* 
					 td.appendChild(hr);
						tr.appendChild(td);
						tableBody.appendChild(tr);
					 
					 for(var rep=0; rep<commentTable.length; rep++){
						 var replyComment=commentTable[rep];
						 
						 if(currentComment.id==replyComment.pcommentid && replyComment.puserid!=undefined  ){
							// console.log("rahul: "+replyComment.comment);
							
							//
							
							// console.log(currentComment.cid);
								var tr=document.createElement("tr");
								var td=document.createElement("td");
								var hr=document.createElement("hr");
								//userTable[(replyComment.uid)-1].name >userTable[(replyComment.puserid)-1].name
								
								td.innerText=replyComment.username+" > "+replyComment.pusername+"  : "+replyComment.comment; 
								td.setAttribute("class","allCommentsbutton"+(i+1)+"  allReply");
								
								if(userName==="world!!!"){
									var span=document.createElement("span");
									span.setAttribute("class","replyButton");
									span.setAttribute("onclick","login()");
									span.innerText="reply";
									td.appendChild(span);
								}else{
									var span=document.createElement("span");
									span.setAttribute("class","replyButton");
									span.setAttribute("onclick","reply(this)");
									span.setAttribute("id","commentId"+replyComment.id);
									span.innerText="reply";
									td.appendChild(span);
									
								
										
										 var replyDiv=document.createElement("div");
										replyDiv.setAttribute("class","replySection commentId"+replyComment.id);
										//replyDiv.setAttribute("id", "commentId"+currentComment.id);
										var center=document.createElement("center");
										replyDiv.appendChild(center);
										var cButton=document.createElement("input");
										cButton.setAttribute("type","button");
										cButton.setAttribute("value","x");
										cButton.setAttribute("onclick","cancle('replySection')");
										cButton.setAttribute("id","cancleReply");
										center.appendChild(cButton);
										
										//var commetSpan=document.createElement("span");
										var replyForm=document.createElement("form");
										replyForm.setAttribute("action","replyOfComments");
										replyForm.setAttribute("class","replyForm");
										
										var br=document.createElement("br");
										replyForm.appendChild(br);
										
										var inputnId=document.createElement("input");
										inputnId.setAttribute("type","hidden");
										inputnId.setAttribute("name","pCUId");
										inputnId.setAttribute("value", replyComment.uid);//
										replyForm.appendChild(inputnId);
										
										var inputnId=document.createElement("input");
										inputnId.setAttribute("type","hidden");
										inputnId.setAttribute("name","newsId");
										inputnId.setAttribute("value", replyComment.nid);
										replyForm.appendChild(inputnId);
										
										var parentId=document.createElement("input");
										parentId.setAttribute("type","hidden");
										parentId.setAttribute("name","parentCommentId");
										parentId.setAttribute("value", replyComment.pcommentid);//
										replyForm.appendChild(parentId);
										
										var inputuId=document.createElement("input");
										inputuId.setAttribute("type","hidden");
										inputuId.setAttribute("name","userId");
										inputuId.setAttribute("value",uId );
										replyForm.appendChild(inputuId);
										
										
										
										var commentContent=document.createElement("textarea");
										commentContent.setAttribute("rows",4);
										commentContent.setAttribute("cols",50);
										commentContent.setAttribute("name","reply");
										commentContent.setAttribute("required","true");
										commentContent.setAttribute("placeholder","write here reply!! for single quote use backward slash and ' " );
										replyForm.appendChild(commentContent);
										var br=document.createElement("br");
										replyForm.appendChild(br);
										
										var submit=document.createElement("input");
										submit.setAttribute("type","submit");
										submit.setAttribute("value","submit" );
										submit.setAttribute("class","finalReplyComments" );
										replyForm.appendChild(submit);
										
										var br=document.createElement("br");
										replyForm.appendChild(br);
										var br=document.createElement("br");
										replyForm.appendChild(br);
										
										center.appendChild(replyForm);
										replyDiv.appendChild(center); 
										td.appendChild(replyDiv);
								} 
							
							//
							
							
						 } 
						 td.appendChild(hr);
							tr.appendChild(td);
							tableBody.appendChild(tr);
							 
					 }
					 
					 
				}
			}	
		} */
		 
		newsTable.appendChild(tableBody);
		parent.appendChild(newsTable);
		
		
	}
	/*for hide the all comments at loading time  */
	/* for(var hh=0; hh<document.getElementsByClassName("allComments").length; hh++){
		document.getElementsByClassName("allComments")[hh].style.display="none";
	} */
	/* for hide the all reply at loading time */
	/* for(var rr=0; rr<document.getElementsByClassName("allReply").length; rr++){
		document.getElementsByClassName("allReply")[rr].style.display="none";
	} */
}	
	
	
	function addNews(){
		document.getElementsByClassName("addNewsSection")[0].style.display="block";
	}
	function cancle(obj){		
		var a=document.getElementsByClassName(obj).length;
		//console.log(a);
		for(var i=0; i<a; i++){
			document.getElementsByClassName(obj)[i].style.display="none";
		}		
	}
	function login(){
		document.getElementsByClassName("loginSection")[0].style.display="block";
		//console.log("ask for login");
	}
	function signUp(){
		document.getElementsByClassName("loginSection")[0].style.display="none";
		document.getElementsByClassName("signUpSection")[0].style.display="block";
	}
	function newComments(obj){
		var a=obj.id-1;
		//console.log("comments click");
		document.getElementsByClassName("commentsSection")[a].style.display="block";
	}
	function seeComments(obj){
		var aa=obj.id
		var a="allComments"+aa;
		//console.log(aa+", "+a);
		//console.log(obj.innerHTML);
		
		 
		var abc;
				
			    if (window.XMLHttpRequest)
			    {// If the browser if IE7+[or]Firefox[or]Chrome[or]Opera[or]Safari
			    	abc=new XMLHttpRequest();
			    }
			   else
			    {//If browser is IE6, IE5
				   abc=new ActiveXObject("Microsoft.XMLHTTP");
			    }
			
			    abc.onreadystatechange=function()
			{
				//console.log("value is "+abc.readyState);
			  if (abc.readyState==4 && abc.status==200)
			  {
				  var commentData1=abc.responseText;
				 // testData.replace(/&quot;/g,'"');
				  
				  var commentTable=JSON.parse(commentData1.replace(/&quot;/g,'"'));
				 // console.log(commentTable);
				  var firstComment=commentTable[0];
				  if(commentTable.length>0){
					  var tableBody=document.getElementById("tbody"+commentTable[0].nid);
					  obj.innerHTML="show comments";
					 // console.log(tableBody);
					// var tableRow=document.getElementsByclassName()

					  var rr=document.getElementsByClassName("allCommentsbutton"+firstComment.nid)[0];
					//console.log(rr);
					if(rr!=undefined){
						for(var rc=0; rc<commentTable.length; rc++){
						    rrr=document.getElementsByClassName("allCommentsbutton"+firstComment.nid)[0];
						  // console.log(rrr);
						  //if(rr!=undefined){
							  tableBody.removeChild(rrr.parentNode);
						  //}  
					  } 
					}else{
						obj.innerHTML="hide comments";
						 for(var cc=0; cc<commentTable.length ; cc++){
								
								var currentComment=commentTable[cc];
								//console.log(currentComment.uid+", "+currentComment.id+", "+currentComment.comment+", "+currentComment.pcommentid+", pUserId:"+currentComment.puserid);
								//  userTable[(currentComment.uid)-1].name;
								
								
								if(currentComment.puserid==undefined){
									//console.log("hello");
									var tr=document.createElement("tr");
									var td=document.createElement("td");
									var hr=document.createElement("hr");
									td.innerText=currentComment.username+" :  "+currentComment.comment;  
									td.setAttribute("class","allCommentsbutton"+(currentComment.nid)+" allComments");
									if(userName==="world!!!"){
										var replyButtonSpan=document.createElement("span");
										replyButtonSpan.setAttribute("class","replyButton");
										replyButtonSpan.setAttribute("onclick","login()");
										replyButtonSpan.innerText="reply";
										td.appendChild(replyButtonSpan);
									}else{
										var replyButtonSpan=document.createElement("span");
										replyButtonSpan.setAttribute("class","replyButton");
										replyButtonSpan.setAttribute("onclick","reply(this)");
										replyButtonSpan.setAttribute("id","commentId"+currentComment.id);
										replyButtonSpan.innerText="reply";
										td.appendChild(replyButtonSpan);
										
										
											
											 var replyDiv=document.createElement("div");
											replyDiv.setAttribute("class","replySection commentId"+currentComment.id);
											//replyDiv.setAttribute("id", "commentId"+currentComment.id);
											var center=document.createElement("center");
											replyDiv.appendChild(center);
											var cButton=document.createElement("input");
											cButton.setAttribute("type","button");
											cButton.setAttribute("value","x");
											cButton.setAttribute("onclick","cancle('replySection')");
											cButton.setAttribute("id","cancleReply");
											center.appendChild(cButton);
											
											//var commetSpan=document.createElement("span");
											var replyForm=document.createElement("form");
											replyForm.setAttribute("action","replyOfComments");
											replyForm.setAttribute("class","replyForm");
											
											var br=document.createElement("br");
											replyForm.appendChild(br);
											
											var inputnId=document.createElement("input");
											inputnId.setAttribute("type","hidden");
											inputnId.setAttribute("name","pCUId");
											inputnId.setAttribute("value",currentComment.uid);
											replyForm.appendChild(inputnId);
											
											var inputnId=document.createElement("input");
											inputnId.setAttribute("type","hidden");
											inputnId.setAttribute("name","newsId");
											inputnId.setAttribute("value", currentComment.nid);
											replyForm.appendChild(inputnId);
											
											var parentId=document.createElement("input");
											parentId.setAttribute("type","hidden");
											parentId.setAttribute("name","parentCommentId");
											parentId.setAttribute("value", currentComment.id);
											replyForm.appendChild(parentId);
											
											var inputuId=document.createElement("input");
											inputuId.setAttribute("type","hidden");
											inputuId.setAttribute("name","userId");
											inputuId.setAttribute("value",uId );
											replyForm.appendChild(inputuId);
											
											
											
											var commentContent=document.createElement("textarea");
											commentContent.setAttribute("rows",4);
											commentContent.setAttribute("cols",50);
											commentContent.setAttribute("name","reply");
											commentContent.setAttribute("required","true");
											commentContent.setAttribute("placeholder","write here reply!! for single quote use backward slash and ' " );
											replyForm.appendChild(commentContent);
											var br=document.createElement("br");
											replyForm.appendChild(br);
											
											var submit=document.createElement("input");
											submit.setAttribute("type","submit");
											submit.setAttribute("value","submit" );
											submit.setAttribute("class","finalReplyComments" );
											replyForm.appendChild(submit);
											
											var br=document.createElement("br");
											replyForm.appendChild(br);
											var br=document.createElement("br");
											replyForm.appendChild(br);
											
											center.appendChild(replyForm);
											replyDiv.appendChild(center); 
											td.appendChild(replyDiv);
											
											
									}
									 td.appendChild(hr);
										tr.appendChild(td);
										tableBody.appendChild(tr);
									 
									 for(var rep=0; rep<commentTable.length; rep++){
										 var replyComment=commentTable[rep];
										 
										 if(currentComment.id==replyComment.pcommentid && replyComment.puserid!=undefined  ){
											// console.log("rahul: "+replyComment.comment);
											
											//
											
											// console.log(currentComment.cid);
												var tr=document.createElement("tr");
												var td=document.createElement("td");
												var hr=document.createElement("hr");
												//userTable[(replyComment.uid)-1].name >userTable[(replyComment.puserid)-1].name
												
												td.innerText=replyComment.username+" > "+replyComment.pusername+"  : "+replyComment.comment; 
												td.setAttribute("class","allCommentsbutton"+(currentComment.nid)+"  allReply");
												
												if(userName==="world!!!"){
													var span=document.createElement("span");
													span.setAttribute("class","replyButton");
													span.setAttribute("onclick","login()");
													span.innerText="reply";
													td.appendChild(span);
												}else{
													var span=document.createElement("span");
													span.setAttribute("class","replyButton");
													span.setAttribute("onclick","reply(this)");
													span.setAttribute("id","commentId"+replyComment.id);
													span.innerText="reply";
													td.appendChild(span);
													
												
														
														 var replyDiv=document.createElement("div");
														replyDiv.setAttribute("class","replySection commentId"+replyComment.id);
														//replyDiv.setAttribute("id", "commentId"+currentComment.id);
														var center=document.createElement("center");
														replyDiv.appendChild(center);
														var cButton=document.createElement("input");
														cButton.setAttribute("type","button");
														cButton.setAttribute("value","x");
														cButton.setAttribute("onclick","cancle('replySection')");
														cButton.setAttribute("id","cancleReply");
														center.appendChild(cButton);
														
														//var commetSpan=document.createElement("span");
														var replyForm=document.createElement("form");
														replyForm.setAttribute("action","replyOfComments");
														replyForm.setAttribute("class","replyForm");
														
														var br=document.createElement("br");
														replyForm.appendChild(br);
														
														var inputnId=document.createElement("input");
														inputnId.setAttribute("type","hidden");
														inputnId.setAttribute("name","pCUId");
														inputnId.setAttribute("value", replyComment.uid);//
														replyForm.appendChild(inputnId);
														
														var inputnId=document.createElement("input");
														inputnId.setAttribute("type","hidden");
														inputnId.setAttribute("name","newsId");
														inputnId.setAttribute("value", replyComment.nid);
														replyForm.appendChild(inputnId);
														
														var parentId=document.createElement("input");
														parentId.setAttribute("type","hidden");
														parentId.setAttribute("name","parentCommentId");
														parentId.setAttribute("value", replyComment.pcommentid);//
														replyForm.appendChild(parentId);
														
														var inputuId=document.createElement("input");
														inputuId.setAttribute("type","hidden");
														inputuId.setAttribute("name","userId");
														inputuId.setAttribute("value",uId );
														replyForm.appendChild(inputuId);
														
														
														
														var commentContent=document.createElement("textarea");
														commentContent.setAttribute("rows",4);
														commentContent.setAttribute("cols",50);
														commentContent.setAttribute("name","reply");
														commentContent.setAttribute("required","true");
														commentContent.setAttribute("placeholder","write here reply!! for single quote use backward slash and ' " );
														replyForm.appendChild(commentContent);
														var br=document.createElement("br");
														replyForm.appendChild(br);
														
														var submit=document.createElement("input");
														submit.setAttribute("type","submit");
														submit.setAttribute("value","submit" );
														submit.setAttribute("class","finalReplyComments" );
														replyForm.appendChild(submit);
														
														var br=document.createElement("br");
														replyForm.appendChild(br);
														var br=document.createElement("br");
														replyForm.appendChild(br);
														
														center.appendChild(replyForm);
														replyDiv.appendChild(center); 
														td.appendChild(replyDiv);
												} 
											
											
											
											
										 } 
										 td.appendChild(hr);
											tr.appendChild(td);
											tableBody.appendChild(tr);
											 
									 }
									 
									 
								}
								
						} 
					  //
						
					}
					  
					   
				  }
				 
			   }
			}
			
		    abc.open("GET","seeComments.action?newsId="+aa,true);
			abc.send(); 
			
			
			
		
	}
	
	
	
	function reply(obj){
		var a=obj.id;
		console.log(obj);
		document.getElementsByClassName(a)[0].style.display="block";
	}
	
	function seeReply(obj){
		console.log(obj);
	}


</script>
</html>

