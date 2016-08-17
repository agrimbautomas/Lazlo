var win;
var elementsHeight;

$(document).on('ready page:load', function (event) {

    setupResize();
    adjustStyles();
});



function setupResize() {
    win = $(this); //this = window

    $(window).on('resize', function () {
        adjustStyles();
    });
}

function adjustStyles() {
    elementsHeight = $('.icons').height() + $('.header').height() + $('.arrow').height() + 40; //40 for margins


    $('.landing-slides-container').css('height', win.height() - elementsHeight);

    //If is not mobile
    if (win.width() > 700) {

        $('.image-container img').css({
            height: win.height() / 1.4,
            width: 'auto'
        });
        $('.arrow a').css({
            height: win.height() / 12,
            width: win.height() / 12
        });

        $('h3').css({
            'font-size': win.height() / 30
        });

        $('h4').css({
            'font-size': win.height() / 40
        });

        $('h5').css({
            'font-size': win.height() / 65
        });

        $('.nav-icon img').css({
            height: win.height() / 25
        });

    }
}


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