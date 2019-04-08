$(document).ready(function () {
    $(window).scroll(function () {
        if ($(window).width() >= 1024) {
            //$('.cd-dropdown').css({ 'position': 'initial' });
            $('.cd-dropdown').removeClass('fixed');
            if ($(window).scrollTop() > 110)
                //alert('werewrew');
                $('.fixed-header').addClass('show');
            else if ($(window).scrollTop() <= 110) {
                $('.fixed-header').removeClass('show');
                closeSearchItems();
            }
            if ($(window).scrollTop() > 430)
                $('.fh-main-menu-toggle').addClass('show');
            if ($(window).scrollTop() <= 430)
                $('.fh-main-menu-toggle').removeClass('show');
        }
    })

    $('.fh-main-menu-toggle').click(function () {
        //$('.cd-dropdown').css({ 'position': 'fixed', 'top': '50px', 'left': '208px', 'z-index': '9999' });
        $('.cd-dropdown').addClass('fixed');
        $('.cd-dropdown').css({ "left": $('.fh-main-menu-toggle').offset().left });
        if ($('.cd-dropdown-trigger').is(':visible'))
            $('.cd-dropdown').addClass('dropdown-is-active');
    })

    $('.cd-dropdown').mouseleave(function (event) {
        //var e = event.toElement || event.relatedTarget;
        //if (e.parentElement == this || e == this)
            //return;
        //$('.cd-dropdown').css({ 'position': 'initial' });
        $('.cd-dropdown').removeClass('fixed');
        $('.cd-dropdown').css({ 'left': 0 });
        if ($('.cd-dropdown-trigger').is(':visible'))
            $('.cd-dropdown').removeClass('dropdown-is-active');
    })

    function closeSearchItems() {
        $('.fixed-header .search-items-cont').hide();
    }
})