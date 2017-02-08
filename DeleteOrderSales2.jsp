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
			public String username;
			public HttpSession session;
			public static CentralHashMap ob;
			public static final String JDBC_DRIVER="com.mysql.jdbc.Driver";  
			public static final String DB_URL="jdbc:mysql://localhost:3306/gadgethub?autoReconnect=true&useSSL=false";
			String user = "root";
			String pass = "tiger";
			ResultSet rs;
			Connection conn = null;
			Statement stmt = null;
			public String key;
		%>
		<!doctype html>
		<%
		
		key = request.getParameter("info");
		username = request.getParameter("userdata");
		key = request.getParameter("info");
		
		
		
		try
							{
								
								Class.forName("com.mysql.jdbc.Driver");
								
								
								conn = DriverManager.getConnection(DB_URL,user,pass);
								
								
								stmt = conn.createStatement();
								
								String sql,sql2;
								sql = "Delete FROM orders where ord_date='"+key+"' and username ='"+username+"';";
								sql2 = "Delete FROM orderdetails where ord_date='"+key+"' and username ='"+username+"';";
								int i = stmt.executeUpdate(sql);
								
								if(i != 0)
								{
									int i1 = stmt.executeUpdate(sql2);
									System.out.println(i1);
									if(i1 != 0)
									{
									
									ob.OrderList.remove(key);
									%><h3><a href="/assign3/delorder">Order Deleted Successfully</a></h3>
									<%
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