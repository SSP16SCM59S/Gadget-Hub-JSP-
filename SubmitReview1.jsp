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

productModelName = request.getParameter("productmodelname");
		productCategory = request.getParameter("productcategory");
		productPrice = request.getParameter("price");
		retailerName = request.getParameter("retailername");
		retailerZip = request.getParameter("retailerzip");
		retailerCity = request.getParameter("retailercity");
		retailerState = request.getParameter("retailerstate");
		productOnSale = request.getParameter("productsale");
		manufacturerName = request.getParameter("manufacturername");
		manufacturerRebate = request.getParameter("manufacturerrebate");
		userId = request.getParameter("userId");
		userAge = request.getParameter("userage");
		userGender = request.getParameter("usergender");
		userOccupation = request.getParameter("useroccupation");
		ReviewRating = request.getParameter("rating");
		ReviewDate = request.getParameter("reviewdate");
		ReviewText = request.getParameter("reviewtext");
		
		
		
		try {
			
			// If database doesn't exists, MongoDB will create it for you
			DB db = mongo.getDB("assign2");

			// If the collection does not exists, MongoDB will create it for you
			DBCollection myReviews = db.getCollection("myReviews");
			System.out.println("Collection myReviews selected successfully");

			BasicDBObject doc = new BasicDBObject("title", "myReviews").append("productModelName", productModelName)
					.append("productCategory", productCategory).append("productPrice", productPrice).append("retailerName", retailerName)
					.append("retailerZip", retailerZip).append("retailerCity", retailerCity).append("retailerState", retailerState).append("productOnSale", productOnSale)
					.append("manufacturerName", manufacturerName).append("manufacturerRebate", manufacturerRebate).append("userId", userId).append("userAge", userAge)
					.append("userGender", userGender).append("userOccupation", userOccupation).append("ReviewRating", ReviewRating).append("ReviewDate", ReviewDate).append("ReviewText", ReviewText);

			myReviews.insert(doc);

			System.out.println("Document inserted successfully");

		} catch (MongoException e) {
			e.printStackTrace();
		}
		response.sendRedirect("/assign3/"+productCategory);


%>