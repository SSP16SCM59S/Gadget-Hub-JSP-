<%@ page import="java.util.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.CentralHashMap" %>
<%@ page import="com.PhoneCatalog" %>
<%@ page import="com.CartDetails" %>


		<%!
			public String username;
			public HttpSession session;
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
			public String key;
		%>
		
		<%
		
		key = request.getParameter("info");
		
		
		try
							{
								
								Class.forName("com.mysql.jdbc.Driver");
								
								
								conn = DriverManager.getConnection(DB_URL,user,pass);
								
								
								stmt = conn.createStatement();
								
								sql = "delete FROM cart where id1 = '"+key+"';";
								int i = stmt.executeUpdate(sql);
								
								if(i != 0)
								{
									ob.cartList.remove(key);
									response.sendRedirect("/assign3/cart1");
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