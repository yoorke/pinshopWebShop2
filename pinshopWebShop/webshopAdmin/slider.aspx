﻿<%@ Page Language="C#" MasterPageFile="~/webshopAdmin/adminPanel.Master" AutoEventWireup="true" CodeBehind="slider.aspx.cs" Inherits="webshopAdmin.slider" Title="Slider | Admin panel" %>
<%@ Register src="customControls/CustomStatus.ascx" tagname="CustomStatus" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Slider</h1>
            </div><!--col-->
        </div><!--row-->
        <div class="row">
            <div class="col-lg-12">
                <div class="btn-group">
                    <asp:Button ID="btnSave" runat="server" Text="Sačuvaj" OnClick="btnSave_Click" CssClass="btn btn-primary" />
                    <asp:Button ID="btnSaveClose" runat="server" Text="Sačuvaj i zatvori" OnClick="btnSaveClose_Click" CssClass="btn btn-default" />
                    <asp:Button ID="btnClose" runat="server" Text="Zatvori" OnClick="btnClose_Click" CssClass="btn btn-default" CausesValidation="false" />
                </div><!--btn-group-->
            </div><!--col-->
        </div><!--row-->
        <div class="row">
            <div class="col-lg-12">
                <uc1:CustomStatus ID="csStatus" runat="server" />
                <asp:HiddenField ID="lblSliderID" runat="server" />        
            </div><!--col-->
        </div><!--row-->
        <div class="row margin-top-2">
            <div class="col-lg-5 col-md-6 col-sm-10 col-xs-12">
                <div role="form">
                    <div class="form-group">
                        <label for="txtName">Naziv:</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
                    </div><!--form-group-->
                    <div class="form-group">
                        <asp:CheckBox ID="chkActive" runat="server" Text="Aktivan" CssClass="checkbox" />
                    </div><!--form-group-->
                    <div class="background-gray padding-05">
                        <div class="form-group">
                            <label for="fluImage">Dodaj slide: </label>
                            <asp:FileUpload ID="fluImage" runat="server" />
                        </div><!--form-group-->
                        <div class="form-group">
                            <label for="txtUrl">Url: </label>
                            <asp:TextBox ID="txtUrl" runat="server" CssClass="form-control"></asp:TextBox>
                        </div><!--form-group-->
                    
                        <div class="form-group">
                            <asp:Button ID="btnImageUpload" runat="server" OnClick="btnImageUpload_Click" Text="Dodaj" CssClass="btn btn-primary" />
                        </div><!--form-group--> 
                    </div>
                </div><!--form-->
            </div><!--col-->
        </div><!--row-->
        <div class="row margin-top-2">
            <div class="col-lg-12">
                <div class="table-responsive">
                    <asp:GridView ID="dgvImages" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-bordered table-hover table-striped"
                        OnRowDeleting="dgvImages_RowDeleting" DataKeyNames="sliderItemID" OnRowCommand="dgvImages_RowCommand">
                        <Columns>
                            <asp:TemplateField Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblSliderItemID" runat="server" Text='<%#Eval("sliderItemID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-Width="200px">
                                <ItemTemplate>
                                    <asp:Image ID="imgSliderItem" runat="server" ImageUrl='<%#Eval("imageUrl") %>' Width="150px" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Url">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtUrl" runat="server" Text='<%#Eval("url") %>' CssClass="form-control"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Sortiraj" ControlStyle-Width="20px" ItemStyle-Width="50px">
                                <ItemTemplate>
                                    <asp:ImageButton ID="btnSortUp" runat="server" ImageUrl="images/arrow_up.png" CommandName="sortUp" />
                                    <asp:ImageButton ID="btnSortDown" runat="server" ImageUrl="images/arrow_down.png" CommandName="sortDown" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField ShowDeleteButton="true" DeleteImageUrl="images/delete_icon.png" ButtonType="Image" ItemStyle-Width="20px" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div><!--col-->
        </div><!--row-->
        <div class="row">
            <div class="col-lg-5">
                <div role="form">

                </div>
            </div>
        </div>
    </div><!--page-wrapper-->
    
    
    <%--<div id="topMenu">
        
    </div>
    
    <div id="mainContent">
        
        <p class="row">
            
        </p>
        <p class="row">
            <label class="label"></label>
            
        </p>
        
        <p class="row">
            
        </p>
        <p class="row">
            
            
        </p>
        <p class="row">
            
        </p>
        
        
        
    </div>--%>
</asp:Content>
