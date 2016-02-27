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
					<td class="button"><a href="javascript:sendKey('rewind');"><img class="icon" src="icon/button_rewind.png" alt="RWnd" title="Rewind"/></a></td>
					<td class="button"><a href="javascript:sendkey('slow');"><img class="icon" src="icon/button_slow.png" alt="Slow" title="Slow"/></a></td>
					<td class="button"><a href="javascript:sendKey('fwd');"><img class="icon" src="icon/button_forward.png" alt="FFwd" title="Fast Forward"/></a></td>
					
					</tr>
					<tr>
					<td class="button"><a href="javascript:sendKey('prev');"><img class="icon" src="icon/button_previous.png" alt="Prev" title="Skip Previous"/></a></td>
					<td class="button"><a href="javascript:sendKey('pause');"><img class="icon" src="icon/button_pause.png" alt="Pause" title="Pause"/></a></td>
					<td class="button"><a href="javascript:sendKey('next');"><img class="icon" src="icon/button_next.png" alt="Next" title="Skip Next"/></a></td>
					</tr>
					<tr>
					<td  class="button" colspan="3" align="center">
					<a href="javascript:sendKey('stop');"><img class="icon" src="icon/button_stop.png" alt="Stop" title="Stop"/></a>
					<a href="javascript:sendKey('play');"><img class="icon" src="icon/button_play.png" alt="Play" title="Play"/></a>
					</td>
					
					</tr>
					
				</table>
</jsp:root>