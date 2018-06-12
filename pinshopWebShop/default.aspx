<%@ Page Title="" Language="C#" MasterPageFile="~/webShop.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="WebShop2._default" %>
<%@ Register Src="~/userControls/MainMenuVerticalV2.ascx" TagName="MainMenuVerticalV2" TagPrefix="Ws2" %>
<%@ Register Src="~/userControls/Slider.ascx" TagName="Slider" TagPrefix="Ws2" %>
<%@ Register Src="~/userControls/ProductSlider.ascx" TagName="ProductSlider" TagPrefix="Ws2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="<%# ResolveUrl("~/css/main-menu-vertical-v2.min.css") %>" rel="stylesheet" type="text/css" />
    <link href="<%# ResolveUrl("~/css/camera-bundle.min.css") %>" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-md-3 padding-left-0 padding-right-0">
            <Ws2:MainMenuVerticalV2 ID="mainMenuVerticalV2" runat="server" />
        </div>
        <div class="col-md-9">
            <Ws2:Slider ID="slider" runat="server" SliderID="12" />
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <asp:Repeater ID="rptPromotions" runat="server" OnItemDataBound="rptPromotions_ItemDataBound" EnableViewState="false">
                <ItemTemplate>
                    <asp:HiddenField ID="lblPromotionID" runat="server" Value='<%#Eval("promotionID") %>' />
                    <Ws2:ProductSlider ID="psPromotion" runat="server" />
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <asp:Repeater ID="rptCategories" runat="server" OnItemDataBound="rptCategories_ItemDataBound" EnableViewState="false">
                <ItemTemplate>
                    <asp:HiddenField ID="lblCategoryID" runat="server" Value='<%#Eval("categoryID") %>' />
                    <asp:HiddenField ID="lblNumberOfProducts" runat="server" Value='<%#Eval("numberOfProducts") %>' />
                    <asp:HiddenField ID="lblFirstPageOrderBy" runat="server" Value='<%#Eval("firstPageOrderBy") %>' />
                    <Ws2:ProductSlider ID="psCategory" runat="server" />
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <%--<div class="col-md-3">
            Banner
        </div>--%>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
    <script src="<%=ResolveUrl("~/js/main-menu-vertical-v2-start.min.js") %>"></script>
    <script src="<%=ResolveUrl("~/js/slider.min.js") %>"></script>
</asp:Content>
