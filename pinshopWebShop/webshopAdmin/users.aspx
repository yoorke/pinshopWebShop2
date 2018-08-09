﻿<%@ Page Language="C#" MasterPageFile="~/webshopAdmin/adminPanel.Master" AutoEventWireup="true" CodeBehind="users.aspx.cs" Inherits="webshopAdmin.users" Title="Korisnici | Admin panel" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Korisnici</h1>
            </div><!--col-->
        </div><!--row-->
        <div class="row">
            <div class="col-lg-12">
                <div class="btn-group">
                    <asp:Button ID="btnAddUser" runat="server" Text="Dodaj korisnika" OnClick="btnAddUser_Click" CssClass="btn btn-primary" />
                </div><!--btn-group-->
            </div><!--col-->
        </div><!--row-->
        <div class="row margin-top-2">
            <div class="col-lg-12">
                <div class="table-responsive">
                    <asp:GridView ID="dgvUsers" runat="server" CssClass="table table-condensed table-bordered table-hover table-striped"
                        AutoGenerateColumns="false"
                        OnRowDeleting="dgvUsers_RowDeleting" DataKeyNames="userID" OnRowDataBound="dgvUsers_RowDataBound">
                        <Columns>
                            <asp:TemplateField Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblUserID" runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Username" ControlStyle-Width="100px">
                                <ItemTemplate>
                                    <asp:HyperLink ID="lnkUsername" runat="server" NavigateUrl='<%#"/" + ConfigurationManager.AppSettings["webshopAdminUrl"] + "/user.aspx?userID=" + Eval("userID") %>'>
                                        <asp:Label ID="lblUsername" runat="server" Text='<%#Eval("username") %>'></asp:Label>
                                    </asp:HyperLink>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Ime" ControlStyle-Width="100px">
                                <ItemTemplate>
                                    <asp:Label ID="lblFirstName" runat="server" Text='<%#Eval("firstName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Prezime" ControlStyle-Width="100px">
                                <ItemTemplate>
                                    <asp:Label ID="lblLastName" runat="server" Text='<%#Eval("lastName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Type" ControlStyle-Width="100px">
                                <ItemTemplate>
                                    <asp:Label ID="lblUserType" runat="server" Text='<%#Eval("userType") %>'></asp:Label>
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
