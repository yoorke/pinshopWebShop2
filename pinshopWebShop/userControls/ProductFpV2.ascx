<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductFpV2.ascx.cs" Inherits="WebShop2.UserControls.ProductFpV2" EnableViewState="false" %>
<%@ Register Src="~/userControls/ProductRatingView.ascx" TagName="ProductRating" TagPrefix="Ws" %>
<div class="product-fp">
    <div class="wrapper">
        <asp:LinkButton ID="btnDeleteFromWishList" runat="server" CssClass="btn-deleteFromWishList" OnClick="btnDeleteFromWishList_Click" Visible="false"><span class="glyphicon glyphicon-remove"></span></asp:LinkButton>
        <asp:HyperLink ID="lnkEditProduct" runat="server" CssClass="btn_editProduct" Visible="false" Target="_blank" ToolTip="Izmeni proizvod"></asp:HyperLink>
        <div class="photo">
            <div class="nis-cont" id="divNis" runat="server" style="display:none">
                <asp:Label ID="lblNotification" runat="server"></asp:Label>
            </div>
            <asp:HyperLink ID="lnkPhoto" runat="server">
                <asp:Image ID="imgPhoto" runat="server" ImageUrl="~/images/no-image.jpg" CssClass="img-responsive" />
            </asp:HyperLink>
        </div><%--photo--%>
        <asp:HyperLink ID="lnkName" runat="server">
            <h3><asp:Label ID="lblBrand" runat="server"></asp:Label></h3>
            <h4><asp:Label ID="lblName" runat="server"></asp:Label></h4>
        </asp:HyperLink>
        <Ws:ProductRating ID="productRating" runat="server" />      
        <asp:Image ID="imgPromotion" runat="server" CssClass="promotion" Visible="false" data-toggle="tooltip" data-placement="top" data-container="body" AlternateText="Promotion"/>
        <div class="price_div" runat="server" id="price_div">
            <span class="price_label">M.P.</span>
            <asp:Label ID="lblPrice" runat="server" CssClass="price" Visible="false">312</asp:Label>
            <span class="price_label">din</span>
        </div><%--price_div--%>
        <div class="webprice_div">
            <asp:Label ID="lblCode" runat="server" CssClass="code hidden-sm hidden-xs" ToolTip="Šifra proizvoda"></asp:Label>
            <span class="webprice_label"></span>
            <asp:Label ID="lblWebPrice" runat="server">12313,12</asp:Label>
            <span class="webprice-label">RSD</span>
        </div>
        <div id="savingDiv" class="saving_div" runat="server">
            <%--<span class="saving_label">Ušteda</span>--%>
            <asp:Label ID="lblSaving" runat="server" CssClass="saving" Visible="false">3213,32</asp:Label>
            <%--<span class="saving_label">din</span>--%>
        </div>
        <div class="buttons">
            <%--<asp:LinkButton ID="btnCart" runat="server" CssClass="btn_cart" OnClick="btnCart_Click" Text=""></asp:LinkButton>--%>
            <button type="button" id="btnCartAjax" class="ws-btn btn-cart" runat="server"><span class="fa fa-fw fa-shopping-cart"></span><span> Dodaj u korpu</span></button>
            <%--<asp:LinkButton ID="btnDetails" runat="server" Text="Detalji" CssClass="btn_details"></asp:LinkButton>--%>
            <asp:HyperLink ID="lblDetails" runat="server" CssClass="btn-details"><span>Detalji</span></asp:HyperLink>
            <%--<asp:LinkButton ID="btnCompare" runat="server" Text="Uporedi" CssClass="btn_compare" OnClientClick="function(){ $('#messageBoxCompare').show()}"></asp:LinkButton>--%>
            <button type="button" class="ws-btn btn-icon btn-compare" onclick="AddToCompare(event, '<%=lblProductID.ClientID %>')" data-toggle="tooltip" data-placement="top" title="Uporedi" data-container="body"><span class="fa fa-fw fa-square-o"></span></button>
            <button type="button" class="ws-btn btn-icon btn-wishlist" data-toggle="tooltip" data-placement="top" title="Ubaci u listu želja" data-container="body" onclick="AddToWishList(event, '<%=lblProductID.ClientID %>')"><span class="fa fa-fw fa-heart-o"></span></button>
            
        </div><%--buttons--%>
        <asp:HiddenField ID="lblProductID" runat="server" />
    </div><%--wrapper--%>
</div><%--product_fp--%>