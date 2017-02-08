<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.sql.*" %>

<%!
			public String username = null,password = null;
			HashMap<String,String> hmap = new HashMap<String,String>();
			public static final String JDBC_DRIVER="com.mysql.jdbc.Driver";  
			public static final String DB_URL="jdbc:mysql://localhost:3306/gadgethub?autoReconnect=true&useSSL=false";
			String user = "root";
			String pass = "tiger";
			String sql;
			ResultSet rs;
			Connection conn = null;
			Statement stmt = null;
			int i,id;
		
%>

<%

		username = request.getParameter("uname");
		password = request.getParameter("passwd");

		try
		{
			
			Class.forName("com.mysql.jdbc.Driver");
			
			
			conn = DriverManager.getConnection(DB_URL,user,pass);
			
			
			stmt = conn.createStatement();
			
			sql = "SELECT username,passwd FROM userinfo";
			rs = stmt.executeQuery(sql);
			
			// Extract data from result set
			while(rs.next())
			{
				 String p  = rs.getString("passwd");
				String uid = rs.getString("username");
				
				hmap.put(uid,p);
			}
			 rs.close();
			 stmt.close();
			 conn.close();
		}
		catch(SQLException se)
		{	
			se.printStackTrace();
		}
		catch(Exception e)
		{	
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
		
		
		for (Map.Entry<String,String> entry : hmap.entrySet()) 
			{
			  String key = entry.getKey();
			  String value = entry.getValue();
			  
			 
			  if(key.equals(username) && value.equals(password))
			  {
					session.setAttribute("userid",username);

					if(username.equals("storemanager"))
					{
						response.sendRedirect("/assign3/store"); 
					}
					else if(username.equals("sales"))
					{
						response.sendRedirect("/assign3/sales"); 
					}
					
					else
					{
						response.sendRedirect("/assign3/Welcome"); 
					}
					
			  }
			  
			  
			}
%>
<h3><a href="/assign3/login">Incorrect Username Password pair</a></h3> 