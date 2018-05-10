<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Cart.ascx.cs" Inherits="WebShop2.UserControls.Cart" %>
<%@ Register src="CustomStatus.ascx" tagname="CustomStatus" tagprefix="uc1" %>
<div class="row">
    <div class="col-lg-12">
        <asp:Label ID="lblStatus" runat="server" Visible="false" CssClass="alert alert-warning status"></asp:Label>
        <asp:GridView ID="dgvCart" runat="server" CssClass="table table-striped table-condensed"
            AutoGenerateColumns="false" OnRowDataBound="dgvCart_RowDataBound" OnRowCommand="dgvCart_RowCommand" DataKeyNames="productID"
            OnRowDeleting="dgvCart_RowDeleting">
                <Columns>
                    <asp:TemplateField HeaderText="Rb">
                        <ItemTemplate>
                            <asp:Label ID="lblRowIndex" runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
            
                    <asp:TemplateField Visible="false">
                        <ItemTemplate>
                            <asp:Label ID="lblProductID" runat="server" Text='<%#Eval("productID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:HyperLink ID="lnkImage" runat="server" NavigateUrl='<%# "/proizvodi/" + eshopBE.Product.CreateFriendlyUrl(Eval("categoryName") + "/" + Eval("brandName") + " " + Eval("name") + "-" + Eval("productID")) %>'>
                            <asp:Image ID="imgProduct" runat="server" ImageUrl='<%#Eval("imageUrl")%>' CssClass="img-responsive" />
                            </asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
            
                    <asp:TemplateField HeaderText="Naziv">
                        <ItemTemplate>
                            <asp:HyperLink ID="lnkProduct" runat="server" NavigateUrl='<%# "/proizvodi/" + eshopBE.Product.CreateFriendlyUrl(Eval("categoryName") + "/" + Eval("brandName") + " " + Eval("name") + "-" + Eval("productID")) %>'>
                            <asp:Label ID="lblBrand" runat="server" Text='<%#Eval(ConfigurationManager.AppSettings["productFP_Line1"]) + " " + Eval(ConfigurationManager.AppSettings["productFP_Line2"]) + ", " + Eval("code")%>'></asp:Label>
                            </asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
            
                    <%--<asp:TemplateField HeaderText="Naziv" ControlStyle-Width="100px">
                        <ItemTemplate>
                            <asp:Label ID="lblName" runat="server" Text='<%#Eval("name") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>--%>
            
                    <asp:TemplateField Visible="true" HeaderText="Web cena" ControlStyle-CssClass="text-right" ItemStyle-CssClass="text-right" HeaderStyle-CssClass="text-right">
                        <ItemTemplate>
                            <asp:Label ID="lblProductPrice" runat="server" Text='<%#String.Format("{0:N2}", double.Parse(Eval("productPrice").ToString())) %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
            
                    <asp:TemplateField HeaderText="Vaša cena" ItemStyle-HorizontalAlign="Right" HeaderStyle-CssClass="text-right">
                        <ItemTemplate>
                            <asp:Label ID="lblUserPrice" runat="server" Text='<%#String.Format("{0:N2}", double.Parse(Eval("userPrice").ToString())) %>'></asp:Label>
                            <div class="coupon-wrapper" id="divCoupon" runat="server" style="display:none">
                                <span class="coupon">%</span>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
            
                    <asp:TemplateField ItemStyle-CssClass="padding-right-0 text-center" ControlStyle-Width="20px" ItemStyle-Width="20px">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnRemoveQuantity" runat="server" CommandName="RemoveQuantity" ToolTip="Smanji količinu za 1" CausesValidation="false"><span aria-hidden="true" class="glyphicon glyphicon-minus icon"></span></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Količina" ItemStyle-CssClass="padding-left-0 padding-right-0" ControlStyle-Width="50px" ItemStyle-Width="50px">
                        <ItemTemplate>
                            <asp:Panel ID="pnlQuantity" runat="server">
                                <asp:TextBox ID="txtQuantity" runat="server" Text='<%#Eval("quantity") %>' CssClass="text-center form-control"></asp:TextBox>
                                <%--<asp:LinkButton ID="btnUpdateQuantity" runat="server" Text="Ažuriraj" CommandName="UpdateQuantity"></asp:LinkButton>--%>
                            </asp:Panel>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-CssClass="padding-left-0 text-center" ControlStyle-Width="20px" ItemStyle-Width="20px">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnAddQuantity" runat="server" CommandName="AddQuantity" ToolTip="Povećaj količinu za 1" CausesValidation="false"><span aria-hidden="true" class="glyphicon glyphicon-plus icon"></span></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
            
                    <asp:TemplateField HeaderText="Iznos" ItemStyle-HorizontalAlign="Right" HeaderStyle-CssClass="text-right">
                        <ItemTemplate>
                            <asp:Label ID="lblSum" runat="server" Text='<%#String.Format("{0:N2}", double.Parse(Eval("total").ToString())) %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField Visible="false">
                        <ItemTemplate>
                            <asp:Label ID="lblCouponID" runat="server" Text='<%#Eval("couponID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
            
                    <asp:CommandField ShowDeleteButton="true" ButtonType="Link" ControlStyle-CssClass="fa fa-fw fa-trash" DeleteText="" ControlStyle-Width="20px" ItemStyle-Width="20px" />
                </Columns>    
            </asp:GridView>
    </div><%--col--%>
</div><%--row--%>
<div class="row margin-top-1">
    <div class="col-md-3 col-md-offset-9">
        <div class="total-box">
            <div class="form-horizontal">
                <div class="form-group margin-bottom-0">
                    <label class="control-label col-md-5">Osnovica:</label>
                    <div class="col-md-7">
                        <asp:Label ID="lblOsnovica" runat="server" CssClass="value text-right"></asp:Label>             
                    
                        <%--<div class="col-md-1">--%>
                        <span class="currency">RSD</span>
                        <%--</div>--%>
                    </div>
                </div>            
                <div class="form-group margin-bottom-0">
                    <label class="control-label col-md-5">PDV:</label>
                    <div class="col-md-7">
                        <asp:Label ID="lblTax" runat="server" CssClass="value text-right"></asp:Label>
                        <span class="currency">RSD</span>
                    </div>
                </div>
                <div class="form-group margin-bottom-0">
                    <label class="control-label col-md-5">Ukupno: </label>
                    <div class="col-md-7">
                        <asp:Label ID="lblTotal" runat="server" CssClass="value value-total text-right"></asp:Label>
                        <span class="currency">RSD</span>
                    </div>
                </div>
            </div>
        </div>
    </div><%--col--%>
</div><%--row--%>
<div class="row">
    <%--<div class="col-lg-6">
        <label>Kupon za popust: </label>
        <asp:TextBox ID="txtCoupon" runat="server"></asp:TextBox>
        <asp:LinkButton ID="btnAddCoupon" runat="server" Text="Unesi" OnClick="btnAddCoupon_Click" CssClass="standardButton"></asp:LinkButton>
        <asp:LinkButton ID="btnDeleteCoupon" runat="server" Text="Obriši kupon" OnClick="btnDeleteCoupon_Click" Visible="false"></asp:LinkButton>        
    </div><!--col-->--%>
    
</div><%--row--%>


















<div id="cart">
    <%--<uc1:CustomStatus ID="CustomStatus1" runat="server" Visible="false" />--%>
    
    
    
    
    <div class="total">
        
    </div>
    
    <div class="buttons">
        
    </div>
    
    <div class="coupons">
        <p class="row">
            
        </p>
    </div>
</div>

