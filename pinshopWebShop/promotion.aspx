﻿<%@ Page Title="" Language="C#" MasterPageFile="~/webShop.Master" AutoEventWireup="true" CodeBehind="promotion.aspx.cs" Inherits="WebShop2.promotion" %>
<%@ Register Src="/userControls/Banner.ascx" TagName="Banner" TagPrefix="banner" %>
<%@ Register Src="/userControls/product_fp.ascx" TagName="ProductFP" TagPrefix="productFP" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%=ResolveUrl("~/css/mainMenuVerticalV1.min.css") %>" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-xs-2 left-column visible-md visible-lg">
        <banner:Banner id="banner1" runat="server" Position="FP1" />
        <banner:Banner ID="banner2" runat="server" Position="FP2" />
    </div>
    <div class="col-lg-10 col-md-10 col-xs-12 col-sm-12 main-content first-page">
        <div class="row">
            <div class="col-lg-12">
                <h1><asp:Literal  ID="lblPromotionName" runat="server"></asp:Literal></h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <asp:Repeater ID="rptProducts" runat="server">
                    <ItemTemplate>
                        <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12 padding-left-0 padding-right-0 margin-top-05">
                            <productFP:ProductFP id="product_fp1" runat="server" ProductItem='<%#Container.DataItem %>' />
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
</asp:Content>
