<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductSlider.ascx.cs" Inherits="WebShop2.UserControls.ProductSlider" EnableViewState="false" %>
<%@ Register Src="~/userControls/ProductFpV2.ascx" TagName="ProductFpV2" TagPrefix="Ws2" %>
<div class="row product-slider-header">
    <div class="col-md-10">
        <asp:HyperLink ID="lnkName" runat="server" NavigateUrl='<%# "/proizvodi/" + Eval("url") %>'>
            <h2><asp:Label ID="lblName" runat="server" Text='<%#Eval("name") %>'></asp:Label></h2>
        </asp:HyperLink>
    </div>
    <div class="col-md-2">
        <%-- Controls --%>
        <%--<div class="controls pull-right hidden-xs">
            <asp:Literal ID="lblPrev" runat="server"></asp:Literal>
            <asp:Literal ID="lblNext" runat="server"></asp:Literal>--%>
            <%--<a id="prev" runat="server" href="#carousel-example" data-slide="prev"><img src="<%=ResolveUrl("~/images/prev_next.gif") %>" alt="Prethodni" /></a>
            <a id="next" runat="server" href="#carousel-example" data-slide="next" class="next_button"><img src="<%=ResolveUrl("~/images/prev_next.gif") %>" alt="Sledeći" /></a>--%>
        <%--</div>--%><%--controls--%>
    </div><%--col--%>
</div><%--row--%>
<div class="row">
<div class="col-lg-12">
    <asp:Literal ID="lblPrev1" runat="server"></asp:Literal>
    <asp:Literal ID="lblNext1" runat="server"></asp:Literal>
<asp:Literal ID="lblCarousel" runat="server"></asp:Literal>
<%--<!--<div id="carouselexample" class="carousel slide" data-ride="" runat="server">-->
    <!-- wrapper for slides -->--%>
    <div class="carousel-inner">
        <asp:Repeater ID="rptSlides" runat="server" OnItemDataBound="rptSlides_ItemDataBound">
            <HeaderTemplate>
                
            </HeaderTemplate>
            <ItemTemplate>
                <div class="item" id="divHeader" runat="server">
                    <div class="row">
                        <asp:Repeater ID="rptProducts" runat="server" OnItemDataBound="rptProducts_ItemDataBound">
                            <ItemTemplate>
                                <div id="colDiv" runat="server" class="col-lg-2 col-md-3 col-sm-3 col-xs-6">
                                    <Ws2:ProductFpV2 ID="productFirstPage1" runat="server" ProductItem='<%#Container.DataItem %>' />
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div><%--row--%>
                </div><%--item--%>
            </ItemTemplate>
            <FooterTemplate>
                    
            </FooterTemplate>
        </asp:Repeater>
        <asp:Literal ID="lblCarouselClose" runat="server"></asp:Literal>
                <%--<div class="col-lg-2 col-md-2 col-sm-3 col-xs-12 padding-left-0 padding-right-0">
                    <product_fp:ProductFirstPage ID="product_fp1" runat="server" />
                </div><!--col-->
                <div class="col-lg-2 col-md-2 col-sm-3 col-xs-12 padding-left-0 padding-right-0">
                    <product_fp:ProductFirstPage ID="ProductFirstPage1" runat="server" />
                </div><!--col-->
                <div class="col-lg-2 col-md-2 col-sm-3 col-xs-12 padding-left-0 padding-right-0">
                    <product_fp:ProductFirstPage ID="ProductFirstPage2" runat="server" />
                </div><!--col-->
                <div class="col-lg-2 col-md-2 col-sm-3 col-xs-12 padding-left-0 padding-right-0">
                    <product_fp:ProductFirstPage ID="ProductFirstPage3" runat="server" />
                </div><!--col-->
                <div class="col-lg-2 col-md-2 col-sm-3 col-xs-12 padding-left-0 padding-right-0">
                    <product_fp:ProductFirstPage ID="ProductFirstPage8" runat="server" />
                </div><!--col-->
                <div class="col-lg-2 col-md-2 col-sm-3 col-xs-12 padding-left-0 padding-right-0">
                    <product_fp:ProductFirstPage ID="ProductFirstPage9" runat="server" />
                </div><!--col-->
            
        <div class="item">
            <div class="row">
                <div class="col-lg-2 col-md-2 col-sm-4 col-xs-12">
                    <product_fp:ProductFirstPage ID="ProductFirstPage4" runat="server" />
                </div><!--col-->
                <div class="col-lg-2 col-md-2 col-sm-4 col-xs-12">
                    <product_fp:ProductFirstPage ID="ProductFirstPage5" runat="server" />
                </div><!--col-->
                <div class="col-lg-2 col-md-2 col-sm-4 col-xs-12">
                    <product_fp:ProductFirstPage ID="ProductFirstPage6" runat="server" />
                </div><!--col-->
                <div class="col-lg-2 col-md-2 col-sm-4 col-xs-12">
                    <product_fp:ProductFirstPage ID="ProductFirstPage7" runat="server" />
                </div><!--col-->
            </div><!--row-->
        </div><!--item-->--%>
    <%--<!--</div>-->
        <!--carusel-->--%>
</div><%--carousel--%>
</div><%--col--%>
</div><%--row--%>
