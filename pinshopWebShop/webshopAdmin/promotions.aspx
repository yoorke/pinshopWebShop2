﻿<%@ Page Language="C#" MasterPageFile="~/webshopAdmin/adminPanel.Master" AutoEventWireup="true" CodeBehind="promotions.aspx.cs" Inherits="webshopAdmin.promotions" Title="Promocije | Admin panel" %>
<%@ Register src="customControls/CustomStatus.ascx" tagname="CustomStatus" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Promocije</h1>
            </div><!--col-->
        </div><!--row-->
        <div class="row">
            <div class="col-lg-12">
                <div class="btn-group">
                    <asp:Button ID="btnAddPromotion" runat="server" Text="Dodaj promociju" OnClick="btnAddPromotion_Click" CssClass="btn btn-primary" />            
                </div><!--btn-group-->
            </div><!--col-->
        </div><!--row-->
        <div class="row">
            <div class="col-lg-12">
                <uc1:CustomStatus ID="csStatus" runat="server" />        
            </div><!--col-->
        </div><!--row-->
        <div class="row margin-top-2">
            <div class="col-lg-12">
                <div class="table-responsive">
                    <asp:GridView ID="dgvPromotions" runat="server" AutoGenerateColumns="false" CssClass="table table-hover table-bordered table-condensed table-striped"
                        OnRowDeleting="dgvPromotions_RowDeleting" DataKeyNames="promotionID">
                        <Columns>
                            <asp:TemplateField HeaderText="ID" ControlStyle-Width="50px" Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblPromotionID" runat="server" Text='<%#Eval("promotionID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Naziv" ControlStyle-Width="200px">
                                <ItemTemplate>
                                    <asp:HyperLink ID="lnkName" runat="server" NavigateUrl='<%#"/" + ConfigurationManager.AppSettings["webshopAdminUrl"] + "/promotion.aspx?promotionID=" + Eval("promotionID") %>'>
                                        <asp:Label ID="lblName" runat="server" Text='<%#Eval("name") %>'></asp:Label>
                                    </asp:HyperLink>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Popust" ControlStyle-Width="50px">
                                <ItemTemplate>
                                    <asp:Label ID="lblValue" runat="server" Text='<%#Eval("value") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:CommandField ShowDeleteButton="true" DeleteText="" ControlStyle-Width="20px" DeleteImageUrl="images/delete_icon.png" ButtonType="Image" ItemStyle-Width="20px" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div><!--col-->
        </div><!--row-->
    </div><!--page-wrapper-->
    
    
    
    
    
    
    
    
    
    
    
    <%--<div id="topMenu">
        
    </div>
    
    <div id="mainContent">
        
        
    </div>--%>

</asp:Content>
