<%@ Page Language="C#" MasterPageFile="~/webShop.Master" AutoEventWireup="true" CodeBehind="cart.aspx.cs" Inherits="WebShop2.cart" Title="Korpa | PinShop" %>
<%@Register Src="userControls/Cart.ascx" TagName="Cart" TagPrefix="Cart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%=ResolveUrl("~/css/main-menu-vertical-v1.min.css") %>" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <asp:ScriptManager runat="server"></asp:ScriptManager>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <div class="col-md-12 page-content">
                <div class="row">
                    <div class="col-lg-12">
                        <h1>Korpa</h1>
                    </div>
                    <div class="col-lg-12">
                        <div class="row margin-top-2 cart-page" id="cart">
                            <div class="col-lg-12">
                                <Cart:Cart ID="cart1" runat="server" />
                            </div><%--col--%>
                        </div><%--row--%>
                        <div class="row margin-bottom-2 margin-top-2">
                            <div class="col-lg-12">
                                <div class="pull-right">
                                    <asp:LinkButton ID="btnContinueShopping" runat="server" Text="Nastavi kupovinu" OnClick="btnContinueShopping_Click" CssClass="btn btn-default" CausesValidation="false"></asp:LinkButton>    
                                    <asp:LinkButton ID="btnCheckout" runat="server" Text="Naruči" OnClick="btnCheckout_Click" CssClass="btn btn-primary" CausesValidation="false"></asp:LinkButton>
            
                                </div>
                            </div><%--col--%>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
    
</asp:Content>
