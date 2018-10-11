<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chorganizer</title>
    <link rel="stylesheet" type="text/css" href="/css/homepage.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css?family=Amatic+SC" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
	<script>
	    $(document).ready(function(){
	    	
	            $("#logError").click(function() {
	            	$(".alert").hide();
	            });
	            
	        });
   	</script>
</head>
<body>
    <div class="content">
     <!-- The Header -->
    <div class="header">
        <a class="homebutton" href="/home"><i class="fas fa-home"></i></a>
        <a href="/home"class="logolink"><h1 id="logo">Choreganizer</h1></a>
        <div class="options">
	    	<a href="/logout" id="logoutUser" class="headerlink">Logout</a>
	    </div>
    </div>
	    
    	<div id="joinHouse">
    		<h2>Connect to an Existing House</h2><hr><br>
    			<!-- Invalid House Alert -->
		    <c:if test="${logError != null}">
			    <div class="alert alert-danger">
				     ${logError}
				     <span class="close" id="logError">&times;</span>
				</div>
			</c:if>
    		<form method="POST" action="/addHouse" class="form">
    			<br>
    			<p><label for="houseName">Name: </label><br>
    			<input type="text" name="houseName"></p>
    			<p><label for="housePassword">Password: </label><br>
    			<input type="password" name="housePassword"></p>
    			<input type="hidden"  name="${_csrf.parameterName}" value="${_csrf.token}"/>
    			<input type = "submit" value="Join House" class="btn btn-dark">
    		</form>
    		<img src="/images/join_home.jpeg" alt="Join House">
    	</div>
    
    	<div id="createHouse" >
    		<h2>Create a New House</h2><hr><br>
    		<form:form method="POST" action="/createHouse" modelAttribute="house" class="form">
    			<p><form:label path="name">Name: </form:label><br><form:input path="name"/><br><form:errors path="name" class="text text-danger"/></p>
    			<p><form:label path="password">Password: </form:label><br><form:password path="password"/><br><form:errors path="password" class="text text-danger"/></p>
    			<p><form:label path="confirm">Confirm Password: </form:label><br><form:password path="confirm"/><br><form:errors path="confirm" class="text text-danger"/></p>
    			<input type = "submit" value="Create House" class="btn btn-dark">
    		</form:form>
    		<img src="/images/create_home.jpeg" alt="Create House">
    	</div>
    	
    </div>
</body>
</html>