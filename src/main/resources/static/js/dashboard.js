$(document).ready(function(){
	// Get User Data
	var userId = $(".userId").attr("id").slice(1);
	$(".userId").remove();
	var houseId = $(".houseId").attr("id").slice(1);
	$(".houseId").remove();
	
	// Target the modal
    var modal = document.getElementById("createModal");
	
    // When the user clicks the create button, open the modal
    $("#create").click(function(ev) {
        $("#modalTitle").html("Create Chore");
        $("#newChore").attr("action", "/chores/new");
        $("#title").val("");
		$("#description").val("");
		$("#priority").val("");
		$("#assignee").val("");
        $('#submit').val("Create");
    	$(modal).show();
        $("#title").focus();
        ev.stopPropagation();
    });
       
    // When the user clicks on <span> (x), close the modal
    $("#closeCreate").click(function(ev) {
    	$(modal).hide();
    	ev.stopPropagation();
    });
    
    $("#choreError").click(function(ev) {
    	$(".alert").hide();
    	ev.stopPropagation();
    });

    // When the user clicks anywhere outside of the modal, close it
    $(document).click(function(ev) {
        if ( $("#createForm").has(ev.target).length == 0 && modal.style.display == "block" ) {
        	$(modal).hide();
        	ev.stopPropagation();
        }
    });
    
    // Delete User
    $(".userDelete").click(function (ev) {
    	var id = $(this).attr("id").slice(1);
    	var csrf = $("#csrf").val();
    	$.post("/admin/delete/" + id, { "_csrf": csrf });
    	//if super user reload otherwise get all the user info
    	if($(this).attr("id")[0] === 'D'){
    		location.reload();
    	} else{
	    	setTimeout(function() {
		    	$.get("/home/users/"+houseId, function(users) {
		    		fillUsers(users);
		    	});
	    	}, 200);
    	}
    	ev.preventDefault();
    });
    
    //Remove
	$(".userRemove").click(function (ev) {
		var id = $(this).attr("id").slice(1);
		var csrf = $("#csrf").val();
		$.post("/admin/remove/" + id, { "_csrf": csrf });
		//if super user reload otherwise get all the user info
		if($(this).attr("id")[0] === 'D'){
			location.reload();
		} else{
	    	setTimeout(function() {
		    	$.get("/home/users/"+houseId, function(users) {
		    		fillUsers(users);
		    	});
	    	}, 200);
		}
		ev.preventDefault();
	});
    
    // Make Admin
    $(".makeAdmin").click(function (ev) {
    	var id = $(this).attr("id").slice(1);
    	var csrf = $("#csrf").val();
    	$.post("/admin/make-admin/" + id, { "_csrf": csrf });
    	//if super user reload otherwise get all the user info
    	if($(this).attr("id")[0] === 'S'){
    		location.reload();
    	} else{
	    	setTimeout(function() {
		    	$.get("/home/users/"+houseId, function(users) {
		    		fillUsers(users);
		    	});
	    	}, 200);
    	}
    	ev.preventDefault();
    });
    
    // Take Admin
    $(".takeAdmin").click(function(ev) {
    	var id = $(this).attr("id").slice(1);
    	var csrf = $("#csrf").val();
    	$.post("/admin/take-admin/" + id, { "_csrf": csrf });
    	//if super user reload otherwise get all the user info
    	if($(this).attr("id")[0] === 'S'){
    		location.reload();
    	} else{
	    	setTimeout(function() {
		    	$.get("/home/users/"+houseId, function(users) {
		    		fillUsers(users);
		    	});
	    	}, 200);
    	}
    	ev.preventDefault();
    });
    
    // Edit Chore
    $(".edit").click(function(ev) {
    	fillModal($(this).attr("id").slice(1));
    	ev.preventDefault();
    });
    
    // Delete Chore
    $(".delete").click(function(ev) {
    	var id = $(this).attr("id").slice(1);
    	var csrf = $("#csrf").val();
    	$.post("/chores/" + id + "/delete", { "_csrf": csrf });
    	//refresh chores
    	setTimeout(function(){
    		$.get("/home/chores/"+houseId, function(chores) {
    			fillChores(chores);
    		})
    	}, 200);
    	
    	ev.preventDefault();
    });
    
    // fill the modal with selected chore info
    function fillModal(id){
    	$("#modalTitle").html("Edit Chore");
    	$.get("/chores/"+ id, function(chore) {
 			$("#newChore").attr("action", "/chores/"+ id +"/edit");
 			$("#title").val(chore.title);
 			$("#description").val(chore.description);
 			$("#priority").val(chore.priority);
 			$("#assignee").val(chore.assignee.id);
 			$('#submit').val("Edit");
 			$(modal).show();
    	}); 
    }
    
    // fills the chores table
    function fillChores(chores) {
    	var html = "";
    	for(var chore of chores) {
    		html += "<tr><td>"+chore.title+"</td>"
    		html +=	"<td>"+chore.description+"</td>"
    		html += "<td>"+chore.assignee.first+"</td>"
    		switch(chore.priority){
	    		case 1:
	    			html += "<td>Low</td>"
	    			break;
	    		case 2:
	    			html += "<td>Medium</td>"
	    			break;
	    		case 3:
	    			html += "<td>High</td>"
	    			break;
    		}
    		html += "<td><a href='#' id='E" + chore.id + "' class='edit'>Edit</a> | <a href='#' id='D" + chore.id + "' class='delete'>  Delete</a></td></tr>"	
    	}
    	$("#choreBody").html(html);
    }
    
    // fills the users table
    function fillUsers(users) {
    	var html = "";
    	for(var user of users) {
    		html += "<tr><td>"+user.first + " " + user.last+"</td>"
    		html += "<td>"+user.phone+"</td>"
    		switch(user.roles.length){
    			case 4,3:
    				//super admin
    				html += "<td>Manager</td>"
    				break;
    			case 2:
    				//admin
    				html += "<td>Admin</td>"
    				break;
    			case 1:
    				html += "<td><a href='#' id='D"+user.id+"' class='userRemove'>Remove User</a> | <a href='#' id='A"+user.id+"' class='makeAdmin'>Make Admin</a></td>"
    				break;
    		}
    		if(user.lastSignIn == null){
    			html += "<td>Never Signed In</td>"
    		} else {
    			var date = new Date(user.lastSignIn)
    			html += "<td>"+date.format("mmmm dd, yyyy")+"</td>"
    		}
    		date = new Date(user.createdAt)
    		html += "<td>"+date.format("mmmm dd, yyyy")+"</td></tr>"	
    	}
    	$("#userBody").html(html);
    }
    
 });