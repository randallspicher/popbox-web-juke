<!doctype html>

<html lang="en">
<head>
  <meta charset="utf-8" />
  <title>jQuery UI Resizable - Default functionality</title>
  <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
  <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
  <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

  <style>

body {
width:100%;
height:100%;
}
  #iframe {
  width: 100%;
  height: 100%;
  border: none;    

  background: #eee ;


  z-index: 1;
}

#resizable {
  width: 30%;
  height: 100%;
  background: #fff;
  border: 1px solid #ccc;
  z-index: 9;
  float:left;
	background-color:#AAAACC;
}


#content {
overflow:hidden; width:auto;
height:100%;
background-color:#DDAAAA;
xxfloat:right;
margin-left:5px;

}
#wrapper { 
float:left; 
width:100%; }

  </style>
  <script>
$(function() {
 $("#resizable").resizable({ handles: 'e' });
  
  $("#resizable").bind("resize", function (event, ui) {
      $('content').width(850 -(ui.size.width - 175));
      $('#content').css("left",ui.size.width - ui.originalSize.width);
  });
 });
  
  </script>
</head>
<body>
<div id="wrapper">

<div id="resizable">
Foobar
</div>
<div id="content">
  <iframe src="browse.jsp?nmthost=192.168.1.11&mount=file:///share/Music" id="iframe">
  </iframe>
</div>

</div>






</body>
</html>