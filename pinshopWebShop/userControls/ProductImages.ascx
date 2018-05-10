<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductImages.ascx.cs" Inherits="WebShop2.UserControls.ProductImages" %>
<div class="row">
    <div class="col-md-12">
        <asp:HyperLink ID="lnkMainImage" runat="server" data-lightbox="main-image">
            <asp:Image ID="imgMain" runat="server" CssClass="img-responsive main-image" />
        </asp:HyperLink>
    </div>
</div>
<asp:Repeater ID="rptThumbImages" runat="server" OnItemDataBound="rptThumbImages_ItemDataBound">
    <ItemTemplate>
        <asp:HyperLink ID="lnkThumbImage" runat="server" NavigateUrl='<%#Eval("imageUrl") %>'></asp:HyperLink>
    </ItemTemplate>
</asp:Repeater>

<asp:Panel ID="pnlThumbs" runat="server" CssClass="row thumbs-images"></asp:Panel>