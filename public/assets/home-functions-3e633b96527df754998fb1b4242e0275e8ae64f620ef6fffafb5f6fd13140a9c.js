$(document).ready(function () {

    setupPager();
    setupSlider();
    setupResize();

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

        //Custom selectors
        sectionSelector: '.slider-block'
    });
}

function setupSlider() {
    $(function () {
        //$('#landing-slides-container').slidesjs({

    });
}

function setupResize() {
    var win = $(this); //this = window

    $(window).on('resize', function () {

        console.log("Window Height: ", win.height());
        console.log("Window Width: ", win.width());
        $('.slide-img-container').css('height', win.height() / 1.9);

        if (win.height() >= 820) {

        }
        if (win.width() >= 1280) {
        }
    });
}

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
