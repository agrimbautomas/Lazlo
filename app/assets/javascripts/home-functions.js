var win;
var elementsHeight;

$(document).on('ready page:load', function (event) {

});




// To hide navigation bar
window.addEventListener("load", function () {
    // Set a timeout...
    setTimeout(function () {
        // Hide the address bar!
        window.scrollTo(0, 1);
    }, 0);
});


/** New Home Functions **/
$(document).ready(function () {


    $('.contacto').click(function () {
        $('.pre-contact').show();
        $('.pre-contact').animate({
            opacity: 1
        });
    });


    $(document).keyup(function(e) {
        if (e.keyCode == 27) { // escape key maps to keycode `27`
            $('.pre-contact').animate({
                opacity: 0
            }, 300, function(){ $(this).hide() });
        }
    });




    $('.pre-contact .contact input').focus(function () {
        $(this).css('border', '3px dimgrey solid');
    });


    $('.pre-contact .contact input').blur(function () {
        $(this).css('border', '2px #2ca0a0 solid;');
    });



    $('.pre-contact .contact textarea').focus(function () {
        $(this).css('border', '3px dimgrey solid');
    });


    $('.pre-contact .contact textarea').blur(function () {
        $(this).css('border', '2px #2ca0a0 solid;');
    });

});