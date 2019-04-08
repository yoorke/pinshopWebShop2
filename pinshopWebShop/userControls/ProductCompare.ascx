<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductCompare.ascx.cs" Inherits="WebShop2.UserControls.ProductCompare" %>
<div class="row product-compare">
    <div class="close">
        <span class="glyphicon glyphicon-remove" onclick="btnProductCompareRemove_Click('<%=lblProductID.ClientID %>')"></span>
    </div>
    <div class="col-lg-12">
        <div class="row">
            <div class="col-lg-12 text-center">
                <asp:Image ID="imgProduct" runat="server" />
            </div><%--col--%>
        </div><%--row--%>
        <asp:HiddenField ID="lblProductID" runat="server" />
        <div class="row">
            <div class="col-lg-12 text-center product-brand">
                <asp:Literal ID="lblBrand" runat="server"></asp:Literal>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <h2 class="product-name"><asp:Literal ID="lblProductName" runat="server"></asp:Literal></h2>
            </div>
        </div><%--row--%>
        <div class="row">
            <div class="col-lg-12 product-price text-right">
                <asp:Literal ID="lblWebPrice" runat="server"></asp:Literal> din
            </div>
        </div><%--row--%>
        <div class="row specification">
            <div class="col-lg-12">
                <asp:Literal ID="lblSpecification" runat="server"></asp:Literal>
            </div>
        </div>
    </div>
</div><%--row--%>