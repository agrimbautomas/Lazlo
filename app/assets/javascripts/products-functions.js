var $productsContainer, containerWidth, smallBoxesWidth, bigBoxesWidth;

var counter = 0;
var topPointer = 0;
var leftPointer = 0;
var goToTop = false;
var doubleRowCounter = 0;
var randomNum, featuredBoxIndexes, featuredBoxDisplayed;

$(document).on('ready page:load', function(event) {

    setupResponsiveBoxes();
  //  setProductQuantity();

    setImagesGallery();
});

function setupResponsiveBoxes() {
    $productsContainer = $('.products-box-container .inner-container');
    containerWidth = $productsContainer.width();

    setSmallBoxes();
    setBigBoxes();
    setPositions();
    setBoxesContainer();
}

function setBoxesContainer() {
    var doubleRowsCount = Math.ceil($('.product-box').length / 7);
    var containerHeight = doubleRowsCount * bigBoxesWidth;

    $productsContainer.height(containerHeight)
}

function setSmallBoxes() {
    smallBoxesWidth = containerWidth / 5;
    $('.small-box').css({
        width: smallBoxesWidth,
        height: smallBoxesWidth
    });
}

function setBigBoxes() {
    bigBoxesWidth = smallBoxesWidth * 2;
    $('.big-box').css({
        width: bigBoxesWidth,
        height: bigBoxesWidth
    });
}

function setPositions() {

    counter = 0;
    doubleRowCounter = 0;
    goToTop = false;
    topPointer = 0;
    leftPointer = 0;
    featuredBoxDisplayed = false;

    featuredBoxIndexes = [1,3,5,7];
    randomNum = Math.floor(Math.random() * featuredBoxIndexes.length) + 0;

    $('.product-box').each(function () {
        counter++;

        if ((counter % featuredBoxIndexes[randomNum] == 0) && !featuredBoxDisplayed) {
            $(this).setBigBox();
            featuredBoxDisplayed = true;
        } else {
            $(this).setSmallBox();
        }


        //Set Values for next loop
        if (goToTop) {
            if (!featuredBoxDisplayed) {
                if (counter % 2 == 0)
                    leftPointer += smallBoxesWidth;
            }

            if (featuredBoxDisplayed && !$(this).hasClass('big-box')) {
                if (counter % 2 != 0 )
                    leftPointer += smallBoxesWidth;
            }
        }

        resetValues();

        topPointer = (goToTop) ? topPointerPosition() : (topPointer + smallBoxesWidth);
    });
}

function resetValues(){

    if ( counter % 7 == 0) {

        leftPointer = 0;
        counter = 0;
        doubleRowCounter++;
        featuredBoxDisplayed = false;
        randomNum = Math.floor(Math.random() * featuredBoxIndexes.length) + 0;
    }
}

function topPointerPosition() {
    var doubleRowHeight = smallBoxesWidth * 2;
    return doubleRowHeight * doubleRowCounter;
}

function setProductQuantity(){

    $(".product-quantity input").bind('keyup mouseup', function () {
        var inputValue = $(this).val();
        var inputUrl = $(".product-quantity").data('request-path');

        console.log("changed", inputValue);
        console.log("inputUrl", inputUrl);

        $.ajax({
            url: inputUrl,
            context: document.body,
            data: { quantity: inputValue }
        }).done(function(data) {
            updatePaymentButton(data.response.response);
        });
    });
}

function updatePaymentButton(responseData){
    console.log('responseData.sandbox', responseData.init_point)
    $('.product-buy-button').attr('href', responseData.init_point);
}

jQuery.fn.extend({
    setSmallBox: function () {
        $(this).animate({
            top: topPointer,
            left: leftPointer
        });

        if (!featuredBoxDisplayed)
            goToTop = (counter % 2 == 0) && !goToTop ? true : false;

        if (featuredBoxDisplayed)
            goToTop = (counter % 2 != 0) && !goToTop ? true : false;

    }
});

jQuery.fn.extend({
    setBigBox: function () {
        $(this).addClass('big-box').css({
            width: bigBoxesWidth,
            height: bigBoxesWidth
        }).animate({
            top: topPointer,
            left: leftPointer
        });

        goToTop = true;

        leftPointer += smallBoxesWidth * 2;

    }


});


/**************************/
/**************************/
/****  Product Detail  ****/
/**************************/
/**************************/

function setImagesGallery(){
    //Todo Check gallery
    //http://www.elevateweb.co.uk/image-zoom/configuration
    $('#zoom_01').elevateZoom({
        zoomType: "inner",
        responsive: true,
        cursor: "crosshair",
        zoomWindowFadeIn: 500,
        zoomWindowFadeOut: 750
    });
}