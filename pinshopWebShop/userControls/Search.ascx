<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Search.ascx.cs" Inherits="WebShop2.userControls.Search" %>
<div class="input-group search-control">
    <input type="text" id="txtSearch" class="form-control" placeholder="Pronađi" />
    <span class="input-group-btn"><button type="button" id="btnSearch" class="btn btn-default" onclick="btnSearch_Click"><span class="fa fa-search"></span></button></span>
    <div class="search-items-cont" style="display:none" id="searchItemsCont">
        <table id="tblSearchItems"></table>
    </div>
</div>