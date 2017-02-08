package com;

import java.io.*;  
import javax.servlet.*;  
import javax.servlet.http.*;  
import java.util.*;
import java.sql.*;
import java.io.File;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import java.io.IOException;
import java.util.HashMap;
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParserFactory;

public class SAXProductHandler extends DefaultHandler 
{

	

	boolean bphone = false;
	boolean bid = false;
	boolean bname = false;
	boolean bretailer = false;
	boolean bprice = false;
	boolean bcondition = false;
	boolean bimage = false;

	PhoneCatalog catalog;
	HashMap<String, PhoneCatalog> hpCatalog = new HashMap<String, PhoneCatalog>();

	public HashMap<String, PhoneCatalog> readDataFromXML(String fileName) throws ParserConfigurationException, SAXException, IOException 
	{

		SAXParserFactory factory = SAXParserFactory.newInstance();
		javax.xml.parsers.SAXParser parser = factory.newSAXParser();

		parser.parse(new File(fileName), this);

		return hpCatalog;
	}

	
	public void startDocument() throws SAXException 
	{
		//System.out.println("Start document");
	}

	
	public void endDocument() throws SAXException 
	{
		//System.out.println("End document");
	}

	
	public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException 
	{
			
		//if(qName.equalsIgnoreCase("tv"))
			if(qName.matches("(?i)phone|tablet|laptop|tv|accessory"))
		{
			bphone = true;
			catalog = new PhoneCatalog();
		}
		
		if(bphone)
		{
		
			if (qName.equalsIgnoreCase("ID")) 
			{
				bid = true;
			}

			else if (qName.equalsIgnoreCase("NAME")) 
			{
				bname = true;
			}

			else if (qName.equalsIgnoreCase("retailer")) 
			{
				bretailer = true;
			}

			else if (qName.equalsIgnoreCase("PRICE")) 
			{
				bprice = true;
			}

			else if (qName.equalsIgnoreCase("CONDITION")) 
			{
				bcondition = true;
			}

			else if (qName.equalsIgnoreCase("image")) 
			{
				bimage = true;
			}
		}
			
		
	}

	
	public void endElement(String uri, String localName, String qName) throws SAXException 
	{
		//if (qName.equalsIgnoreCase("tv"))
		if(qName.matches("(?i)phone|tablet|laptop|tv|accessory"))
				{
					
					hpCatalog.put(catalog.getId(), catalog);
					bphone = false;
				}
	}

	
	public void characters(char[] ch, int start, int length) throws SAXException 
	{
		
			if (bid) 
			{
				catalog.setId(new String(ch, start, length));
				bid = false;
			}
			
			else if (bname) 
			{
				catalog.setName(new String(ch, start, length));
				bname = false;
			}
			
			else if (bretailer)
			{
				catalog.setRetailer(new String(ch, start, length));
				bretailer = false;
			}
			
			else if (bcondition) 
			{
				catalog.setCondition(new String(ch, start, length));
				bcondition = false;
			}
			
			
			else if (bprice) 
			{
				catalog.setPrice(new String(ch, start, length));
				bprice = false;
			}
			
			else if (bimage) 
			{
				catalog.setImage(new String(ch, start, length));
				bimage = false;
			}
		
	}
}