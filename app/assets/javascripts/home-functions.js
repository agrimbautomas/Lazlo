var win;
var elementsHeight;

$(document).on('ready page:load', function(event) {

    setupPager();
    setupSlider();
    setupResize();
    adjustStyles();

});

function setupPager() {
    $('#slider-container').fullpage({

        scrollBar: true,
        paddingTop: '45px',

        //Navigation
        //menu: '#sidebar-nav',
        anchors: ['productos', 'ajedrez', 'mesas', 'caballos', 'relojes', 'contacto'],
        menu: '#sidebar-nav',

        //Slides
        slidesNavigation: true,
        fitToSection: true,
        //Custom selectors
        sectionSelector: '.slider-block'
    });
}

function setupSlider() {
    $('.landing-slides-container .slide-home').each(function () {
        $(this).click(function () {
        });
    })

    $('.landing-slides-container .slide-home:first-child').addClass('active')

}


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
