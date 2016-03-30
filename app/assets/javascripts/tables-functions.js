
$(document).ready(function () {
    console.log('Tables!');

    $(".tables-box-container").mason({
        itemSelector: ".table-box",
        ratio: 1.5,
        sizes: [
            [1,1],
            [1,2],
            [2,2]
        ]
    });

});
