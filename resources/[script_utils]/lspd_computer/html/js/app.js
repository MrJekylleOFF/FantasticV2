$(document).ready(function(){
	var documentWidth = document.documentElement.clientWidth;
	var documentHeight = document.documentElement.clientHeight;
  
	function triggerClick(x, y) {
		var element = $(document.elementFromPoint(x, y));
		element.focus().click();
		return true;
	}
  
	function OpenAll() {
		$("body").css("display", "block");
		$("#content").css("display", "block");
	}
	function ShowTablet() {
		$("body").css("opacity", "1");
		$("body").css("transition", "opacity 5s");
	}
	function closeAll() {
	  $("body").css("display", "none");
		$("#content").css("display", "none");
	}
	function HideTablet() {
		$("body").css("opacity", "0");
		$("body").css("transition", "opacity 5s");
	}
	window.addEventListener('message', function(event){
	  var item = event.data;
	  if(item.openRedPad == true) {
			OpenAll();
	  }
	  if(item.openRedPad == false) {
			closeAll();
	  }
	});
	document.onkeyup = function (data) {
	  if (data.which == 27 ) {
			$.post('http://orion_computer/close', JSON.stringify({}));
			
	  }
	};
  });
  