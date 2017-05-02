$(document).on('ready page:load', function (event) {

    $noProductsMessage = $('.no-products-message');
    setupCartFunctions();

    updateTotalPrice();
});

function setupCartFunctions() {
    $('.cart-product-row').each(function () {
        setupRemoveButton($(this));
        setQuantityControls($(this));
    });
}

function setupRemoveButton($productRow) {
    $productRow.children('i.remove-row').click(function () {
        var productUrl = $productRow.data('remove-path');

        $.ajax({
            url: productUrl,
            context: document.body,
            type: 'DELETE',
            data: {
                quantity: 1
            }
        }).done(function (data) {
            if (data.response == 'success')
                removeProductFromCart($productRow)
        });

    });
}

function removeProductFromCart($productRow) {
    $productRow.remove();
    checkIfListIsEmpty();
    updateTotalPrice();
    decrementCartNumber();
}

function setQuantityControls($productRow) {
    var url = $productRow.data('put-path');
    var $quantityTag = $productRow.find('.quantity-message span');
    var $priceBox = $productRow.find('.cart-product-price');

    $productRow.find('.fa-plus-circle').click(function () {
        //Todo - Refactorize
        quantity = parseInt($quantityTag.text());
        $quantityTag.text(++quantity);
        updateRowPrice($priceBox, quantity);
        requestProductRow('PUT', url, quantity, updateTotalPrice())
    })
    $productRow.find('.fa-minus-circle').click(function () {
        //Todo - Bug in here whe substract
        //Todo - Refactorize
        quantity = parseInt($quantityTag.text());
        if (quantity > 1) {
            $quantityTag.text(--quantity);
            requestProductRow('PUT', url, quantity, updateTotalPrice())
        }
        updateRowPrice($priceBox, quantity);
    })

}

function updateRowPrice($priceBox, quantity) {
    var productPrice = $priceBox.data('product-price');
    $priceBox.html('$' + productPrice * quantity);
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