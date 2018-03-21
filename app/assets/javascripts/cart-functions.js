$( document ).ready(function() {

    $noProductsMessage = $('.no-products-message');
    setupCartFunctions();
    updateRowPrices();
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
    updateRowPrices();
    decrementCartNumber();
}

function setQuantityControls($productRow) {
    var url = $productRow.data('put-path');

    setSumEvents($productRow, url);
    setSubstracEvents($productRow, url);
}

function checkIfListIsEmpty() {
    if ($('.cart-product-row').length == 0)
        $noProductsMessage.show();
    else
        $noProductsMessage.hide();
}

function updateRowPrices() {
    var totalPrice = 0;
    $('.cart-product-row').each(function () {

        var $priceBox = $(this).find('.cart-product-price');
        var rowTotal = getRowProductPrice($priceBox) * getRowQuantity($(this));

        $priceBox.html('$' + rowTotal);
        totalPrice += rowTotal;
    });

    setCheckoutTotal(totalPrice);
}

/**
 * Rows Methods
 */
function setCheckoutTotal(totalPrice) {
    $('.total-sum span').html(totalPrice);
}

/**
 *
 * @param $row
 * @returns {Number}
 */
function getRowQuantity($row) {
    var $quantityTag = $row.find('.quantity-message span');
    return parseInt($quantityTag.text());
}

/**
 *
 * @param quantity
 * @param $row
 */
function setRowQuantity(quantity, $row) {
    var $quantityTag = $row.find('.quantity-message span');
    $quantityTag.text(quantity);
}

/**
 *
 * @param $row
 * @param url
 */
function setSumEvents($row, url) {
    $row.find('.fa-plus-circle').click(function () {
        var quantity = getRowQuantity($row);
        setRowQuantity(++quantity, $row);
        requestProductRow('PUT', url, quantity, updateRowPrices())
    })
}

/**
 *
 * @param $row
 * @param url
 */
function setSubstracEvents($row, url) {
    $row.find('.fa-minus-circle').click(function () {
        var quantity = getRowQuantity($row);
        if (quantity > 1) {
            setRowQuantity(--quantity, $row);
            requestProductRow('PUT', url, quantity, updateRowPrices())
        }
    })
}

/**
 *
 * @param $priceBox
 * @returns {Number}
 */
function getRowProductPrice($priceBox) {
    return $priceBox.data('product-price');
}
