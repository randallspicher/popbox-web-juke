<%@page import="org.apache.commons.lang3.StringEscapeUtils"%>
<%@page import="org.jaudiotagger.tag.FieldKey"%>
<%@page import="org.jaudiotagger.audio.generic.GenericTag"%>
<%@page import="org.jaudiotagger.audio.AudioFile"%>
<%@page import="org.jaudiotagger.audio.AudioFileIO"%>
<%@page import="org.jaudiotagger.audio.generic.GenericAudioHeader"%>
<%@page import="nmt.utils.SAXParserFiles"%>
<%@page import="nmt.utils.FileItem"%>
<%@page import="nmt.utils.Utility"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page language="java"
		contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
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
,java.util.logging.Logger
,java.util.regex.Pattern
,java.util.regex.Matcher
,java.util.HashMap
"
%>
<%
String rootpath=(String) request.getAttribute("rootpath");
String urlpath=(String) request.getAttribute("urlpath");

String fanart=null;
String poster=null;
String logo=null;
{
	File FANART = new File(rootpath+"/fanart.jpg");
	try {
		if (FANART.isFile()){
			fanart=urlpath+"/fanart.jpg";
		}
	}
	catch (Exception EX){
		
	}
}
if (null == fanart){
	File FANART = new File(rootpath+"/../fanart.jpg");
	try {
		if (FANART.isFile()){
			fanart=urlpath+"/../fanart.jpg";
		}
	}
	catch (Exception EX){
		
	}
}

{
	File FANART = new File(rootpath+"/logo.png");
	try {
		if (FANART.isFile()){
			logo=urlpath+"/logo.png";
		}
	}
	catch (Exception EX){
		
	}
}


{
	File FANART = new File(rootpath+"/poster.jpg");
	try {
		if (FANART.isFile()){
			poster=urlpath+"/poster.jpg";
		}
	}
	catch (Exception EX){
		
	}
}
if (null == poster){
	File FANART = new File(rootpath+"/cover.jpg");
	try {
		if (FANART.isFile()){
			poster=urlpath+"/cover.jpg";
		}
	}
	catch (Exception EX){
		
	}
}
if (null == poster){
	File FANART = new File(rootpath+"/folder.jpg");
	try {
		if (FANART.isFile()){
			poster=urlpath+"/folder.jpg";
		}
	}
	catch (Exception EX){
		
	}
}

if (null == poster){
	File FANART = new File(rootpath+"/../folder.jpg");
	try {
		if (FANART.isFile()){
			poster=urlpath+"/../folder.jpg";
		}
	}
	catch (Exception EX){
		
	}
}

%>
<style>
.poster {
max-width:30vw;
max-height:30vw;
}
.fanart {
max-width:60vw;
max-height:30vw;
}
</style>
<div class="folderinfo">
<%
if (poster!=null){
	%>
	<img class="poster" src="<%=poster %>"/>
	<%
}
if (fanart!=null){
	%>
	<img class="fanart" src="<%=fanart%>"/>
	<%
}


{
	File NFO = new File(rootpath+"/artist.nfo");
	try {
		if (NFO.isFile()){
		%>
		<div>
		Found artist.nfo
		<br>httppoint: <%=urlpath %>
		</div>
		<%
		}
	}
	catch (Exception EX){
		
	}
}

{
	File NFO = new File(rootpath+"/album.nfo");
	try {
		if (NFO.isFile()){
		%>
		<div>
		Found album.nfo
		</div>
		<%
		}
	}
	catch (Exception EX){
		
	}
}




{
	File NFO = new File(rootpath+"/movie.nfo");
	try {
		if (NFO.isFile()){
		%>
		<div>
		Found movie.nfo
		</div>
		<%
		}
	}
	catch (Exception EX){
		
	}
}


{
	File NFO = new File(rootpath+"/tvshow.nfo");
	try {
		if (NFO.isFile()){
		%>
		<div>
		Found tvshow.nfo
		</div>
		<%
		}
	}
	catch (Exception EX){
		
	}
}
%>
</div>
    