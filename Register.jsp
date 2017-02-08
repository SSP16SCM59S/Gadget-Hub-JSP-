<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.sql.*" %>



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

<%

		username = request.getParameter("uname");
		password = request.getParameter("passwd");
		email = request.getParameter("email");
		phone = request.getParameter("phone");
		address = request.getParameter("address");
		
		
		try
		{
			
			Class.forName("com.mysql.jdbc.Driver");
			
			
			conn = DriverManager.getConnection(DB_URL,user,pass);
			
			
			stmt = conn.createStatement();
			
			sql = "SELECT id, username,email,phone,address FROM userinfo";
			rs = stmt.executeQuery(sql);
			
			// Extract data from result set
			while(rs.next())
			{
				 id  = rs.getInt("id");
				String uid = rs.getString("username");
				
				hmap.put(id,uid);
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
		
		
		
		for (Map.Entry<Integer, String> entry : hmap.entrySet()) 
		{
			Integer key = entry.getKey();
			if((hmap.get(key)).equals(username))
			{ %>
				<h3><a href="/assign3/Signup"> Username already Exists please signup using a different one </a> </h3>
				
				<%flag = false;
			}
		}
		
		
		if(flag == true)
		{
			try
		{
			
			Class.forName("com.mysql.jdbc.Driver");
			
			
			conn = DriverManager.getConnection(DB_URL,user,pass);
			
			
			
			
			stmt = conn.createStatement();
			
			sql = "insert into userinfo values("+null+",'"+username+"','"+password+"','"+email+"','"+phone+"','"+address+"');";
			
			i = stmt.executeUpdate(sql);
			
			if(i!=0)
			{%>
				<h3><a href="/assign3/login">Account Created Successfully</a></h3>
			<%}
			else
			{%>
				<h3><a href="/assign3/Welcome"> Account cannot be created contact the admin </a></h3>
			<%}
			
			
			
			 
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
		}

%>