<%@ Page Title="" Language="C#" MasterPageFile="~/webShop.Master" AutoEventWireup="true" CodeBehind="kontakt.aspx.cs" Inherits="WebShop2.kontakt" %>
<%@ Register Assembly="BotDetect" Namespace="BotDetect.Web.UI" TagPrefix="BotDetectCaptcha" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%=ResolveUrl("~/css/main-Menu-Vertical-V1.min.css") %>" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-lg-12 page-content">
        <%--<div class="row">
            <div class="col-lg-12">
                <h1 class="heading">Kontakt</h1>
            </div>
        </div>--%>
        <%--<div class="row  margin-top-2 margin-bottom-2" id="map"></div>--%>
        
        <div class="row">
            <div class="col-md-5">
                <h3>Pin Servis PR</h3>
                <h4 class="margin-top-1 section-header">Adresa</h4>
                <p class="contact-box">
                    <span class="fa fa-fw fa-home icon"></span>
                    <span>Pupinova 16</span>
                </p>
                <p>23000 Zrenjanin</p>
                <h4 class="section-header">Telefoni</h4>
                <p class="contact-box">
                    <span class="fa fa-fw fa-phone icon"></span>
                    <span>023 236 140</span>
                </p>
                <p class="contact-box">
                    <span class="fa fa-fw fa-phone icon"></span>
                    <span>023 601 007</span>
                </p>
                <p class="contact-box">
                    <span class="fa fa-fw fa-mobile icon"></span>
                    <span>060 0 601 007</span>
                </p>
                <p class="contact-box">
                    <%--<span class="fab fa-fw fa-viber icon"></span>--%>
                    <span>Viber</span>
                    <span>060 0 601 007</span>
                </p>
                <h4 class="section-header">Email</h4>
                <p class="contact-box">
                    <span class="fa fa-fw fa-envelope icon"></span>
                    <span>maloprodaja at pinshop.rs</span>
                </p>
                <h4 class="section-header">Pronađite nas na društvenim mrežama</h4>
                <p class="contact-box">
                    <a href="https://www.facebook.com/pinservis" target="_blank"><span class="fa fa-fw fa-facebook-official icon"></span></a>
                    <a href="https://www.youtube.com" target="_blank"><span class="fa fa-fw fa-youtube-play icon"></span></a>
                    <a href="https://www.twitter.com" target="_blank"><span class="fa fa-fw fa-twitter-square icon"></span></a>
                    <a href="https://www.instagram.com/pinserviszr" target="_blank"><span class="fa fa-fw fa-instagram icon"></span></a>
                </p>
            </div>
            <div class="col-md-7">
                <div class="row margin-top-4">
                    <div class="col-lg-9 col-md-offset-3">
                        <p>Kontaktirajte nas i saznajte više o proizvodima, ili nam pošaljite komentar ili sugestiju. Odgovorićemo Vam u najkraćem roku.</p>
                    </div>
                </div>
                <div class="row margin-top-1">
                    <div class="form-horizontal" role="form">
                        <div class="form-group">
                            <label class="control-label col-lg-3">Vaš email:</label>
                            <div class="col-lg-9">
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="requiredFiledValidator1" runat="server" ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="Email je obavezan podatak" CssClass="form-control-error"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3">Naslov:</label>
                            <div class="col-lg-9">
                                <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="requiredFieldValidator2" runat="server" ControlToValidate="txtSubject" Display="Dynamic" ErrorMessage="Naslov je obavezan podatak" CssClass="form-control-error"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3">Poruka:</label>
                            <div class="col-lg-9">
                                <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="requiredFieldValidator3" runat="server" ControlToValidate="txtMessage" Display="Dynamic" ErrorMessage="Poruka je obavezan podatak" CssClass="form-control-error"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3"></label>
                            <div class="col-md-9">
                                <BotDetectCaptcha:WebFormsCaptcha ID="botDetect1" runat="server" UserInputControlID="txtCaptchaCode" ImageSize="150,50" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3">Kod sa slike:</label>
                            <div class="col-md-9">
                                <asp:TextBox ID="txtCaptchaCode" runat="server" CssClass="form-control" placeholder="Unesite kod sa slike"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3"></label>
                            <div class="col-lg-9">
                                <asp:Button ID="btnSend" runat="server" CssClass="btn btn-default width-100" OnClick="btnSend_Click" Text="Pošalji" UseSubmitBehavior="false" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row margin-top-1 margin-bottom-1">
            <div class="col-lg-12">
                <div class="status" style="">
                    <asp:Label ID="lblStatus" runat="server" Visible="false" Width="100%"></asp:Label>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <iframe width="100%" height="450" frameborder="0" style="border:0" src="https://www.google.com/maps/embed/v1/place?q=pinservis%20zrenjanin&key=AIzaSyDuBl4yxRFkrnxzxMLD63WUtVaJfIOHOcc" allowfullscreen></iframe>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
    <%--<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDmzY1PFJ6PdSD0uGEOfedUKPMVZJOcJyQ"></script>
    <script src="/js/map.js"></script>--%>
    <script>
        function btnSend1_Click() {
            $('[id*=btnSend').attr('disabled', true);
            //return true;
        }
        window.onbeforeunload = btnSend1_Click;
    </script>
</asp:Content>
