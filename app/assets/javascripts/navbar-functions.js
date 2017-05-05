var $cartProductsNumber;
var cartNumberValue;

$(document).on('ready page:load', function (event) {

    $cartProductsNumber = $('.notification-number');
    setCartCounters();
});

function setCartCounters(){
    cartNumberValue = parseInt($cartProductsNumber.html());
    hideIfEmpty();
}

function incrementCartNumber() {
    $cartProductsNumber.html(++cartNumberValue);
    displayIfUsed();
}
function decrementCartNumber() {
    $cartProductsNumber.html(--cartNumberValue);
    hideIfEmpty();
}

function hideIfEmpty(){
    if (cartNumberValue == 0)
        $cartProductsNumber.hide();
}
function displayIfUsed(){
    if (cartNumberValue != 0)
        $cartProductsNumber.show();
}