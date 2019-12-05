<%@ Page Title="" Language="C#" MasterPageFile="~/webShop.Master" AutoEventWireup="true" CodeBehind="search.aspx.cs" Inherits="WebShop2.search" %>
<%@ Register Src="userControls/productFpV2.ascx" TagName="ProductFp" TagPrefix="Ws2" %>
<%@ Register Src="userControls/Pager.ascx" TagName="Pager" TagPrefix="Ws2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%=ResolveUrl("~/css/main-menu-vertical-v1.min.css") %>" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-lg-12 products">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="heading">
                    Pretraga: <asp:Literal ID="lblHeading" runat="server" EnableViewState="true"></asp:Literal>
                    , u kategoriji: <asp:Literal ID="lblCategoryName" runat="server" EnableViewState="true"></asp:Literal>
                </h1>
            </div>
        </div>
        <div class="row product-pager">
            <div class="col-lg-5">
                <Ws2:Pager ID="pager1" runat="server" OnOnClick="pager1_OnClick" />
            </div>
            <div class="col-lg-7">
                <div class="row sort">
                    <div class="col-sm-6 col-xs-12">
                        <div role="form" class="form-horizontal">
                            <div class="form-group">
                                <label for="cmbPageSize" class="col-xs-8 padding-left-0">Prikaži po stranici:</label>
                                <div class="col-xs-4 padding-left-0">
                                    <asp:DropDownList ID="cmbPageSize" runat="server" OnSelectedIndexChanged="cmbPageSize_SelectedIndexChanged" CssClass="form-control" AutoPostBack="true"></asp:DropDownList>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-xs-12">
                        <div role="form" class="form-horizontal">
                            <div class="form-group">
                                <label for="cmbSort" class="col-xs-5 padding-left-0">Sortiraj po:</label>
                                <div class="col-xs-7 padding-left-0">
                                    <asp:DropDownList ID="cmbSort" runat="server" OnSelectedIndexChanged="cmbSort_SelectedIndexChanged" CssClass="form-control" AutoPostBack="true"></asp:DropDownList>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row product_box">
            <div class="col-lg-12">
                <asp:Repeater ID="rptProducts" runat="server">
                    <ItemTemplate>
                        <%--<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12 padding-left-0 padding-right-0 margin-top-05">--%>
                        <div class="col-lg-3 col-md-4 col-sm-4 col-xs-6 product-fp-col">
                            <Ws2:ProductFp ID="product_fp" runat="server" ProductItem='<%#Container.DataItem %>' />
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
        <div class="row product-pager">
            <div class="col-lg-5">
                <Ws2:Pager ID="pager2" runat="server" OnOnClick="pager1_OnClick" />
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
    <script>
        
        $(document).ready(function () {
            $.expr[':'].Contains = $.expr.createPseudo(function (arg) {
                return function (elem) {
                    return $(elem).text().toUpperCase().indexOf(arg.toUpperCase()) >= 0;
                }
            })

            var searchedText = decodeURIComponent(getQueryString()['a']).split(' ');
            $(searchedText).each(function(p, text){
                $('.product-fp h3 span:Contains(' + text + '), .product-fp h4:Contains(' + text + '), .product-fp .webprice_div .code:Contains(' + text + ')').each(function (i, element) {
                    var content = $(element).text();
                    //content = content.replace(text, '<span class="search_found">' + text + '</span>');
                    var regex = new RegExp('(' + text + ')', 'gi');
                    content = content.replace(regex, '<span class="search-found">$1</span>');
                    element.innerHTML = content;
                })
            })
        })

        function getQueryString() {
            var vars = [], hash;
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < hashes.length; i++) {
                hash = hashes[i].split('=');
                vars.push(hash[0]);
                vars[hash[0]] = hash[1];
            }
            return vars;
        }
    </script>
</asp:Content>
