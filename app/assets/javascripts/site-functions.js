var didScroll;
var lastScrollTop = 0;
var delta = 5;

var $contactForm;
var $chatButton;
var $chatWidget;


jQuery(document).ready(function () {
	 setUpHeaderToggleOnScroll();

	 setupVars();
	 setupContactForm();
	 setupAlertButtons();
	 setupToggleChat();
});


function setupVars() {
	 $contactForm = $('.contact-form');
	 $chatButton = $('.chat-button');
	 $chatWidget = $('.chat-widget');
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
		  $('header').removeClass('nav-down').addClass('nav-up');
	 } else {
		  if (st + $(window).height() < $(document).height())
				$('header').removeClass('nav-up').addClass('nav-down');
	 }

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