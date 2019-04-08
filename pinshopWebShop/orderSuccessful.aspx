<%@ Page Language="C#" MasterPageFile="~/webShop.Master" AutoEventWireup="true" CodeBehind="orderSuccessful.aspx.cs" Inherits="WebShop2.orderSuccessful" Title="Narudžbina uspešno prosleđena | Webshop" %>
<%@ Register Src="userControls/Banner.ascx" TagName="Banner" TagPrefix="Ws" %>
<asp:Content ID="content3" ContentPlaceHolderID="headBefore" runat="server">
    <script>
        var dataLayer = window.dataLayer = window.dataLayer || [];
        dataLayer.push({
            orderTotal: <%=this.OrderValue%>
        })
    </script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%=ResolveUrl("~/css/main-menu-vertical-v1.min.css") %>" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<div class="bannerColumn">
        <div class="banner"></div>
    </div>
    <div class="checkout">
        <div class="heading">Narudžbina uspešno prosleđena</div>
        <p class="description">
            Vaša narudžbina je uspešno prosleđena. Uskoro ćete primiti potvrdu na Vašu e-mail adresu sa detaljnim informacijama.
        </p>
    </div>
    <div class="bannerColumn">
        <div class="banner"></div>
    </div>
    --%>
    <%--<div class="col-xs-2 left-column visible-md visible-lg">
        <banner:Banner ID="banner1" runat="server" Position="FP1" />
        <banner:Banner ID="banner2" runat="server" Position="FP2" />
    </div><!--col-->--%>
    
    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 text-center margin-top-2">
        <span class="alert alert-success status">Vaša narudžbina je uspešno prosleđena. Uskoro ćete primiti potvrdu na Vašu email adresu sa detaljnim informacijama.</span>
    </div>

</asp:Content>
