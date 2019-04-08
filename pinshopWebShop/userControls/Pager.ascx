<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Pager.ascx.cs" Inherits="WebShop2.UserControls.Pager" EnableViewState="true" %>
<div class="row paging">
    <div class="col-lg-12">
        <asp:Repeater ID="rptPaging" runat="server" OnItemCommand="rptPaging_ItemCommand" OnItemDataBound="rptPaging_ItemDataBound">
            <ItemTemplate>
                <asp:LinkButton ID="lnkPage" runat="server" CommandArgument='<%#Eval("PageIndex") %>' CommandName="paging" Text='<%#Eval("PageText") %>'></asp:LinkButton>
            </ItemTemplate>
        </asp:Repeater>
    </div><%--col--%>
</div><%--row--%>