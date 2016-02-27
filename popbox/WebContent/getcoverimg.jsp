<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="nmt.utils.Utility"%>
<%@page
	import="org.apache.commons.httpclient.*
,org.apache.commons.httpclient.methods.*
,java.net.*
,java.util.ArrayList
,java.util.List
,javax.xml.parsers.SAXParser
,javax.xml.parsers.SAXParserFactory
,org.xml.sax.Attributes
,org.xml.sax.SAXException
,org.xml.sax.helpers.DefaultHandler
,javax.xml.parsers.ParserConfigurationException
,java.io.IOException
,java.io.File
,java.io.FileFilter
,java.util.regex.Pattern
,java.util.regex.Matcher,
java.util.logging.Logger
"
%>
<%!public static String htmlEncode(String s) {
		StringBuffer out = new StringBuffer();
		for (int i = 0; i < s.length(); i++) {
			char c = s.charAt(i);
			if (c > 127 || c == '"' || c == '<' || c == '>') {
				out.append("&#" + (int) c + ";");
			} else {
				out.append(c);
			}
		}
		return out.toString();
	}
%><%
	Logger log = Logger.getLogger("getcoverimg.jsp");

	//String nmthost = application.getInitParameter("nmthost");
	String nmthost = request.getParameter("nmthost");
	String thedavidport = application.getInitParameter("thedavidport");
	String remoteport = application.getInitParameter("remoteport");
	String mount = request.getParameter("mount");

	String mountpoint = (String) request.getSession().getAttribute("mountpoint");
	String localpoint = (String) request.getSession().getAttribute("localpoint");
	String httppoint = (String) request.getSession().getAttribute("httppoint");

	
	String imgsize = request.getParameter("imgsize");
	
	
	
	if (imgsize == null) {
		imgsize = "100";
	}

//	log.info("mount=" + mount);

	// list items in directory
	//mount=mount.replace("file://","");

	String image=Utility.getCoverImage(mount,mountpoint,localpoint,httppoint);

/*	
	String rootpath = mount;
	//log.info("path1:" + rootpath);
	
	rootpath = mount.replaceFirst("file.+\\/media-share\\/", "/media-share/");
	//log.info("path2:" + rootpath);
	rootpath = rootpath.replaceFirst("file.+\\/NETWORK_SHARE\\/share\\d+\\/", "/media-share/");

	String httppath = rootpath;

	//log.info("path3:" + rootpath);
	//rootpath=rootpath.replace("file:///opt/.+NETWORK_SHARE/shares\\d+/","/");

	//httppath=httppath.replace("file:///opt/.+NETWORK_SHARE/shares\\d+/","/media/");
	boolean found = false;
	String image="";
	if (!found) {
		Pattern coverpattern = Pattern.compile("^(cover|folder|front|poster)\\.(jpg$|jpeg$|png$|gif$)", Pattern.CASE_INSENSITIVE);
		File directory = new File(rootpath);
		if (directory.isDirectory()) {
			//out.print("x");
			for (File thisfile : directory.listFiles()) {
				//	out.print("y");
				if (!thisfile.isDirectory()) {
					//	out.print("z");
					String name = thisfile.getName();
					Matcher mm = coverpattern.matcher(name);
					if (mm.find()) {
						image=httppath + "/" + name;
						found = true;
						break;
					}
				}
			}
		}
	}
	
	if (!found) {
		Pattern coverpattern = Pattern.compile("(cover|folder|front|poster).*(jpg$|jpeg$|png$|gif$)", Pattern.CASE_INSENSITIVE);
		File directory = new File(rootpath);
		if (directory.isDirectory()) {
			//out.print("x");
			for (File thisfile : directory.listFiles()) {
				//	out.print("y");
				if (!thisfile.isDirectory()) {
					//	out.print("z");
					String name = thisfile.getName();
					Matcher mm = coverpattern.matcher(name);
					if (mm.find()) {
						image=httppath + "/" + name;
						found = true;
						break;
					}
				}
			}
		}
	}
	
	if (!found) {
		Pattern coverpattern = Pattern.compile("(jpg$|jpeg$|png$|gif$)", Pattern.CASE_INSENSITIVE);
		File directory = new File(rootpath);
		if (directory.isDirectory()) {
			//out.print("x");
			for (File thisfile : directory.listFiles()) {
				//	out.print("y");
				if (!thisfile.isDirectory()) {
					//	out.print("z");
					String name = thisfile.getName();
					Matcher mm = coverpattern.matcher(name);
					if (mm.find()) {
						image=httppath + "/" + name;
						found = true;
						break;
					}
				}
			}
		}
	}
	*/
	if (null!=image && !image.isEmpty()){
		%>
		<a href="<%=image%>" target="_blank">
		<img src="<%=image%>" class="cover"/>
		</a>
		<%
	}
	
	
%>