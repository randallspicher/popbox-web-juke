<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:fn="http://java.sun.com/jsp/jstl/functions"
    xmlns:fmt="http://java.sun.com/jsp/jstl/fmt"
    xmlns="http://www.w3.org/1999/xhtml"
    version="2.0">

<jsp:directive.page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"/>
	


<table class="buttontable">
<tr>
<td class="button"><a href="javascript:sendKey('one');">1</a></td>
<td class="button"><a href="javascript:sendKey('two');">2</a></td>
<td class="button"><a href="javascript:sendKey('three');">3</a></td>
</tr>
<tr>
<td class="button"><a href="javascript:sendKey('four');">4</a></td>
<td class="button"><a href="javascript:sendKey('five');">5</a></td>
<td class="button"><a href="javascript:sendKey('six');">6</a></td>
</tr>
<tr>
<td class="button"><a href="javascript:sendKey('seven');">7</a></td>
<td class="button"><a href="javascript:sendKey('eight');">8</a></td>
<td class="button"><a href="javascript:sendKey('nine');">9</a></td>
</tr>
<tr>
<td></td>
<td class="button"><a href="javascript:sendKey('zero');">0</a></td>
<td></td>
</tr>
</table>
</jsp:root>