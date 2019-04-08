<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CheckoutV2.ascx.cs" Inherits="WebShop2.UserControls.CheckoutV2" %>
<%@ Register src="CustomStatus.ascx" tagname="CustomStatus" tagprefix="uc1" %>
<div class="checkout">
    <a id="account" name="account"></a>
    <div class="row margin-top-1 margin-bottom-1">
        <div class="col-lg-12">
            <uc1:CustomStatus ID="csStatus" runat="server" />
        </div><%--col--%>
    </div><%--row--%>
    <asp:Panel ID="pnlLogin" DefaultButton="btnLogin" runat="server">
        <div class="row margin-top-2">
            <div class="col-lg-12">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <span>Prijava</span>
                    </div><%--panel-heading--%>
                    <div class="panel-body">
                        <div class="row text-center">
                            <span>Ukoliko već posedujete korisnički nalog, prijavite se sa svojim korisničkim imenom i šifrom.</span>
                        </div>
                        <div class="row margin-top-05">
                            <div class="col-lg-5">
                                <div role="form" class="form-horizontal">
                                    <div class="form-group">
                                        <label for="txtUsername" class="control-label col-sm-5">Email:</label>
                                        <div class="col-sm-6">
                                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div><%--form-group--%>
                                </div><%--form--%>
                            </div><%--col--%>
                            <div class="col-lg-5">
                                <div role="form" class="form-horizontal">
                                    <div class="form-group">
                                        <label for="txtPassword" class="control-label col-sm-4">Šifra:</label>
                                        <div class="col-sm-8">
                                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div><%--form-group--%>
                                </div><%--form--%>
                            </div><%--col--%>
                            <div class="col-lg-2">
                                <asp:Button ID="btnLogin" runat="server" Text="Prijavi se" OnClick="btnLogin_Click" CausesValidation="false" CssClass="btn btn-default" />
                            </div>
                        </div><%--row--%>
                        <div class="row">
                            <div class="col-lg-12 text-right">
                                <small><asp:HyperLink ID="lnkPasswordReset" runat="server" NavigateUrl="/passwordResetRequest.aspx">Zaboravili ste šifru?</asp:HyperLink></small>
                            </div>
                        </div>
                    </div><%--panel-body--%>
                </div><%--panel--%>
            </div><%--col--%>
        </div><%--login--%>
    </asp:Panel>
    <div class="row margin-top-2">
        
                    <div class="col-lg-7">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <span><span class="glyphicon glyphicon-user fa-icon"></span> Podaci o dostavi</span>
                            </div><%--panel-heading--%>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div role="form">
                                            <div class="form-group">
                                                <label for="rdbUserType">Tip kupca: </label>
                                                <asp:RadioButtonList ID="rdbUserType" runat="server" RepeatColumns="2" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="radio" OnSelectedIndexChanged="rdbUserType_SelectedIndexChanged" AutoPostBack="true">
                                                    <asp:ListItem Text="Fizičko lice" Value="1" Selected="True"></asp:ListItem>
                                                    <asp:ListItem Text="Pravno lice" Value="2"></asp:ListItem>
                                                </asp:RadioButtonList>
                                    
                                            </div><%--form-group--%>
                                        </div><%--form--%>
                                    </div><%--col--%>
                                </div><%--row--%>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div role="form">
                                            <div class="form-group">
                                                <label for="txtFirstname">Ime: </label>
                                                <asp:TextBox ID="txtFirstname" runat="server" CssClass="textbox form-control"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="requiredFieldValidator1" runat="server" ControlToValidate="txtFirstname" ErrorMessage="Ime je obavezan podatak" Display="Dynamic" CssClass="form-control-error"></asp:RequiredFieldValidator>
                                            </div><%--form-group--%>
                                        </div><%--form--%>
                                    </div><%--col--%>
                                    <div class="col-lg-6">
                                        <div role="form">
                                            <label for="txtLastname">Prezime: </label>
                                            <asp:TextBox ID="txtLastname" runat="server" CssClass="textbox form-control"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="requiredFieldValidator2" runat="server" ControlToValidate="txtLastname" ErrorMessage="Prezime je obavezan podatak" Display="Dynamic" CssClass="form-control-error"></asp:RequiredFieldValidator>
                                        </div><%--form--%>
                                    </div><%--col--%>
                        
                                </div><%--row--%>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div role="form">
                                            <div class="form-group">
                                                <label for="txtEmail">Email: </label>
                                                <asp:TextBox ID="txtEmail" runat="server" CssClass="textbox form-control"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="requiredFieldValidator3" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email je obavezan podatak" Display="Dynamic" CssClass="form-control-error"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="regularExpressionValidator1" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email adres nije u odgovarajućem formatu" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ToolTip="Email adresa nije u odgovarajućem formatu" Display="Dynamic" CssClass="form-control-error"></asp:RegularExpressionValidator>
                                            </div>
                                        </div><%--form--%>
                                    </div><%--col--%>
                                </div><%--row--%>
                                <div class="row" id="divCompany" style="display:none" runat="server">
                                    <div class="col-lg-6">
                                        <div role="form">
                                            <div class="form-group">
                                                <label for="txtCompanyName">Naziv: </label>
                                                <asp:TextBox ID="txtCompanyName" runat="server" CssClass="textbox form-control" Text="0"></asp:TextBox>
                                                <%--<asp:CustomValidator ID="customValidator1" runat="server" ClientValidationFunction="companyNameValidation" ErrorMessage="*" ValidateEmptyText="true" ControlToValidate="txtCompanyName" EnableClientScript="true"></asp:CustomValidator>--%>
                                                <asp:RequiredFieldValidator ID="requiredFieldValidator8" ControlToValidate="txtCompanyName" runat="server" ErrorMessage="Naziv je obavezan podatak" Display="Dynamic" CssClass="form-control-error"></asp:RequiredFieldValidator>
                                            </div><%--form-group--%>
                                        </div><%--form--%>
                                    </div><%--col--%>
                                    <div class="col-lg-6">
                                        <div role="form">
                                            <div class="form-group">
                                                <label for="txtPib">PIB: </label>
                                                <asp:TextBox ID="txtPib" runat="server" Text="0" CssClass="textbox form-control"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="requiredFieldValidator9" ControlToValidate="txtPib" runat="server" ErrorMessage="PIB je obavezan podatak" Display="Dynamic" CssClass="form-control-error"></asp:RequiredFieldValidator>
                                            </div><%--form-group--%>
                                        </div><%--form-group--%>
                                    </div><%--col--%>
                                </div><%--row--%>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div role="form">
                                            <div class="form-group">
                                                <label for="txtAddress">Adresa: </label>
                                                <asp:TextBox ID="txtAddress" runat="server" CssClass="textbox form-control"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="requiredFieldValidator4" runat="server" ControlToValidate="txtAddress" ErrorMessage="Adresa je obavezan podatak" Display="Dynamic" CssClass="form-control-error"></asp:RequiredFieldValidator>
                                            </div><%--form-group--%>
                                        </div><%--form--%>
                                    </div><%--col--%>
                                </div><%--row--%>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div role="form">
                                            <div class="form-group">
                                                <label for="txtCity">Mesto: </label>
                                                <asp:TextBox ID="txtCity" runat="server" CssClass="textbox form-control"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="requiredFieldValidator5" runat="server" ControlToValidate="txtCity" ErrorMessage="Mesto je obavezan podatak" Display="Dynamic" CssClass="form-control-error"></asp:RequiredFieldValidator>
                                            </div><%--form-group--%>
                                        </div><%--col--%>
                                    </div>
                                    <div class="col-lg-6">
                                        <div role="form">
                                            <div class="form-group">
                                                <label for="txtZip">Poštanski broj: </label>
                                                <asp:TextBox ID="txtZip" runat="server" CssClass="textbox form-control" MaxLength="5"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="regularExpressionValidator2" runat="server" ControlToValidate="txtZip" ErrorMessage="PTT nije u odgovarajućem formatu" ValidationExpression="^\d{5}$" Display="Dynamic" CssClass="form-control-error"></asp:RegularExpressionValidator>
                                                <asp:RequiredFieldValidator ID="requiredFieldValidator6" runat="server" ControlToValidate="txtZip" ErrorMessage="PTT je obavezan podatak" Display="Dynamic" CssClass="form-control-error"></asp:RequiredFieldValidator>                                    
                                            </div><%--form-group--%>
                                        </div><%--form--%>
                                    </div><%--col--%>
                                </div><%--row--%>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div role="form">
                                            <div class="form-group">
                                                <label for="txtPhone">Telefon: </label>
                                                <asp:TextBox ID="txtPhone" runat="server" CssClass="textbox form-control"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="requiredFieldValidator7" runat="server" ControlToValidate="txtPhone" ErrorMessage="Telefon je obavezan podatak" Display="Dynamic" CssClass="form-control-error"></asp:RequiredFieldValidator>
                                            </div><%--form-group--%>
                                        </div><%--form--%>
                                    </div><%--col--%>
                                </div><%--row--%>
                                <%--<div class="row" id="divCompanyPayment" style="display:none">
                                    <div class="col-lg-8">
                                        <div role="form" class="form-horizontal">
                                            <div class="form-group">
                                                <label for="rdbPaymentCompany" class="control-label col-sm-3">Način plaćanja:</label>
                                                <div class="col-sm-9">
                                                    <asp:RadioButtonList ID="rdbPaymentCompany" runat="server" RepeatColumns="2" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="radio">
                                                        <asp:ListItem Text="Gotovina" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Virman" Value="2" Selected="True"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                            </div><!--form-group-->
                                        </div><!--form-->
                                    </div><!--col-->
                                </div><!--row-->--%>
                                <%--<div class="row" id="divPersonPayment">
                                    <div class="col-lg-8">
                                        <div role="form" class="form-horizontal">
                                            <div class="form-group">
                                                <label for="rdbPayment" class="control-label col-sm-3">Način plaćanja:</label>
                                                <div class="col-sm-9">
                                                    <asp:RadioButtonList ID="rdbPayment" runat="server" RepeatColumns="3" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="radio">
                                                        <asp:ListItem Text="Gotovina" Value="1" Selected="True"></asp:ListItem>
                                                        <asp:ListItem Text="Čekovima" Value="3"></asp:ListItem>
                                                        <asp:ListItem Text="Uplatnica" Value="4"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div><!--col-->
                                            </div><!--form-group-->
                                        </div><!--form-->
                                    </div><!--col-->
                                </div><!--row-->--%>
                                <%--<div class="row">
                                    <div class="col-lg-8">
                                        <div role="form" class="form-horizontal">
                                            <div class="form-group">
                                                <label for="rdbDelivery" class="control-label col-sm-3">Način preuzimanja: </label>
                                                <div class="col-sm-9">
                                                    <asp:RadioButtonList ID="rdbDelivery" runat="server" RepeatColumns="2" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="radio">
                                                        <asp:ListItem Text="Lično" Value="1" Selected="True"></asp:ListItem>
                                                        <asp:ListItem Text="Dostava kurirskom službom" Value="2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div><!--col-->
                                            </div><!--form-group-->
                                        </div><!--form-->
                                    </div><!--col-->
                                </div><!--row-->--%>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div role="form">
                                            <div class="form-group">
                                                <label for="txtRemark">Napomena: </label>
                                                <asp:TextBox ID="txtRemark" runat="server" TextMode="MultiLine" Height="120px" CssClass="form-control"></asp:TextBox>
                                            </div><%--form-group--%>
                                        </div><%--form--%>
                                    </div><%--col--%>
                                </div><%--row--%>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div role="form">
                                            <div class="form-group">
                                                <label for="chkCreateAccount"></label>
                                                <asp:CheckBox ID="chkCreateAccount" runat="server" Text="Kreiraj korisnički nalog" Checked="true" CssClass="checkbox" />
                                            </div>
                                        </div><%--form--%>
                                    </div><%--col--%>
                                </div><%--row--%>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <p class="small">
                                            Kreiranjem korisničkog naloga dobijate mogućnost praćenja statusa vaše narudžbine, kao i uvid u sve prošle
                                            narudžbine. Takođe, prilikom svake sledeće narudžbine podaci neophodni za dostavu će automatski biti popunjeni.
                                        </p>    
                                    </div><%--col--%>
                                </div><%--row--%>
                                <div class="row">
                                    <div class="col-lg-12">
                                        
                                    </div><%--col--%>
                                </div><%--row--%>
                            </div><%--panel-body--%>
                        </div><%--panel--%>
                </div><%--col--%>
                    <div class="col-lg-5">
            
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="panel panel-primary">
                                            <div class="panel-heading">
                                                <span><span class="fa fa-fw fa-truck fa-icon"></span> Način dostave</span>
                                            </div>
                                            <div class="panel-body">
                                    
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <asp:RadioButtonList ID="rdbDelivery" runat="server" RepeatColumns="1" RepeatDirection="Vertical" RepeatLayout="Flow" CssClass="radio" OnSelectedIndexChanged="rdbDelivery_SelectedIndexChanged" AutoPostBack="true">
                                                            <asp:ListItem Text="Dostava kurirskom službom" Value="1" Selected="True"></asp:ListItem>
                                                            <asp:ListItem Text="Preuzimanje u radnji" Value="2"></asp:ListItem>                                                
                                                        </asp:RadioButtonList>
                                                        <div id="showDeliveryInfo" class="margin-top-2" style="display:block" runat="server">
                                                            <ul class="margin-left-1">
                                                                <%--<li><small>Za porudžbine preko 5.000,00 dinara dostava je BESPLATNA.</small></li>--%>
                                                                <%--<li><small>Za porudžbine čija vrednost ne prelazi 5.000,00 dinara naplaćuje se dostava u iznosu od 300 din.</small></li>--%>
                                                                <li><small>U PROMO periodu do 30.06.2019. dostava je besplatna za sve porudžbine bez obzira na vrednost poručene robe.</small></li>
                                                            </ul>
                                                        </div>
                                                        <div id="showShop" class="margin-top-2" runat="server" style="display:none">
                                                            <span>Odaberite radnju:</span>
                                                            <select id="cmbShop" class="form-control">
                                                                <option>Pin servis str, Pupinova 16, 23000 Zrenjanin</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="panel panel-primary">
                                            <div class="panel-heading">
                                                <span><span class="fa fa-fw fa-money fa-icon"></span> Način plaćanja</span>
                                            </div>
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <asp:RadioButtonList ID="rdbPayment" runat="server" RepeatColumns="1" RepeatDirection="Vertical" RepeatLayout="Flow" CssClass="radio">
                                                            <%--<asp:ListItem Text="Gotovina pri preuzimanju" Value="1" Selected="True"></asp:ListItem>--%>
                                                            <%--<asp:ListItem Text="Kartica" Value="2"></asp:ListItem>--%>
                                                            <%--<asp:ListItem Text="Uplatnica" Value="3"></asp:ListItem>--%>
                                                        </asp:RadioButtonList>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                    
                    
                
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        <span>Kupon</span>
                                    </div>
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-lg-8">
                                                <asp:TextBox ID="txtCoupon" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                            <div class="col-lg-4">
                                                <asp:Button ID="btnCoupon" runat="server" OnClick="btnCoupon_Click" CssClass="btn btn-primary" Text="Primeni" CausesValidation="false" OnClientClick="return applyCoupon()" style="width:100%;float:right" />
                                                <span id="couponWorkerBox" class="worker-box" style="padding-top:5px"><span class="fa fa-fw fa-spinner fa-spin"></span></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        <span><span class="fa fa-fw fa-shopping-cart fa-icon"></span> Pregled porudžbine</span>
                                    </div>
                                    <div class="panel-body">
                                        <div class="row cartView">
                                            <div class="col-lg-12">
                                                <p>
                                                    <span class="priceTitle">Broj proizvoda:</span>
                                                    <asp:Label ID="lblProductCount" runat="server" CssClass="price"></asp:Label>
                                                </p>
                                                <p>
                                                    <span class="priceTitle">Vrednost korpe:</span>
                                                    <asp:Label ID="lblCartValue" runat="server" CssClass="price"></asp:Label>
                                                </p>
                                                <p>
                                                    <span class="priceTitle">Popust:</span>
                                                    <asp:Label ID="lblDiscount" runat="server" CssClass="price discount"></asp:Label>
                                                </p>
                                                <p>
                                                    <span class="priceTitle">Kupon:</span>
                                                    <asp:Label ID="lblCoupon" runat="server" CssClass="price coupon"></asp:Label>
                                                    <asp:LinkButton ID="lblRemoveCoupon" runat="server" OnClick="lblRemoveCoupon_Click" Visible="false" CausesValidation = "false">
                                                        <span class="glyphicon glyphicon-remove"></span>
                                                    </asp:LinkButton>
                                                    <%--<span id="couponWorkerBox" class="worker-box"><span class="fa fa-fw fa-spinner fa-spin"></span></span>--%>
                                                </p>
                                                <p>
                                                    <span class="priceTitle">Iznos dostave:</span>
                                                    <asp:Label ID="lblDeliveryPrice" runat="server" CssClass="price"></asp:Label>
                                                </p>
                                                <p>
                                                    <span class="priceTitle">Ukupno:</span>
                                                    <asp:Label ID="lblTotal" runat="server" CssClass="total"></asp:Label>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%--<div class="row">
                            <div class="col-md-12">
                                <button type="button" class="btn btn-primary btn-order">Naruči</button>
                            </div>
                        </div>--%>
                    </div>
                
   </div><%--row--%>
    <div class="row margin-top-2 margin-bottom-2">
        <div class="col-lg-7">
            <asp:LinkButton ID="btnBack" runat="server" Text="Vrati se na korpu" CssClass="btn btn-default margin-top-3 btn-order" OnClick="btnBack_Click" CausesValidation="false"></asp:LinkButton>
        </div>
        <div class="col-lg-5">
            <asp:LinkButton ID="btnOrder" runat="server" Text="Naruči" CssClass="btn btn-primary btn-order pull-right width-100" OnClick="btnOrder_Click" OnClientClick="return removeValidatorStyle()"></asp:LinkButton>
            <span id="workerBox" class="worker-box"><span class="fa fa-fw fa-spinner fa-spin"></span></span>
        </div>
    </div>
</div><%--checkout--%>
                    
                    
                                <%--<!--<div class="form-group">-->
                                    
                                <!--</div>--><!--form-group-->
                                
                                
                            <!--</div>--><!--form-->
                        <!--</div>--><!--col-->
                    <!--</div>--><!--row-->
                    <!--<div class="row">-->
                    <!--</div>--><!--row-->
                    <!--<div class="row">-->
                    <!--</div>--><!--row-->
                    <!--<div class="row">-->
                    <!--</div>--><!--row-->
                <!--</div>--><!--panel-body-->
            <!--</div>--><!--panel-->
        <!--</div>--><!--col-->
    <!--</div>--><!--row-->
                    
                    <!--<div class="column column600">
                        <p class="row">
                            
                        </p>
                        <p class="row">
                            
                            
                        </p>
            
                        <p class="row">
                            
                
                
                        </p>
            
                        <div class="group" id="divCompany" style="display:none">
                            <p class="row">
                                
                                
                            </p>
                        </div>
                        <div class="group"><%--</div>--%->
                        <p class="row">
                            
                        </p>
                        <p class="row">
                            
                            
                        </p>
                        </div>
                        <p class="row">
                            
                        </p>
                        
                        
                        
                        <div id="divCompanyPayment" style="display:none">
                            <p class="row">
                                
                            </p>
                        </div>
                        <div id="divPersonPayment" style="display:block">
                            <p class="row">
                                
                            </p>
                        </div>
                        <p class="row">
                            
                        </p>
                        
                        
                        <p class="row">
                            
                        </p>
                        <p class="row">
                            
                        </p>
                        
                        
                        
                        <div class="buttons">
                            
                        </div>
                        
                    </div>
                
</div>-->--%>
<script type="text/javascript">
    function userTypeChanged(radioButton) {
        //var divCompany = document.getElementById("divCompany");
        if (radioButton.value == 2) {
            document.getElementById("divCompany").style.display = "block";
            document.getElementById("ctl00_ContentPlaceHolder1_checkout1_txtCompanyName").value = "";
            document.getElementById("ctl00_ContentPlaceHolder1_checkout1_txtPib").value = "";
            document.getElementById("divCompanyPayment").style.display = "block";
            document.getElementById("divPersonPayment").style.display = "none";
        }
        //divCompany.style = "display:block;";
        else {
            document.getElementById("divCompany").style.display = "none";
            document.getElementById("ctl00_ContentPlaceHolder1_checkout1_txtCompanyName").value = "fizicko lice";
            document.getElementById("ctl00_ContentPlaceHolder1_checkout1_txtPib").value = "000000000";
            document.getElementById("divCompanyPayment").style.display = "none";
            document.getElementById("divPersonPayment").style.display = "block";
        }
    }
</script>

<script language="javascript">
    function companyNameValidation(oSrc, args) {
        var radioButton = document.getElementById("ctl00_ContentPlaceHolder1_checkout1_rdbUserType_1");
        var textbox = document.getElementById("ctl00_ContentPlaceHolder1_checkout1_txtCompanyName");

        if (radioButton.checked) {
            if (textbox.value == "") {
                args.isValid = false;
                alert("false");
            }
            else
                args.isValid = true;
        }
        else
            args.isValid = true;
    }
</script>
<script>
    function removeValidatorStyle() {
        $('[id*=requiredFieldValidator]').removeAttr('style');
        $('[id*=regularExpressionValidator]').removeAttr('style');
        if (Page_ClientValidate('')) {
            $('[id*=btnOrder').attr('disabled', true)
            $('#workerBox').show();
        }
        else {
            $('body,html').animate({
                scrollTop: $('[id*=rdbUserType]').offset().top - 90
            }, 700)
        }
    }

    function applyCoupon() {
        if ($('[id*=txtCoupon]').val() != '') {
        $('#couponWorkerBox').show();
        //$('[id*=btnCoupon').attr('disabled', true);
        window.setTimeout(function () {
            $('#couponWorkerBox').hide();
            //$('[id*=btnCoupon').attr('disabled', false);
        }, 3000);
            return true;
        }
    }
</script>
<script>
    
</script>