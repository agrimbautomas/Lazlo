var didScroll;
var lastScrollTop = 0;
var delta = 5;

var $shadowLayer;
var $contactForm;
var $chatButton;
var $chatWidget;
var $productsMenuBtn;
var $productsSubMenu;
var $header;

jQuery(document).ready(function () {
    setUpHeaderToggleOnScroll();

    setupVars();
    setupToggleMenu();
    setupShadows();
    setupContactForm();
    setupAlertButtons();
    setupToggleChat();
});


function setupVars() {
    $shadowLayer = $('.shadow-layer');
    $contactForm = $('.contact-form');
    $chatButton = $('.chat-button');
    $chatWidget = $('.chat-widget');
    $productsMenuBtn = $('.products-menu-button');
    $productsSubMenu = $('.products-sub-menu');
    $header = $('header');
}

/*
 *
 * Menu functions
 *
 */
function setupToggleMenu() {
    $productsMenuBtn.click(function () {
        if ($productsSubMenu.hasClass('displayed'))
            hideProductsSubMenu();
        else
            displayProductsSubMenu();
    })
}

function displayProductsSubMenu() {
    $productsSubMenu.addClass('displayed');
    $productsSubMenu.show();
}

function hideProductsSubMenu() {
    $productsSubMenu.removeClass('displayed');
    $productsSubMenu.hide();
}

function showHeader() {
    $header.removeClass('nav-up').addClass('nav-down');
}

function hideHeader() {
    $header.removeClass('nav-down').addClass('nav-up');
}

/*
 *
 * Chat functions
 *
 */
function setupToggleChat() {
    $chatButton.click(function () {
        if ($chatWidget.hasClass('displayed'))
            hideChat();
        else
            displayChat()
    });
}

function displayChat() {

    $chatWidget.addClass('displayed');
    $('.display-on-chat').animate({
        opacity: 1
    }, 100);

}

function hideChat() {

    $('.display-on-chat').animate({
        opacity: 0
    }, 100, function () {
        $chatWidget.removeClass('displayed');
    });
}

/*
 *
 * Header Scroll functions
 *
 */
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
        hideHeader();
        hideProductsSubMenu();
    } else if (st + $(window).height() < $(document).height())
        showHeader();


    lastScrollTop = st;
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
    showShadowLayer();
    $contactForm.show().animate({
        opacity: 1
    }, 300);
}

function hideContactForm() {
    hideShadowLayer();
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


/*
 *
 * Shadow Layer
 *
 */

function showShadowLayer() {
    $shadowLayer.show().animate({
        opacity: 1
    }, 300);
}

function hideShadowLayer() {
    $shadowLayer.animate({
        opacity: 0
    }, 300, function () {
        $(this).hide()
    });
}

function setupShadows() {
    $shadowLayer.click(function () {
        hideSidebar();
        hideContactForm();
    })
}
/*
 *
 * Helpers
 *
 */
function formatPrice(nStr) {
    nStr += '';
    x = nStr.split('.');
    x1 = x[0];
    x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1))
        x1 = x1.replace(rgx, '$1' + '.' + '$2');

    return '$' + x1 + x2;
}