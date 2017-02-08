<%@ page import="java.util.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.sql.*" %>


<%!
			public String username;
			public String airline;
			public static final String JDBC_DRIVER="com.mysql.jdbc.Driver";  
			public static final String DB_URL="jdbc:mysql://localhost:3306/gadgethub?autoReconnect=true&useSSL=false"; //update database name
			String user = "root";
			String pass = "tiger";
			Statement stmt = null;
			Connection conn = null;
			ResultSet rs;
			String sql;
			
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

airline = request.getParameter("airlines");


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
								<li <a href='/assign3/store' style='font-size: 10px'>Home</a></li>
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
						
						<article>
						<h2 align='center'>Update Flight Data</h2>
						<p align='left'><h3><%=airline%> </h3></p>
						</article>
						<article class='expanded'>
						<h4>Flights</h4>
						<table>
						
						<%
						try
							{
								
								Class.forName("com.mysql.jdbc.Driver");
								
								
								conn = DriverManager.getConnection(DB_URL,user,pass);
								
								
								stmt = conn.createStatement();
								
																																
								sql = "SELECT * FROM flightdetails where airline ='"+airline+"';";
								rs = stmt.executeQuery(sql);
								while(rs.next())
								{
						%>
						<tr>
						
						<td>
						<form method = 'post' action = '/assign3/update2'>
						Flight Id:<br><h3><input type ="text" name ="flightid" value='<%=rs.getString("flightid")%>' readonly/></h3>
						Flight Name:<br><h3><input type ="text" name ="flightname" value='<%=rs.getString("flightname")%>' /></h3>
						Flight capacity:<br><h3><input type ="text" name ="flightcapacity" value='<%=rs.getString("flightcapacity")%>' /></h3>
						Flight Type:<br><h3><input type ="text" name ="flighttype" value='<%=rs.getString("flighttype")%>' /></h3>
						<input type='hidden' name = 'info' value='<%=rs.getString("flightid")%>'/>
						<input type = 'submit' name = 'phone' value = 'Modify'>
						</form>
						</td>
						</tr>
						<%
						}
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
						</table>
						</article>
						</section>
						
						<aside class='sidebar'>
					
							<ul>
							   <li>
									<h4>Products</h4>
									<ul>
										<li><a href='/assign3/store'>Home Page</a></li>
										<li><a href='/assign3/updprod'>Back</a></li>					
										
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