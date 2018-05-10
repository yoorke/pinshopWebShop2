$(document).ready(function () {
    if ($(window).width() >= 1024) {
        $('.cd-dropdown').addClass('dropdown-is-active');
        $('.cd-dropdown-trigger').hide();
    }
    else if ($(window).width() < 1024) {
        $('.cd-dopdown-trigger').show();
    }        
})