$(function() {

    window.addEventListener('message', function(event) {
        
        var item = event.data;
        var choise = item.status;

        if (item.type === "FantasticLogo"){
            if (choise === true) { 
                $('#div').css('display', 'block')
        }   else if (choise === false){
                $('#div').css('display', 'none')
            }           
        }               
    });
})


