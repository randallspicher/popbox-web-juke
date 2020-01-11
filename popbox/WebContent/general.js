var currentlyplaying=false;
var currenttrack="";
	
function openRemote(){
	$(".remotePopup").css('display', 'inline-block');
}	
function closeRemote(){
	$(".remotePopup").css('display', 'none');
}
	
function htmlEncode(value) {
    return $('<div/>').text(value).html();
}

function htmlDecode(value) {  
    return $('<div/>').html(value).text();
} 

function changeQueueType(TYPE){
	queuetype=TYPE;showqueue();
	if (TYPE=='vod'){
		$(".AUDIO").hide();
		$(".VIDEO").show();
	}
	if (TYPE=='aod'){
		$(".VIDEO").hide();
		$(".AUDIO").show();
	}
	showqueue();				
}

function currentlyPlaying(){
	var url="/popbox/prox.jsp?nmthost="+nmthost+"&cmd=playback&arg0=get_current_"+queuetype+"_info";
	$.ajax({
		type: "GET",
		url: url,
		dataType: "text",
		//	crossDomain: 'true',
		success: function( response ) {
//			var response =(new XMLSerializer()).serializeToString(data);
			var album=$(response).find('album').text();
			var artist=$(response).find('artist').text();
			var title=$(response).find('title').text();
			var fullpath=$(response).find('fullPath').text();
			//alert(response);
			//alert(title+"\n"+fullpath);
	        if (fullpath.trim().length>0){
	        	currentlyplaying=true;
	        	$("#DEBUG2").empty().append("Playing Now");
				var id=fullpath.substr(fullpath.lastIndexOf("/")+1).replace(/[^a-zA-Z0-9]/g,"x");
				//alert(id);
				//$('#'+fullPath).addClass('current');		
				$('tr.querow').removeClass('current');
				$('#'+id).addClass('current');	
				var thistrack=$('#'+id+" td.title").attr("title");
				if (currenttrack!=thistrack){
					currenttrack=thistrack;
					//alert(thistrack);
					getCover();
				}

	        }
	        else {
	        	currentlyplaying=false;
				$('tr.querow').removeClass('current');
	        	$("#DEBUG2").empty().append("Nothing Playing");
	        	$("#COVER").empty();
	        }
	        if (title.trim().length<=0){
				title=fullpath.substr(fullpath.lastIndexOf("/")+1);
			}
	        title=title.replace(/[_.]/g,' ').replace(/mp3$|flac$|wav$|dts$/i,'');
	        
			
	        if (album.trim().length<=0){
				album=fullpath.substr(0,fullpath.lastIndexOf("/"));
				album=album.substr(album.lastIndexOf("/")+1);
	        }
	        if (artist.trim().length<=0){
				artist=fullpath.substr(0,fullpath.lastIndexOf("/"));
				artist=artist.substr(0,artist.lastIndexOf("/"));
				artist=artist.substr(artist.lastIndexOf("/")+1);
	        }
	        album=album.replace(/[_.]/g,' ');
	        artist=artist.replace(/[_.]/g,' ');
			var totalTime=$(response).find('totalTime').text();
			var currentTime=$(response).find('currentTime').text();

			

			var tsec=totalTime%60;
			var tsr=totalTime-tsec;
			var tmr=tsr/60;
			var tmin=tmr%60;
			tmr=tmr-tmin;
			var thour=tmr/60;
			var ttime="";

			var csec=currentTime%60;
			var csr=currentTime-csec;
			var cmr=csr/60;
			var cmin=cmr%60;
			cmr=cmr-cmin;
			var chour=cmr/60;
			var ctime="";
			
			//			if (thour>0){
//				ttime+=thour+":";
//			}
//			if (thour>0 && tmin<10){
//				ttime+="0";
//			}
//			ttime=tmin+":";
//			if (tsec<10){
//				ttime+="0";
//			}
//			ttime +=tsec;

			
			if (thour>0){
				ttime=thour+":";
				if (tmin<10){
					ttime+="0";
				}
			}
			ttime+=tmin+":";
			if (tsec<10){
				ttime+="0";
			}
			ttime+=tsec;
			
			if (chour>0){
				ctime=chour+":";
				if (cmin<10){
					ctime+="0";
				}
			}
			ctime+=cmin+":";
			if (csec<10){
				ctime+="0";
			}
			ctime+=csec;

			var data="<table>";
			data+="<tr><td>Title:</td><td class='nowplaying' title='"+fullpath+"'>"+title.replace(/[_.]/g,' ')+"</td></tr>";
			//data+="<tr><td>Path:</td><td>"+fullPath+"</td></tr>";
			data+="<tr><td>Album:</td><td>"+album+"</td></tr>";
			data+="<tr><td>Artist:</td><td>"+artist+"</td></tr>";
			data+="<tr><td id='SPEEDDISP'></td><td title='"+currentTime+"/"+totalTime+"'>"+ctime+" / "+ttime+"</td></tr>";
			data+="</table>";
			$("#CURRENT" ).empty().append(data);
			url="/popbox/prox.jsp?nmthost="+nmthost+"&cmd=playback&arg0=get_playback_speed_"+queuetype+"";
			document.title=title+ ' - ' + artist + ' - '+album;
			$.ajax({
				type: "GET",
				url: url,
				dataType: "text",
				//	crossDomain: 'true',
				success: function( response ) {
					var speed=$(response).find('speed').text();
					if (speed=="0"){
						speed="paused";						
					}
					$("#SPEEDDISP").empty().append(speed);
				}
			});

		}
	});
}

function getCover(){
	//alert(currenttrack);
	if (currenttrack){
		var lookpath=currenttrack.replace(/[^\/]+$/,"");
		//alert('lookpath: '+lookpath);
		var url="getcoverimg.jsp?nmthost="+nmthost+"&mount="+lookpath;	 
		var owner=$("#COVER");
		owner.empty();
		$.ajax({
			type: "GET",
			url: url,
			dataType: "text",
			success: function( data ) {
				owner.append(data);
				//alert(data)
				//var newimg=$(data).filter("img");
				//alert(newimg.attr("src"));
				//if (newimg){
				//owner.attr("src",newimg.attr("src"));
				//}
			}	
		
		});
	}	 
}


function setScreenSaver(Level){
	//alert('SPEED='+SPEED);
		
		var url="/popbox/prox.jsp?nmthost="+nmthost+"&cmd=setting&arg0=set_screen_saver_time&arg1="+Level;
		$.ajax({
			type: "GET",
			url: url,
			dataType: "text",
			//	crossDomain: 'true',
			success: function( data ) {
			},
		error: function(d1,d2,d3){
			$("#DEBUG" ).empty().append('an error happened d1='+d1 + ' d2='+d2+ ' d3='+d3);
		}
		});
		
	}



function setSpeed(SPEED){
//alert('SPEED='+SPEED);
	
	if (SPEED=="RESET"){
		listSpeeds();
	}
	else {
	
	var url="/popbox/prox.jsp?nmthost="+nmthost+"&cmd=playback&arg0=set_playback_speed_"+queuetype+"&arg1="+SPEED;
	$.ajax({
		type: "GET",
		url: url,
		dataType: "text",
		//	crossDomain: 'true',
		success: function( data ) {
//			$("#SPEED").empty().append("<option value='RESET'>RESET</option>");
//			alert(data);
//			$(data).find("response").find("speed").each(renderspeed);
		},
	error: function(d1,d2,d3){
		$("#DEBUG" ).empty().append('an error happened d1='+d1 + ' d2='+d2+ ' d3='+d3);
	}
	});
	}
	
}


function listSpeeds(){

	function renderspeed(){
		//alert('rr');
		var speed=$(this).text();
		$("#SPEED").append("<option value=\""+speed+"\">"+speed+"</option>");
	};
	
	var url="/popbox/prox.jsp?nmthost="+nmthost+"&cmd=playback&arg0=list_playback_speed_"+queuetype+"";
	$.ajax({
		type: "GET",
		url: url,
		dataType: "text",
		//	crossDomain: 'true',
		success: function( data ) {
			$("#SPEED").empty().append("<option>[Play Speed]</option><option value='RESET'>RESET</option>");
			//alert(data);
			$(data).find("response").find("speed").each(renderspeed);
		},
	error: function(d1,d2,d3){
		$("#DEBUG" ).empty().append('an error happened d1='+d1 + ' d2='+d2+ ' d3='+d3);
	}
	});
}




var QueueQueue = [];

function queue(filepath, filetype, filetitle){
	//alert('adding FILEPATH:\n'+filepath+'\nTITLE\n'+filetitle);
	QueueQueue.push([filepath, filetype, filetitle]);
	document.getElementById("queuelength").innerHTML=QueueQueue.length;
	processQueue();
}



var processingQueue=false;
function processQueue(){
	if (!processingQueue && QueueQueue.length > 0){
		processingQueue=true;
		var queueitem=QueueQueue.shift();
		document.getElementById("queuelength").innerHTML=QueueQueue.length;
		var filepath=queueitem[0];
		var type=queueitem[1];
		var title=queueitem[2];
			//alert('processing FILEPATH:\n'+filepath+'\nTITLE\n'+title);

		if (title.size < 1){
			title=decodeURI(filepath);
			title=title.substr(title.lastIndexOf("/")+1);
			title=title.replace(/[_.]/g,' ').replace(/mp3$|flac$|wav$|dts$|avi$|mpg$|mkv$/i,'');
		}

		filepath=encodeURIComponent(filepath);
		title=encodeURIComponent(title);
		//if (type=='video'){
		//	queuetype='vod';
		//}	
		//if (type=='music'){
		//	queuetype='aod';
		//}
		//if (type=='photo'){
		//	queuetype='pod';
		//}
		
		
		
		//filepath=escape(filepath);
		//alert('file:'+filepath);
		//alert('type='+type+'\nqueuetype='+queuetype);
		var url="";
		
		if (queuetype=='aod'){
			if (currentlyplaying){
				url="/popbox/prox.jsp?nmthost="+nmthost+"&cmd=playback";
				url+="&arg0=insert_"+queuetype+"_queue";
				url+="&arg1="+title;
				//url+="&arg1=";
				url+="&arg2="+filepath;
				if (QueueQueue.length==0){
				url+="&arg3=show";
				}
				url+="&arg4=enable";

			}
			else {
				url="/popbox/prox.jsp?nmthost="+nmthost+"&cmd=playback";
				url+="&arg0=start_"+queuetype;
				url+="&arg1="+title;
				//url+="&arg1=";
				url+="&arg2="+filepath;
				url+="&arg3=show";
				//url+="&arg3=";
				url+="&arg4=enable";
			}
		}
		else if (queuetype=='vod'){
			if (currentlyplaying){
				url="/popbox/prox.jsp?nmthost="+nmthost+"&cmd=playback";
				url+="&arg0=insert_"+queuetype+"_queue";
				//url+="&arg1="+title;
				url+="&arg1=";
				url+="&arg2="+filepath;
				url+="&arg3=show";
				url+="&arg4=";
				//url+="&arg5=10";
				//url+="&arg6=enable";
			}
			else {
				url="/popbox/prox.jsp?nmthost="+nmthost+"&cmd=playback";
				url+="&arg0=start_"+queuetype;
			//	//url+="&arg1="+title;
				url+="&arg1=";
				url+="&arg2="+filepath;
				url+="&arg3=show";
				//url+="&arg3";
				url+="&arg4=";
				url+="&arg5=10";
				url+="&arg6=enable";
			}
		}
			
		//alert(url);
		//var url="/playback&arg0=insert_"+queuetype+"_queue&arg1=";
		currentlyplaying=true;
	
		$.ajax({
			'async': true,
			'timeout':10000,
			'url':url,
			'success':	 function( data ) {
				//setTimeout("waitQueue('"+queuetype+"',10)",10);
				processingQueue=false;
				processQueue();
				//alert('SUCCESS: '+data+'\n');
			},
			'error': function ( jqXHR,textStatus,errorThrown ){
				alert('Status: '+textStatus+'\n');
				processingQueue=false;
			},
			'complete':function(){
				document.getElementById("queuelength").innerHTML=QueueQueue.length;
				//if (QueueQueue.length <= 0 ){
					setTimeout("showqueue()",2000);
				//}
			}
		});
	}
	
	//else {
		//setTimeout(processQueue, 5000);
	//}
}

function waitQueue(queuetype,trycount){
//	alert("queuetype:"+queuetype+"\ntrycount"+trycount);
	if (trycount>0){
		var count=trycount-1;
		var url="/popbox/prox.jsp?nmthost="+nmthost+"&cmd=playback&arg0=get_current_"+queuetype+"_info";
		$.ajax({
			'async': true,
			'timeout':10000,
			'url':url,
			'success':	 function( data ) {
				currentlyplaying=true;
				var responseval=$(data).find('response').text();
				//alert(responseval);
				if (responseval.length > 0){
					//alert("already playing");1
					processingQueue=false;
					if (QueueQueue.length > 0){
						//showqueue();
						processQueue();
					}
					else {
						showqueue();
					}
				}
				else{
					//alert("not playing");
					setTimeout("waitQueue('"+queuetype+"',"+count+")",1000);
				}
			//	alert('SUCCESS: '+data+'\n');
		},	
		'error': function ( jqXHR,textStatus,errorThrown ){
				processingQueue=false;
				alert('Status: '+textStatus+'\n');
			},
			'complete':function(){
				document.getElementById("queuelength").innerHTML=QueueQueue.length;
			}
		});
	}	
	else {
		alert('timeed out waiting for queue to start');
		processingQueue=false;
	}
}

setTimeout("showqueue()",1000);

//setInterval("showqueue()",10000);
//setInterval("processQueue()",1250);
//



function remove(index){
//alert('file:'+filepath);
var url="/popbox/prox.jsp?nmthost="+nmthost+"&cmd=playback&arg0=delete_"+queuetype+"_entry_queue&arg1="+index;
	$.get(url,	{},  
		 function( data ) {
			setTimeout ("showqueue()",500);
		}
	);
}



/*
        arg0 Function name String
arg1 First level mount point. String
arg2 Further level mount point. String
arg3 Username to access this content. String
arg4 Password to access this content. String
arg5 Offset, start number of the response list. String
arg6 Range, number of response to return. Default is 99999. String
arg7 Show folders in response list. Boolean
arg8 Show files in response list. Boolean
arg9 Enable return more information of the file or folder. Example: file size. Boolean
arg10 Mime type to return. 

*/


function showqueue(){
//alert('showqueue');
$("#DEBUG" ).empty();

	function showfile(){


			var fullpath=$(this).find('fullpath').text();
			var title=$(this).find('title').text();
			var index=$(this).find('index').text();
	        if (title.trim().length<=0){
				title=fullpath.substr(fullpath.lastIndexOf("/")+1);
			}
			title=title.replace(/[_.]/g,' ').replace(/mp3$|flac$|wav$|dts$/i,'');
			
			var id=fullpath.substr(fullpath.lastIndexOf("/")+1).replace(/[^a-zA-Z0-9]/g,"x");
//			alert(id);
			//var link="";
//			var data="<tr class='querow' id=\""+fullpath+"\">";
			var data="<tr class='querow' id=\""+id+"\">";
//			data+="<td><a href=\"javascript:remove(&quot;"+index+"/"+dir+"/"+name+"&quot;);\" title='Add this to the Queue'></a></td>";
			data+="<td class='action'><a href=\"javascript:remove(&quot;"+index+"&quot;);\"><img alt='REMOVE' src='icon/remove.gif'></a></td>";
//			data+="<td><a href=\"javascript:remove(&quot;"+index+"&quot;);\">[remove]</a></td>";
			data+="<td class='title' title=\""+htmlEncode(fullpath)+"\n"+id+"\">"+htmlEncode(title)+"</td>";
			data+="</tr>";
	//		data+="<tr><td>"+htmlEncode(fullpath)+"</td></tr>";
			$("#QUEUE" ).append(data);

	};

	var url="/popbox/prox.jsp?nmthost="+nmthost+"&cmd=playback&arg0=list_"+queuetype+"_queue_info";
//		url+="&arg3=&arg4=&arg5=&arg6=&arg7=&arg8=&arg9=&arg10=";
	$.ajax({
		type: "GET",
		url: url,
		dataType: "text",
		//	crossDomain: 'true',
		success: function( data ) {
//			alert('have data');
			//var files="";
			//var xmlstr = (new XMLSerializer()).serializeToString(data);
			$("#QUEUE" ).empty();
			$("#QUEUE" ).append("<table cellspacing='4'>");
			$(data).find("response").find("queue").each(showfile);
			$("#QUEUE" ).append("</table>");
			
		//	$("#DEBUG" ).empty().append(data.replace(/[<]/g,"&lt;").replace(/[>]/g,"&gt;"));
		},
		error: function(d1,d2,d3){
			$("#DEBUG" ).empty().append('an error happened d1='+d1 + ' d2='+d2+ ' d3='+d3);
		}
	});
	currentlyPlaying();
}	





function pause(){
	playback("arg0=pause_"+queuetype);
}
function resume(){
	playback("arg0=resume_"+queuetype);
}
function stop(){
	playback("arg0=stop_"+queuetype);
}
function next(){
//	sendButton("n");
	playback("arg0=next_"+queuetype+"_in_queue");
}
function prev(){
	playback("arg0=prev_"+queuetype+"_in_queue");
}


function playback(COMMAND){
	
	var url="/popbox/prox.jsp?nmthost="+nmthost+"&cmd=playback&"+COMMAND;
	//alert(url);
$.ajax({
	type: "GET",
	url: url,
	dataType: "text",
	success: function( data ) {
	},
	error: function(d1,d2,d3){
		$("#DEBUG" ).empty().append('an error happened d1='+d1 + ' d2='+d2+ ' d3='+d3);
	},
	'complete':function(){
		setTimeout ("showqueue()",2000);
	}
	});
	
	
} 

function sendKey(KEY){
	var url="/popbox/prox.jsp?nmthost="+nmthost+"&cmd=system&arg0=send_key&arg1="+KEY;
	//alert(url);
$.ajax({
	type: "GET",
	url: url,
	dataType: "text",
	success: function( data ) {
	},
	error: function(d1,d2,d3){
		$("#DEBUG" ).empty().append('an error happened d1='+d1 + ' d2='+d2+ ' d3='+d3);
	},
	complete: setTimeout("showqueue()",2000)
});
	
	
	
}

var videoformats="";

function getvideoformats(){
	
	var url="/popbox/prox.jsp?nmthost="+nmthost+"&cmd=playback&arg0=list_vod_supported_format";
	$.ajax({
		type: "GET",
		url: url,
		dataType: "text",
		success: function( data ) {
//			$("#DEBUG2" ).empty().append(data.replace(/[<]/g,"&lt;").replace(/[>]/g,"&gt;"));
	
			$(data).find("response").find("format").each(function(index) {
//				alert(index);
				videoformats+="|"+$(this).text()+"|";
			});
		},
		error: function(d1,d2,d3){
			$("#DEBUG" ).empty().append('an error happened d1='+d1 + ' d2='+d2+ ' d3='+d3);
		}
	});
}

var audioformats="";
function getaudioformats(){
	
	var url="/popbox/prox.jsp?nmthost="+nmthost+"&cmd=playback&arg0=list_aod_supported_format";
	$.ajax({
		type: "GET",
		url: url,
		dataType: "text",
		success: function( data ) {
//			$("#DEBUG2" ).empty().append(data.replace(/[<]/g,"&lt;").replace(/[>]/g,"&gt;"));
	
			$(data).find("response").find("format").each(function(index) {
//				alert(index);
				audioformats+="|"+$(this).text()+"|";
			});
		},
		error: function(d1,d2,d3){
			$("#DEBUG" ).empty().append('an error happened d1='+d1 + ' d2='+d2+ ' d3='+d3);
		}
	});
}

function sendButton(BUTTON){
	var url="/popbox/sendbutton.jsp?nmthost="+nmthost+"&cmd="+BUTTON;
	$.ajax({
		type: "GET",
		url: url,
		dataType: "text"
	});
}


function listformats(){
	var msg="video format=";
	msg+=videoformats;
	alert(msg);	
}

function buildkeys() {
var url="/popbox/prox.jsp?nmthost="+nmthost+"&cmd=system&arg0=list_key";
//alert(url);
$.ajax({
type: "GET",
url: url,
dataType: "text",
success: function( data ) {
	$(data).find("response").find("key").each(function(index) {
		$("#KEYS").append("<option value=\""+$(this).text()+"\">"+$(this).text()+"</option>");
	});
},
error: function(d1,d2,d3){
	$("#DEBUG" ).empty().append('an error happened d1='+d1 + ' d2='+d2+ ' d3='+d3);
}
});
}



//setTimeout ("listSpeeds();browse(sharepath1,sharename1);showqueue()",500);
setTimeout ("changeQueueType('aod');listSpeeds();showqueue();currentlyPlaying();",1000);
setInterval ("currentlyPlaying()",currentrefresh);


	  


$(function() {
    $('#QUEUE').resizable({
      start: function(event, ui) {
        $('iframe').css('pointer-events','none');
         },
      stop: function(event, ui) {
        $('iframe').css('pointer-events','auto');
      },
       handles: "e"
  });

  $("#QUEUE").bind("resize", function (event, ui) {
      $('#FILEBOX').width(850 -(ui.size.width - 175));
      $('#FILEBOX').css("left",ui.size.width - ui.originalSize.width);
  });

});




//getvideoformats();

