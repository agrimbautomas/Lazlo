var win;
var elementsHeight;

$(document).ready(function () {

    setupPager();
    setupSlider();
    setupResize();
    adjustStyles();

    papin();
    foca();
    siranush();
    salchipapa();

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


function papin() {
    var keys = [];
    var konami = '80,65,80,73,78';

    $(document).keydown(function (e) {

        keys.push(e.keyCode);
        if (keys.toString().indexOf(konami) >= 0) {
            playAudio();
            keys = [];
        }
    });
}

function foca() {
    var keys = [];
    var konami = '70,79,67,65';

    $(document).keydown(function (e) {

        keys.push(e.keyCode);
        if (keys.toString().indexOf(konami) >= 0) {
            playAudio();
            keys = [];
        }
    });
}

function siranush() {
    var keys = [];
    var konami = '83, 73, 82, 65, 78, 85, 83, 72';

    $(document).keydown(function (e) {

        keys.push(e.keyCode);
        if (keys.toString().indexOf(konami) >= 0) {
            playAudio();
            keys = [];
        }
    });
}

function salchipapa() {
    var keys = [];
    var konami = '83,65,76,67,72,73,80,65,80,65';

    $(document).keydown(function (e) {

        keys.push(e.keyCode);
        if (keys.toString().indexOf(konami) >= 0) {
            playAudio();
            keys = [];
        }
    });
}

function playAudio() {
    document.getElementById('audio-up').play();
}
