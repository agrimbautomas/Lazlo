
$(function () {
	 setupNewOrderForm();
})


/*********************/
/******* ORDER *******/
/*********************/

function setupNewOrderForm() {

    setInitialSelectedValues();
}

function setInitialSelectedValues(){
    $('.order-product-row-product').on('change', function () {

        console.log('Options', $(this));
        $(this).css('display', 'block');
    });


    $('.profile-select.neighborhood-select option:selected').each( function(){
        $(this).css('display', 'block');
    });
}