$(document).ready(function () {
    if($('#camera_wrap_1').length){
        $('#camera_wrap_1').camera({
            thumbnails: true
        })
    }

    if ($(window).width() >= 992) {
        $('.slider').css({ 'height': $('.cd-dropdown').height() });
    }
})