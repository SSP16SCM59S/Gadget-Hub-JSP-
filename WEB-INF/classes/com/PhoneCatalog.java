package com;

import java.io.*;
import java.util.*;

public class PhoneCatalog implements java.io.Serializable
{
	private String id;
	private String retailer;
	private String name;
	private String price;
	private String image;
	private String condition;
	
	public PhoneCatalog()
	{
		
		
	}

	public String getId() 
	{
		
		return id;
	}

	public void setId(String id) 
	{
		this.id = id;
	}

	public String getRetailer() 
	{
		return retailer;
	}

	public void setRetailer(String retailer)
	{
		this.retailer = retailer;
	}

	public String getName() 
	{
		return name;
	}

	public void setName(String name) 
	{
		this.name = name;
	}

	public String getPrice() 
	{
		return price;
	}

	public void setPrice(String price) 
	{
		this.price = price;
	}

	public String getImage() 
	{
		return image;
	}

	public void setImage(String image) 
	{
		this.image = image;
	}

	public String getCondition() 
	{
		return condition;
	}

	public void setCondition(String condition) 
	{
		
		this.condition = condition;
	}

}