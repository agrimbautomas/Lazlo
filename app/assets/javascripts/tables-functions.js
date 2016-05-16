var $tablesContainer;
var containerWidth;
var smallBoxesWidth;
var bigBoxesWidth;

var counter = 0;
var topPointer = 0;
var leftPointer = 0;
var goToTop = false;
var doubleRowCounter  = 0;

$(document).ready(function () {

    setupResponsiveBoxes();

});

function setupResponsiveBoxes() {
    $tablesContainer = $('.tables-box-container .inner-container');
    containerWidth = $tablesContainer.width();

    setSmallBoxes();
    setBigBoxes();

    setPositions();
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


    $('.table-box').each(function () {
        counter++;



        if (counter % 5 == 0) {
            $(this).setBigBox();
        } else {
            $(this).setSmallBox();
        }


        if ( (counter % 2 == 0) && goToTop ) {
            leftPointer += smallBoxesWidth;
        }

        topPointer = (goToTop) ?  topPointerPosition() : (topPointer + smallBoxesWidth);


        if (counter % 7 == 0){
            leftPointer = 0;
            counter = 0;
            doubleRowCounter++;
        }
    });
}

function topPointerPosition(){
    var doubleRowHeight = smallBoxesWidth*2;
    return doubleRowHeight * doubleRowCounter;
}

jQuery.fn.extend({
    setSmallBox: function () {
        $(this).animate({
            top: topPointer,
            left: leftPointer
        });

        goToTop = (counter % 2 == 0) && !goToTop ? true : false;
        
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