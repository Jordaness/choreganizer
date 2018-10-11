<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chorganizer</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css?family=Amatic+SC" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="/css/sunrise.css">
    <link rel="stylesheet" type="text/css" href="/css/homepage.css">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
    <script type="text/javascript" src="js/app.js"></script>
    <script src="/js/landing.js"></script>
</head>
<body onmouseup="stopMove();">
 <!-- The Header -->
    <div class="header">
        <a class="homebutton" href="/home"><i class="fas fa-home"></i></a>
        <a href="/home" class="logolink"><h1 id="logo">Choreganizer</h1></a>
        <div class="options">
	        <c:if test="${sessionScope.userId == null}">
		        <a href="#" class="headerlink" id="myBtn">Login</a>
		        <a href="#" class="headerlink" id="myBtnTwo">Register</a>
		    </c:if>
		    <c:if test="${sessionScope.userId != null}">
		    	<a href="/logout" class="headerlink" id="logoutUser">Logout</a>
		    </c:if>
	    </div>
    </div>
    <!-- Logout Alert -->
    <c:if test="${logout != null}">
   		<div class="alert alert-danger">
        	<c:out value="${logout}"></c:out>
        	<span class="close" id="logout">&times;</span>
        </div>
    </c:if>
    <!-- Invalid Login Alert -->
    <c:if test="${logError != null}">
	    <div class="alert alert-danger">
		     ${logError}
		     <span class="close" id="logError">&times;</span>
		</div>
	</c:if>
	<!-- Invalid Registration Alert -->
	<c:set var="formErrors"><form:errors path="user.*"/></c:set>
	<c:if test="${not empty formErrors}">
		<div class="alert alert-danger">
			<span class="close" id="regError">&times;</span>
			<form:errors path="user.*"/>
		</div>
	</c:if>
    <!-- The Modal for Login -->
    <div id="myModal" class="modal">
	    <!-- Modal content to login -->
	    <div class="modal-content" id="logForm">
	    	<span class="close" id="closeLogin">&times;</span>
	    	<h1>Login</h1>
		    <form method="POST" action="/login">
		        <p>Email: </p><input type="text" id="loginEmail" name="username"/>
		        <p>Password: </p><input type="password" name="password"/>
		        <input type="hidden"  name="${_csrf.parameterName}" value="${_csrf.token}"/>
		        <br><br><input type="submit" value="Login" class="btn btn-dark"/>
		    </form>
		</div>
    </div>
    
     <!-- The Modal for Registering -->
    <div id="myModal2" class="modal">
        <!-- Modal content to register -->
        <div class="modal-content" id="regForm">
            <span class="close" id="closeReg">&times;</span>
           	<h1>Register</h1>
			<fieldset>
			    <form:form method="POST" action="/register" modelAttribute="user">
			        <p><form:label path="email">Email: </form:label><br><form:input path="email"/><br><form:errors path="email" class="text text-danger"/></p>
			        <p><form:label path="first">First Name: </form:label><br><form:input path="first"/><br><form:errors path="first" class="text text-danger"/></p>
			        <p><form:label path="last">Last Name: </form:label><br><form:input path="last"/><br><form:errors path="last" class="text text-danger"/></p>
			        <form:label path="phone">Phone: </form:label><br>
		    		<p><form:input type="tel" path="phone"
			           placeholder="123-456-7890"
			           pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}"
			           required= "true" />
			   	 	<span class="validity"></span><br><form:errors path="phone" class="text text-danger"/></p>
			        <p><form:label path="password">Password: </form:label><br><form:password path="password"/><br><form:errors path="password" class="text text-danger"/></p>
			        <p><form:label path="confirm">Confirm Password: </form:label><br><form:password path="confirm"/><br><form:errors path="confirm" class="text text-danger"/></p>
			        <input type="submit" value="Register" class="btn btn-dark"/>
			    </form:form>
		   </fieldset> 
   		</div>
   </div>
   <!-- SunSet Backgound -->
  <div id="screen">
	  <div id="starsContainer" onmousedown="startMove();" onmouseup="stopMove();">
	  		<div id="stars" onmousedown="startMove();" onmouseup="stopMove();"></div>
	  </div>
	
	  <div id="sun" onmousedown="startMove();" onmouseup="stopMove();"></div>
	
	  <div id="sunDay" onmousedown="startMove();" onmouseup="stopMove();"></div>
	
	  <div id="sunSet" onmousedown="startMove();" onmouseup="stopMove();"></div>
	
	  <div id="sky" onmousedown="startMove();" onmouseup="stopMove();"></div>
	
	  <div class="star" style="left: 250px; top: 70px;"></div>
	  <div class="star" style="left: 300px; top: 85px;"></div>
	  <div class="star" style="right: 40px; top: 90px;"></div>
	  <div class="star" style="right: 80px; top: 95px;"></div>
	  <div class="star" style="right: 120px; top: 65px;"></div>
	
	  <div id="horizon" onmousedown="startMove();" onmouseup="stopMove();"></div>
	
	  <div id="horizonNight" onmousedown="startMove();" onmouseup="stopMove();"></div>
	
	  <div id="moon" onmousedown="startMove();" onmouseup="stopMove();"></div>
	  
	  <div id="mountains" ><img src="/images/cascades.png"></div>
	  
	<!-- Sky/Ground Divider -->
	  
	  <div id="division" onmouseup="stopMove();"></div>
	  
	  <div id="water" onmousedown="startMove();" onmouseup="stopMove();"></div>
	  <div id="waterDistance"  onmousedown="startMove();" onmouseup="stopMove();"></div>
	  <div id="darknessOverlaySky"  onmousedown="startMove();" onmouseup="stopMove();"></div>
	  <div id="darknessOverlay"></div>
	  <div id="oceanRippleContainer"></div>
	  <div id="oceanRipple"></div>
  </div>
</body>
</html>