<%@ Page Language="C#" MasterPageFile="~/webShop.Master" AutoEventWireup="true" CodeBehind="wishList.aspx.cs" Inherits="WebShop2.wishList" Title="Lista želja | PinShop" %>
<%@ Register Src="userControls/Banner.ascx" TagName="Banner" TagPrefix="Ws2" %>
<%@ Register Src="userControls/ProductFpV2.ascx" TagName="ProductFP" TagPrefix="Ws2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%=ResolveUrl("~/css/main-menu-vertical-v1.min.css") %>" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--BANNER-->
    <%--<div class="col-xs-2 left-column visible-lg visible-md">
        <banner:Banner ID="banner1" runat="server" Position="FP1" />
        <banner:Banner ID="banner2" runat="server" Position="FP2" />
    </div>--%>
    <!--MAIN CONTENT-->
    <div class="col-xs-12 col-sm-12 col-md-10 col-lg-10 main-content page-content">
        <div class="row">
            <div class="col-lg-12">
                <h1>Lista želja</h1>
            </div>
        </div>
        <div class="row padding-left-05 padding-right-05">
            <asp:Repeater ID="rptProducts" runat="server">
                <ItemTemplate>
                    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12 padding-left-0 padding-right-0 margin-top-05">
                        <Ws2:ProductFP ID="product_fp1" runat="server" ProductItem='<%#Container.DataItem %>' WishList="true" />
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
</asp:Content>
