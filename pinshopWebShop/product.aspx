<%@ Page Language="C#" MasterPageFile="~/webShop.Master" AutoEventWireup="true" CodeBehind="product.aspx.cs" Inherits="WebShop2.product" Title="Untitled Page" EnableViewState="false" %>
<%@ Register Src="userControls/ProductImages.ascx" TagName="ProductImages" TagPrefix="Ws2" %>
<%@ Register Src="userControls/Banner.ascx" TagName="Banner" TagPrefix="Ws2" %>
<%@ Register Src="userControls/productSlider.ascx" TagName="ProductSlider" TagPrefix="Ws2" %>
<%@ Register Src="~/userControls/ProductRatingView.ascx" TagName="ProductRating" TagPrefix="Ws" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--<script type="text/javascript" src="/js/jquery-1.10.1.min.js"></script>--%>
    <link rel="stylesheet" type="text/css" media="all" href="<%=ResolveUrl("/css/lightbox.min.css") %>" />
    <link rel="stylesheet" href="<%=ResolveUrl("~/css/main-menu-vertical-v1.min.css") %>" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--BANNER--%>
    <%--<div class="col-xs-2 left-column visible-lg visible-md">
        <banner:Banner ID="banner1" runat="server" Position="FP1" />
        <banner:Banner ID="banner2" runat="server" Position="FP2" />
    </div><!--col-banner-->--%>
            
    <%--MAIN CONTENT--%>
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 product">
        <%--images, name, price--%>
        <div class="row">
            <div class="col-sm-5">
                <div class="nis-cont" id="divNis" runat="server" style="display:none">
                    <span class="nis-label">Nema na stanju</span>
                </div>
                <Ws2:ProductImages ID="priProductImages" runat="server" />
                <asp:Image ID="imgPromotion" runat="server" Visible="false" CssClass="promotion" />
                <div class="row icons">
                    <%--<div class="col-md-12">--%>
                        
                    <%--</div>--%>
                    <div class="col-xs-3 text-center padding-left-0 padding-right-0">
                        <button type="button" onclick="AddToWishList(event, '<%=lblProductID.ClientID %>')" class="ws-btn" data-toggle="tooltip" data-placement="top" title="Dodaj u listu želja">
                            <span class="fa fa-fw fa-heart"></span>
                            <span class="hidden-xs hidden-sm">Lista želja</span>
                        </button>
                    </div>
                    <div class="col-xs-3 text-center padding-left-0 padding-right-0"><%--<asp:LinkButton ID="btnCompare" runat="server" Text="Uporedi" OnClientClick="btnCompare_Click('<%=lblProductID.ClientID %>')"></asp:LinkButton>--%>
                        <%--<button type="button" id="btnCompare" onclick="btnCompare_Click('<%=lblProductID.ClientID %>')">Uporedi</button>--%>
                        <button type="button" onclick="AddToCompare(event, '<%=lblProductID.ClientID %>')" class="ws-btn" data-toggle="tooltip" data-placement="top" title="Uporedi proizvod">
                            <span class="fa fa-fw fa-balance-scale"></span>
                            <span class="hidden-xs hidden-sm">Uporedi</span>
                        </button>

                    </div>
                    <div class="col-xs-3 text-center padding-left-0 padding-right-0">
                        <button type="button" onclick="RecommendProduct()" class="ws-btn" data-toggle="tooltip" data-placement="top" title="Pošalji prijatelju">
                            <span class="fa fa-fw fa-envelope"></span>
                            <span class="hidden-xs hidden-sm">Podeli</span>
                        </button>
                    </div>
                    <div class="col-xs-3 text-center padding-left-0 padding-right-0">
                        <a href="<%=ResolveUrl("~/stampa-proizvoda/" + lblProductID.Value) %>" target="_blank">
                            <span class="fa fa-fw fa-print"></span>
                            <span class="hidden-xs hidden-sm">Štampaj</span>
                        </a>
                    </div>
                </div>
            </div><%--col--%>
            <div class="col-sm-7">
                <div id="imgZoom" class="img-zoom"></div>
                <asp:HiddenField ID="lblProductID" runat="server" />
                
                <h1 id="lblH1" runat="server"><asp:Literal ID="lblBrand" runat="server"></asp:Literal></h1>
                <h2 id="lblH2" runat="server"><asp:Literal ID="lblName" runat="server"></asp:Literal></h2>
                <div class="code">Šifra: <asp:Label ID="lblCode" runat="server"></asp:Label></div>
                <p>Pogledajte i ostale proizvode iz kategorije <asp:HyperLink ID="lnkCategory" runat="server" CssClass="underline"></asp:HyperLink></p>
                
                <%--Kredit i rate--%>
                <div class="row box-content box-content-primary" id="loanBox" runat="server">
                    <div class="col-sm-1">
                        <img src='<%=Page.ResolveUrl("~/images/loan.gif") %>' />
                    </div>
                    <div class="col-sm-4">
                        
                        <span><label onclick="loan()" class="cursor-pointer bold-none">Prijavite se za beskamatni kredit</label></span>
                    </div>
                    <div class="col-sm-1">
                        <img src='<%=Page.ResolveUrl("~/images/calculator.gif") %>' />
                    </div>
                    <div class="col-sm-3">
                        <span><label onclick="calculateLoan()" class="cursor-pointer bold-none">Izračunajte vašu ratu</label></span>
                    </div>
                    <div class="col-sm-3">
                        Rata već od <span class="color-red">3.688,55</span> din
                    </div>
                </div><%--row-kredit-i-rate--%>
                
                <div class="row box-content box-content-secondary margin-left-05">
                    <div class="col-sm-8">
                        <div class="row">
                            <div class="col-xs-12">
                                <asp:Image ID="imgBrand" runat="server" Visible="false" CssClass="brand-logo" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-6">
                                <p>Dostupnost:</p>
                                <p class="bold uppercase"><span class="stock-icon"><asp:Label ID="lblStockIcon" runat="server"></asp:Label></span> <asp:Literal ID="txtAvailability" runat="server" Text="Na stanju"></asp:Literal></p>
                                
                            </div>
                            <div class="col-xs-6">
                                <p class="margin-top-2">Očekivani rok isporuke:</p>
                                <p class="bold"><asp:Literal ID="txtDelivery" runat="server" Text="do 2 dana"></asp:Literal></p>
                                <Ws:ProductRating ID="productRating" runat="server" />
                            </div>
                        </div>
                    </div>
                    <%--<div class="col-sm-4">

                    </div>--%>
                    <div class="col-sm-4 text-right">
                        <div class="price-div"><p class="margin-bottom-0" id="priceDiv" runat="server"><asp:Label ID="lblPrice" runat="server" Text="MP 110.989 din"></asp:Label><span class="price-label"></span></p></div>
                        <div class="web-price-div"><p class="web-price margin-bottom-0" id="webPriceDiv" runat="server"><asp:Label ID="lblWebPrice" runat="server" Text="99.890 din"></asp:Label><span class="web-price-label"> RSD</span></p></div>
                        <div class="saving-div"><p id="savingDiv" runat="server"><asp:Label ID="lblSaving" runat="server" Text="Ušteda: 2.548,00 din"></asp:Label><span class="saving-label"></span></p></div>
                        <%--<asp:Button ID="btnCart" runat="server" CssClass="btnAddToCart" Text="Dodaj u korpu" OnClick="btnCart_Click" />--%>
                        <button type="button" id="btnCartAjax" class="ws-btn btn-cart" runat="server"><span class="fa fa-fw fa-shopping-cart"></span><span>Dodaj u korpu</span></button>
                    </div>
                </div><%--row--%>
                <%--<div class="row icons">--%>
                    <%--<div class="col-xs-1">--%>
                        <%--<img src='<%=Page.ResolveUrl("~/images/compare.gif") %>' />--%>
                        
                    <%--</div>--%>
                    
                    <%--<div class="col-xs-1">--%>
                        <%--<img src='<%=Page.ResolveUrl("~/images/wishlist.gif") %>' />--%>
                        
                    <%--</div>--%>
                    
                    <%--<div class="col-xs-1">--%>
                        <%--<img src='<%=Page.ResolveUrl("~/images/recommend.gif") %>' />--%>
                        
                    <%--</div>--%>
                    
                    
                <%--</div>--%><%--row--%>
                <div class="row margin-top-1">
                    <div class="col-lg-12 text-right">
                        <div id="lblProductFacebookLike" runat="server"></div>
                    </div>
                </div>
                <%--<div class="row">
                    <div class="col-lg-12">
                        Redovna cena: <asp:Label ID="lblPrice1" runat="server" CssClass="regular"></asp:Label> din<br />
                        Web cena: <asp:Label ID="lblWebPrice1" runat="server" CssClass="web"></asp:Label> din<br />
                        Ušteda: <asp:Label ID="lblSaving1" runat="server" CssClass="saving"></asp:Label> din
                
                    </div><!--col-->
                </div><!--row-->
        <div class="row">
            <asp:LinkButton ID="btnCart" runat="server" CssClass="button" OnClick="btnCart_Click">Ubaci u korpu</asp:LinkButton>
        </div>--%>
            </div><%--col--%>
        </div><%--row--%>
        
        
        <%--description--%>
        <div class="row">
            <div class="col-lg-12">
                <h3>Opis</h3>
                <asp:Literal ID="lblDescription" runat="server"></asp:Literal>
            </div><%--col--%>
        </div><%--row--%>

        <div class="row margin-top-1" id="divUputstvo" runat="server">
            <div class="col-md-12">
                <span class="fa fa-fw fa-newspaper-o"></span>
                <a href="/uputstvo-za-koriscenje-posudja">Uputstvo za korišćenje.</a>
            </div>
        </div>
        
        <%--specification--%>
        <div class="row">
            <div class="col-lg-7 specification">
                <h3>Specifikacije i detalji</h3>
                <asp:Literal ID="lblSpecification" runat="server"></asp:Literal>
            </div><%--col--%>
            <%--<div class="col-lg-4" style="background-color:#eee">

            </div>--%>
        </div><%--row--%>
        <div class="row question">
            <div class="col-md-12">
                <h3>Pitanja o proizvodu</h3>
                <span>Nema pitanja</span>
            </div>
        </div>
        <div class="row product_slider margin-bottom-4">
            <div class="col-lg-12">
                <Ws2:ProductSlider ID="sliderCategory" runat="server" />
            </div>
        </div>

        <div class="product-icon-box">
        <a href="<%= ResolveUrl("~/stampa-proizvoda/" + lblProductID.Value) %>" target="_blank"><span class="fa fa-fw fa-print"></span></a>
        <a id="btnShowSpecification"><span class="fa fa-fw fa-newspaper-o"></span></a>
        <a id="btnShowQuestion"><span class="fa fa-fw fa-question-circle"></span></a>
        <a id="btnToTop" class="secondary"><span class="fa fa-fw fa-arrow-circle-up"></span></a>
    </div>
    </div><%--col main--%>
    <%--<div class="messageBoxWrapper" id="wishListMessageBox" style="display:none">
        <div class="messageBox" id="wishListMessageBoxText">
            <span>Proizvod dodat u listu želja</span>
            <div>
                <button type="button" id="btnWishListMessageBoxOk" onclick="WishListMessageBoxOk_Click()">Zatvori</button>
                <button type="button" id="btnWishListShowList" onclick="window.location='/wishList.aspx'">Prikaži listu</button>
            </div>
        </div>
        
    </div><!--messageBox-->--%>

    
    
    
    <%--<div class="bannerColumn">
        <div class="banner"></div>    
    </div>
    
    <div class="productColumn">
        <div class="productBox">
            <div class="images">
                
            </div>
            
            <div class="description"></asp:Literal></div>
            <div class="prices">
                
            </div>
            <div class="cartButton">
                
            </div>
        </div>
        
        
        <div id="tabsContainer">
            <ul class="tabs">
                <li class="tab-link current" data-tab="tab-1">Specifikacija</li>
                <li class="tab-link" data-tab="tab-2">Opis</li>
            </ul>
            
            <div id="tab-1" class="tab-content current">
                <div class="specification">
                    <h2>Specifikacija</h2>
                    
                </div>
            </div>
            <div id="tab-2" class="tab-content">
                
            </div>
        </div>--%>
        <%--<ajaxtoolkit:ToolkitScriptManager ID="toolkitScriptManager1" runat="server" EnablePartialRendering="true"></ajaxtoolkit:ToolkitScriptManager>
        <ajaxtoolkit:TabContainer ID="tabContainer1" runat="server" Width="640px">
            <ajaxtoolkit:TabPanel ID="tbpSpecification" runat="server" HeaderText="Specifikacija">
                <ContentTemplate>
                    
                </ContentTemplate>
            </ajaxtoolkit:TabPanel>
            <ajaxtoolkit:TabPanel ID="tbpDescription" runat="server" HeaderText="Opis">
                <ContentTemplate>
                    <asp:Literal runat="server"></asp:Literal>
                </ContentTemplate>
            </ajaxtoolkit:TabPanel>
        </ajaxtoolkit:TabContainer>--%>
        
    <%--</div>--%>
    
    <%--<div class="bannerColumn">
        <div class="banner"></div>
    </div>--%>
    
    
    

    <%--<script type="text/javascript">
        $(document).ready(function() {
            $('ul.tabs li').click(function(){
                                        var tab_id=$(this).attr('data-tab');
                                        $('ul.tabs li').removeClass('current');
                                        $('.tab-content').removeClass('current');
                                        $(this).addClass('current');
                                        $("#"+tab_id).addClass('current');
                                    })
        });
    </script>--%>
    <%--</span>
    </label>--%>
</asp:Content>

    <asp:Content ID="Content3" runat="server" ContentPlaceHolderID="footer">
    <script type="text/javascript" src="/js/lightbox.min.js"></script>
    <script src="/js/product-image-zoom.min.js" type="text/javascript"></script>
    
    <script type="text/javascript">
        //jQuery(function() {
            //jQuery('#thumbnails a').lightBox();
        //});
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            if ($(window).width() > 1024) {
                $('.product-icon-box').show();
            }

            $('#btnShowSpecification').click(function () {
                $('body,html').animate({
                    scrollTop: $('.specification').offset().top
                }, 700);
            })

            $('#btnShowQuestion').click(function () {
                $('body,html').animate({
                    scrollTop: $('.question').offset().top
                }, 700)
            })

            $('#btnToTop').click(function () {
                $('body,html').animate({
                    scrollTop: 0
                }, 700)
            })
        })

        $(window).scroll(function () {
            var boxTop = $(window).scrollTop() > 100 ? $(window).scrollTop() : 100;
            if (boxTop >= $('.footer').offset().top - $('.product-icon-box').height() - 300)
                boxTop = $('.footer').offset().top - $('.product-icon-box').height() - 300;
            $('.product-icon-box').css({ top: boxTop });
        })
    </script>
</asp:Content>