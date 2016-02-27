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
	<td class="button"><a href="javascript:sendKey('pageup');"><img class="icon" src="icon/button_pageup.png" alt="Pg+" title="Page Up"/></a></td>
</tr>
<tr>
	<td class="button"><a href="javascript:sendKey('pagedown');"><img class="icon" src="icon/button_pagedown.png" alt="Pg-" title="Page Down"/></a></td>
</tr>
<tr>
	<td class="button"><a href="javascript:sendKey('return');"><img class="icon" src="icon/button_return.png" alt="Back" title="Return/Back"/></a></td>
</tr>
</table>
    
</jsp:root>