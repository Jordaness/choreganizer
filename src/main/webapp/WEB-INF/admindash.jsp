<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Collections"%>
   
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Admin Dash</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css?family=Amatic+SC" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="/css/style.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="http://stevenlevithan.com/assets/misc/date.format.js"></script>
    <script src="/js/dashboard.js"></script>

</head>
<body>
	<div id="Z${user.id}" class="userId"></div>
	<div id="X${house.id}" class="houseId"></div>
	<div class="headers">
		<a class="homebutton" href="/home"><i class="fas fa-home"></i></a>
        <a href="/home" class="logolink"><h1 id="logo">House ${house.name}</h1></a>
        <div class="options">
	        <span id="create" class="headera" >Create Chore</span>
	        <a href="/logout" class="headera">Logout</a>
        </div>
    </div>
    <!-- Invalid Registration Alert -->
	<c:set var="formErrors"><form:errors path="chore.*"/></c:set>
	<c:if test="${not empty formErrors}">
		<div class="alert alert-danger">
			<span class="close" id="choreError">&times;</span>
			<form:errors path="chore.*"/>
		</div>
	</c:if>
<!-- Admin Dashboard -->
    <div class="container">
        <h1>Welcome, ${user.first}</h1> 
        <div class="scroll">
	        <table class="table table-ruled">
	            <thead>
	              <tr>
	                <th>House Mates</th>
	                <th>Phone #</th>
	                <th>Actions</th>
	                <th>Last Login</th>
	                <th>House Member Since</th>
	              </tr>
	            </thead>
	            <tbody id="userBody">
	              <c:forEach items="${allUsers}" var="single">
		                 <tr>
		                 	<!-- User Name -->
		                   <td>${single.first} ${single.last}</td>
		                   <!-- User Phone -->
		                   <td>${single.phone}</td>
		                   <!--  User Title / Options -->
		                   		<!-- Super User Options -->
		                   <c:if test="${user.getRoles().size() == 4}">
			                   <td>
			                       <c:if test="${single.getRoles().size() == 4}">Super Admin</c:if>
			                       <c:if test="${single.getRoles().size() == 3}">Manager</c:if>
			                       <c:if test="${single.getRoles().size() <= 2}">
										<a href="#" id="D${single.id}" class="userDelete">Delete User</a>
			                      </c:if>
			                   </td>
		                    </c:if>
		                    	<!-- Manager User Options -->
		                   <c:if test="${user.getRoles().size() == 3}">
			                   <td>
			                       <c:if test="${single.getRoles().size() >= 3}">Manager</c:if>
			                       <c:if test="${single.getRoles().size() <= 2}">
			                       		<a href="#" id="D${single.id}" class="userRemove">Remove User</a>
										<c:if test="${single.getRoles().size() == 1}"> | <a href="#" id="S${single.id}" class="makeAdmin">Make Admin</a></c:if>
										<c:if test="${single.getRoles().size() == 2}"> | <a href="#" id="S${single.id}" class="takeAdmin">Take Admin</a></c:if>
			                      </c:if>
			                   </td>
		                    </c:if>
		                    	<!-- Admin Options -->
		                   	<c:if test="${user.getRoles().size() == 2}">
			                    <c:if test="${single.getRoles().size() >= 2}">
			                    	<td>Admin</td>
			                    </c:if>
			                    <c:if test="${single.getRoles().size() == 1}">
			                    	<td><a href="#" id="R${single.id}" class="userRemove">Remove User</a> | <a href="#" id="A${single.id}" class="makeAdmin">Make Admin</a></td>
			                    </c:if>
		                    </c:if>
		                    <!-- Last Sign In -->
		                   	<c:if test="${single.lastSignIn == null}">
	                       		<td>Never signed in</td>
		                   	</c:if>
		                   	<c:if test="${single.lastSignIn != null}">
		                       <td><fmt:formatDate pattern = "MMMMM dd, yyyy" value="${user.lastSignIn}"></fmt:formatDate></td>
		                   	</c:if>
		                   	<!-- User Create Date -->
		                   	<td><fmt:formatDate pattern = "MMMMM dd, yyyy" value="${user.createdAt}"></fmt:formatDate></td>
		                 </tr>
	               </c:forEach>
	            </tbody>
	        </table>
        </div>
        <div class="scroll2">
			<table class="table table-ruled">
				<thead>
				  <tr>
				    <th>All Chores</th>
				    <th>Chore Duties</th>
				    <th>Assignee</th>
				    <th>Priority</th>
				    <th>Actions</th>
				  </tr>
				</thead>
				<tbody id="choreBody">
				  <c:forEach items="${chores}" var="chore">
				  <tr>
				  	<td>${chore.title}</td>
				    <td>${chore.description}</td>
				    <td>${chore.assignee.first}</td>
				    <c:if test="${chore.priority == 1 }">
					    <td><c:out value="Low"/></td></c:if>
					    <c:if test="${chore.priority == 2 }">
					    <td><c:out value="Medium"/></td></c:if>
					    <c:if test="${chore.priority == 3 }">
					    <td><c:out value="High"/></td>
				    </c:if>
					<td>
						<a href="#" id="E${chore.id}" class="edit">Edit</a> | <a href="#" id="D${chore.id}" class="delete">  Delete</a>
					</td>
				  </tr>
				  </c:forEach>
			    </tbody>
			</table>
		</div>
		<div class="message">
			<div class="row-fluid">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>
								Message Board
							</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${house.messageBoard.size() == 0}">
							<tr>
								<td colspan="2">No messages</td>
							</tr>
						</c:if>
						<c:if test="${house.messageBoard.size() > 0}">
							<c:forEach items="${house.messageBoard}" var="msg"> 
								<tr>
									<td colspan="2">${msg}</td>
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>
			<div class="row-fluid">
				<form id="newMessage" action="/message" method="post">
					<input type="text" name="message" placeholder="Message" />
					<input type="hidden"  id="csrf" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					<input type="submit" id="send" class="btn btn-primary" value="Post">
				</form>		
			</div>

		</div> 
		
	    <!-- The Modal for creating Chore -->
	    <div id="createModal" class="modal">
		    <!-- Modal content to login -->
		    <div class="modal-content" id="createForm">
		    	<span class="close" id="closeCreate">&times;</span>
		    	<h1 id="modalTitle"></h1>
			    <form:form method="POST" action="/chores/new" modelAttribute="chore" id="newChore"> 
			    	<form:input path="title"/>
			    	<p>Chore<br>
			    	<form:errors path="title" class="text text-danger"/></p>
			       	
			       	<form:input path="description"/>
			        <p>Description<br>
			        <form:errors path="description" class="text text-danger"/> </p>
			     
			     	<form:select path="priority">
							<form:option value="1">Low</form:option>
							<form:option value="2">Medium</form:option>
							<form:option value="3">High</form:option>
					</form:select>
					<p>Priority<br>
					<form:errors path="priority" class="text text-danger"/></p>
					
			       	<form:select path="assignee" >
			            <c:forEach items="${allUsers}" var="x">
			                <form:option value="${x.id}">${x.first}</form:option>
			            </c:forEach>
			        </form:select>
			        <p>Assignee<br>
			        <form:errors path="assignee" class="text text-danger"/></p>
						       
			        <input type="submit" id="submit"/>
			    </form:form>
			</div>
	    </div>
	</div>
</body>
</html>