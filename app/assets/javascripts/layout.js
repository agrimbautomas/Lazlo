var didScroll;
var lastScrollTop = 0;
var delta = 5;

jQuery(document).ready(function () {
	 setUpHeaderToggleOnScroll();
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
