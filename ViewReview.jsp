<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.CentralHashMap" %>
<%@ page import="com.PhoneCatalog" %>
<%@ page import="java.text.*" %>
<%@ page import="com.mongodb.*" %>

<%!
	public String key;
	public String username;
	public String producttype;
	
	public static CentralHashMap ob;
	DBObject dob;
	
	public static MongoClient mongo = new MongoClient("localhost",27017);

	public String productModelName;
	public String productCategory;
	public String productPrice;
	public String retailerName;
	public String retailerZip;
	public String retailerCity;
	public String retailerState;
	public String productOnSale;
	public String manufacturerName;
	public String manufacturerRebate;
	public String userId;
	public String userAge;
	public String userGender;
	public String userOccupation;
	public String ReviewRating;
	public String ReviewDate;
	public String ReviewText;
%>

<%
key = request.getParameter("info");

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
		
		ob = new CentralHashMap();
		PhoneCatalog obj = ob.Products.get(key);
		productModelName = obj.getName();
		
		
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
			DB db = mongo.getDB("assign2");
		
			DBCollection myReviews = db.getCollection("myReviews");
			
			BasicDBObject searchQuery = new BasicDBObject();
			searchQuery.put("productModelName", productModelName);
			
			DBCursor cursor = myReviews.find(searchQuery);
%>

		<html>
				
				<head>
				<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
				<title>Gadget Hub</title>
				<link rel='stylesheet' href='styles.css' type='text/css' />
				<link rel='stylesheet' href='a6.css' type='text/css' />
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
						
						<%
						while(cursor.hasNext()!=false)
						{
						 dob = cursor.next();
						%>
						
						<form action='/assign3/<%=producttype%>' method='post'>
						<header>View Review</header>
						
						<label>Product Model Name </label>
							<input type='text' name='productmodelname' value='<%=dob.get("productModelName")%>' readonly  />
							
							<label>Product Category </label>
							<input type = 'text' name='productcategory'  value='<%=dob.get("productCategory")%>' readonly/>
							
							<label>Product Price </label>
							<input type='text' name='price' value='<%=dob.get("productPrice")%>'  readonly/>
							
							<label>Retailer Name </label>
							<input type='text' name='retailername' value='<%=dob.get("retailerName")%>' readonly />
							
							<label>Retailer Zip </label>
							<input type='number' name='retailerzip' value='<%=dob.get("retailerZip")%>' readonly />
							
							<label>Retailer City </label>
							<input type='text' name='retailercity' value='<%=dob.get("retailerCity")%>' readonly />
							
							<label>Retailer State </label>
							<input type='text' name='retailerstate'  value='<%=dob.get("retailerState")%>' readonly />
							
							<label>Product on sale? </label>
							<input type='text' name='productsale' value='<%=dob.get("productOnSale")%>' readonly />
							
							<label>Manufacturer Name </label>
							<input type='text' name='manufacturername' value='<%=dob.get("manufacturerName")%>' readonly />
							
							<label>Manufacturer Rebate </label>
							<input type='text' name='manufacturerrebate' value='<%=dob.get("manufacturerRebate")%>' readonly/>
							<%
							if(username != null)
							{%>
								
								<label>User Id </label>
							<input type='text' name='userId' value = '<%=dob.get("userId")%>' readonly/>
								
							<%}
							else
							{%>
								<label>User Id </label>
							<input type='text' name='userId' value='<%=dob.get("userId")%>' readonly />
								
							<%}%>
							
							<label>User Age </label>
							<input type='text' name='userage' value='<%=dob.get("userAge")%>' readonly />
							
							<label>User Gender </label>
							<input type='text' name='usergender' value='<%=dob.get("userGender")%>' readonly />
							
							<label>User Occupation </label>
							<input type='text' name='useroccupation' value='<%=dob.get("userOccupation")%>' readonly />
							
							<label>Review Rating </label>
							<input type='number' name='rating' value='<%=dob.get("ReviewRating")%>' readonly />
							
							<label>Review Date </label>
							<input type='text' name='reviewdate' value='<%=dob.get("ReviewDate")%>' readonly />
							<%
							System.out.println(dob.get("ReviewText"));
							%>
							<br>
							<label>Review Text </label>
							<textarea name='reviewtext' cols='60' rows='5' style="margin-left:20px" ><%=dob.get("ReviewText")%></textarea>
					
							
							<input type = 'submit' value='Back' class='center' style='margin-left:25px'  />
					
					
					
							</form>
						<%}%>
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
		catch (MongoException e) 
		{
				e.printStackTrace();
		}
		%>