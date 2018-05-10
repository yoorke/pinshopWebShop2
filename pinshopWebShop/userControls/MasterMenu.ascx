<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MasterMenu.ascx.cs" Inherits="WebShop2.UserControls.MasterMenu" EnableViewState="false" %>
<nav class="master-menu navbar navbar-default">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#master-menu">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
        </div>
        <div class="collapse navbar-collapse" id="master-menu">
            <asp:Repeater ID="rptMasterMenu" runat="server">
                <HeaderTemplate>
                    <ul class="nav navbar-nav navbar-right">
                </HeaderTemplate>
                <ItemTemplate>
                    <li><asp:HyperLink runat="server" NavigateUrl='<%# ResolveUrl("~/" + Eval("url")) %>' Text='<%#Eval("name") %>'></asp:HyperLink></li>
                </ItemTemplate>
                <FooterTemplate>
                    </ul>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </div>
</nav>