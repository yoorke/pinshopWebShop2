<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PagerV2.ascx.cs" Inherits="WebShop2.UserControls.PagerV2" EnableViewState="false" %>
<div class="row paging">
    <div class="col-lg-12">
        <asp:Repeater ID="rptPaging" runat="server" OnItemCommand="rptPaging_ItemCommand" OnItemDataBound="rptPaging_ItemDataBound">
            <ItemTemplate>
                <%--<asp:LinkButton ID="lnkPage" runat="server" CommandArgument='<%#Eval("PageIndex") %>' CommandName="paging" Text='<%#Eval("PageText") %>'></asp:LinkButton>--%>
                <asp:Hyperlink ID="lblPage" runat="server" NavigateUrl="" Text='<%#Eval("PageText") %>'></asp:Hyperlink>
            </ItemTemplate>
        </asp:Repeater>
    </div><%--col--%>
</div><%--row--%>

<%--<script type="text/javascript">
    
</script>--%>