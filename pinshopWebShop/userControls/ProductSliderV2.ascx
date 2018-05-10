<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductSliderV2.ascx.cs" Inherits="WebShop2.UserControls.ProductSliderV2" EnableViewState="false" %>
<div class="row">
    <div class="col-lg-12">
        <asp:Repeater ID="rptProductSlider" runat="server">
            <HeaderTemplate>
                <ul class="bxslider">
            </HeaderTemplate>
            <ItemTemplate>
                <li>
                    <div class="wrapper">
                        <div class="product-inner">
                            <asp:HyperLink ID="lnkProduct" runat="server" NavigateUrl='<%#Eval("url") %>'>
                                <asp:Label ID="lblBrand" runat="server" CssClass="product-brand" Text='<%#Eval("brand.Name") %>'></asp:Label>
                                <asp:Label ID="lblProductName" runat="server" CssClass="product-name" Text='<%#Eval("name") %>'></asp:Label>
                                <asp:Image ID="imgProductImage" runat="server" CssClass="product-image" ImageUrl='<%#new eshopBL.ProductBL().CreateImageDirectory(int.Parse(Eval("images[0].imageUrl").ToString().Substring(0, Eval("images[0].imageUrl").ToString().IndexOf(".")))) + Eval("images[0].imageUrl").ToString().Substring(0, Eval("images[0].imageUrl").ToString().IndexOf(".")) + "-" + ConfigurationManager.AppSettings["mainName"] + Eval("images[0].imageUrl").ToString().Substring(Eval("images[0].imageUrl").ToString().IndexOf(".")) %>' />
                                <asp:Label ID="lblProductPrice" runat="server" CssClass="product-price" Text='<%#string.Format("{0:N2}", double.Parse(Eval("webPrice").ToString())) + " din" %>'></asp:Label>
                                <asp:Label ID="lblProductAttribute1" runat="server" CssClass="product-attribute attribute1" Text='<%#Eval("attributes[0].Value") %>'></asp:Label>
                                <asp:Label ID="lblProductAttribute2" runat="server" CssClass="product-attribute attribute2" Text='<%#Eval("attributes[1].Value") %>'></asp:Label>
                                <asp:Label ID="lblProductAttribute3" runat="server" CssClass="product-attribute attribute3" Text='<%#Eval("attributes[2].Value") %>'></asp:Label>
                                <asp:Label ID="lblProductAttribute4" runat="server" CssClass="product-attribute attribute4" Text='<%#Eval("attributes[3].Value") %>'></asp:Label>
                            </asp:HyperLink>
                        </div>
                    </div>
                </li>
            </ItemTemplate>
            <FooterTemplate>
                </ul>
            </FooterTemplate>
        </asp:Repeater>
    </div>
</div>