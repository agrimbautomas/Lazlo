$( document ).ready(function() {

    setImagesGallery();
    setToggleCartBtn();
    setProductImagesSlider();
});

/**************************/
/**************************/
/** Products Categories  **/
/**************************/
/**************************/


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

function setToggleCartBtn() {
    $(".add-to-cart-btn").click(function (e) {
        e.preventDefault();

        if ($(this).hasClass('in_cart'))
            removeFromCart($(this));
        else
            addToCart($(this));

    })

}

function addToCart($btn) {
    var url = $btn.attr('href');

    requestProductRow('POST', url, 1, addToCartCallback($btn));
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

function addToCartCallback($btn){
    incrementCartNumber();
    addToCartStyles($btn);
}

function removeFromCartCallback($btn){
    decrementCartNumber();
    removeFromCartStyles($btn);
}


function addToCartStyles($btn) {
    $btn.addClass('in_cart').addClass('green-button')
        .removeClass('transparent-button').html('Guardado en el Carrito!');
}

function removeFromCartStyles($btn) {
    $btn.removeClass('in_cart').removeClass('green-button')
        .addClass('transparent-button').html('Agregar al Carrito');
}



/**************************/
/**************************/
/**** Products Slider *****/
/**************************/
/**************************/

function setProductImagesSlider(){
	 $('.product-images-gallery').slick({
		  infinite: true,
		  slidesToShow: 3,
		  slidesToScroll: 3,
		  width: '32%'
	 });
}

/**************************/
/**************************/
/*****  AJAX Methods *****/
/**************************/
/**************************/

function requestProductRow(method, url, quantity, callback) {

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