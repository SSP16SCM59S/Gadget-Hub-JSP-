<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.CentralHashMap" %>
<%@ page import="com.PhoneCatalog" %>


		<%!
			public String username;
			public HttpSession session;
			public static CentralHashMap obj;
			PhoneCatalog temp1 = null;
			String fileName = "D:/ProductCatalog.xml";
			
		%>
		
		<%
		
		session=request.getSession(false);
		
		if(session != null)
		{
			
			if((request.getSession().getAttribute("userid")) != null)
			{
				username = request.getSession().getAttribute("userid").toString();

			}
		
		}
		if(session == null)
		{
			username = null;
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
						
							<article>
								<h2 align="center">Tablets</h2>		
								<p align="center">Browse through our collection of Tablets</p>
							</article>
							
							<article class='expanded'>
							<h2>Brands</h2>
							<table>
							<%
							
							
		
							
							
								for(String key: obj.Products.keySet())
								{
									temp1 = obj.Products.get(key);
									if(temp1.getId().startsWith("TB"))
									{
							%>
							<tr>
								<td>
									<img src = 'images/<%= temp1.getImage()%>' width = "100" height = '100' alt = 'phone'>
								</td>
								<td>
									<p>Model: <%= temp1.getName()%></p>
									<p>Sold by: <%= temp1.getRetailer()%></p>
									<p> Condition : <%= temp1.getCondition()%></p>
									<p> Price: <%= temp1.getPrice() %></p>
								</td>
								<td>
									<form method = 'post' action = '/assign3/cart'>
										<input type='hidden' name = 'info' value='<%=key%>'/>
										<input type = 'submit' name = 'phone' value = 'Add to Cart'>
									</form>
									<br>
									<form method = 'post' action = '/assign3/submitreview'>
										<input type='hidden' name = 'info' value='<%=key%>'/>
										<input type = 'submit' name = 'phone' value = 'Submit Review'>
									</form>
									<br>
									<form method = 'post' action = '/assign3/viewreview'>
										<input type='hidden' name = 'info' value='<%=key%>'/>
										<input type = 'submit' name = 'phone' value = 'View Review'>
									</form>
								</td>
							</tr>
			
							<%
									}
								}
							%>
						</table>
						</article>
						</section>
						
						<aside class='sidebar'>
					
							<ul>
							   <li>
									<h4>Products</h4>
									<ul>
										<li><a href='/assign3/Welcome'>Home Page</a></li>
										
									<%	if(username!=null)
										{
											if(!username.equals("storemanager") && !username.equals("sales"))
											{%>
												<li><a href='/assign3/orders'>View Orders</a></li>
										<%	}
										
										}%>
										<li><a href='/assign3/phones'>Smartphones</a></li>
										<!--<li><a href='/assign3/tablets'>Tablets</a></li>--> 
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

