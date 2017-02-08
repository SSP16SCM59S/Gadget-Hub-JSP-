<%@ page import="java.util.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.CentralHashMap" %>
<%@ page import="com.PhoneCatalog" %>
<%@ page import="com.OrderDetails" %>


		<%!
			public String username = null;
			public String key;
			public String price;
			public static CentralHashMap ob;
			public static final String JDBC_DRIVER="com.mysql.jdbc.Driver";  
			public static final String DB_URL="jdbc:mysql://localhost:3306/gadgethub?autoReconnect=true&useSSL=false";
			String user = "root";
			String pass = "tiger";
			ResultSet rs;
			Connection conn = null;
			Statement stmt = null;
			
		%>
		<!doctype html>
		<%
		
		
		
		ob = new CentralHashMap();
		ob.OrderList = new HashMap<Integer, OrderDetails>();
		
		
		
		username = request.getParameter("userdata");
		key = request.getParameter("info");
		price = request.getParameter("price");
		
		ob.OrderList.remove(key);
		try
		{
			//Register JDBC Driver
			Class.forName("com.mysql.jdbc.Driver");
			
			//Opening Connection
			conn = DriverManager.getConnection(DB_URL,user,pass);
			
			//Execute Sql Query
			stmt = conn.createStatement();
			String sql,sql1,sql2;
			sql = "update orders set price = "+Integer.parseInt(price)+" where username='"+username+"' and ord_date='"+key+"';";
			
			sql1 = "SELECT * FROM orders";
			
			int i = stmt.executeUpdate(sql);

			ResultSet rs = stmt.executeQuery(sql1);
			OrderDetails obj;
		
			
			while(rs.next())
			{
				obj = new OrderDetails();
				obj.setAddress(rs.getString("address"));
				obj.setPrice(rs.getString("price"));
				obj.setDate(rs.getString("ord_date"));
				ob.OrderList.put(rs.getInt("orderid"),obj);
			
			}
			
			if(i!=0)
			{
			
				out.println("<h3><a href='/assign3/updorder'> Updated Succesfully</a></h3>");
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