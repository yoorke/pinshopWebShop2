<%@ Page Title="" Language="C#" MasterPageFile="~/webShop.Master" AutoEventWireup="true" CodeBehind="registration.aspx.cs" Inherits="WebShop2.registration" %>
<%@ Register Assembly="BotDetect" Namespace="BotDetect.Web.UI" TagPrefix="BotDetectCaptcha" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%=ResolveUrl("~/css/main-menu-vertical-v1.min.css") %>" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-lg-12 page-content">
        <div class="row text-center">
            <div class="col-lg-12">
                <h1 class="heading">Registracija</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="loginMessage text-center" runat="server" id="divLoginMessage" visible="false">
                    <span id="lblLoginText" runat="server"></span>
                </div>
            </div>
        </div>
        <div class="row" id="divRegistration" runat="server">
            <div class="login col-md-4 col-md-offset-4">
                <div role="form" class="form-horizontal">
                    <div class="form-group">
                        <%--<label class="control-label col-sm-3">Prezime: </label>--%>
                        <div class="col-sm-12">
                            <div class="input-group">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                                <asp:TextBox ID="txtLastname" runat="server" data-required="true" CssClass="form-control" placeholder="Prezime"></asp:TextBox>
                                <%--<span class="input-group-addon"><span class="glyphicon glyphicon-asterisk requiredField" title="Obavezan podatak"></span></span>--%>
                                <asp:RequiredFieldValidator ID="requiredFieldValidator1" runat="server" ControlToValidate="txtLastName"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <%--<label class="control-label col-sm-3">Ime: </label>--%>
                        <div class="col-sm-12">
                            <div class="input-group">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                                <asp:TextBox ID="txtFirstname" runat="server" CssClass="form-control" data-required="true" placeholder="Ime"></asp:TextBox>
                                <%--<span class="glyphicon glyphicon-asterisk requiredField" title="Obavezan podatak"></span>--%>
                                <asp:RequiredFieldValidator ID="requiredFieldValidator2" runat="server" ControlToValidate="txtFirstname"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <%--<label class="control-label col-sm-3">Adresa: </label>--%>
                        <div class="col-sm-12">
                            <div class="input-group">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-home"></span></span>
                                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" data-required="true" placeholder="Adresa"></asp:TextBox>
                                <%--<span class="glyphicon glyphicon-asterisk requiredField" title="Obavezan podatak"></span>--%>
                                <asp:RequiredFieldValidator ID="requiredFieldValidator3" runat="server" ControlToValidate="txtAddress"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <%--<label class="control-label col-sm-3">PTT: </label>--%>
                        <div class="col-sm-12">
                            <div class="input-group">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-home"></span></span>
                                <asp:TextBox ID="txtZip" runat="server" CssClass="form-control" data-required="true" data-type="numeric" placeholder="Ptt"></asp:TextBox>
                                <%--<span class="glyphicon glyphicon-asterisk requiredField" title="Obavezan podatak"></span>--%>
                                <asp:RequiredFieldValidator ID="requiredFieldValidator4" runat="server" ControlToValidate="txtZip"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <%--<label class="control-label col-sm-3">Mesto:</label>--%>
                        <div class="col-sm-12">
                            <div class="input-group">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-home"></span></span>
                                <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" data-required="true" placeholder="Mesto"></asp:TextBox>
                                <%--<span class="glyphicon glyphicon-asterisk requiredField" title="Obavezan podatak"></span>--%>
                                <asp:RequiredFieldValidator ID="requiredFieldValidator5" runat="server" ControlToValidate="txtCity"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <%--<label class="control-label col-sm-3">Telefon: </label>--%>
                        <div class="col-sm-12">
                            <div class="input-group">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-earphone"></span></span>
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" data-required="true" placeholder="Telefon"></asp:TextBox>
                                <%--<span class="glyphicon glyphicon-asterisk requiredField" title="Obavezan podatak"></span>--%>
                                <asp:RequiredFieldValidator ID="requiredFieldValidator6" runat="server" ControlToValidate="txtPhone"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <hr />
                    <div class="form-group">
                        <%--<label class="control-label col-sm-3">Email: </label>--%>
                        <div class="col-sm-12">
                            <div class="input-group">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-envelope"></span></span>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" data-required="true" placeholder="Email"></asp:TextBox>
                                <%--<span class="glyphicon glyphicon-asterisk requiredField" title="Obavezan podatak"></span>--%>
                                <asp:RequiredFieldValidator ID="requiredFieldValidator7" runat="server" ControlToValidate="txtEmail"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        
                    </div>
                    <div id="divEmailStatus" style="display:none" class="form-info form-info-danger">
                        <%--<span class="col-sm-3"></span>--%>
                        <%--<div class="col-sm-9">--%>
                            <span id="EmailStatus"></span>
                        <%--</div>--%>
                    </div>
                    <div class="form-group">
                        <%--<label class="control-label col-sm-3">Šifra:</label>--%>
                        <div class="col-sm-12">
                            <div class="input-group">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
                                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" data-required="true" placeholder="Šifra"></asp:TextBox>
                                <%--<span class="glyphicon glyphicon-asterisk requiredField" title="Obavezan podatak"></span>--%>
                                <asp:RequiredFieldValidator ID="requiredFieldValidator8" runat="server" ControlToValidate="txtPassword"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div id="divPasswordStatus" style="display:none" class="form-info form-info-danger">
                        <%--<span class="col-sm-3"></span>--%>
                        <%--<div class="col-sm-9 controlStatus">--%>
                            <span id="PasswordStatus"></span>
                        <%--</div>--%>
                    </div>
                    <div class="form-group">
                        <%--<label class="control-label col-sm-3">Ponovite šifru:</label>--%>
                        <div class="col-sm-12">
                            <div class="input-group">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
                                <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" data-required="true" placeholder="Šifra ponovljena"></asp:TextBox>
                                <%--<span class="glyphicon glyphicon-asterisk requiredField" title="Obavezan podatak"></span>--%>
                            </div>
                        </div>
                    </div>
                    <div id="divConfirmPasswordStatus" style="display:none" class="form-info form-info-danger">
                        <%--<span class="col-sm-3"></span>--%>
                        <%--<div class="col-sm-9 controlStatus">--%>
                            <span id="ConfirmPasswordStatus"></span>
                        <%--</div>--%>
                    </div>
                    <div class="form-group text-center">
                        <%--<span class="col-sm-3"></span>--%>
                        <%--<div class="col-sm-12 margin-top-2 margin-bottom-2">--%>
                        <div class="col-md-12">
                            <BotDetectCaptcha:WebFormsCaptcha ID="botDetect1" runat="server" />
                        </div>
                    </div>
                    <div class="form-group text-center">
                        <%--<p>Unesite tekst sa slike:</p>--%>
                        <asp:TextBox ID="CaptchaCode" runat="server" CssClass="form-control" placeholder="Unesite tekst sa slike"></asp:TextBox>
                        <asp:Label ID="CaptchaErrorLabel" runat="server"></asp:Label>
                        <%--</div>--%>
                    </div>
                    <hr />
                    <div class="text-center">
                        <asp:Button ID="btnCreateUser" runat="server" OnClick="btnCreateUser_Click" CssClass="btn btn-primary" Text="Kreiraj nalog" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
    <script src='<%=ResolveUrl("/js/registration.min.js") %>'></script>
</asp:Content>
