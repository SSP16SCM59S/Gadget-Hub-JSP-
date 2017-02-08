<%@ page import="java.util.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.sql.*" %>

<%@ page import="com.mongodb.*" %>
<%!
		public String flightid;
		public String flightname;
		public String airline;
		public String flighttype;
		public String flightcapacity;
		public static MongoClient mongo = new MongoClient("localhost",27017);
		public static final String JDBC_DRIVER="com.mysql.jdbc.Driver";  
		public static final String DB_URL="jdbc:mysql://localhost:3306/gadgethub?autoReconnect=true&useSSL=false"; //update database name
		String user = "root";
		String pass = "tiger";
		Statement stmt = null;
		Connection conn = null;
		
%>

<%

		flightid = request.getParameter("flightid");
		flightname = request.getParameter("flightname");
		flightcapacity = request.getParameter("capacity");
		flighttype = request.getParameter("flighttype");
		airline = request.getParameter("airlines");
		
			
		try
		{
			//Register JDBC Driver
			Class.forName("com.mysql.jdbc.Driver");
			
			//Opening Connection
			conn = DriverManager.getConnection(DB_URL,user,pass);
			
			//Execute Sql Query
			stmt = conn.createStatement();
			String sql;
			sql = "insert into flightdetails values('"+flightid+"','"+flightname+"','"+flightcapacity+"','"+flighttype+"','"+airline+"');"; //update table name
			
			int i = stmt.executeUpdate(sql);
			if(i!=0)
			{
				out.println("<h3><a href='/assign3/store'>Flight Added Successfully</a></h3>"); //update link
			}
			else
			{
				out.println("<h3><a href='/assign3/store'>Flight cannot be added</a></h3>"); // update link
			}
			
			
			 
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