<?xml version="1.0" encoding="UTF-8" ?>

<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page"
	xmlns:c="http://java.sun.com/jsp/jstl/core"
	xmlns:fn="http://java.sun.com/jsp/jstl/functions"
	xmlns:fmt="http://java.sun.com/jsp/jstl/fmt"
	xmlns="http://www.w3.org/1999/xhtml" version="2.0">

	<jsp:directive.page language="java"
		contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" />
	<jsp:directive.page import="javax.servlet.ServletContext" />

	<c:set var="nmthost" value="192.168.1.11" scope="session" />
	<c:set var="mountpoint" value="file:///share/Music" scope="session" />

	<c:set var="localpoint" value="/a400/Music" scope="session" />
	<c:set var="httppoint" value="http://192.168.1.11:9999/music" scope="session" />
	<!-- 
	<c:set var="mountpoint" value="http://192.168.1.2:8080/media-share" scope="session" />
	-->
	<c:set var="defaultrefresh" value="5000" scope="session" />


	<jsp:include page="nmt.jsp" />

</jsp:root>

