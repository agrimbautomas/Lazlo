
$(document).ready(function(){
    setupSilderCarousel();
});

function setupSilderCarousel(){
    $('.bx-wrapper').bxSlider({
        randomStart: true,
        controls: false,
        mode: 'vertical'
    });
}