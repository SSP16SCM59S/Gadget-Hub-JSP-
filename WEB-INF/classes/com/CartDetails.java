package com;

public class CartDetails implements java.io.Serializable
{
	public String name,price,retailer;
	public int qty;
	
	public CartDetails()
	{
		
	}
	
	public void setQuantity(int q)
	{
		this.qty = q;
	}
	public int getQuantity()
	{
		return qty;
	}

	public void setName(String n)
	{
		this.name = n;
	}
	
	public String getName()
	{
		return name;
	}
	
	public void setRetailer(String r)
	{
		this.retailer = r;
	}
	
	public String getRetailer()
	{
		return retailer;
	}
	
	public void setPrice(String price)
	{
		this.price = price;
	}
	
	public String getPrice()
	{
		return price;
	}
}