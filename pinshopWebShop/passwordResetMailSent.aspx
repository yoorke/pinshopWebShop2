<%@ Page Title="" Language="C#" MasterPageFile="~/webShop.Master" AutoEventWireup="true" CodeBehind="passwordResetMailSent.aspx.cs" Inherits="WebShop2.passwordResetMailSent" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%=ResolveUrl("~/css/mainMenuVerticalV1.min.css") %>" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="loginMessage text-center">
        <p>Poštovani, email poruka sa linkom za kreiranje nove korisničke šifre je poslat na Vašu email adresu.</p>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
</asp:Content>
