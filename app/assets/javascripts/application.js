//= require_tree .
//= require jquery3
//= require jquery_ujs
// require turbolinks Avoid turbo links since images dont show properly

var $contactForm;
$( document ).ready(function(){

    setupVars();
    setupContactForm();
    setupAlertButtons();


    function setupVars() {
        $contactForm = $('.contact-form')
    }

    function setupContactForm() {
        $('.contact-form-button').each(function () {
            $(this).click(function () {
                showContactForm();
            })
        })

        $('.close-contact-form').click(function () {
            hideContactForm();
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

});

