<?xml version="1.0" encoding="UTF-8" ?>

<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page"
	xmlns:c="http://java.sun.com/jsp/jstl/core"
	xmlns:fn="http://java.sun.com/jsp/jstl/functions"
	xmlns:fmt="http://java.sun.com/jsp/jstl/fmt"
	xmlns="http://www.w3.org/1999/xhtml" version="2.0">

<jsp:directive.page import="java.util.HashMap"/>
	<jsp:directive.page language="java"
		contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" />
	<jsp:directive.page import="javax.servlet.ServletContext" />

	<c:set var="nmthost" value="192.168.1.13" scope="session" />
	<c:set var="mountpoint" value="nfs://192.168.1.2/music-share/ALL-MUSIC/Genres" scope="session" />

<jsp:scriptlet><![CDATA[

HashMap<String,HashMap<String,String>> MainMap=new HashMap<String,HashMap<String,String>>();
{
	HashMap<String,String> node=new HashMap<String,String>();
	node.put("localpoint","/media-share");
	node.put("httppoint","/media-share");
	MainMap.put("media-share",node);
}

{
	HashMap<String,String> node=new HashMap<String,String>();
	node.put("localpoint","/music-share");
	node.put("httppoint","/music-share");
	MainMap.put("music-share",node);
}
request.getSession().setAttribute("sharemap",MainMap);

]]></jsp:scriptlet>

	<c:set var="defaultrefresh" value="5000" scope="session" />


	<jsp:include page="nmt.jsp" />

</jsp:root>


