$(document).on('ready page:load', function (event) {

    $noProductsMessage = $('.no-products-message');
    setupCartFunctions();

    updateTotalPrice();
});

function setupCartFunctions() {

    $('.cart-product-row i').each(function () {
        $(this).click(function () {
            var productUrl = $(this).parent('.cart-product-row').data('remove-path')
            var $row = $(this).parent('.cart-product-row');
            $.ajax({
                url: productUrl,
                context: document.body,
                type: 'DELETE',
                data: {
                    quantity: 1
                }
            }).done(function (data) {
                if (data.response == 'success')
                    $row.remove();
                checkIfListIsEmpty();
                updateTotalPrice();
            });

        });
    });
}


function setQuantityControls() {
    $('.cart-product-row').each(function () {
        $(this).children('.fa-plus-circle').click(function () {
            //TODO
        })
        $(this).children('.fa-minus-circle')
    })
}

function checkIfListIsEmpty() {
    if ($('.cart-product-row').length == 0)
        $noProductsMessage.show();
    else
        $noProductsMessage.hide();
}

function updateTotalPrice() {
    $('.total-sum span').html(getCheckoutTotal());
}

function getCheckoutTotal() {
    var totalPrice = 0;
    $('.cart-product-row').each(function () {
        totalPrice += getPriceByRow($(this));
    })

    return totalPrice;
}

function getPriceByRow($row) {
    var strPrice = $row.children('.cart-product-price').html();
    return parseInt(strPrice.replace('$', ''));
}