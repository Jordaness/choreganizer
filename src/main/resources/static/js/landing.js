$(document).ready(function(){
		//Turn on the Sunrise JS
		eventStart();
		
		// Get the modal
	    var modal = document.getElementById("myModal");
		
		 // Get the second modal
	    var modal2 = document.getElementById("myModal2");
	
	    // When the user clicks the login button, opens the modal and stops the Sunrise JS
	    $("#myBtn").click(function(e) {
	        $(modal).show()
	        $(modal2).hide();
	        $("#loginEmail").focus();
	        e.stopPropagation();
	        eventStop();
	        e.preventDefault();
	    });
	    
	    // When the user clicks the register button, opens the modal and stops the Sunrise JS
	    $("#myBtnTwo").click(function(e) {
	        $(modal2).show();
	        $(modal).hide();
	        $("#email").focus();
	        e.stopPropagation();
	        eventStop();
	        e.preventDefault();
	    });
	
	    //closes alert boxes
	    $("#logout").click(function(e) {
	    	$(".alert").hide();
	    	e.stopPropagation();
	    });
	    $("#logError").click(function(e) {
	    	$(".alert").hide();
	    	e.stopPropagation();
	    });
	    $("#regError").click(function(e) {
	    	$(".alert").hide();
	            	e.stopPropagation();
	            });
	   
	   // When the user clicks on <span> (x), close the modal
	    $("#closeLogin").click(function() {
	    	$(modal).hide();
	    	eventStart();
	    });
	    
	    $("#closeReg").click(function() {
	    	$(modal2).hide();
	    	eventStart();
	    });
	
	    // When the user clicks anywhere outside of the modal, close it
	    $(document).click(function(event) {
	        if ( $('#logForm').has(event.target).length == 0 && modal.style.display == 'block' ) {
	        	$(modal).hide();
	        	eventStart();
	        }
	    	if ( $('#regForm').has(event.target).length == 0 && modal2.style.display == 'block' ) {
	        	$(modal2).hide();
	        	eventStart();
	        }
	    });
});