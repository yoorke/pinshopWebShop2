<%@ Page Title="" Language="C#" MasterPageFile="~/webShop.Master" AutoEventWireup="true" CodeBehind="products-old.aspx.cs" Inherits="WebShop2.productsOld" %>
<%@ Register Src="userControls/Pager.ascx" TagName="Pager" TagPrefix="pager" %>
<%@ Register Src="userControls/productFpV2.ascx" TagName="Product_fp" TagPrefix="Ws2" %>
<%@ Register Src="userControls/Slider.ascx" TagName="Slider" TagPrefix="Ws2" %>
<%@ Register Src="userControls/ProductSliderV2.ascx" TagName="ProductSlider" TagPrefix="Ws2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <asp:Literal ID="canonicalUrl" runat="server"></asp:Literal>
    <link rel="Stylesheet" id="camera-css" href="<%=ResolveUrl("~/css/camera-bundle.min.css") %>" />
    <link rel="stylesheet" href="<%=ResolveUrl("~/css/main-menu-vertical-v1.min.css") %>" />
    <%--<link rel="stylesheet" href="<%=ResolveUrl("~/css/jquery.bxslider.min.css") %>" />--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-xs-12"></div>
    </div>
    <div class="row">
        <div class="product-filter">
            <%--<h2>Kategorija</h2>
            <div class="filterBox">
                <asp:CheckBoxList ID="chkCategory" runat="server" AutoPostBack="true" OnSelectedIndexChanged="chkCategory_SelectedIndexChanged"></asp:CheckBoxList>
            </div>--%>
            <div id="filterBrandsDiv" runat="server">
                <h2 id="brandLabel" runat="server">Proizvođač</h2>
                <div class="filter-box">
                    <asp:CheckBoxList ID="chkBrands" runat="server" OnSelectedIndexChanged="chkBrands_SelectedIndexChanged"></asp:CheckBoxList>
                </div>
            </div>

            <h2>Cena</h2>
            <div class="filter-box">
                <label class="before">Od:</label><asp:DropDownList ID="cmbPriceFrom" runat="server" OnSelectedIndexChanged="cmbPriceFrom_SelectedIndexChanged"></asp:DropDownList><label><small>din</small></label><br />
                <label class="before">Do:</label><asp:DropDownList ID="cmbPriceTo" runat="server" OnSelectedIndexChanged="cmbPriceTo_SelectedIndexChanged"></asp:DropDownList><label><small>din</small></label>
            </div>
            <asp:Repeater ID="rptFilter" runat="server">
                <ItemTemplate>
                    <h2><asp:Literal ID="lblFilterName" runat="server" Text='<%#Eval("nameScreen") %>'></asp:Literal></h2>
                    <asp:HiddenField ID="lblAttributeID" runat="server" Value='<%#Eval("attributeID") %>' />
                    <div class="filter-box">
                        <asp:CheckBoxList ID="chkValues" runat="server" DataSource='<%#Eval("values") %>' DataTextField="value" DataValueField="attributeValueID" OnSelectedIndexChanged="chkValues_SelectedIndexChanged"></asp:CheckBoxList>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <div class="col-xs-12 col-sm-9 col-md-10, col-lg-10 margin-top-1 products">
            <Ws2:Slider ID="slider" runat="server" />
            <Ws2:ProductSlider ID="productSlider" runat="server" Visible="false" />
            <div class="row category-description">
                <div class="col-md-12 padding-0">
                    <asp:Label ID="lblCategoryDescription" runat="server"></asp:Label>
                </div>
            </div>
            <div class="row product-pager">
                <div class="col-lg-5">
                    <pager:Pager ID="pgrPager" runat="server" OnOnClick="pgrPages_Click" />
                </div>
                <div class="col-lg-7">
                    <div class="row sort">
                        <div class="col-sm-6 col-xs-12">
                            <div role="form" class="form-horizontal">
                                <div class="form-group">
                                    <label for="cmbPageSize" class="col-xs-8 control-label">Po stranici:</label>
                                    <div class="col-xs-4 padding-left-0">
                                        <asp:DropDownList ID="cmbPageSize" runat="server" OnSelectedIndexChanged="cmbPageSize_SelectedIndexChanged" CssClass="form-control"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-xs-12">
                            <div role="form" class="form-horizontal">
                                <div class="form-group">
                                    <label for="cmbSort" class="col-xs-5 control-label">Sort:</label>
                                    <div class="col-xs-7 padding-left-0">
                                        <asp:DropDownList ID="cmbSort" runat="server" OnSelectedIndexChanged="cmbSort_SelectedIndexChanged" CssClass="pull-right form-control"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row status" id="divStatus" runat="server" visible="false">
                <div class="col-lg-12">
                    Nema proizvoda za traženi filter
                </div>
            </div>
            <div class="row filter-btn hidden-sm hidden-md hidden-lg">
                <div class="col-xs-12">
                    <button type="button" class="btn btn-default width-100" onclick="ShowFilter()"><span class="fa fa-fw fa-filter"></span> Filter</button>
                </div>
            </div>
            <div class="row product_box padding-left-05 padding-right-05">
                <asp:Repeater ID="rptProducts" runat="server">
                    <ItemTemplate>
                        <div class="col-lg-3 col-md-4 col-sm-4 col-xs-6 padding-left-0 padding-right-0 margin-top-05">
                            <Ws2:Product_fp ID="product_fp" runat="server" ProductItem='<%#Container.DataItem %>' />
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <div class="row product-pager">
                <div class="col-lg-5">
                    <pager:Pager ID="pgrPager1" runat="server" OnOnClick="pgrPages_Click" />
                    <asp:HiddenField ID="lblPageIndex" runat="server" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
    <%--<script src="<%=ResolveUrl("~/js/jquery.mobile.customized.min.js") %>"></script>
    <script src="<%=ResolveUrl("~/js/jquery.easing.1.3.js") %>"></script>
    <script src="<%=ResolveUrl("~/js/camera.js") %>"></script>--%>
    <script src="<%=ResolveUrl("~/js/slider.min.js") %>"></script>
    <script>
        $(document).ready(function () {
            
            $('[id*=chkBrands] input').click(function () {
                //alert(this);
                $('[id*=lblPageIndex]').val('');
                createQueryString();
               
            });
            $('[id*=cmbPrice]').change(function () {
                $('[id*=lblPageIndex]').val('');
                createQueryString();
              
            })
            $('[id*=chkValues] input').click(function () {
                $('[id*=lblPageIndex]').val('');
                createQueryString();
              
            })
            $('[id*=cmbPageSize]').change(function () {
                $('[id*=lblPageIndex]').val('');
                createQueryString();
            });
            $('[id*=lnkPage]').click(function () {
                $('[id*=lblPageIndex]').val($(this)[0].attributes['data-pageindex'].value);
                createQueryString();
                
            });
            $('[id*=cmbSort]').change(function () {
                createQueryString();
            })

            //if($('#camera_wrap_1').length){
                //jquery_1_7_1('#camera_wrap_1').camera({
                    //thumbnails:true
                //})
            //}

            //setTimeout(setFilter(), 2000);
        })

        $(window).load(function () {
            setFilter();
        })

        function createQueryString() {
            var queryString = '';
            var exists = false;
            $.each($('[id*=chkBrands] input:checked'), function (key, value) {
                queryString += $(this).parent().attr('attributeValue') + ',';
            })
            if (queryString.length > 0) {
                queryString = 'brands=' + queryString;
                queryString = queryString.substring(0, queryString.length - 1);
                exists = true;
                
            }

            if ($('[id*=cmbPriceFrom]').val() != '-') {
                queryString += (exists ? '&' : '') + 'priceFrom=' + $('[id*=cmbPriceFrom]').val();
                exists = true;
            }

            if ($('[id*=cmbPriceTo]').val() != '-') {
                queryString += (exists ? '&' : '') + 'priceTo=' + $('[id*=cmbPriceTo]').val();
                exists = true;
            }

            var attributeQueryString = '';
            $.each($('[id*=chkValues] input:checked'), function (key, value) {
                attributeQueryString += $(this).parent().attr('attributeValue') + ',';
            })
            if (attributeQueryString != '') {
                queryString += (exists ? '&' : '') + 'attributes=' + attributeQueryString.substring(0, attributeQueryString.length - 1);
                exists = true;
            }

            if($('[id*=cmbPageSize]').val() != '16'){
                queryString += (exists ? '&' : '') + 'pageSize=' + $('[id*=cmbPageSize]').val();
                exists = true;
            }
            if($('[id*=lblPageIndex]').val() != ''){
                queryString += (exists ? '&' : '') + 'pageIndex=' + $('[id*=lblPageIndex]').val();
                exists = true;
            }
            if($('[id*=cmbSort]').val() != 'priceAsc'){
                queryString += (exists ? '&' : '') + 'sort=' + $('[id*=cmbSort]').val();
                exists = true;
            }

            //var category = window.location.href.substring(window.location.href.indexOf('/proizvodi/') + 11, window.location.href.indexOf('.html') + 5);
            var href = window.location.href;
            if (href.indexOf('?') > 0)
                href = href.substring(0, href.indexOf('?'));
            window.location = href + (queryString.length > 0 ? ('?' + encodeURI(queryString)) : '');
        }

        function setFilter() {
            $('.product-filter').removeClass('col-sm-3 col-md-2 col-lg-2');

            if ($(window).width() > 768) {
                $('.product-filter').addClass('col-sm-3 col-md-2 col-lg-2');
                $('.product-filter').css('position', 'inherit');
                //$('.product-filter').position({ top: 0, left: 0 });
            }
            else {
                $('.product-filter').css('position', 'absolute');
                $('.product-filter').css('opacity', '0.9');
                $('.product-filter').offset({ top: $('.product_box').offset().top, left: -236 });
                
            }
        }

        $(window).resize(function () {
            setFilter();
        })

        function ShowFilter() {
            $('.product-filter').offset({ top: $('.product_box').offset().top, left: $('.product-filter').offset().left });
            $('.product-filter').removeClass('product-filter-xs-visible');
            //$('.product-filter').show();
            if ($('.product-filter').offset().left == -236){
                
                $('.product-filter').offset({ top: $('.product_box').offset().top, left: 0 });
                $('.product-filter').addClass('product-filter-xs-visible');
            }
            else {
                $('.product-filter').offset({ top: $('.product_box').offset().top, left: -236 });
            }
        }
    </script>
    <%--<script src="<%=ResolveUrl("~/js/jquery.bxslider.min.js") %>"></script>
    <script>
        $(document).ready(function () {
            $('.bxslider').bxSlider({
                auto: true
            });
        })
    </script>--%>
</asp:Content>
