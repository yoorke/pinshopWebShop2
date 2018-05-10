<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Retail.ascx.cs" Inherits="WebShop2.UserControls.Retail" %>
<div class="retail">
    <div class="retail-name">        
        <asp:Label ID="lblName" runat="server"></asp:Label>
    </div>
    <div class="retail-address">
        <asp:Label ID="lblAddress" runat="server"></asp:Label>
    </div>
    <div class="retail-phone">
        <span class="fa fa-fw fa-phone"></span>
        <asp:Label ID="lblPhone" runat="server"></asp:Label>
    </div>
    <div class="retail-phone">
        <span class="fa fa-fw fa-mobile"></span>
        <asp:Label ID="lblMobilePhone" runat="server"></asp:Label>
    </div>
</div>