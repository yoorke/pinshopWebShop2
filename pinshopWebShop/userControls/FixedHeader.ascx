<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FixedHeader.ascx.cs" Inherits="WebShop2.userControls.FixedHeader" %>
<%@ Register Src="~/userControls/Search.ascx" TagName="SearchControl" TagPrefix="Ws2" %>
<div class="fixed-header">
    <div class="container">
        <div class="row">
            <div class="col-xs-1">
                <span class="fh-main-menu-toggle">
                    <span class="fa fa-fw fa-bars"></span>
                 </span>
            </div>
            <div class="col-xs-2">
                <%--<img src="/images/logo.png" class="logo" />--%>
                <span class="fh-cont">Pin Service & Shop</span>
            </div>
            <div class="col-xs-6">
                <Ws2:SearchControl runat="server" />
            </div>
            <div class="col-xs-2">
                <div class="fh-cont">
                    <asp:LoginView runat="server" EnableViewState="false">
                        <AnonymousTemplate>
                            <a href="/prijava" class=""><span class="fa fa-fw fa-user"></span> Prijava</a>
                            <a href="/registracija" class=""><span class="fa fa-fw fa-user-plus"></span> Registracija</a>
                        </AnonymousTemplate>
                        <LoggedInTemplate>
                            <span>Dobrodošli, </span><asp:Label ID="lblFHUsername" runat="server"></asp:Label>
                            <asp:LinkButton ID="btnLogout" runat="server" OnClick="btnLogout_Click" Text="Odjava" EnableViewState="false" CausesValidation="false"></asp:LinkButton>
                        </LoggedInTemplate>
                    </asp:LoginView>
                </div>
            </div>
            <div class="col-xs-1 cart">
                <span class="cart-cont">
                    <span class="fa fa-fw fa-shopping-cart" onclick="ShowCartFpContainer('', event)"></span>
                    <span id="fhCartProductsCount" class="fh-cart-products-count">0</span>
                </span>
            </div>
        </div>
    </div>
</div>