var $widthInput;
var $heightInput;
var $diameterInput;
var $materialSelect;
var $typeSelect;
var $rectangularBox;
var $circularBox;
var typeValue;
var widthVal;
var heigthVal;
var diameterVal;
var materialPrice;
var $resultBox;
var DIAMETER_EXTRA_RATE = 1.5439;

$(document).ready(function () {

    $widthInput = $('input[name="width_size"]');
    $heightInput = $('input[name="height_size"]');
    $diameterInput = $('input[name="diameter_size"]');
    $materialSelect = $('select[name="material"]');
    $typeSelect = $('select[name="shape"]');
    $rectangularBox = $('.show-rectangular');
    $circularBox = $('.show-circular');
    $resultBox = $('.result-box span');


    $('input, select').bind("propertychange change click keyup input paste", function (event) {
        onChangeInputs();
    })


});


function onChangeInputs() {

    typeValue = $typeSelect.val();
    widthVal = $widthInput.val();
    heigthVal = $heightInput.val();
    diameterVal = $diameterInput.val();
    materialPrice = $materialSelect.val();

    toggleByType();


}


function toggleByType() {
    var typeValue = $typeSelect.val();
    if (typeValue == 'rectangular') {

        showRectangular();
        if ($widthInput.validateSize() && $heightInput.validateSize())
            calculateRectangularPrice();
    }

    if (typeValue == 'circular') {
        showCircular();
        if ($widthInput.validateSize() && $heightInput.validateSize())
            calculateCircularPrice()
    }
}

function calculateRectangularPrice() {
    var sizeSum = parseInt(widthVal) + parseInt(heigthVal);
    var result = (sizeSum / 100 ) * materialPrice;
    showResult(result);
}


function calculateCircularPrice() {
    var diameterMaterialPrice = materialPrice * DIAMETER_EXTRA_RATE;
    var result = (diameterVal * diameterMaterialPrice) / 100;
    showResult(result);
}

function showResult(result) {
    var parserdResult = Math.round(result).toFixed(0);
    $resultBox.html(commaSeparateNumber(parserdResult));
}

function showRectangular() {
    $rectangularBox.show();
    $circularBox.hide();
}

function showCircular() {
    $rectangularBox.hide();
    $circularBox.show();
}

jQuery.fn.extend({
    validateSize: function () {
        return $.isNumeric($(this).val())
    }


});

function commaSeparateNumber(val) {
    while (/(\d+)(\d{3})/.test(val.toString())) {
        val = val.toString().replace(/(\d+)(\d{3})/, '$1' + '.' + '$2');
    }
    return val;
}