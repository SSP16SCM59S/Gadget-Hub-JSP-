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
public static CentralHashMap ob;
public static final String JDBC_DRIVER="com.mysql.jdbc.Driver";  
public static final String DB_URL="jdbc:mysql://localhost:3306/gadgethub?autoReconnect=true&useSSL=false";
String user = "root";
String pass = "tiger";
String sql;
ResultSet rs;
Connection conn = null;
Statement stmt = null;
public static HashMap<Integer, String> users = new HashMap<Integer, String>();
%>
<!doctype html>
<%
if(session.getAttribute("userid") == null)
		{
				
			username = null;
		}
		else
		{
			username = session.getAttribute("userid").toString();
		}
		
		try
		{
			//Register JDBC Driver
			Class.forName("com.mysql.jdbc.Driver");
			
			//Opening Connection
			conn = DriverManager.getConnection(DB_URL,user,pass);
			
			//Execute Sql Query
			stmt = conn.createStatement();
			String sql;
			sql = "SELECT username,id FROM userinfo";
			ResultSet rs = stmt.executeQuery(sql);
			
			// Extract data from result set
			while(rs.next())
			{
				int id  = rs.getInt("id");
				String uid = rs.getString("username");
				
				users.put(id,uid);
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
								<li class='start selected single'><a href='#' style='font-size: 10px'>Home</a></li>
							</div>
							<li><a href='#body' style='font-size: 10px' style='font-size: 10px'>Products</a></li>
							
						<%	
							if(username!=null)
							{
						%>
								<li style='float:right;'><a href='/assign3/Logout'  style='font-size: 10px'>Logout</a></li>
								<li style='float:right;'><a href='#'  style='font-size: 10px'>Welcome,<%= username %></a></li>
								
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
						<header><h1>Add New order</h1></header>
						
						<h2>Brands</h2>
						
						
						<%
						ob = new CentralHashMap();
						PhoneCatalog temp1 = null;
						for(String key: ob.Products.keySet())
						{
							temp1 = ob.Products.get(key);
							
						%>
						<table>
						<tr>
						<td>
						<img src = 'images/<%= temp1.getImage() %>' width = '100' height = '100' alt = 'phone'>
						</td>
						<td>
							<p>Model: <%= temp1.getName()%></p>
							<p>Sold by: <%= temp1.getRetailer()%></p>
							<p> Condition : <%= temp1.getCondition()%></p>
							<p> Price: <%= temp1.getPrice() %></p>
						</td>
						<td>
						<form action='/assign3/addorder1' method='post'  autofocus>
						<label>Select User </label><br>
						<select name='userslist' style='width:85%;margin-top:0px;margin-left:0px;'>
						
							<%
							for(int keys: users.keySet())
							{
								if(!users.get(keys).equalsIgnoreCase("storemanager") && !users.get(keys).equalsIgnoreCase("sales"))
								out.println("<option value = '"+users.get(keys)+"'>"+users.get(keys)+"</option>");
							
							}
							%>
							</select>
							<br><label>Credit Card </label><br>
							<input type='text' name = 'credit'/> <br/>
							<label>Cvv </label><br>
							<input type='text' name = 'credit'/> <br/>
							<input type='hidden' name = 'info' value='<%=key%>'/>
							<br/><br/><input type = 'submit' name = 'phone' value = 'Place Order'>
						</form>
							</td>
							</tr>
						<%}%>
						</table>
						</article>
						</section>
						
						<aside class='sidebar'>
					
							<ul>
							   <li>
									<h4>Products</h4>
									<ul>
										<li><a href='/assign3/sales'>Home Page</a></li>
										
																
										
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
								
								<li>
									<h4>Search site</h4>
									<ul>
										<li class='text'>
											<form method='get' class='searchform' action='#' >
												<p>
													<input type='text' size='30' value='' name='s' class='s' style='float: center' align = 'center'/>
													
												</p>
											</form>
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
						