<%@ page import="java.util.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.CentralHashMap" %>
<%@ page import="com.PhoneCatalog" %>


<%!
		public String key;
		public static final String DB_URL="jdbc:mysql://localhost:3306/gadgethub?autoReconnect=true&useSSL=false";
		String user = "root";
		String pass = "tiger";
		Statement stmt = null;
		Connection conn = null;
		String sql;

%>

<%


key = request.getParameter("info");


try
		{
			
			Class.forName("com.mysql.jdbc.Driver");
			
			
			conn = DriverManager.getConnection(DB_URL,user,pass);
			
			
			stmt = conn.createStatement();
			
			sql = "Delete from flightdetails where flightid = '"+key+"';";
			
			int i = stmt.executeUpdate(sql);
			if(i!=0)
			{ %>
				<h3><a href="/assign3/store">Product Deleted Successfully</a></h3>
			<%	}
			else
			{%>
				<h3><a href="/assign3/store">Product could not be Deleted</a></h3>
			<%}
			
			
			 
			 stmt.close();
			 conn.close();
		}
		catch(SQLException se)
		{	//Handle errors for JDBC
			se.printStackTrace();
		}
		catch(Exception e)
		{	//Handle errors for Class.forName
			e.printStackTrace();
		}
		finally
		{
			try
			{
				if(stmt!=null)
                stmt.close();
			}
			catch(SQLException se2)
			{
				
			}
			
			try
			{
				if(conn!=null)
                conn.close();
			}
			catch(SQLException se)
			{
				se.printStackTrace();
			}
		}

%>