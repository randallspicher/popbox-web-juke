<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:fn="http://java.sun.com/jsp/jstl/functions"
    xmlns:fmt="http://java.sun.com/jsp/jstl/fmt"
    xmlns="http://www.w3.org/1999/xhtml"
    version="2.0">

<jsp:directive.page import="org.apache.commons.httpclient.params.HttpClientParams"/>
<jsp:directive.page import="java.net.URLEncoder"/>
<jsp:directive.page import="org.apache.commons.httpclient.util.URIUtil"/>
<jsp:directive.page language="java"
        contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" />
<jsp:directive.page import="
org.apache.commons.httpclient.*,
org.apache.commons.httpclient.methods.*,
java.net.ConnectException,
java.io.InputStream,
java.util.logging.Logger
"/>	

<jsp:scriptlet><![CDATA[


Logger LOGGER = Logger.getLogger("prox.jsp"); 
 
//String nmthost = application.getInitParameter("nmthost");
String nmthost = request.getParameter("nmthost");
String thedavidport=application.getInitParameter("thedavidport");
String remoteport=application.getInitParameter("remoteport");
int dport=Integer.parseInt(thedavidport);
String cmd=request.getParameter("cmd");
//String url="http://"+nmthost+":"+thedavidport+"/"+cmd;
//String query=request.getQueryString();


//uri.setEscapedAuthority(escapedAuthority)
//url+="?arg0="+encodeURI(request.getParameter("arg0"));
String query="";



for(int i=0; i<=10; i++){
	if (null !=request.getParameter("arg"+i)){
		if (i>0){
			query+="&";
		}
		//params.setParameter("arg"+i, request.getParameter("arg"+i));
		query+="arg"+i+"="+URLEncoder.encode(request.getParameter("arg"+i),"UTF-8").replaceAll("\\+","%20");
	}
}
URI uri = new URI("http",null,nmthost,dport,"/"+cmd);
//query=query.replaceAll("[+]","%20");

//LOGGER.info("query = "+ query);

uri.setEscapedQuery(query);

HttpClient client = new HttpClient();

//String url=uri.getURI();
GetMethod get = new GetMethod();
get.setURI(uri);
try {
	int status = client.executeMethod(get);
	//int status = 0;
	if (status != HttpStatus.SC_OK) {
		out.print("ERROR: Failure, could not fetch url "+uri+": status code: "+status);
	}
	else {
//		out.print(get.getResponseBody());
//		out.print(new String(responseBody)); 
		out.print(get.getResponseBodyAsString());

//		final byte[] buffer = new byte[128];		
//		//byte[] responseBody = get.getResponseBody();
//		InputStream resBody = get.getResponseBodyAsStream();
//		for (int count = resBody.read(buffer); count >= 0; count = resBody.read(buffer)) {
//			out.print(new String(buffer)); 
//		}
//out.print(get.getResponseBodyAsString());
	}
} catch (ConnectException e) {
	out.print("ERROR: Connect exception for url "+uri+": "+e);
//	ics.DisableCache();
}
finally {
	get.releaseConnection();
}



//out.print(urlContent);
]]></jsp:scriptlet>
</jsp:root>