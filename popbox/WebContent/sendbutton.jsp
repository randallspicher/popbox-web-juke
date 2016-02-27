<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:fn="http://java.sun.com/jsp/jstl/functions"
    xmlns:fmt="http://java.sun.com/jsp/jstl/fmt"
    xmlns="http://www.w3.org/1999/xhtml"
    version="2.0">

<jsp:directive.page language="java"
        contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" />
<jsp:directive.page import="
java.net.*
"/>	

<jsp:scriptlet><![CDATA[

//String nmthost = application.getInitParameter("nmthost");
String nmthost = request.getParameter("nmthost");
String thedavidport=application.getInitParameter("thedavidport");
String remoteport=application.getInitParameter("remoteport");

String cmd=request.getParameter("cmd");
cmd.replaceAll("Z","\n");
byte[] b = cmd.getBytes();

Socket ss = new Socket(nmthost, Integer.parseInt(remoteport));

try {
	ss.getOutputStream().write(b);
//	out = new PrintWriter(ss.getOutputStream(), true);
} catch (ConnectException e) {
	out.print("ERROR: Connect exception"+e);
}
finally {
	ss.close();
}


]]></jsp:scriptlet>
</jsp:root>