$(document).ready(function() {

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

    $(function() {
        $('#landing-slides-container').slidesjs({
            width: 940,
            height: 400,
            navigation: {
                active: false
            }

        });
    });
});