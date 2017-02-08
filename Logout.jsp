<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.sql.*" %>




<%

		
		if(session!=null)
		{	
			session.removeAttribute("userid");
			session.invalidate();
			
		}
		session = request.getSession(false);
		if(session==null)
		{	
	
		
%>

<h3><a href="/assign3/Welcome">Logged out Successfully</a></h3>

<%
		}
		else
		{
			
	%>	
	<h3><a href="/assign3/Welcome">Did not work</a></h3>
	
	<%
		}
	
	%>	