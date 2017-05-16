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
,java.util.HashMap
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
	String type = request.getParameter("type");

// NOTE:  pch returns local paths, not our shared points, so pull last known mount-point from session (saved while browsing)

	//log.info("mount="+mount);
			
////	file:///opt/sybhttpd/localhost.drives/NETWORK_SHARE/share4/

String mountpoint=(String) request.getSession().getAttribute("mountpoint");	

mount=mount.replaceFirst("file:///opt/sybhttpd/localhost.drives/NETWORK_SHARE/share.", mountpoint);

//log.info("new mount="+mount);

//	String mountpoint="";
	String localpoint="";
	String httppoint="";
	Pattern sharepattern = Pattern.compile("^([^/:]+)://([^/]*)/+([^/]+)", Pattern.CASE_INSENSITIVE);
	Matcher mm = sharepattern.matcher(mountpoint);

	if (mm.find()) {
		//mountpoint=mm.group(0);
		String protocall=mm.group(1);	
		String server=mm.group(2);	
		String share=mm.group(3);	
		//log.info("mountpoint="+mountpoint);
		//log.info("protocall="+protocall);
		//log.info("server="+server);
		//log.info("share="+share);

		HashMap<String,HashMap<String,String>> sharemap = (HashMap<String,HashMap<String,String>>) request.getSession().getAttribute("sharemap");

		HashMap<String,String> node=sharemap.get(share);
		if (node!=null){
			localpoint=node.get("localpoint");
			httppoint=node.get("httppoint");
		}
	}

	String imgsize = request.getParameter("imgsize");
	
	if (imgsize == null) {
		imgsize = "100";
	}

	String image=Utility.getCoverImage(mount,mountpoint,localpoint,httppoint);


	if (null!=image && !image.isEmpty()){
		%>
		<a href="<%=image%>" target="_blank">
		<img src="<%=image%>" class="cover"/>
		</a>
		<%
	}
	
	
%>