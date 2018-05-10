<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MainMenuVerticalV2.ascx.cs" Inherits="WebShop2.UserControls.MainMenuVerticalV2" EnableViewState="false" %>
<%--<%@ Register Src="~/userControls/Banner.ascx" TagName="Banner" TagPrefix="banner" %>--%>
<%@ Register Src="~/userControls/CategoryBanner.ascx" TagName="CategoryBanner" TagPrefix="ws" %>

<a class="cd-dropdown-trigger" href="#"><span class="glyphicon glyphicon-menu-hamburger"></span> Proizvodi</a>
<nav class="cd-dropdown">
    <h2>Proizvodi</h2>
    <a href="#" class="cd-close">Close</a>
    <ul class="cd-dropdown-content">

        <asp:Repeater ID="rptMainMenu" runat="server" OnItemDataBound="rptMainMenu_ItemDataBound">
            <ItemTemplate>
                <li id="li" runat="server">
                    
                    <asp:Hyperlink ID="lnkMenuItem" runat="server" NavigateUrl='<%#Eval("url") %>'>
                        <asp:Label ID="lblIcon" runat="server" CssClass='<%#Eval("icon") + " icon" %>' Visible='<%#!Eval("icon").Equals(string.Empty) %>'></asp:Label>
                        <asp:Label Text='<%#Eval("name") %>' runat="server"></asp:Label>
                    </asp:Hyperlink>
                    <div class="separator" runat="server" visible="false"></div>
                    <asp:Repeater ID="rptSubMenu" runat="server" DataSource='<%#Eval("SubCategory") %>' OnItemDataBound="rptSubMenu_ItemDataBound">
                        <HeaderTemplate>
                            <ul class="cd-secondary-dropdown is-hidden">
                            <li class="go-back"><a href="#0">Nazad</a></li>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <li id="secondLi" runat="server">
                                <asp:HyperLink ID="lnkSubMenu" runat="server" NavigateUrl='<%# ResolveUrl("~" + Eval("url")) %>'>
                                    <asp:HiddenField ID="lblImageUrlSource" runat="server" Value='<%#Eval("imageUrlSource") %>'></asp:HiddenField>
                                    <asp:HiddenField ID="lblImageUrlPositionX" runat="server" Value='<%#Eval("imageUrlPositionX") %>' />
                                    <asp:HiddenField ID="lblImageUrlPositionY" runat="server" Value='<%#Eval("imageUrlPositionY") %>' />
                                    <span id="imgSprite" runat="server" class="img-sprite" visible='<%#Eval("imageUrlSource").ToString().Equals("1") %>' style=""></span>
                                    <asp:Image ID="imgCategory" runat="server" ImageUrl='<%# ResolveUrl("~/" + Eval("imageUrl")) %>' CssClass="menu-img" Visible='<%#Eval("imageUrl").ToString() != string.Empty && Eval("imageUrlSource").ToString().Equals("0") %>' />
                                    <asp:Label ID="lblName" runat="server" Text='<%#Eval("name") %>'></asp:Label>
                                </asp:HyperLink>
                                        
                                <asp:Repeater ID="rptSubMenu3" runat="server" DataSource='<%#Eval("SubCategory") %>'>
                                    <ItemTemplate>
                                        <ul class="is-hidden">
                                            <li>
                                                <asp:HyperLink ID="lnkSubMenu3" runat="server" NavigateUrl='<%#Eval("url") %>' Text='<%#Eval("name") %>'></asp:HyperLink>
                                            </li>
                                        </ul>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </li>

                        </ItemTemplate>
                        <FooterTemplate>
                            <li class="categoryBanner visible-lg visible-md">
                                        
                                <%--<img src="/images/no-image.jpg" style="position:absolute;right:0;bottom:0" />--%>
                                <%--<banner:Banner ID="categoryBanner" runat="server" Position="FP2" />--%>
                                <ws:CategoryBanner ID="categoryBanner1" runat="server" CategoryBannerID='<%# ((eshopBE.Category)((RepeaterItem)(Container.NamingContainer.NamingContainer)).DataItem).CategoryBannerID %>'  />
                                <%--<asp:Label runat="server" Text='<%# ((eshopBE.Category)((RepeaterItem)(Container.NamingContainer.NamingContainer)).DataItem).CategoryBannerID %>'></asp:Label>--%>
                            </li>
                            <li class="bottom">
                                <div class="bottomExtraMenu">
                                    <%-- %><asp:Repeater ID="rptExtraMenus" runat="server" DataSource='<%#((eshopBE.Category)((RepeaterItem)(Container.NamingContainer.NamingContainer)).DataItem).CategoryExtraMenus %>'>
                                        <ItemTemplate>
                                            <asp:Label ID="lblExtraMenuName" runat="server" Text='<%#Eval("name") + ":" %>' CssClass="categoryExtraMenuName"></asp:Label>
                                            <asp:Repeater ID="lblBrands" runat="server" DataSource='<%#Eval("brands") %>'>
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="lnkBrand" runat="server" NavigateUrl='<%# ((eshopBE.Category)((RepeaterItem)((Repeater)((RepeaterItem)((Repeater)((RepeaterItem)((Repeater)Container.NamingContainer).NamingContainer).NamingContainer).NamingContainer).NamingContainer).NamingContainer).DataItem).Url + "?brands=" + Eval("brandID") %>' CssClass="padding-right-0">
                                                        <asp:Label ID="lblBrand" runat="server" Text='<%#Eval("name")%>'></asp:Label>
                                                    </asp:HyperLink>
                                                    <span class="extraMenuSeparator"> | </span>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <%--<%#((eshopBE.Category)((RepeaterItem)(Container.NamingContainer.NamingContainer)).DataItem).CategoryExtraMenus.Count.ToString() %>--%>
                                </div>
                            </li>
                        </ul>
                        </FooterTemplate>
                    </asp:Repeater>
                            
                </li>
            </ItemTemplate>
        </asp:Repeater>
        <%--<li class="has-children">
            <a href="#">Clothing</a>
            <ul class="cd-secondary-dropdown is-hidden">
                <li class="has-children">
                    <a href="#">Accessories</a>
                </li>
                <li class="has-children">
                    <a href="#">Bottoms</a>
                </li>
            </ul>
                   
        </li>
        <li>
            <a href="#">Semenska roba</a>
        </li>
        <li>
            <a href="#">Hidraulične komponente</a>
        </li>
        <li>
            <a href="#">Menu 2</a>
        </li>
        <li>
            <a href="#">Menu 3</a>
        </li>--%>
    </ul>
</nav>