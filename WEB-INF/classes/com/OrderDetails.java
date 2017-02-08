package com;
import java.io.*;

public class OrderDetails implements java.io.Serializable
{
	
	private String date,price,address;
	public OrderDetails()
	{
		
	}
	public String getDate()
	{
		return date;
	}
	public String getPrice()
	{
		return price;
	}
	public String getAddress()
	{
		return address;
	}
	public void setDate(String d)
	{
		this.date = d;
	}
	public void setPrice(String p)
	{
		this.price = p;
	}
	public void setAddress(String a)
	{
		this.address = a;
	}
}