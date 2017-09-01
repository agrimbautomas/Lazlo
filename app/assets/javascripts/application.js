//= require_tree .
//= require jquery
//= require jquery_ujs
// require turbolinks Avoid turbo links since images dont show properly

var $contactForm;

$(document).on('ready page:load', function (event) {

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
        $('.notification-bar i.fa').each(function () {
            $(this).click(function () {
                $(this).parent().hide();
            });
        });
    }

});

