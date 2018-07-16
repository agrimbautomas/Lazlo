var $noProductsMessage;
var $profileProductsSlider;
var $currentProducRow;
var $sidebar;
var $showSidebarBtn;
var $closeSidebarBtn;

$(document).ready(function () {

	 $noProductsMessage = $('.cart-no-products-message');
	 $profileProductsSlider = $('.profile-products-slider-buttons');

	 setupSidebar();
	 setupCartFunctions();
	 updateRowPrices();
	 setupProfileProductsSlider();
	 checkIfListIsEmpty();
});


/***************************************/
/********* Display Sidebar **********/

/***************************************/
function setupSidebar() {
	 $sidebar = $('aside.sidebar');
	 $showSidebarBtn = $('.logged-cart-button');
	 $closeSidebarBtn = $('.close-sidebar');

	 $showSidebarBtn.click(function (e) {
		  e.preventDefault();
		  showSidebar();
		  showShadowLayer();
	 });

	 $closeSidebarBtn.click(function () {
		  hideSidebar();
		  hideShadowLayer();
	 });
}

function hideSidebar() {
	 $sidebar.animate({
		  right: -($sidebar.outerWidth() + 20)
	 })
}

function showSidebar() {
	 var url = $sidebar.data('prudcts-url');
	 console.log(url);
	 getCollection(url, [], refreshSidebarProducts);
	 $sidebar.animate({
		  right: 0
	 })
}

function refreshSidebarProducts(data) {
	 console.log('refreshSidebarProducts', data);
}

/***************************************/
/********* Slider functions **********/

/***************************************/

function setupProfileProductsSlider() {
	 $('.profile-products-slider').bxSlider({
		  controls: false,
		  infiniteLoop: false,
		  touchEnabled: false,
		  pagerSelector: $profileProductsSlider,
		  buildPager: function (slideIndex) {
				switch (slideIndex) {
					 case 0:
						  return 'FAVORITOS';
					 case 1:
						  return 'CARRITO';
					 case 2:
						  return 'HISTORIAL';
				}
		  }
	 });
}


/***************************************/
/********* Products functions **********/

/***************************************/


function setupCartFunctions() {
	 $('.cart-product-row').each(function () {
		  setupRemoveButton($(this));
		  setQuantityControls($(this));
	 });
}

function setupRemoveButton($productRow) {
	 $productRow.find('i.remove-row').click(function () {
		  var productUrl = $productRow.data('remove-path');
		  $currentProducRow = $productRow;
		  requestProductRow('DELETE', productUrl, 1, removeProductFromCart);
	 });
}

function removeProductFromCart(data) {
	 $currentProducRow.remove();
	 $currentProducRow = null;

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
	 if ($('.cart-product-row').length == 0) {
		  $noProductsMessage.show();
		  $('.user-cart-block').hide();
	 }
}

function updateRowPrices(data) {
	 var totalPrice = 0;
	 $('.cart-product-row').each(function () {

		  var $priceBox = $(this).find('.cart-product-price');
		  var rowTotal = getRowProductPrice($priceBox) * getRowQuantity($(this));


		  $priceBox.html(formatPrice(rowTotal));
		  totalPrice += rowTotal;
	 });

	 setCheckoutTotal(totalPrice);
}

/**
 * Rows Methods
 */
function setCheckoutTotal(totalPrice) {
	 $('.total-sum').html(formatPrice(totalPrice));
}

/**
 *
 * @param $row
 * @returns {Number}
 */
function getRowQuantity($row) {
	 var $quantityTag = $row.find('.quantity-message');
	 return parseInt($quantityTag.text());
}

/**
 *
 * @param quantity
 * @param $row
 */
function setRowQuantity(quantity, $row) {
	 var $quantityTag = $row.find('.quantity-message');
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
		  requestProductRow('PUT', url, quantity, updateRowPrices)
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
				requestProductRow('PUT', url, quantity, updateRowPrices)
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
				callback(data);
	 });
}

function getCollection(url, data, callback) {
	 $.ajax({
		  url: url,
		  context: document.body,
		  type: 'GET'
	 }).done(function (data) {
		  callback(data);
	 });
}