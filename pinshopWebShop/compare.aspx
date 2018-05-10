<%@ Page Language="C#" MasterPageFile="~/webShop.Master" AutoEventWireup="true" CodeBehind="compare.aspx.cs" Inherits="WebShop2.compare" %>
<%@ Register Src="userControls/ProductCompare.ascx" TagName="ProductCompare" TagPrefix="ProductCompare" %>

<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Upoređivanje proizvoda | PinShop</title>
    <%--<link href="<%=ResolveUrl("~/css/bootstrap.min.css") %>" rel="Stylesheet" />
    <link href="<%=ResolveUrl("~/css/StyleV2.css") %>" rel="Stylesheet" />--%>
    <%--<link href="<%=ResolveUrl("~/css/style.min.css") %>" rel="Stylesheet" />
</head>
<body>--%>
    <%--<form id="form1" runat="server">--%>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">

</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <div class="row">
        <div class="col-md-12 page-content">
            <div class="row">
                <div class="col-md-12">
                    <asp:Label ID="lblStatus" runat="server" CssClass="alert" Visible="false"></asp:Label>
                </div>
            </div>
            <div>
                <asp:Repeater ID="rptProducts" runat="server">
                    <HeaderTemplate>
                        <div class="row">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <div class="col-lg-3">
                            <ProductCompare:ProductCompare ID="productCompare" runat="server" Product='<%#Container.DataItem %>' />
                        </div>
                    </ItemTemplate>
                    <FooterTemplate>
                        </div>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" runat="server" ContentPlaceHolderID="footer"></asp:Content>
    <%--</form>--%>
    <%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>--%>
    <%--<script src="<%=ResolveUrl("~/js/bootstrap.min.js") %>"></script>
    <script src="<%=ResolveUrl("~/js/product.js") %>"></script>--%>
    <%--<script src="<%=ResolveUrl("~/js/bundle.js") %>" type="text/javascript"></script>--%>
<%--</body>--%>
<%--</html>--%>
