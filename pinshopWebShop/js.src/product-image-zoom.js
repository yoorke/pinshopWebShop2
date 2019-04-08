$(document).ready(function () {
    $('#ctl00_ContentPlaceHolder1_priProductImages_imgMain').mouseenter(function () {
        var src = $('#ctl00_ContentPlaceHolder1_priProductImages_imgMain')[0].src;
        //var filename = src.substring(0, src.indexOf('-main.jpg'));
        var filename = src.replace('-main', '');
        if (filename != '') {
            //$('#imgZoom').css('background-image', 'url(' + filename + '.jpg' + ')');
            $('#imgZoom').css('background-image', 'url(' + filename + ')');
            $('#imgZoom').css('background-size', '300%');
            $('#imgZoom').show();
        }
    })
    $('#ctl00_ContentPlaceHolder1_priProductImages_imgMain').mouseout(function () {
        $('#imgZoom').hide();
    })
    $('#ctl00_ContentPlaceHolder1_priProductImages_imgMain').mousemove(function (e) {
        var dimensions = $('#ctl00_ContentPlaceHolder1_priProductImages_imgMain')[0].getBoundingClientRect();

        var x = e.clientX - dimensions.left;
        var y = e.clientY - dimensions.top;

        var xpercent = Math.round(100 / (dimensions.width / x));
        var ypercent = Math.round(100 / (dimensions.height / y));

        $('#imgZoom').css('background-position', xpercent + '%' + ypercent + '%');
    })
    $('#imgZoom').mouseout(function () {
        $('#imgZoom').hide();
    })
})