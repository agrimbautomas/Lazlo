var $cartProductsNumber;
var cartNumberValue;

$(document).on('ready page:load', function (event) {

    $cartProductsNumber = $('.notification-number');
    cartNumberValue = parseInt($cartProductsNumber.html());

});

function incrementCartNumber() {
    $cartProductsNumber.html(++cartNumberValue);
}
function decrementCartNumber() {
    $cartProductsNumber.html(--cartNumberValue);
}