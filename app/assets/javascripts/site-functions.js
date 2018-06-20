var didScroll;
var lastScrollTop = 0;
var delta = 5;


var $contactForm;


jQuery(document).ready(function () {
    setUpHeaderToggleOnScroll();

    setupVars();
    setupContactForm();
    setupAlertButtons();
});

// Header Scroll functions
function setUpHeaderToggleOnScroll() {

    $(window).scroll(function (event) {
        didScroll = true;
    });

    setInterval(function () {
        if (didScroll) {
            hasScrolled();
            didScroll = false;
        }
    }, 250);

}

function hasScrolled() {
    var st = $(this).scrollTop();
    var navbarHeight = $('header').outerHeight();

    if (Math.abs(lastScrollTop - st) <= delta)
        return;

    if (st > lastScrollTop && st > navbarHeight) {
        $('header').removeClass('nav-down').addClass('nav-up');
    } else {
        if (st + $(window).height() < $(document).height())
            $('header').removeClass('nav-up').addClass('nav-down');
    }

    lastScrollTop = st;
}


function setupVars() {
    $contactForm = $('.contact-form')
}

function setupContactForm() {
    $('.contact-form-button').each(function () {
        $(this).click(function () {
            showContactForm();
        })
    })

    $('.close-contact-form, .contact-form').click(function () {
        hideContactForm();
    })

    $('.contact-form-inner').click(function (e) {
        e.stopPropagation();
    })
}


function showContactForm() {
    $contactForm.show().animate({
        opacity: 1
    }, 300);
}

function hideContactForm() {
    $contactForm.animate({
        opacity: 0
    }, 300, function () {
        $(this).hide()
    });
}

function setupAlertButtons() {
    $('.notification-bar .close-notification-bar').each(function () {
        $(this).click(function () {
            $(this).parent().hide();
        });
    });
}

