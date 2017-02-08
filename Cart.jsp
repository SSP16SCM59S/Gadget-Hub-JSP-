<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.PhoneCatalog" %>
<%@ page import="com.CentralHashMap" %>

<%!
			
			public static final String JDBC_DRIVER="com.mysql.jdbc.Driver";  
			public static final String DB_URL="jdbc:mysql://localhost:3306/gadgethub?autoReconnect=true&useSSL=false";
			String user = "root";
			String pass = "tiger";
			String sql;
			ResultSet rs;
			public String producttype;
			Connection conn = null;
			public static CentralHashMap obj;
			Statement stmt = null;
			
			public String key;
			int qty=0;
		
%>

<%

key = request.getParameter("info");

PhoneCatalog temp1 = obj.Products.get(key);

		if(key.startsWith("PH"))
		{			
			producttype = "phones";
		}
		else if(key.startsWith("AC"))
		{		
			producttype = "accessories";
		}
		else if(key.startsWith("LP"))
		{			
			producttype = "laptops";
		}
		else if(key.startsWith("TB"))
		{
			producttype = "tablets";
		}
		else if(key.startsWith("TV"))
		{
			producttype = "tv";
		}

		
		try
		{
			
			Class.forName("com.mysql.jdbc.Driver");
			
			
			conn = DriverManager.getConnection(DB_URL,user,pass);
						
			
			stmt = conn.createStatement();
			String sql,sql1,sql2;
			sql = "insert into cart values("+null+",'"+key+"','"+temp1.getName()+"','"+temp1.getPrice()+"','"+temp1.getRetailer()+"','"+1+"');";
			sql1 = "select * from cart where id1 = '"+key+"';";
			
			
			
			ResultSet rs = stmt.executeQuery(sql1);
			
			while(rs.next())
			{
				 qty = rs.getInt("Quantity");
				
			}
			if(qty!=0)
			{
				qty++;
				sql2 = "update cart set quantity = "+qty+" where id1 = '"+key+"';";
				int i = stmt.executeUpdate(sql2);
				 if(i!=0)
				{
					response.sendRedirect("/assign3/"+producttype);
				}
			}
			else
			{
				int i = stmt.executeUpdate(sql);
			
				 if(i!=0)
				{
					response.sendRedirect("/assign3/"+producttype);
				}
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