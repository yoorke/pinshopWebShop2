<%@ Page Title="" Language="C#" MasterPageFile="~/webShop.Master" AutoEventWireup="true" CodeBehind="passwordChanged.aspx.cs" Inherits="WebShop2.passwordChanged" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%=ResolveUrl("~/css/mainMenuVerticalV1.min.css") %>" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="loginMessage text-center">
        <p>Poštovani, Vaš šifra je uspešno izmenjena. Prijavite se na portal preko stranice <a href="/prijava">Prijava</a>.</p>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
</asp:Content>
