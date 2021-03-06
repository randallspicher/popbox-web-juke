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

public class Utility {


	
	public static String htmlEncode(String s) {
		StringBuffer out = new StringBuffer();
		for (int i = 0; i < s.length(); i++) {
			char c = s.charAt(i);
			if (c > 127 || c == '"' || c == '<' || c == '>' || c == '&' || c == '\'') {
				out.append("&#" + (int) c + ";");
			} else {
				out.append(c);
			}
		}
		return out.toString();
	}

	public static String getFanart(String path, String mountpoint, String localpoint, String httppoint) {
		
		String image = getFile("^(fanart)\\.(jpg$|jpeg$|png$|gif$)",path,mountpoint,localpoint,httppoint);

		if (null==image) {
			image = getFile("^.*(fanart).*(jpg$|jpeg$|png$|gif$)",path,mountpoint,localpoint,httppoint);
		}

		return image;
	}

	public static String getLogo(String path, String mountpoint, String localpoint, String httppoint) {

		String image = getFile("^(logo)\\.(jpg$|jpeg$|png$|gif$)",path,mountpoint,localpoint,httppoint);

		return image;
	}

	public static String getCover(String path, String mountpoint, String localpoint, String httppoint) {

		String image = getFile("^(cover|folder|front|poster|album)\\.(jpg$|jpeg$|png$|gif$)",path,mountpoint,localpoint,httppoint);

		if (null==image) {
			image = getFile(".*(cover|folder|front|poster|album).*(jpg$|jpeg$|png$|gif$)",path,mountpoint,localpoint,httppoint);
		}

		if (null==image) {
			image = getFile(".*(jpg$|jpeg$|png$|gif$)",path,mountpoint,localpoint,httppoint);
		}
		return image;
	}

	public static String getThumb(String path, String mountpoint, String localpoint, String httppoint) {

		String image = getFile("^(thumb)\\.(jpg$|jpeg$|png$|gif$)",path,mountpoint,localpoint,httppoint);

		if (null==image) {

			image = getFile("^.*(thumb).*(jpg$|jpeg$|png$|gif$)",path,mountpoint,localpoint,httppoint);
		}

		return image;
	}
	
	
	
	private static String getFile(String theRegex, String path, String mountpoint, String localpoint, String httppoint) {
		Logger log = Logger.getLogger("browse.jsp");

		String rootpath = path.replaceFirst(mountpoint, localpoint);
		String httppath = path.replaceFirst(mountpoint, httppoint);

		boolean found = false;
		String image = "";

		if (!found) {
			Pattern coverpattern = Pattern.compile(theRegex, Pattern.CASE_INSENSITIVE);
			File directory = new File(rootpath);
			try {
				if (directory.isDirectory()) {
					// out.print("x");
					try {
						for (File thisfile : directory.listFiles()) {
							// out.print("y");
							try {
								if (!thisfile.isDirectory()) {
									// out.print("z");
									String name = thisfile.getName();
									Matcher mm = coverpattern.matcher(name);
									if (mm.find()) {
										image = httppath + "/" + name;
										found = true;
										break;
									}
								}
							} catch (Exception c) {

							}
						}
					} catch (Exception b) {

					}
				}
			} catch (Exception a) {

			}
		}

		if (found) {
			return image;
		} else {
			return null;
		}
	}


}