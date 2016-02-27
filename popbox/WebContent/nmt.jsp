<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@page language="java"
		contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
		import="javax.servlet.ServletContext" 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>PopBox Control</title>
<script type="text/javascript">
	var nmthost = "${nmthost}";
	var mount="${mountpoint}";
	var currentrefresh = ${defaultrefresh};
	var queuetype = 'vod';
</script>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<!-- 
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="jquery-ui.min.js"></script>
-->
<script type="text/javascript" src="general.js"></script>

<link rel="StyleSheet" href="popbox.css" type="text/css" />
</head>
<body>
	
	<div class="headerBox">
		<table style="width:100%;">
			<tr>
				<td>
					<table>
						<tr>
							<td><jsp:include page="controls-nav.jsp" /></td>
							<td><jsp:include page="controls-pagination.jsp" /></td>
							<td><jsp:include page="controls-playback.jsp" /></td>
							<td><jsp:include page="controls-misc.jsp" /></td>
						</tr>

						<tr>
							<td colspan="5">
								<table>
									<tr>
										<td id="queuelength"></td>
										<td class="button"><a href="javascript:openRemote();"><img
												class="icon" src="icon/button_keyboard.png" alt="R"
												title="Complete Remote" /></a></td>

										<!-- 					<select id="QUEUETYPE" name='queuetype'	onchange='changeQueueType(this.value);'>
						<option value="vod" selected="selected">Video Queue</option>
						<option value="aod">Audio Queue</option>
					</select>
-->

										<!-- 
					<select	id="SPEED" name='speed' onchange='setSpeed(this.value)'></select>
					<select class="AUDIO" id="SCREENSAVER" name='screensaver' onchange='setScreenSaver(this.value)'>
						<option value="">[screen saver]</option>
						<option>off</option>
						<option>1</option>
						<option>5</option>
						<option>10</option>
						<option>15</option>
						<option>30</option>
						<option>60</option>
					</select>
-->

										<td class="buttonish"><input type="text" value=""
											onkeyup="sendButton(this.value);$('#lastkey').text(this.value);this.value='';"
											size="1" /> <span id="lastkey"></span> <select id="KEYS"
											onchange="sendKey(this.value);this.selectedIndex=0;">
												<option>[Send Command...]</option>
										</select></td>
										<td class="button"><a href='javascript:sendKey("setup");'><img
												class="icon" src="icon/button_setup.png" alt="Setup"
												title="Setup" /></a></td>
										<td class="button"><a
											href="javascript:if (confirm('Reboot the Device?' )){sendKey('power');sendKey('eject');}">
												<img class="icon" src="icon/button_power.png" alt="REBOOT"
												title="Reboot" />
										</a></td>
										<td class="button"><a
											href="javascript:listSpeeds();showqueue();buildkeys();">refresh</a></td>
									</tr>
								</table>


							</td>
						</tr>
					</table>

				</td>




				<td class="currentBox" style="text-align:left;width:100%;">
					<div id="CHOLDER">
						<div class="cover"> </div>
						<div id="CURRENT"> </div>
						<div style="text-align:left;">
							<a href="popbox.jsp">popbox</a>	
							<a href="a400.jsp">a400 (nfs)</a>
							<a href="a400-local.jsp">Local a400</a>
						</div>
					</div>

				</td>
			</tr>

		</table>
	</div>
		<div class="contentBox">
			<div class="contentBoxLeft" id="QUEUE"></div>
			<div id="FILEBOX" 
			class="contentBoxRight ui-widget-content"
			>
				<iframe 
					class="ui-widget-content"
					frameborder="0" marginheight="0" marginwidth="0" 
					id="FILES" seamless="seamless" 
					src="browse.jsp?nmthost=${nmthost}&mount=${mountpoint}">
				</iframe>
			</div>
		</div>
<!-- 		
		<div class="footerBox">
			<div id="DEBUG" style="float: right;"></div>

			<div id="DEBUG2" style="float: left;"></div>
		</div>
-->	





	<div class="remotePopup">
		<a href="javascript:closeRemote();" class="simplebutton"
			style="position: relative; top: 2px;">X</a>

		<table class="buttontable">
			<tr>
				<td><jsp:include page="controls-numberpad.jsp" /></td>
				<td></td>
				<td><jsp:include page="controls-playback.jsp" /></td>
			</tr>

			<tr>
				<td colspan="3" align="center"><jsp:include
						page="controls-colors.jsp" /></td>
			</tr>

			<tr>
				<td><jsp:include page="controls-nav.jsp" /></td>
				<td><jsp:include page="controls-pagination.jsp" /></td>
				<td><jsp:include page="controls-misc.jsp" /></td>

			</tr>
			<tr>
				<td colspan="3"><select class="AUDIO" id="SCREENSAVER"
					name='screensaver' onchange='setScreenSaver(this.value)'>
						<option value="">[screen saver]</option>
						<option>off</option>
						<option>1</option>
						<option>5</option>
						<option>10</option>
						<option>15</option>
						<option>30</option>
						<option>60</option>
				</select></td>
			</tr>
		</table>
	</div>

</body>
</html>
