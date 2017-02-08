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
			public String username;
			public static CentralHashMap ob;
			public static final String JDBC_DRIVER="com.mysql.jdbc.Driver";  
			public static final String DB_URL="jdbc:mysql://localhost:3306/gadgethub?autoReconnect=true&useSSL=false";
			String user = "root";
			String pass = "tiger";
			String sql;
			ResultSet rs;
			Connection conn = null;
			Statement stmt = null;
			public static CartDetails temp1;
			public static int price=0;
		
			public String address;
			public String date1;
			
		%>

<!doctype html>

<%


date1 = new SimpleDateFormat("MM-dd-yyyy/hh:mm").format(new java.util.Date());	
address = request.getParameter("address");
price = Integer.parseInt(request.getParameter("info"));	
username = session.getAttribute("userid").toString();


try
		{
			//Register JDBC Driver
			Class.forName("com.mysql.jdbc.Driver");
			
			//Opening Connection
			conn = DriverManager.getConnection(DB_URL,user,pass);
			
			//Execute Sql Query
			stmt = conn.createStatement();
			String sql1,sql_end;
			
			sql_end = "delete from cart";
			sql1 = "insert into orders values("+null+",'"+date1+"',"+price+",'"+address+"','"+username+"');";
			
			int i = stmt.executeUpdate(sql1);
			
			int i2=0;
			CartDetails temp1 = null;
			System.out.println("reached");
			if(i!=0)
			{
				for(String key: ob.cartList.keySet())
				{
						
					temp1 = ob.cartList.get(key);
					
					String sql2 = "insert into orderdetails values("+null+",'"+date1+"','"+temp1.getName()+"',"+Integer.parseInt(temp1.getPrice())+",'"+temp1.getRetailer()+"',"+temp1.getQuantity()+",'"+username+"');";
					i2 = stmt.executeUpdate(sql2);
				}
			}
			
			
			int i3 = stmt.executeUpdate(sql_end);
			if(i2!=0)
			{	ob.cartList.clear();
				out.println("<h3><a href='/assign3/Welcome'> Order Placed return to home page</a></h3>");
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