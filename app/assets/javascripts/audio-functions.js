
$(document).ready(function () {

    papin();
    foca();
    siranush();
    salchipapa();

});

function papin() {
    var keys = [];
    var konami = '80,65,80,73,78';

    $(document).keydown(function (e) {

        keys.push(e.keyCode);
        if (keys.toString().indexOf(konami) >= 0) {
            playAudio();
            keys = [];
        }
    });
}

function foca() {
    var keys = [];
    var konami = '70,79,67,65';

    $(document).keydown(function (e) {

        keys.push(e.keyCode);
        if (keys.toString().indexOf(konami) >= 0) {
            playAudio();
            keys = [];
        }
    });
}

function siranush() {
    var keys = [];
    var konami = '83,73,82,65,78,85,83,72';

    $(document).keydown(function (e) {

        keys.push(e.keyCode);
        if (keys.toString().indexOf(konami) >= 0) {
            playAudio();
            keys = [];
        }
    });
}

function salchipapa() {
    var keys = [];
    var konami = '83,65,76,67,72,73,80,65,80,65';

    $(document).keydown(function (e) {

        keys.push(e.keyCode);
        if (keys.toString().indexOf(konami) >= 0) {
            playAudio();
            keys = [];
        }
    });
}

function playAudio() {
    document.getElementById('audio-up').play();
}
