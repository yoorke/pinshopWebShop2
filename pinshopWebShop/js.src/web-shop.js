function ShowCartFpContainer(src) {
    var top = (src == 'cartButton' ? $('#btnCartFp').offset().top + $('#btnCartFp').height() : $(window).scrollTop());
    var right = $(window).width() - ($('#btnCartFp').offset().left + $('#btnCartFp').width());
    $('#cartFpContainer').css({ top: top, right: right });
    $('#cartFpContainer').show();

    GetCartItems();
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

function AddToCart(lblProductID) {
    var productID = parseInt($('#' + lblProductID).val());
    
    $.ajax({
        type: 'POST',
        url: '/WebMethods.aspx/AddToCart',
        data: JSON.stringify({ 'productID': productID }),
        contentType: 'application/json;charset=utf-8',
        dataType: 'json',
        success: function (response) {
            ShowCartFpContainer('productFp');
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(jqXHR.responseText);
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
            $('#cartFpTotal')[0].innerText = total.toFixed(2);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(jqXHR.responseText);
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
            $('[id*=lblCompareCount]')[0].innerText = msg.d;
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(jqXHR.responseText);
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
            alert(jqXHR);
        }
    })
}

function RecommendProduct() {

}

//document
$(window).scroll(function () {
    if($('#cartFpContainer').is(':visible')){
        var scrollTop = $(window).scrollTop();
        var btnCartFpTop = $('#btnCartFp').offset().top + $('#btnCartFp').height();
        $('#cartFpContainer').css({ top: scrollTop > btnCartFpTop ? scrollTop : btnCartFpTop });
    }
})

$(document).click(function (e) {
    if ($('#cartFpContainer').is(':visible') && e.target.parentElement.className != 'cart-fp' && e.target.parentElement.className != 'header-box cart-fp-container' && e.target.parentElement.className != 'update-cont') {
        $('#cartFpContainer').hide();
    }
    if ($('#compareFpContainer').is(':visible')) {
        $('#compareFpContainer').hide();
    }
    if ($('#wishListFpContainer').is(':visible')) {
        $('#wishListFpContainer').hide();
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

function btnSearch_Click() {
    if ($('#txtSearch').val().length > 0)
        window.location = '/pretraga?a=' + $('#txtSearch').val();
}

$('#btnSearch').click(function () {
    btnSearch_Click();
    return false;
})

$('#txtSearch').keydown(function (event) {
    if (event.keyCode == 13) {
        btnSearch_Click();
        return false;
    }    
})

function CartFpUpdateQuantity(productID, value) {
    
    $.ajax({
        type: 'POST',
        url: '/WebMethods.aspx/UpdateProductQuantity',
        data: JSON.stringify({ 'productID': productID, 'value': value }),
        contentType: 'application/json;charset=utf-8',
        dataType: 'json',
        success: function (msg) {
            ShowCartFpContainer('cartButton');
        },
        error: function (jqXhr, textStatus, errorThrown) {

        }
    })
}

function CartFpDeleteProduct(productID) {
    $.ajax({
        type: 'POST',
        url: '/WebMethods.aspx/DeleteProductFromCart',
        data: JSON.stringify({ 'productID': productID }),
        contentType: 'application/json;chartset=utf-8',
        dataType: 'json',
        success: function (msg) {
            ShowCartFpContainer('cartButton');
        },
        error: function (jqXhr, textStatus, errorThrown) {

        }
    })
}