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
    <link rel="stylesheet" type="text/css" href="/css/style.css">
	<script type="text/javascript" src="js/app.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body>
    <div class="container">
        <a href="/logout" class="pull-right">Logout</a>
        <h1>Welcome, ${user.first} ${user.last}</h1>
        <table style="text-align: left; outline: 1px black solid;">
            <tr style="margin: 5px;">
                <td style="padding: 10px;">First Name:</td>
                <td style="padding: 10px;">${user.first}</td>
            </tr>
            <tr style="margin: 5px;">
                <td style="padding: 10px;">Last Name:</td>
                <td style="padding: 10px;">${user.last}</td>
            </tr>
            <tr style="margin: 5px;">
                <td style="padding: 10px;">Email:</td>
                <td style="padding: 10px;">${user.email}</td>
            </tr>
            <tr style="margin: 5px;">
                <td style="padding: 10px;">Sign Up Date:</td>
                <td style="padding: 10px;"><fmt:formatDate pattern = "MMMMM dd, yyyy" value="${user.createdAt}"></fmt:formatDate></td>
            </tr>
            <tr style="margin: 5px;">
                <td style="padding: 10px;">Last Sign In:</td>
                <td style="padding: 10px;"><fmt:formatDate pattern = "MMMMM dd, yyyy" value="${user.lastSignIn}"></fmt:formatDate></td>
            </tr>
        </table>
    </div>
    <div class="tables">
			<table>
				<thead>
				  <tr>
				    <th>Chore</th>
				    <th>Description</th>
				    <!-- <th>Creator</th> -->
				    <th>Assignee</th>
				    <th>Priority</th>
				  </tr>
				</thead>
				<tbody>
				 <c:forEach items="${chores}" var="chore"> 
				  <tr>
				  	<td>${chore.title}</td>
				    <td>${chore.description}</td>
				    <%-- <td>${chore.creator.first}</td> --%>
				    <td>${chore.assignee.first}</td>
				    <c:if test="${chore.priority == 1 }">
				    <td><c:out value="Low"/></td></c:if>
				    <c:if test="${task.priority == 2 }">
				    <td><c:out value="Medium"/></td></c:if>
				    <c:if test="${task.priority == 3 }">
				    <td><c:out value="High"/></td></c:if>
				  </tr>
				</c:forEach>
			  </tbody>
			</table>
		</div>
</body>
</html>