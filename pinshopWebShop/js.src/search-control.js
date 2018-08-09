function SearchControl_GetSearchResponse(searchString) {
    $.ajax({
        type: 'POST',
        url: '/WebMethods.aspx/GetSearchData',
        data: JSON.stringify({ "searchText": searchString }),
        contentType: 'application/json;charset=utf-8',
        dataType: 'json',
        success: function (response) {
            $('#tblSearchItems tr').remove();
            $('.search-items-cont').show();
            $.get('/jQueryTemplates/searchItemsTemplate.html', null, function (searchItemsTemplate) {
                $.tmpl(searchItemsTemplate, JSON.parse(response.d)).appendTo('#tblSearchItems');
            })
        },
        error: function (jqXHR, textStatus, errorThrown) {

        }
       
    })
}