<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
   
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>User Dash</title>
    <link rel="stylesheet" type="text/css" href="/css/sunrise.css">
	<script type="text/javascript" src="js/app.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body style="width: 100%; height: 100%; margin: 0; padding: 0" onmouseup="stopMove();" onresize="windowResize();">

  <div id="starsContainer" onmousedown="startMove();" onmouseup="stopMove();">
    <div id="stars" onmousedown="startMove();" onmouseup="stopMove();">
    </div>
  </div>

    <div id="sun" onmousedown="startMove();" onmouseup="stopMove();">
	<a href="/admin">Home</a>
    </div>

  <div id="sunDay" onmousedown="startMove();" onmouseup="stopMove();">

  </div>

  <div id="sunSet" onmousedown="startMove();" onmouseup="stopMove();">

  </div>

  <div id="sky" onmousedown="startMove();" onmouseup="stopMove();">

  </div>

  <div class="star" style="left: 250px; top: 30px;"></div>
  <div class="star" style="left: 300px; top: 25px;"></div>
  <div class="star" style="right: 40px; top: 40px;"></div>
  <div class="star" style="right: 80px; top: 45px;"></div>
  <div class="star" style="right: 120px; top: 20px;"></div>

  <div id="horizon" onmousedown="startMove();" onmouseup="stopMove();"></div>

  <div id="horizonNight" onmousedown="startMove();" onmouseup="stopMove();"></div>

  <div id="moon" onmousedown="startMove();" onmouseup="stopMove();"></div>
  
  <div id="mountainRange">
    <div id="mountain" onmousedown="startMove();" onmouseup="stopMove();">
  </div>

  </div>

  <div id="division" onmousedown="startDraggingDivision();" onmouseup="stopMove();">

  </div>

  <div id="water" onmousedown="startMove();" onmouseup="stopMove();"></div>

  <div id="waterReflectionContainer" onmousedown="startMove();" onmouseup="stopMove();">
    <div id="waterReflectionMiddle" onmousedown="startMove();" onmouseup="stopMove();">

    </div>
  </div>
  <div id="waterDistance"  onmousedown="startMove();" onmouseup="stopMove();"></div>
  <div id="darknessOverlaySky"  onmousedown="startMove();" onmouseup="stopMove();"></div>
  <div id="darknessOverlay"></div>
  <div id="oceanRippleContainer">
 </div>
  <div id="oceanRipple"></div>
</body>
</html>