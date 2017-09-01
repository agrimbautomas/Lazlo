$(function () {
	 setupNewOrderForm();
})


/*********************/
/******* ORDER *******/
/*********************/

function setupNewOrderForm() {

	 setInitialSelectedValues();
	 toggleBuyerUserValues();
}


/******* Products Rows *********/

function setInitialSelectedValues() {
	 $('body').on('change', 'select.order-product-row-product', function (e) {
		  setInputValues($(this))
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
}



/******* Buyer/User *********/

function toggleBuyerUserValues() {

}