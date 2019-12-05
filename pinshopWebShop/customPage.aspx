<%@ Page Language="C#" MasterPageFile="~/webShop.Master" AutoEventWireup="true" CodeBehind="customPage.aspx.cs" Inherits="WebShop2.customPage" Title="Untitled Page" %>
<%@ Register Src="userControls/Banner.ascx" TagName="Banner" TagPrefix="banner" %>
<%@ Register Src="userControls/ProductFPV2.ascx" TagName="ProductFP" TagPrefix="ws" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%=ResolveUrl("~/css/mainMenuVerticalV1.min.css") %>" />
    <asp:Literal ID="lblHeader" runat="server"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<div class="col-xs-2 left-column visible-lg visible-md">
        <banner:Banner ID="banner1" runat="server" Position="FP1" />
        <banner:Banner ID="banner2" runat="server" Position="FP2" />        
    </div>--%>
    <div class="col-lg-12 page-content custom-page">
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" id="customPage">
                <h1 class="heading"><asp:Literal ID="lblHeading" runat="server"></asp:Literal></h1>
        
                <div id="divContent" runat="server"></div>
            </div>
        </div>
        <div class="row margin-top-2 product_box">
            <asp:Repeater ID="rptProducts" runat="server">
                <ItemTemplate>
                    <div class="col-lg-3 col-md-4 col-sm-4 col-xs-6 product-fp-col">
                        <ws:ProductFP id="productFP" runat="server" ProductItem='<%#Container.DataItem %>' />
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <%--<div class="row banners">
            <div class="col-md-4 padding-left-0 padding-right-0 bannerFP fp1">
                <banner:Banner id="bannerCP1" runat="server" Position="CP1" />
            </div>
            <div class="col-md-4 bannerFP fp2">
                <banner:Banner ID="bannerCP2" runat="server" Position="CP2" />
            </div>
            <div class="col-md-4 padding-left-0 padding-right-0 bannerFP fp3">
                <banner:Banner ID="bannerCP3" runat="server" Position="CP3" />
            </div>
        </div>--%>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
    <asp:Literal ID="lblFooter" runat="server"></asp:Literal>
</asp:Content>
