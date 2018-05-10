<%@ Page Language="C#" MasterPageFile="~/webShop.Master" AutoEventWireup="true" CodeBehind="checkout.aspx.cs" Inherits="WebShop2.checkout" Title="Podaci o narudžbini | Webshop" %>
<%--@ Register src="user_controls/checkout.ascx" TagName="Checkout" TagPrefix="uc1"--%>
<%@ Register Src="userControls/CheckoutV2.ascx" TagName="CheckoutV2" TagPrefix="Ws2" %>
<%@ Register Src="userControls/CheckoutInfo.ascx" TagName="CheckoutInfo" TagPrefix="Ws2" %>
<%@ Register Src="userControls/Cart.ascx" TagName="Cart" TagPrefix="Ws2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%=ResolveUrl("~/css/main-menu-vertical-v1.min.css") %>" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<div class="bannerColumn">
        <div class="banner"></div>
    </div>--%>
    <div class="col-lg-12">
        <asp:ScriptManager runat="server"></asp:ScriptManager>
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <div class="row page-content">
                    <div class="col-lg-12">
                        <div id="cart">
                            <Ws2:Cart ID="cart1" runat="server" />
                        </div>
                        <%--<uc3:CheckoutInfo ID="checkoutInfo1" runat="server" />--%>
                        <div>
                            <Ws2:CheckoutV2 ID="checkout1" runat="server" />
                        </div>
                        <%--<uc1:Checkout ID="checkout1" runat="server" />--%>
                    </div>
                </div><%--row--%>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    
    <%--<div class="bannerColumn">
        <div class="banner"></div>
    </div>--%>
    
    <script type="text/javascript">
        function scrollToAccount() {
            var a = document.getElementById("account");
            a.scrollIntoView();
            var txtLastname = document.getElementById("ctl00_ContentPlaceHolder1_checkout1_txtLastname");
            txtLastname.focus();
        }
    </script>
</asp:Content>
<asp:Content ID="contentPlac3" runat="server" ContentPlaceHolderID="footer">
    <script>
        $(document).ready(function () {
            $('#ctl00_ContentPlaceHolder1_checkout1_rdbDelivery_0').change(function () {
                if (this.value == '1') {
                    $('#showShop').show();
                    $('#showDeliveryInfo').hide();
                }
                else{
                    $('#showShop').hide();
                    $('#showDeliveryInfo').show();
                }
            })
            $('#ctl00_ContentPlaceHolder1_checkout1_rdbDelivery_1').change(function () {
                if (this.value == '2'){
                    $('#showShop').hide();
                    $('#showDeliveryInfo').show();
                }
            })
        })
    </script>
</asp:Content>
