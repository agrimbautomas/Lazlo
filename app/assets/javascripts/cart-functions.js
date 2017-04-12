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
                $productRow.remove();
            checkIfListIsEmpty();
            updateTotalPrice();
        });

    });
}


function setQuantityControls($productRow) {
    var url = $productRow.data('put-path');
    var $quantityTag = $productRow.find('.quantity-message span');

    $productRow.find('.fa-plus-circle').click(function () {
        //Todo - Check this URL is not working
        quantity = parseInt($quantityTag.text());
        $quantityTag.text(++quantity);
        requestProductRow('PUT', url, 8, updateTotalPrice())
    })
    $productRow.find('.fa-minus-circle').click(function () {
        //Todo - Check this URL is not working
        quantity = parseInt($quantityTag.text());
        if (quantity > 1) {
            $quantityTag.text(--quantity);
            requestProductRow('PUT', url, 8, updateTotalPrice())
        }
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