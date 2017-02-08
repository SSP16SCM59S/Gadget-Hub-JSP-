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

	public String username = null;
	public static HashMap<String, Integer> topfivelist = new HashMap<String, Integer>();
	public static HashMap<String, Integer> topfiveRating = new HashMap<String, Integer>();
	public static MongoClient mongo = new MongoClient("localhost",27017);
	public static DBCollection myReviews;

%>



<%!
public static HashMap<String, Integer> topFiveNoRating()
	{
		HashMap<String, Integer> list = new HashMap<String, Integer>();
		
		DBObject dbobj = new BasicDBObject("_id", 0);
		dbobj.put("productModelName", "$_id");
		dbobj.put("cnt", "$count");
		DBObject project = new BasicDBObject("$project", dbobj);

		DBObject groupFields = new BasicDBObject("_id", 0);
		groupFields.put("_id", "$productModelName");
		groupFields.put("count", new BasicDBObject("$sum", 1));
		DBObject group = new BasicDBObject("$group", groupFields);

		DBObject limit=new BasicDBObject();
		DBObject orderby=new BasicDBObject();
		
		DBObject sort = new BasicDBObject();
		
		sort.put("cnt",-1);
		
		
		
		orderby=new BasicDBObject("$sort",sort);
		limit=new BasicDBObject("$limit",5);
		
		AggregationOutput aggregate = myReviews.aggregate(group, project, orderby, limit);
		
		String cnt = null;
		int cntCount;
		for (DBObject result : aggregate.results()) {
			BasicDBObject bobj = (BasicDBObject) result;
			
			cnt = bobj.getString("cnt");
			if(cnt == null || cnt.isEmpty()) {
				cntCount=0;
			} else {
				cntCount=Integer.parseInt(cnt);
			}
			
			list.put(bobj.getString("productModelName"), cntCount);

		}
		
		return list;
	}	

%>

<%!

	public static HashMap<String, Integer> topFiveZip()
	{
		HashMap<String, Integer> list = new HashMap<String, Integer>();
		
		DBObject dbobj = new BasicDBObject("_id", 0);
		dbobj.put("retailerZip", "$_id");
		dbobj.put("cnt", "$count");
		DBObject project = new BasicDBObject("$project", dbobj);

		DBObject groupFields = new BasicDBObject("_id", 0);
		groupFields.put("_id", "$retailerZip");
		groupFields.put("count", new BasicDBObject("$sum", 1));
		DBObject group = new BasicDBObject("$group", groupFields);

		DBObject limit=new BasicDBObject();
		DBObject orderby=new BasicDBObject();
		
		DBObject sort = new BasicDBObject();
		
		sort.put("cnt",-1);
		
		
		
		orderby=new BasicDBObject("$sort",sort);
		limit=new BasicDBObject("$limit",5);
		
		AggregationOutput aggregate = myReviews.aggregate(group, project, orderby, limit);
		
		String cnt = null;
		int cntCount;
		for (DBObject result : aggregate.results()) {
			BasicDBObject bobj = (BasicDBObject) result;
			
			cnt = bobj.getString("cnt");
			if(cnt == null || cnt.isEmpty()) {
				cntCount=0;
			} else {
				cntCount=Integer.parseInt(cnt);
			}
			
			list.put(bobj.getString("retailerZip"), cntCount);

		}
		
		return list;
	}	
%>

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
			DB db = mongo.getDB("assign2");
		
			myReviews = db.getCollection("myReviews");
			
			topfivelist = topFiveZip();
			
			topfiveRating = topFiveNoRating();
		
		}
		
		catch (MongoException e) 
		{
				e.printStackTrace();
		}
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
						
						<header><h3>Top five zip-codes where maximum number of products sold</h3></header>
						<table>
						<th>Zipcodes</th>
						<th>No. of Products Sold</th>
						<%for(String key: topfivelist.keySet())
						{%>
						<tr>
						<td><%=key%></td>
						<td><%=topfivelist.get(key)%></td>
						</tr>
						<%}%>
						</table>
						
						<header><h3>Top five Products sold irrespective of rating</h3></header>
						<table>
						<th>Products</th>
						<th>No. of Products Sold</th>
						<%for(String key: topfiveRating.keySet())
						{%>
						<tr>
						<td><%=key%></td>
						<td><%=topfiveRating.get(key)%></td>
						</tr>
						<%}%>
						</table>
						
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