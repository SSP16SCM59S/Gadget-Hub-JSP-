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
			public static String username;
			public static String username1;
			public static CentralHashMap ob;
			public static final String JDBC_DRIVER="com.mysql.jdbc.Driver";  
			public static final String DB_URL="jdbc:mysql://localhost:3306/gadgethub?autoReconnect=true&useSSL=false";
			String user = "root";
			String pass = "tiger";
			String sql;
			ResultSet rs;
			Connection conn = null;
			Statement stmt = null;
			public static int price=0;
			public String address;
			public String date1;
%>
<!doctype html>

<%
username = request.getParameter("userslist");

		if(session.getAttribute("userid") == null)
		{
				
			username1 = null;
		}
		else
		{
			username1 = session.getAttribute("userid").toString();
		}

try
		{
			
			Class.forName("com.mysql.jdbc.Driver");
			
			
			conn = DriverManager.getConnection(DB_URL,user,pass);
			
			
			stmt = conn.createStatement();
			String sql;
			sql = "SELECT * FROM orders where username = '"+username+"';";
			ResultSet rs = stmt.executeQuery(sql);
			
			OrderDetails obj;
			ob = new CentralHashMap();
			ob.OrderList = new HashMap<Integer, OrderDetails>();
			
			if(ob.OrderList.isEmpty() == false)
				{
					ob.OrderList.clear();
				}
			
			
			while(rs.next())
			{
				
				obj = new OrderDetails();
				obj.setAddress(rs.getString("address"));
				obj.setPrice(rs.getString("price"));
				obj.setDate(rs.getString("ord_date"));
				ob.OrderList.put(rs.getInt("orderid"),obj);
				
				
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


%>


<html>
				
				<head>
				<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
				<title>Gadget Hub</title>
				<link rel='stylesheet' href='styles.css' type='text/css' />
				</head>

				<body>
				<div id='container'>
					<header>
						<div>
							<h1 class ='single' style='font-family: blaze'><a href='/'>Gadget<span> Hub  </span></a></h1>
							<img src='images/smartphone.jpg' alt='smartphone' width='40' height='40' style='float:center;'/>
							<img src='images/tablet1.png' alt='smartphone' width='40' height='40' style='float:center;'/>
							<img src='images/laptop.jpg' alt='smartphone' width='40' height='40' style='float:center;'/>
							<img src='images/tv.png' alt='smartphone' width='40' height='40' style='float:center;'/>
						</div>
					<h2 class='caption'>Smartphones, Tablets, Laptops & TV's</h2>
					</header>
					
							
					
					
					<nav>
						<ul>
							<div>
								<li><a href='/assign3/Welcome' style='font-size: 10px'>Home</a></li>
							</div>
							<li><a href='#body' style='font-size: 10px' style='font-size: 10px'>Products</a></li>
							<li><a href='/assign3/accessories' style='font-size: 10px'>Accessories</a></li>
							<li><a href='/assign3/cart1' style='font-size: 10px'>Cart (0)</a></li>
							<li><a href='/assign3/checkout' style='font-size: 10px'>Checkout</a></li>
						<%	
							if(username!=null)
							{
						%>
								<li style='float:right;'><a href='/assign3/Logout'  style='font-size: 10px'>Logout</a></li>
								<li style='float:right;'><a href='#'  style='font-size: 10px'>Welcome,<%= username1 %></a></li>
								
							<%	}
							else
							{	%>
								<li style='float:right;'><a href='/assign3/Signup'  style='font-size: 10px'>Signup</a></li>
							<li style='float:right;'><a href='/assign3/login'  style='font-size: 10px'>Login</a></li>
							
							<%}%>
						
							
						</ul>
					</nav>

					<img class='header-image' src='images/image.jpg' alt='Buildings' />

					<div id='body'>
					
						<section id='content'>
						<article class='expanded'>
							<h1 style='float:left;'>Orders</h1>
							
							<table>
							<tr>
							
							<th> Order ID </th>
							<th> Order Date </th>
							<th> Total Price </th>
							<th> Address </th>
							<th> Products </th>
							<th> Quantity </th>
							</tr>
							
							<%
							OrderDetails temp1 = null;
							if(ob.OrderList != null )
							{
							for(int key: ob.OrderList.keySet())
							{
								temp1 = ob.OrderList.get(key);
							%>
							<tr>
							<td><%= key%></td>
							<td><%= temp1.getDate()%></td>
							<form method = 'post' action = '/assign3/updorder2'>
							<td> <input type='number' name='price' value='<%=temp1.getPrice()%>' style='width:60px;'/></td>
							<td><%= temp1.getAddress()%></td>
							
							<%
							try
								{
									//Register JDBC Driver
									Class.forName("com.mysql.jdbc.Driver");
									
									//Opening Connection
									conn = DriverManager.getConnection(DB_URL,user,pass);
									
									//Execute Sql Query
									stmt = conn.createStatement();
									String sql,sql1;
									sql = "SELECT itemname FROM orderdetails where username = '"+username+"' and ord_date='"+temp1.getDate()+"';";
									sql1 = "SELECT quantity FROM orderdetails where username = '"+username+"' and ord_date='"+temp1.getDate()+"';";
									ResultSet rs = stmt.executeQuery(sql);
									
									%>
									<td>
									<%
								   
									while(rs.next())
									{	%>
								
										<%=rs.getString("itemname")%>
										<br/>
										
										
									<%}%>
									</td>
									<%
									ResultSet rs1 = stmt.executeQuery(sql1);%>
									<td>
									<%while(rs1.next())
									{%>
										<%=rs1.getString("quantity")%>
										<br/>
										
										
									<%}%>
									</td>
									<% 
									 rs1.close();
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
								%>
								
								<td>
								
								<input type='hidden' name = 'info' value='<%=temp1.getDate()%>'/>
								<input type='hidden' name = 'userdata' value='<%=username%>'/>
								<input type = 'submit' name = 'Save' value = 'Save Order'>
								</form>
								</td>
								</tr>
								<% 
							}
							}
							%>
							</table>
						</section>
						
						<aside class='sidebar'>
					
							<ul>
							   <li>
									<h4>Products</h4>
									<ul>
										<li><a href='/assign3/sales'>Home Page</a></li>
										<li><a href='/assign3/updorder'>Back </a></li>
									
										
									</ul>
								</li>
								
								<li>
									<h4>About us</h4>
									<ul>
										<li class='text'>
											<p style='margin: 0;'>We are an ecommerce company primarily dealing with Laptops Smartphones Tablets & Televisions. Please feel free to browse our store for our wide range of products.</p>
										</li>
									</ul>
								</li>									
							</ul>
						</aside>
						<div class='clear'></div>
					</div>
					<footer>
					<div class='footer-content'>
								
						<ul class='endfooter'>
							<li><h3>Contact Us</h3></li>
							<li>Gadget Hub</li>
							<li>2801 South King Drive Apt 102</li>
							<li>shash.4243gmail.com</li>
							<li>(312)-678-4446</li>
						</ul>
						
						<div class='clear'></div>
					</div>
					<div class='footer-bottom'>
						<p>&copy; YourSite 2013. <a href='#'>CSP 595 Assignment 3</a></p>
					</div>
				 </footer>
				</div>
				</body>
				</html>