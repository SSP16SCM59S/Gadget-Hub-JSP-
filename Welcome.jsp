<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.CentralHashMap" %>
<%@ page import="com.PhoneCatalog" %>
<%@ page import="com.SAXProductHandler" %>
<%@ page import="javax.xml.parsers.*" %>
<%@ page import="org.xml.sax.*" %>
<%@ page import="org.xml.sax.helpers.*" %>




<%!
			public String username;
			public static CentralHashMap obj;
			public static final String JDBC_DRIVER="com.mysql.jdbc.Driver";  
			public static final String DB_URL="jdbc:mysql://localhost:3306/gadgethub?autoReconnect=true&useSSL=false";
			String user = "root";
			String pass = "tiger";
			String sql,sql1,sql2;
			ResultSet rs;
			Connection conn = null;
			Statement stmt = null;
			PhoneCatalog temp1 = null;
			
			String fileName = "D:/ProductCatalog.xml";
			public static HashMap<String, PhoneCatalog> list = new HashMap<String, PhoneCatalog>();
%>
		
		<%
							
							SAXProductHandler saxHandler = new SAXProductHandler();
							
							if(obj.Products == null)
							{
								
								try
								{
									obj.Products = saxHandler.readDataFromXML(fileName);
								}
								catch(SAXException e)
								{
									
								}
								catch(ParserConfigurationException e)
								{
									
								}
								
							}
							
		
							try
							{
								
								Class.forName("com.mysql.jdbc.Driver");
								
								
								conn = DriverManager.getConnection(DB_URL,user,pass);
								
								
								stmt = conn.createStatement();
								
																																
								sql = "SELECT * FROM productdetails";
								ResultSet rs = stmt.executeQuery(sql);
								
								
								PhoneCatalog temp_obj;
								
								while(!rs.next())
								{
									
									for(String key : obj.Products.keySet())
									{
										temp_obj = obj.Products.get(key);
										sql1 = "insert into productdetails values('"+temp_obj.getId()+"','"+temp_obj.getName()+"','"+temp_obj.getPrice()+"','"+temp_obj.getRetailer()+"','"+temp_obj.getCondition()+"','"+temp_obj.getImage()+"');";
										int i = stmt.executeUpdate(sql1);
									}
								}
								
								do
								{
									temp_obj = new PhoneCatalog();
									
									String id  = rs.getString("id");
									String name = rs.getString("name");
									String price = rs.getString("price");
									String retailer = rs.getString("retailer");
									String condition = rs.getString("cond");
									String image = rs.getString("image");
									
											
										temp_obj.setId(id);
										temp_obj.setName(name);
										temp_obj.setPrice(price);
										temp_obj.setRetailer(retailer);
										temp_obj.setCondition(condition);
										temp_obj.setImage(image);
										
										list.put(id,temp_obj);
								}while(rs.next());
								
								 rs.close();
								 
								 if(list.size() != obj.Products.size())
								 {
									 sql2 = "delete from productdetails;";
									 int i2 = stmt.executeUpdate(sql2);
									 for(String key : obj.Products.keySet())
									{
										temp_obj = obj.Products.get(key);
										sql1 = "insert into productdetails values('"+temp_obj.getId()+"','"+temp_obj.getName()+"','"+temp_obj.getPrice()+"','"+temp_obj.getRetailer()+"','"+temp_obj.getCondition()+"','"+temp_obj.getImage()+"');";
										int i = stmt.executeUpdate(sql1);
									}
								 }
								 
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
		
		
		
		if(session.getAttribute("userid") == null)
		{
				
			username = null;
		}
		else
		{
			username = session.getAttribute("userid").toString();
		}
		
		
		%>
		
		
		
		
		
		<!doctype html>

				

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
							<li><a href='/assign3/accessories' style='font-size: 12px'>Accessories</a></li>
							<li><a href='/assign3/cart1' style='font-size: 12px'>Cart (0)</a></li>
							<li><a href='/assign3/checkout' style='font-size: 12px'>Checkout</a></li>
						<%	
							if(username!=null)
							{
						%>
								<li style='float:right;'><a href='/assign3/Logout'  style='font-size: 12px'>Logout</a></li>
								<li style='float:right;'><a href='#'  style='font-size: 12px'>Welcome,<%= username %></a></li>
								
							<%	}
							else
							{	%>
								<li style='float:right;'><a href='/assign3/Signup'  style='font-size: 12px'>Signup</a></li>
							<li style='float:right;'><a href='/assign3/login'  style='font-size: 12px'>Login</a></li>
							
							<%}%>
						
							
						</ul>
					</nav>

					<img class='header-image' src='images/image.jpg' alt='Buildings' />

					<div id='body'>
					
						<section id='content'>

							<h2 style='margin-top: 10px;margin-left:10px'> Featured Products </h2>
									
								
							<h3 style='margin-left:10px'> Laptops</h3>
								<img src = 'images/samsunglap.jpg' alt='samsung' width='200px' height='200px'/>
								<img src = 'images/hp.jpg' alt='hp' width='200px' height='200px'/>
								<img src = 'images/dell.jpg' alt='dell' width='200px' height='200px'/>
							<h3 style='margin-left:10px'> Smartphones</h3>
								<img src = 'images/samsung.jpg' alt='samsung' width='200px' height='200px'/>
								<img src = 'images/oneplus.jpg' alt='OneplusX' width='200px' height='200px'/>
								<img src = 'images/lg.jpg' alt='Lg' width='200px' height='200px'/>
						</section>
						
						<aside class='sidebar'>
					
							<ul>
							   <li>
									<h4>Products</h4>
									<ul>
										<li><a href='#'>Home Page</a></li>
										
									<%	if(username!=null)
										{
											if(!username.equals("storemanager") && !username.equals("sales"))
											{%>
												<li><a href='/assign3/orders'>View Orders</a></li>
										<%	}
										
										}%>
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
	}
}

