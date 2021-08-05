$(document).ready(function() {
  
    var counter = 0;
    var c = 0;
    var i = setInterval(function(){
        $(".loading-page .counter h1").html(c + "%");
        $(".loading-page .counter hr").css("width", c + "%");
      counter++;
      c++;
        
      if(counter == 101) {
          clearInterval(i);
      }
    }, 2000);
});

    window.onData = function(data) {
      if (data.setDisplay == true) {
        $("#container").css('display', 'flex');
            
      } else {
        $("#container").css('display', 'none');
      }
      
    }


    window.onload = function(e) {
        window.addEventListener('message', function(event) {
            onData(event.data)
        });
    }