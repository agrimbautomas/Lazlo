jQuery(document).ready(function () {

	 setImagesGallery();
	 setToggleCartBtn();
	 setToggleFavouriteBtn();
	 setProductImagesSlider();
});

/**************************/
/**************************/
/****  Product Detail  ****/
/**************************/
/**************************/

function setImagesGallery() {
	 $("#product-detail-zoom").elevateZoom({
		  gallery: 'product-images-gallery',
		  galleryActiveClass: 'active',
		  zoomType: "inner",
		  responsive: true,
		  cursor: "crosshair",
		  zoomWindowFadeIn: 500,
		  zoomWindowFadeOut: 750
	 });
}

/**************************/
/**************************/
/****  Product Cart ****/
/**************************/
/**************************/

function setToggleCartBtn() {
	 $(".add-to-cart-btn").click(function (e) {
		  e.preventDefault();

		  if ($(this).hasClass('in-cart'))
				removeFromCart($(this));
		  else
				addToCart($(this));

	 })

}

function addToCart($btn) {
	 var url = $btn.attr('href');

	 doAjaxRequest('POST', url, 1, addToCartCallback($btn));
}


function removeFromCart($btn) {

	 var url = $btn.data('rm-href');

	 $.ajax({
		  url: url,
		  context: document.body,
		  type: 'DELETE',
		  data: {
				quantity: 1
		  }
	 }).done(function (data) {
		  if (data.response == 'success')
				removeFromCartCallback($btn);
	 });

}

function addToCartCallback($btn) {
	 incrementCartNumber();
	 addToCartStyles($btn);
}

function removeFromCartCallback($btn) {
	 decrementCartNumber();
	 removeFromCartStyles($btn);
}


function addToCartStyles($btn) {
	 $btn.addClass('in-cart').removeClass('transparent-button').html('Guardado en el Carrito!');
}

function removeFromCartStyles($btn) {
	 $btn.removeClass('in-cart').addClass('transparent-button').html('Agregar al Carrito');
}


/**************************/
/**************************/
/*** Product Favourites ***/
/**************************/
/**************************/

function setToggleFavouriteBtn() {
	 $(".add-to-fav-btn").click(function (e) {
		  e.preventDefault();

		  if ($(this).hasClass('in-fav'))
				removeFromFav($(this));
		  else
				addToFav($(this));
	 })

}

function addToFav($btn) {
	 var url = $btn.attr('href');
	 doAjaxRequest('POST', url, 1, addToFavCallback($btn));
}


function removeFromFav($btn) {
	 var url = $btn.data('rm-href');
	 doAjaxRequest('DELETE', url, 1, removeFromFavCallback($btn));
}

function addToFavCallback($btn) {
	 addToFavStyles($btn);
	 sumFavCount($btn);
}

function removeFromFavCallback($btn) {
	 removeFromFavStyles($btn);
	 substractFavCount();
}


function addToFavStyles($btn) {
	 $btn.addClass('in-fav');
}

function getFavCount() {
	 return parseInt($('.fav-count-number').html());
}

function sumFavCount() {
	 $('.fav-count-number').html(getFavCount() + 1);
}

function substractFavCount() {
	 $('.fav-count-number').html(getFavCount() - 1);
}

function removeFromFavStyles($btn) {
	 $btn.removeClass('in-fav');
}


/**************************/
/**************************/
/**** Products Slider *****/
/**************************/
/**************************/

function setProductImagesSlider() {
	 $('.product-images-gallery').slick({
		  infinite: true,
		  slidesToShow: 3,
		  slidesToScroll: 3,
		  responsive: [{
				breakpoint: 900,
				settings: {
					 slidesToShow: 2,
					 slidesToScroll: 2
				}
		  }]
	 });
}

/**************************/
/**************************/
/*****  AJAX Methods *****/
/**************************/
/**************************/

function doAjaxRequest(method, url, quantity, callback) {

	 $.ajax({
		  url: url,
		  context: document.body,
		  type: method,
		  data: {
				quantity: quantity
		  }
	 }).done(function (data) {
		  if (data.response == 'success')
				callback;
	 });
}