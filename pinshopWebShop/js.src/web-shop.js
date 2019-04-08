//import { clearTimeout, setTimeout } from "timers";

var cartFpVisible = false;
function ShowCartFpContainer(src, event) {
    cartFpVisible = true;
    var top = (src == 'cartButton' ? $('#btnCartFp').offset().top + $('#btnCartFp').height() : $(window).scrollTop() + 50);
    var right = $(window).width() - ($('#btnCartFp').offset().left + $('#btnCartFp').width());
    $('#cartFpContainer').css({ top: top, right: right });
    $('#cartFpContainer').show();

    GetCartItems();
    event.stopPropagation();
}

function ShowCompareFpContainer(x, y, count) {
    //$(document).mousemove(function (event) {
        $('#compareFpContainer').css({ top: y - $('#compareFpContainer').height(), right: $(document).width() - x - $('#compareFpContainer').width()});
        //})
        $('#compareFpCount')[0].innerText = count;
    $('#compareFpContainer').show();
}

function ShowWishListFpContainer(x, y, count) {
    $('#wishListFpContainer').css({ top: y - $('#wishListFpContainer').height(), right: $(document).width() - x - $('#wishListFpContainer').width() });
    $('#wishListFpCount')[0].innerText = count;
    $('#wishListFpContainer').show();
}

function AddToCart(lblProductID, event) {
    var productID = parseInt($('#' + lblProductID).val());
    
    $.ajax({
        type: 'POST',
        url: '/WebMethods.aspx/AddToCart',
        data: JSON.stringify({ 'productID': productID }),
        contentType: 'application/json;charset=utf-8',
        dataType: 'json',
        success: function (response) {
            ShowCartFpContainer('productFp', event);
            GetCartProductsCount();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //alert(jqXHR.responseText);
            console.error(jqXHR.responseText);
            alert('Nazalost, doslo je do greske. Pokusajte ponovo');
        }
    })
    
}

function GetCartItems() {
    $.ajax({
        type: 'POST',
        url: '/WebMethods.aspx/GetCart',
        data: '',
        contentType: 'application/json;charset=utf-8',
        dataType: 'json',
        success: function (response) {
            $('#tblCartItems tr').remove();
            $('#cartFpMessage').show();
            $.get('/jQueryTemplates/cartFPTemplate.html', null, function (cartTemplate) {
                if (JSON.parse(response.d).length > 0)
                    $('#cartFpMessage').hide();
                $.tmpl(cartTemplate, JSON.parse(response.d)).appendTo('#tblCartItems');
            })
            var total = 0;
            $.each(JSON.parse(response.d), function (index, value) {
                total += parseFloat(value.userPrice) * parseFloat(value.quantity);
            })
            $('#cartFpTotal')[0].innerText = total.toLocaleString('sr', { minimumFractionDigits: 2 });
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //alert(jqXHR.responseText);
            console.error(jqXHR.responseText);
            alert('Nažalost, došlo je do greške. Pokušajte ponovo.')
        }
    })
}

function AddToCompare(event, lblProductID) {
    var productID = parseInt($('#' + lblProductID).val());

    $.ajax({
        type: 'POST',
        url: '/WebMethods.aspx/AddToCompare',
        data: JSON.stringify({ "productID": productID }),
        contentType: 'application/json;charset=utf-8',
        dataType: 'json',
        success: function (msg) {
            ShowCompareFpContainer(event.pageX, event.pageY, msg.d);
            //$('[id*=lblCompareCount]')[0].innerText = msg.d;
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //alert(jqXHR.responseText);
            console.error(jqXHR.responseText);
            alert('Nažalost, došlo je do greške. Pokušajte ponovo.')
        }
    })
}

function AddToWishList(event, lblProductID) {
    var productID = parseInt($('#' + lblProductID).val());

    $.ajax({
        type: 'POST',
        url: '/WebMethods.aspx/AddToWishList',
        data: JSON.stringify({ "productID": productID }),
        contentType: 'application/json;charset=utf-8',
        dataType: 'json',
        success: function (msg) {
            if (msg.d == 'Not loggedin')
                window.location = '/prijava?returnUrl=' + window.location.pathname;
            else{
                //alert('wishlist');
                ShowWishListFpContainer(event.pageX, event.pageY, msg.d);
                $('#ctl00_lblWishListCount')[0].innerText = msg.d;
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //alert(jqXHR);
            console.error(jqXHR.responseText);
            alert('Nažalost, došlo je do greške. Pokušajte ponovo.')
        }
    })
}

function RecommendProduct() {

}

//document
$(window).scroll(function () {
    if($('#cartFpContainer').is(':visible') && cartFpVisible){
        var scrollTop = $(window).scrollTop() + 50;
        var btnCartFpTop = $('#btnCartFp').offset().top + $('#btnCartFp').height();
        $('#cartFpContainer').css({ top: scrollTop > btnCartFpTop ? scrollTop : btnCartFpTop });
    }
})

$(document).click(function (e) {
    if ($('#cartFpContainer').is(':visible') && e.target.parentElement.className != 'cart-fp' && e.target.parentElement.className != 'header-box cart-fp-container' && e.target.parentElement.className != 'update-cont') {
        //$('#cartFpContainer').hide();
        $('#cartFpContainer').css({ 'top': '-500px' });
        cartFpVisible = false;
    }
    if ($('#compareFpContainer').is(':visible')) {
        $('#compareFpContainer').hide();
    }
    if ($('#wishListFpContainer').is(':visible')) {
        $('#wishListFpContainer').hide();
    }
    if ($('.search-items-cont').is(':visible') && e.target.className != 'search-items-cont') {
        $('.search-items-cont').hide();
    }

})

$(document).ready(function () {
    if ($(location)[0].pathname == '/'){
        if ($(window).width() >= 1024) {
            $('.cd-dropdown').addClass('dropdown-is-active');
            $('.cd-dropdown-trigger').hide();
            
        }
        else {
            $('.cd-dropdown-trigger').show();
            $('.cd-dropdown-trigger').css({ "margin-top": "-40px", "width": "150px" });
            if ($(window).width() < 751) {
                $('.cd-dropdown-trigger').css({ "margin-top": "-52px", "line-height": "52px" });
            }
        }
    }
    GetCartProductsCount();
})

function ChangeImage(imageUrl) {
    //var image = document.getElementById("ctl00_ContentPlaceHolder1_priProductImages_imgMain");
    var image = $('[id*=imgMain]')[0];
    var extension = imageUrl.substring(imageUrl.lastIndexOf('.'));

    image.src = imageUrl.toString().substring(0, imageUrl.toString().indexOf('-thumb')) + '-main' + extension;
    //var link = document.getElementById("ctl00_ContentPlaceHolder1_priProductImages_lnkMainImage");
    var link = $('[id*=lnkMainImage]')[0];
    link.href = imageUrl.toString().substring(0, imageUrl.toString().indexOf('-thumb')) + extension;
}

function btnSearch_Click(value) {
    //if ($('#txtSearch').val().length > 0)
    if (value.length > 0)
        //window.location = '/pretraga?s=' + $('#txtSearch').val() + '&c=-1';
        window.location = '/pretraga?s=' + value + '&c=-1';
}

//$('#btnSearch').click(function () {
$('.search-control button').click(function () {
    btnSearch_Click(this.closest('div.search-control').children[0].value);
    return false;
})

//$('#txtSearch').keydown(function (event) {
$('.search-control input[type=text]').keydown(function (event) {
    if (event.keyCode == 13) {
        btnSearch_Click(this.value);
        return false;
    }
    else if (event.keyCode == 27) {
        $('.search-items-cont').hide();
    }
})

//$('#txtSearch').keyup(function (event) {
$('.search-control input[type=text]').keyup(function (event) {
    var value = this.value;
    var control = event.currentTarget;
    //if ($('#txtSearch').val().length > 3 && ((event.keyCode > 64 && event.keyCode < 91) || event.keyCode == 8 || (event.keyCode > 47 && event.keyCode < 58))) {
    if (this.value.length > 2 && ((event.keyCode > 64 && event.keyCode < 91) || event.keyCode == 8 || (event.keyCode > 47 && event.keyCode < 58))) {
    //$('.search-items-cont').show();
        if (timer) {
            clearTimeout(timer);
        }
        timer = setTimeout(function () {
            //SearchControl_GetSearchResponse($('#txtSearch').val());
            SearchControl_GetSearchResponse(value, control);
        }, 500);
    }
    else {
        $('.search-items-cont').hide();
    }
})

var timer;

function CartFpUpdateQuantity(productID, value, event) {
    
    $.ajax({
        type: 'POST',
        url: '/WebMethods.aspx/UpdateProductQuantity',
        data: JSON.stringify({ 'productID': productID, 'value': value }),
        contentType: 'application/json;charset=utf-8',
        dataType: 'json',
        success: function (msg) {
            ShowCartFpContainer('cartButton', event);
        },
        error: function (jqXhr, textStatus, errorThrown) {

        }
    })
}

function CartFpDeleteProduct(productID, event) {
    $.ajax({
        type: 'POST',
        url: '/WebMethods.aspx/DeleteProductFromCart',
        data: JSON.stringify({ 'productID': productID }),
        contentType: 'application/json;chartset=utf-8',
        dataType: 'json',
        success: function (msg) {
            ShowCartFpContainer('cartButton', event);
            GetCartProductsCount();
        },
        error: function (jqXhr, textStatus, errorThrown) {

        }
    })
}

function GetCartProductsCount() {
    $.ajax({
        type: 'POST',
        url: '/WebMethods.aspx/GetCartProductsCount',
        data: '',
        contentType: 'application/json;chartset=utf-8',
        dataType: 'json',
        success: function (msg) {
            $('#cartFpProductsCount')[0].innerText = msg.d;
            $('#fhCartProductsCount')[0].innerText = msg.d;
        },
        error: function (jqXhr, textStatus, errorThrown) {
            alert(errorThrown);
        }
    })
}

function formatCurrency(value) {
    return value.toLocaleString('sr', { minimumFractionDigits: 2 });
}

function btnProductCompareRemove_Click(lblProductID) {
    $.ajax({
        type: 'POST',
        url: '/WebMethods.aspx/DeleteFromProductCompare',
        data: JSON.stringify({ "productID": $('#' + lblProductID).val() }),
        contentType: 'application/json;chartset=utf-8',
        dataType: 'json',
        success: function (msg) {
            window.location.href = ('/uporedi');
        }
    })
}