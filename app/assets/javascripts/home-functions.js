
$(document).ready(function(){
    setupSilderCarousel();
});

function setupSilderCarousel(){
    $('.home-slider').bxSlider({
        randomStart: true,
        controls: false,
        mode: 'vertical'
    });
}