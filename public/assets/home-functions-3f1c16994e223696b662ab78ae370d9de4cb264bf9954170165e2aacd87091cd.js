$(document).ready(function() {

    console.log("alohja");

    $('#slider-container').fullpage({

        scrollBar: true,
        paddingTop: '45px',


        //Navigation
        //menu: '#sidebar-nav',
        anchors: ['productos', 'ajedrez', 'mesas', 'caballos', 'relojes', 'contacto'],
        menu: '#sidebar-nav',

        //Custom selectors
        sectionSelector: '.slider-block',
        slideSelector: '.slide',
    });
});
