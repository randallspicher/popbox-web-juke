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
,java.util.HashMap
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


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
	queue($(this).val());
	$(this).attr('checked',false).delay(100);
	 }
	 );	
}
function shuffleAdd(){
	var items=$("form#itemselections INPUT[@name='itemselect'][type='checkbox']");
	var newitems=shuffle(items);
	$(newitems).each(function(){
		queue($(this).val());
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


//log.info("mount="+mount);
String mountpoint="";
String localpoint="";
String httppoint="";
Pattern sharepattern = Pattern.compile("^([^/]+)//([^/]*)/+([^/]+)", Pattern.CASE_INSENSITIVE);
Matcher mm = sharepattern.matcher(mount);

if (mm.find()) {
	mountpoint=mm.group(0);
	//String protocall=mm.group(1);	
	//String server=mm.group(2);	
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
	//log.info("localpoint="+localpoint);
	//log.info("httppoint="+httppoint);

}

//String dir=request.getParameter("dir");
//if (dir==null){
//	dir="";
//}

//log.info("mount="+mount);
//System.out.println("dir.length="+mount.length());

String url = "http://" + nmthost + ":" + thedavidport+"/network_browse?";
//String query = request.getQueryString();

String encmount=mount.replaceAll("&", "%26");

//if (dir.length()>0){
//	url+="arg0=list_network_content&arg1="+mount+"&arg2="+dir;
if (mount.matches("[^\\/]+\\:\\/\\/.+\\/.+")){	
	url+="arg0=list_network_content&arg1="+encmount+"&arg2=";
	url+="&arg3=&arg4=&arg5=&arg6=&arg7=true&arg8=true&arg9=true&arg10=";
}
else {
	url+="arg0=list_network_resource&arg1="+encmount+"&arg2=";
	url+="&arg3=";
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
<button type="button"  onclick="shuffleAdd();">Add Shuffled</button>
<a href="browse.jsp?nmthost=<%=nmthost%>&mount=<%=Utility.htmlEncode(backdir)%>">browse</a>
<a href="browse-list.jsp?nmthost=<%=nmthost%>&mount=<%=Utility.htmlEncode(backdir)%>">list</a>
<a href="browse-wall.jsp?nmthost=<%=nmthost%>&mount=<%=Utility.htmlEncode(backdir)%>">wall</a>
</div>

<%

// list items in directory
List<FileItem> directories= new ArrayList<FileItem>();
List<FileItem> files= new ArrayList<FileItem>();

for (FileItem thisfile: SPF.getFiles()){
//	if(thisfile.getIsFolder()){
//		directories.add(thisfile);
//	}
//	else {
		files.add(thisfile);
//	}
}

%>
<div class="foldercontainer">
<%

for (FileItem thisfile: directories){

	String filename=thisfile.getName();
	String thismountpoint=mount+"/"+filename;

	out.print("<a class=\"folderbox\" href=\"javascript:browse(&quot;"+Utility.htmlEncode(mount+"/"+filename)+"&quot;);\">");
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
				<img class="foldericon" src='icon/folder.gif'/>
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

	if (thisfile.getIsFolder()){
		String thismountpoint=mount+"/"+filename;

		out.print("<a class=\"folderbox folder-bg\" href=\"javascript:browse(&quot;"+Utility.htmlEncode(mount+"/"+filename)+"&quot;);\">");
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
				<%=Utility.htmlEncode(filename).replaceAll("[_.]"," ")%> 
			</span>
		<%
		out.print("</a>");
	}
	else {
		
		
		if ("photo".equalsIgnoreCase(type)){

			String rootpath=mount.replace(mountpoint,localpoint);
			String httppath=mount.replaceFirst(mountpoint,httppoint);

			String imageurl=httppath+"/"+filename;
			%>
			<span class="folderbox">
			<a class="folderdisplay" href="<%=imageurl%>" target="_blank">
			
			<span class="folderimagebox">
				<img class="folderimage" alt='(<%=type%>)' title='(<%=type%>)' src="<%=imageurl%>"/>
			</span>
			<span class='foldertitle'>
				<%=Utility.htmlEncode(filename).replaceAll("[_.]"," ")%>
			</span>
			</a>
			</span>
			<%
		}
		else {
			if (filename.endsWith("cue")){
				out.print("<span class=\"folderbox cue-bg\">");
			}
			else if ("music".equalsIgnoreCase(type)){
				out.print("<span class=\"folderbox music-bg\">");
			}
			else if ("video".equalsIgnoreCase(type)){
				out.print("<span class=\"folderbox video-bg\">");
			}
			else {
				out.print("<span class=\"folderbox dvd-bg\">");
			}
		
		
			String image=Utility.getCoverImage(mount+"/"+filename,mountpoint,localpoint,httppoint);


			
			if (("music".equalsIgnoreCase(type)||"video".equalsIgnoreCase(type))
					&& !(filename.matches(".*[cCMmPp][uU3Ll][eEUuSs]") 
						)
					){				%>
				<span style="position:absolute; top:0; left:0;"><input type="checkbox" id="itemselect" name="itemselect" value="<%=Utility.htmlEncode(mount+"/"+filename)%>"/></span> 
				<%
			}
			%>
			<img alt='ADD' src='icon/plus.gif' style="position:absolute; top:0; right:0;"/>
			<%
			out.print("<a class=\"folderdisplay\" href=\"javascript:queue(&quot;"+Utility.htmlEncode(mount+"/"+filename)+"&quot;);\" title='Add this to the Queue'>");
			%>
			<span class='folderimagebox2'>
				<% 
				if (image!=null && image.trim().length()>0){ 
					%>
					<img class='folderimage' src="<%=image%>" />
					<%
				}
				else {
					%>
					&nbsp;<br/>
					<!-- 
					<img class='icon' alt='<%=type%>' title='<%=type%>' src='icon/<%=type%>.gif'/>
					-->
					
					<%
				}
				%>
			</span>
			<%--if (type!=null && type.length()>0){ %>
			<img class='icon' alt='(<%=type%>)' title='<%=type%>' src='icon/<%=type%>.gif'/>
			<%} --%>
			<span class='foldertitle'>
				<%=Utility.htmlEncode(filename).replaceAll("[_.]"," ")%>
				<%if (sz!=null && sz.length()>0){ %>
				<span class='size' title="<%=size%>">(<%=sz%>)</span>
				<%} %>
			</span>
			<%
			out.print("</a>");
			out.print("</span>");
		}

	}
	//alert(link);

}
%>
</div>


<%
out.print("</form>");

%>
<script>
function queue(filepath){
	parent.queue(filepath);
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
			async: false,
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
