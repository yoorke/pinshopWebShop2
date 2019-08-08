<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Search.ascx.cs" Inherits="WebShop2.userControls.Search" %>
<div class="input-group search-control">
    <input type="text" id="txtSearch" class="form-control" placeholder="Pronađi" maxlength="100" />
    <span class="input-group-btn"><button type="button" id="btnSearch" class="btn btn-default" onclick="btnSearch_Click"><span class="fa fa-search"></span></button></span>
    <div class="search-items-cont" style="display:none" id="searchItemsCont">
        <div class="row">
            <div class="col-md-7">
                <table id="tblSearchItems"></table>
            </div>
            <div class="col-md-5">
                <table id="tblSearchProductItems"></table>
            </div>
        </div>
    </div>
</div>