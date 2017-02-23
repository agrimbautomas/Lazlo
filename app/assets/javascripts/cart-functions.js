
$(document).on('ready page:load', function (event) {

    setupCartFunctions();
});

function setupCartFunctions() {

    $('.cart-product-row i').each(function(){
        $(this).click(function(){
            console.log(this);


            var productUrl = $(this).parent('.cart-product-row').data('remove-path')

            console.log("productUrl", productUrl);

            $.ajax({
                url: productUrl,
                context: document.body,
                type: 'DELETE',
                data: {
                    quantity: 1
                }
            }).done(function (data) {
                console.log('Done!', data.response);
            });

        });
    });
}
