function SearchControl_GetSearchResponse(searchString, control) {
    $.ajax({
        type: 'POST',
        url: '/WebMethods.aspx/GetSearchData',
        data: JSON.stringify({ "searchText": searchString }),
        contentType: 'application/json;charset=utf-8',
        dataType: 'json',
        success: function (response) {
            //$('#tblSearchItems tr').remove();
            var tblSearchItems = $(control).closest('.search-control').find('#tblSearchItems');
            $(tblSearchItems).find('tr').remove();
            $(control).closest('.search-control').find('.search-items-cont').show();
            $.get('/jQueryTemplates/searchItemsTemplate.html', null, function (searchItemsTemplate) {
                //$.tmpl(searchItemsTemplate, JSON.parse(response.d)).appendTo('#tblSearchItems');
                $.tmpl(searchItemsTemplate, JSON.parse(response.d)).appendTo(tblSearchItems);
            })
        },
        error: function (jqXHR, textStatus, errorThrown) {

        }
       
    })
}