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

"
%>
<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script src="jquery.min.js"></script>
<link rel="StyleSheet" href="popbox.css" type="text/css"/>

<script>
function selectAll(){
	 $("form#itemselections INPUT[@name='itemselect'][type='checkbox']").attr('checked', true);	
}
function selectNone(){
	 $("form#itemselections INPUT[@name='itemselect'][type='checkbox']").attr('checked', false);	
}
function submitSelected(){
	 $("form#itemselections INPUT[@name='itemselect'][type='checkbox']:checked").each(function (){
		//alert($(this).attr('data-title'));
		 queue($(this).val(),$(this).attr('data-type'),$(this).attr('data-title'));

	$(this).attr('checked',false).delay(100);
	 }
	 );	
}
function shuffleAdd(count){
	var items=$("form#itemselections INPUT[@name='itemselect'][type='checkbox']");
	var newitems=shuffle(items);
	newitems.length=count;
	$(newitems).each(function(){
		 queue($(this).val(),$(this).attr('data-type'),$(this).attr('data-title'));
		$(this).attr('checked',false).delay(100);
		 }
		 );	
}


function shuffle(array) {
	  var currentIndex = array.length, temporaryValue, randomIndex ;

	  // While there remain elements to shuffle...
	  while (0 !== currentIndex) {

	    // Pick a remaining element...
	    randomIndex = Math.floor(Math.random() * currentIndex);
	    currentIndex -= 1;

	    // And swap it with the current element.
	    temporaryValue = array[currentIndex];
	    array[currentIndex] = array[randomIndex];
	    array[randomIndex] = temporaryValue;
	  }

	  return array;
	}
</script>
</head>
<body class="content">
<%
Logger log= Logger.getLogger("browse.jsp"); 

//String nmthost = application.getInitParameter("nmthost");
String nmthost = request.getParameter("nmthost");
String thedavidport = application.getInitParameter("thedavidport");
String remoteport = application.getInitParameter("remoteport");
String mount=request.getParameter("mount");

String mountpoint = (String) request.getSession().getAttribute("mountpoint");
String localpoint = (String) request.getSession().getAttribute("localpoint");
String httppoint = (String) request.getSession().getAttribute("httppoint");
String uname = (String) request.getSession().getAttribute("uname");
String upass = (String) request.getSession().getAttribute("upass");

if (null==mountpoint){
	mountpoint="";
}
if (null==uname){
	uname="";
}
if (null==upass){
	upass="";
}
if (null==mount){
	mount="";
}

//log.info("mountpoint:"+mountpoint);
//log.info("localpoint:"+localpoint);
//log.info("httppoint:"+httppoint);

//String dir=request.getParameter("dir");
//if (dir==null){
//	dir="";
//}

//log.info("mount="+mount);
//System.out.println("dir.length="+mount.length());

String url = "http://" + nmthost + ":" + thedavidport;
//String query = request.getQueryString();

String encmount=mount.replaceAll("&", "%26");
String username=uname.replaceAll("&", "%26");
String password=upass.replaceAll("&", "%26");

boolean showmounts=false;
//if (dir.length()>0){
//	url+="arg0=list_network_content&arg1="+mount+"&arg2="+dir;

//log.info("checkpoint");
if (mount.startsWith("file")){
	showmounts=false;
	url+="/file_operation?";
	url+="arg0=list_user_storage_file";
	url+="&arg1="+encmount.replaceFirst("file://","");
	url+="&arg2=";
	url+="&arg3=";
	url+="&arg4=true";
	url+="&arg5=true";
	url+="&arg6=true";
	url+="&arg7=";
}
else {
	url+="/network_browse?";
	if (mount.matches("[^\\/]+\\:\\/\\/.+\\/.+")){	
		showmounts=false;	
		url+="arg0=list_network_content";
		url+="&arg1="+encmount;
		url+="&arg2=";
		url+="&arg3="+username+"";
		url+="&arg4="+password+"";
		url+="&arg5=";
		url+="&arg6=";
		url+="&arg7=true";
		url+="&arg8=true";
		url+="&arg9=true";
		url+="&arg10=";
	}
	else {
		showmounts=true;
		url+="arg0=list_network_resource&arg1="+encmount+"&arg2=";
		url+="&arg3=";
	}
}
//log.info("url="+url);
SAXParserFiles SPF=new SAXParserFiles(url);


//  crumb navigation
out.print("<form name=\"itemselections\" id=\"itemselections\">");

%>
<div class="breadcrumb">
<%
String[] dirlist=mount.split("/");
String backdir="";
//out.print("[");
for (String thisdir :dirlist){

	if (backdir.length()==0){
		out.print(thisdir);
		backdir+=thisdir;
	}
	else {
		backdir+=thisdir;
		out.print("/<a href=\"javascript:browse(&quot;"+Utility.htmlEncode(backdir)+"&quot;);\">"+Utility.htmlEncode(thisdir).replaceAll("_"," ")+"</a>");
	}
	backdir+="/";
}
%>
</div>
<div class="controls">
	<button type="button" onclick="submitSelected();">ADD Selected</button>
	<button type="button"  onclick="selectAll();submitSelected();">ADD All</button>
	<button type="button"  onclick="selectAll();">Select All</button>
	<button type="button"  onclick="selectNone();">Clear Selections</button>
	<button type="button"  onclick="shuffleAdd(10);">Add 10 Shuffled</button>
<!--
	<a href="browse.jsp?nmthost=<%=nmthost%>&mount=<%=Utility.htmlEncode(backdir)%>">browse</a>
	<a href="browse-list.jsp?nmthost=<%=nmthost%>&mount=<%=Utility.htmlEncode(backdir)%>">list</a>
	<a href="browse-wall.jsp?nmthost=<%=nmthost%>&mount=<%=Utility.htmlEncode(backdir)%>">wall</a>
-->	
</div>

<%
// list items in directory
List<FileItem> directories= new ArrayList<FileItem>();
List<FileItem> files= new ArrayList<FileItem>();

for (FileItem thisfile: SPF.getFiles()){
	if(thisfile.getIsFolder()||showmounts){
		directories.add(thisfile);
	}
	else {
		files.add(thisfile);
	}
}

%>
<div class="foldercontainer">
<%

for (FileItem thisfile: directories){

	String filename=thisfile.getName();
	String thismountpoint=mount+"/"+filename;

	out.print("<a class=\"folderbox folder-bg\" href=\"javascript:browse(&quot;"+
	   Utility.htmlEncode(mount+"/"+filename)+"&quot;);\">");
	%>
		<span class="folderimagebox">
			<%
			String image=Utility.getCoverImage(thismountpoint,mountpoint,localpoint,httppoint);

			if (image!=null){	
				%>
				<img class='folderimage' src="<%=image%>" />
				<%
			}
			else {
				%>
				&nbsp;<br/>
				&nbsp;<br/>
				&nbsp;<br/>
				<!-- img class="foldericon" src='icon/folder.gif'/-->
				<%
			}
			%>
		</span>
		<span class='foldertitle'>
			<%=Utility.htmlEncode(filename).replaceAll("_"," ")%> 
		</span>
	<%
	out.print("</a>");
}
%>
</div>

<table class="list">
<%
for (FileItem thisfile: files){
	String filename=thisfile.getName();
	//filename=htmlEncode(filename);
	//log.info("filename="+filename);
	String type=thisfile.getType();
	long size=(long)thisfile.getSize();
	double k=1024;
	String sz=(long)size+" b";
	
	//System.out.println("size:"+size);
	if ((long)size > (k*k*k*k)){
		//System.out.println("terrabyte range");
		sz=String.valueOf(Math.round((float)((double)size/(k*k*k*k)*10.0))/10.0)+" T";
	}
	else if ((long)size>(long)(k*k*k)){
		//System.out.println("gigabyte range");
		sz=String.valueOf(Math.round((float)((double)size/(k*k*k)*10.0))/10.0)+" G";
	}
	else if (size>k*k){
		//System.out.println("megabyte range");
		sz=String.valueOf(Math.round((float)((double)size/(k*k)*10.0))/10.0)+" M";
	}
	else if (size>k){
		//System.out.println("kilobyte range");
	
		sz=String.valueOf(Math.round((float)((double)size/(k)*10.0))/10.0)+" k";
	}

	
	boolean isFolder=thisfile.getIsFolder();
%>
<tr>
<%
	 {
		//data+="<td><button type='button' title='Add this to the Queue' onclick=\"queue(&quot;"+mount+"/"+dir+"/"+name+"&quot;);\" >Add</button></td>";

		String rootpath=mount.replace(mountpoint,localpoint);
		String httppath=mount.replaceFirst(mountpoint,httppoint);

		String fullpath=rootpath+"/"+filename;
		String title="";
		String artist="";
		String channels="";
		String genre="";
		String album="";
		String runlength="";
		String notes="";

		if (("music".equalsIgnoreCase(type)||"video".equalsIgnoreCase(type))
				&& !(filename.matches(".*[cCMmPp][uU3Ll][eEUuSs]") 
					)
			){
			
		 	//log.info("file: "+fullpath);

		 	File currentFile = new File(fullpath);
			try {
				
				AudioFile f = AudioFileIO.read(currentFile);
				if (null!=f.getTag()){
					title=f.getTag().getFirst(FieldKey.TITLE);
					artist=f.getTag().getFirst(FieldKey.ARTIST);
					album=f.getTag().getFirst(FieldKey.ALBUM);
				}
				channels=f.getAudioHeader().getChannels();
				
				int length=f.getAudioHeader().getTrackLength();
				int min=length/60;
				int sec=length%60;
				runlength=String.valueOf(min)+":";
				if (sec<=9){
					runlength+="0";
				}
				runlength+=String.valueOf(sec);

				String format=f.getAudioHeader().getBitRate();
				notes+="TITLE:  " + title;		
				notes+="\nALBUM:  " + album;		
				notes+="\nARTIST: " + artist;
				notes+="\nLENGTH: " + runlength; 
				notes+="\nCHAN:   " + channels; 
				notes+="\nBITRATE:" + f.getAudioHeader().getBitRate(); 
				notes+="\nSAMPLE: " + f.getAudioHeader().getSampleRate(); 
				notes+="\nBITS:   " + f.getAudioHeader().getBitsPerSample(); 
				notes+="\nENCTYPE:" + f.getAudioHeader().getEncodingType(); 
				notes+="\nFORMAT: " + f.getAudioHeader().getFormat(); 


			}
			catch (Exception Ex){
				log.severe(Ex.getMessage());
			}

		}
		%>
		<td class='action'>
			<a href="javascript:queue('<%=StringEscapeUtils.escapeEcmaScript(mount+"/"+filename)%>','<%=type%>','<%=StringEscapeUtils.escapeEcmaScript(title)%>');" 
				title='Add this to the Queue'><img alt='ADD' src='icon/plus.gif'></a>
		</td>
				
		<td class='action'>
			<a href="javascript:queue('<%=Utility.htmlEncode(httppath+"/"+filename)%>','<%=type%>','<%=Utility.htmlEncode(title)%>');" 
			title='Add this to the Queue Via HTTP'><img alt='+ HTTP' src='icon/plusHTTP.gif'></a>
		</td>
		
		<td class='action'>
			<a href="<%=Utility.htmlEncode(httppath+"/"+filename)%>" 
			title='Open Locally'><img alt='Open' src='icon/plusHTTP.gif'></a>
		</td>
			
		<%
		if (("music".equalsIgnoreCase(type)||"video".equalsIgnoreCase(type))
				&& !(filename.matches(".*[cCMmPp][uU3Ll][eEUuSs]") 
					)
				){
			%>
			<td>
				<input type="checkbox" id="itemselect" 
				name="itemselect" data-type="<%=type%>" data-title="<%=Utility.htmlEncode(title)%>"
				value="<%=Utility.htmlEncode(mount+"/"+filename)%>"/>
			</td> 
			<%
		}
		else {
			out.print("<td>&nbsp;</td>");
		}
		
		if ("photo".equalsIgnoreCase(type)){

			String imageurl=httppath+"/"+filename;
			%><td class='icon'>
			<img class="photo" alt='(<%=type%>)' title='(<%=type%>)' src="<%=imageurl%>"/>
			</td>
			<td class='title'>
			<a href="<%=imageurl%>" target="_blank"><%=Utility.htmlEncode(filename)%></a>
			</td>
			<%
		}
		else {
			out.print("<td class='icon'><img alt='("+type+")' title='("+type+")' src='icon/"+type+".gif'></td>");
			out.print("<td class='title' title=\""+Utility.htmlEncode(notes)+"\">"+Utility.htmlEncode(filename)+" </td>");
		}
		out.print("<td>"+runlength+"</td>");
		out.print("<td class='size' title=\""+size+"\">("+sz+")</td>");
	}
	//alert(link);
%>
</tr>
<%
}
%>
</table>
<%
out.print("</form>");

%>
<script>
function queue(filepath,type,title){
	parent.queue(filepath,type,title);
}

function browse(mount){
	window.location="?nmthost=<%=nmthost%>&mount="+encodeURIComponent(mount);
}

$(window).load(function () {
	 $(".photo").each(function (){
		var url="coverimg.jsp?nmthost=<%=nmthost%>&mount="+$(this).attr("imagepath")+"&imgsize=30";	 
	 	var owner=$(this);
		$.ajax({
			type: "GET",
			url: url,
			dataType: "text",
			async: true,
			timeout: 500,
			//	crossDomain: 'true',
			success: function( data ) {
				//alert(data);

				var newimg=$(data).filter("img");
				
				//alert (newsrc);
				if (newimg){
					owner.attr("height",40);
					owner.attr("width",40);
					owner.attr("src",newimg.attr("src"));
				}
				
			}
		 
		})
	 
	 })
});

</script>

<p>nmthost = <%=nmthost%></p>
</body>
</html>

