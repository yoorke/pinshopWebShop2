<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomStatus.ascx.cs" Inherits="WebShop2.UserControls.CustomStatus" %>
<%--<link href="../administrator/css/style.css" rel="stylesheet" type="text/css" />--%>
<div class="row">
    <div class="col-md-12" id="divCol" runat="server">
        <asp:Label ID="lblStatusText" runat="server" CssClass="alert status"></asp:Label>
    </div>
</div>