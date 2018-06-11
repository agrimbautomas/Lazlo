$(function () {
    setupNewOrderForm();
})


/*********************/
/******* ORDER *******/
/*********************/

function setupNewOrderForm() {

    setInitialSelectedValues();
    toggleBuyerUserValues();
    displayListIfSelected();
    calculateTotalPrice();
}

/******* Products Rows *********/

function setInitialSelectedValues() {
    $('body').on('change',
        'select.order-product-row-product',
        function (e) {
            setInputValues($(this));
        });

    $('body').on('change',
        'input.order-product-row-product-quantity, input.order-product-row-product-price',
        function (e) {
            updateManualProductTotalPrice($(this));
        });
}

function setInputValues($selectInput) {
    var $rowsParentContainer = $selectInput.offsetParent('ol');
    var $selectedOption = $rowsParentContainer.find('option:selected');

    setProductName($selectedOption, $rowsParentContainer);
    setProductPrice($selectedOption, $rowsParentContainer);

}

function setProductName($selectedOption, $rowsParentContainer) {
    var productName = $selectedOption.html();
    var $productNameInput = $rowsParentContainer.find('.order-product-row-product-name');
    $productNameInput.val(productName);
}

function setProductPrice($selectedOption, $rowsParentContainer) {
    var productPrice = $selectedOption.attr('price');
    var $productPriceInput = $rowsParentContainer.find('.order-product-row-product-price');
    $productPriceInput.val(productPrice);

    updateProductTotalPrice($rowsParentContainer, productPrice);
}


function updateManualProductTotalPrice($selectInput) {
    var $rowsParentContainer = $selectInput.offsetParent('ol');
    var $productPriceInput = $rowsParentContainer.find('.order-product-row-product-price');

    updateProductTotalPrice($rowsParentContainer, $productPriceInput.val());
}

function updateProductTotalPrice($rowsParentContainer, productPrice) {
    var $productPriceInput = $rowsParentContainer.find('.order-product-row-product-quantity');
    var totalPrice = $productPriceInput.val() * productPrice;
    $rowsParentContainer.find('.total-row-price span').html(totalPrice);

    console.log('Quantity: ', totalPrice);

    $('#closeButton').on('click',function() {
        $(this).parent().remove();
        return false;
    });
}

function calculateTotalPrice() {
    //console.log('Total price');
}

/******* Buyer/User *********/

function toggleBuyerUserValues() {

    $('#order_code_input .choice input[type=radio]').change(function () {
        displayChosenOption(this.value);
    })
}

function displayChosenOption(chosenOption) {
    if (chosenOption == 'buyer')
        displayListByName('buyer', 'user');
    else if (chosenOption == 'user')
        displayListByName('user', 'buyer');

}

function displayListByName(nameToShow, nameToHide) {
    $('#order_' + nameToShow + '_input').show();
    $('#order_' + nameToHide + '_input').hide();
    $('#order_' + nameToHide + '_input select option:selected').removeAttr("selected");
}

function displayListIfSelected() {
    if ($('#order_user_input select option:selected').val() != '')
        displayListByName('user', 'buyer');
    else
        displayListByName('buyer', 'user');
}

