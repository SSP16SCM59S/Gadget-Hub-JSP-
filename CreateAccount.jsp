<%@ page import="java.util.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.CentralHashMap" %>
<%@ page import="com.PhoneCatalog" %>
<%@ page import="com.CartDetails" %>
<%@ page import="java.text.SimpleDateFormat" %>

		<%!
			public String username = null,phone = null,email = null, address = null,password = null;
			boolean flag = true;
			HashMap<Integer,String> hmap = new HashMap<Integer,String>();
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

<!doctype html>

<%


username = request.getParameter("uname");
		password = request.getParameter("passwd");
		email = request.getParameter("email");
		phone = request.getParameter("phone");
		address = request.getParameter("address");
		
		try
		{
			//Register JDBC Driver
			Class.forName("com.mysql.jdbc.Driver");
			
			//Opening Connection
			conn = DriverManager.getConnection(DB_URL,user,pass);
			
			//Execute Sql Query
			stmt = conn.createStatement();
			String sql;
			sql = "SELECT id, username,email,phone,address FROM userinfo";
			ResultSet rs = stmt.executeQuery(sql);
			
			// Extract data from result set
			while(rs.next())
			{
				int id  = rs.getInt("id");
				String uid = rs.getString("username");
				
				hmap.put(id,uid);
			}
			 rs.close();
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
		
		
		
		for (Integer key : hmap.keySet()) 
		{
			if((hmap.get(key)).equals(username))
			{
				out.println("<h3><a href='/assign3/sales'> Username already Exists please try with a different one</a></h3>");
				flag = false;
			}
		}
		
		
		if(flag == true)
		{
			try
		{
			//Register JDBC Driver
			Class.forName("com.mysql.jdbc.Driver");
			
			//Opening Connection
			conn = DriverManager.getConnection(DB_URL,user,pass);
			
			
			
			//Execute Sql Query
			stmt = conn.createStatement();
			String sql;
			sql = "insert into userinfo values("+null+",'"+username+"','"+password+"','"+email+"','"+phone+"','"+address+"');";
			
			int i = stmt.executeUpdate(sql);
			
			if(i!=0)
			{
				out.println("<h3><a href='/assign3/sales'>Account Created Successfully</a></h3>");
			}
			else
			{
				out.println("<h3><a href='/assign3/sales'>Account cannot be created contact the admin</a></h3>");
			}
			
			// Extract data from result set
			
			 
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
		}


%>
