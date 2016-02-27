<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:fn="http://java.sun.com/jsp/jstl/functions"
    xmlns:fmt="http://java.sun.com/jsp/jstl/fmt"
    xmlns="http://www.w3.org/1999/xhtml"
    version="2.0">

<jsp:directive.page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"/>
	


				<table>

				<tr>
				
					<td class="AUDIO button"><a href="javascript:changeQueueType('vod');"><img class="icon" src="icon/queue_audio.png" alt="Audio Queue" title="Change to Video Queue"/></a></td>
					<td class="VIDEO button"><a href="javascript:changeQueueType('aod');"><img class="icon" src="icon/queue_video.png" alt="Video Queue" title="Change to Audio Queue"/></a></td>
					<td class="button"><a href="javascript:sendKey('repeat');"><img class="icon" src="icon/button_repeat.png" alt="Repeat/Shuffle" title="Repeat/Shuffle"/></a></td>
					<td class="button"><a href="javascript:sendKey('info');"><img class="icon" src="icon/button_information.png" alt="Info" title="Info"/></a></td>

				</tr>
				<tr>	
					<td class="AUDIO button"><a href='javascript:sendKey("home");'><img class="icon" src="icon/button_music.png" alt="Playerlist" title="Playlist"/> </a></td>
					<td class="VIDEO button"><a href="javascript:sendKey('title');"><img class="icon" src="icon/button_title.png" alt="Title" title="Title"/></a></td>
					<td class="VIDEO button"><a href="javascript:sendKey('audio');"><img class="icon" src="icon/button_audio.png" alt="Audio"  title="Audio"/></a></td>
					<td class="VIDEO button"><a href="javascript:sendKey('zoom');"><img class="icon" src="icon/button_zoom.png" alt="Zoom" title="Zoom"/></a></td>
					<td class="AUDIO button"><a href='javascript:sendButton("G");'>Audio screen</a></td>

				</tr>
				<tr>
				<td class="AUDIO"><![CDATA[&nbsp;]]></td>
					<td class="VIDEO button"><a href="javascript:sendKey('menu');"><img class="icon" src="icon/button_menu.png" alt="Menu" title="Menu"/></a></td>
					<td class="VIDEO button"><a href="javascript:sendKey('subtitle');"><img class="icon" src="icon/button_subtitles.png" alt="Subtitle" title="Subtitle"/></a></td>
					<td class="VIDEO button"><a href="javascript:sendKey('angle');"><img class="icon" src="icon/button_angle.png" alt="Angle" title="Angle"/></a></td>

				</tr>
				</table>
</jsp:root>