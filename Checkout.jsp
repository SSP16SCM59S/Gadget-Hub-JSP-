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
			
			
		%>

<!doctype html>

				<%
				if(session.getAttribute("userid") == null)
				{
					
					username = null;
					%>
					<h3><a href = "/assign3/login">Please Login</a></h3>
				<%}
				else
				{
					username = session.getAttribute("userid").toString();
					
					
				
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
								<li style='float:right;'><a href='#'  style='font-size: 10px'>Welcome,<%= username %></a></li>
								
							<%	}
								%>
							
						
							
						</ul>
					</nav>

					<img class='header-image' src='images/image.jpg' alt='Buildings' />

					<div id='body'>
					
						<section id='content'>

							<%
							
							ob = new CentralHashMap();
							ob.cartList = new HashMap<String, CartDetails>();
							
							if(ob.cartList != null)
							{
								
								if(!ob.cartList.isEmpty())
								{
									ob.cartList.clear();
								}
							}
							
							
							try
							{
								
								Class.forName("com.mysql.jdbc.Driver");
								
								
								conn = DriverManager.getConnection(DB_URL,user,pass);
								
								
								stmt = conn.createStatement();
								
								sql = "SELECT * FROM cart";
								ResultSet rs = stmt.executeQuery(sql);
								
								CartDetails obj;
								
								while(rs.next())
								{
									obj = new CartDetails();
									obj.setName(rs.getString("name"));
									obj.setRetailer(rs.getString("retailer"));
									obj.setPrice(rs.getString("price"));
									obj.setQuantity(rs.getInt("Quantity"));
									ob.cartList.put(rs.getString("id1"),obj);
																
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
							
							<article class='expanded'>
							<h1 style='float:left;'>Cart</h1>
							<img src='images/cart.png' width='50' height='50' alt='cart logo' style='margin-left:20;'>
							<table>
							<tr>
							
							<th> Name </th>
							<th> Price </th>
							<th> Retailer </th>
							<th> Quantity </th>
							</tr>
							<%
							if(ob.cartList != null )
							{
								
							
							int temp=0,qty=0;
							for(String key: ob.cartList.keySet())
							{
								temp1 = ob.cartList.get(key);
							%>
							<tr>
							<td><%= temp1.getName()%></td>
							<td><%= temp1.getPrice()%></td>
							<td><%= temp1.getRetailer()%></td>
							<td><%= temp1.getQuantity()%></td>	
							<td>
							<form method = 'post' action = '/assign3/deletecart'>
							<input type='hidden' name = 'info' value='<%=key%>'/>
							<input type = 'submit' name = 'Delete' value = 'Remove Item'>
							</form>
							</td>
							</tr>
							<%
							
							qty = temp1.getQuantity();
							temp += Integer.parseInt(temp1.getPrice()) * qty;
							}
							price = temp;
							}
							%>
							</table>
							<br/>
							<label style='margin-left: 20px;'>Total Price: <%=price%>$</label>
							<br/>
							<label>Credit Card</label>
							<form method = 'post' action = '/assign3/checkout1'>
							<input type ='text' name='credit' maxlength='16' required>
							<br/>cvv<br/><input type='text' name='cvv' maxlength='3' required><br>
							Address<br><input type ='text' name='address' maxlength='46' required>
							<input type='hidden' name = 'info' value='<%=price%>'/>
							<br/><br/><input type = 'submit' name = 'phone' value = 'Submit'>
							</form>
							</article>
						</section>
						
						<aside class='sidebar'>
					
							<ul>
							   <li>
									<h4>Products</h4>
									<ul>
										<li><a href='/assign3/Welcome'>Home Page</a></li>
										
									
										<li><a href='/assign3/phones'>Smartphones</a></li> 
										<li><a href='/assign3/tablets'>Tablets</a></li>
										<li><a href='/assign3/laptops'>Laptops</a></li>
										<li><a href='/assign3/tv'>TV</a></li>
										<li><a href='/assign3/accessories'>Accessories</a></li>
										<li><a href='/assign3/trending'>Trending</a></li>
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
				<%
				}
				%>