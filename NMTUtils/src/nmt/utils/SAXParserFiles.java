package nmt.utils;

//import org.apache.commons.httpclient.*;
//import org.apache.commons.httpclient.methods.*;
import java.net.*;
import java.util.ArrayList;
import java.util.List;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;
import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.io.File;
import java.io.FileFilter;
import java.util.logging.Logger;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class SAXParserFiles extends DefaultHandler {

	private List<FileItem> myFiles;
	private String tempVal;
	private FileItem tempFile;
	private String url="";
	Logger log= Logger.getLogger("browse.jsp"); 

	public SAXParserFiles(String url) {
		myFiles = new ArrayList<FileItem>();
		this.url=url;
		parseDocument();
	}

//	public void runExample() {
//		
//		printData();
//	}

	public List<FileItem> getFiles(){
		return myFiles;
	}
	
	private void parseDocument() {
		SAXParserFactory spf = SAXParserFactory.newInstance();
		try {
			SAXParser sp = spf.newSAXParser();
			sp.parse(url, this);
		}catch(SAXException se) {
			se.printStackTrace();
		}catch(ParserConfigurationException pce) {
				pce.printStackTrace();
		}catch (IOException ie) {
			ie.printStackTrace();
		}		
	}

//	private void printData(){
//		System.out.println("\n\n\tNo of Files '" + myEmpls.size() + "'.\n");
//		Iterator it = myEmpls.iterator();
//		while(it.hasNext()) {
//			System.out.println("\n\t"+it.next().toString());
//		}
//	}

	public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException {
		tempVal = "";
		if(qName.equalsIgnoreCase("file")||qName.equalsIgnoreCase("networkResource")) {
			tempFile = new FileItem();
//			tempFile.setType(attributes.getValue("type"));
		}
	}

	public void characters(char[] ch, int start, int length)
			throws SAXException {
		tempVal += new String(ch, start, length);
	}

	public void endElement(String uri, String localName, String qName) throws SAXException {
		if(qName.equalsIgnoreCase("file")||qName.equalsIgnoreCase("networkResource")) {
			//System.out.println("adding item");
			myFiles.add(tempFile);
//			tempVal="";
		}
		else if (qName.equalsIgnoreCase("name")) {
			//log.info("name="+tempVal);
			tempFile.setName(tempVal);
//			tempVal="";
		}
		else if (qName.equalsIgnoreCase("isFolder")) {
			tempFile.setIsFolder(tempVal);
//			tempVal="";
		}
		else if (qName.equalsIgnoreCase("type")) {
			tempFile.setType(tempVal);
//			tempVal="";
		}
		else if (qName.equalsIgnoreCase("size")) {
			tempFile.setSize(Long.parseLong(tempVal));
//			tempVal="";
		}
	}
}	
	
