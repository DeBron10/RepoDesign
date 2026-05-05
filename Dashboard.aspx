<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Site.Master"
AutoEventWireup="true"
CodeBehind="Dashboard.aspx.cs"
Inherits="APPEXS.Pages.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container-fluid">

        <div class="row">

            <div class="col-lg-3 col-md-6 mb-4">

                <div class="card shadow-sm border-0 rounded-4">

                    <div class="card-body">

                        <h5>Total Projects</h5>

                        <h2 class="mt-3 text-primary">
                            248
                        </h2>

                    </div>

                </div>

            </div>

            <div class="col-lg-3 col-md-6 mb-4">

                <div class="card shadow-sm border-0 rounded-4">

                    <div class="card-body">

                        <h5>Ongoing Projects</h5>

                        <h2 class="mt-3 text-success">
                            84
                        </h2>

                    </div>

                </div>

            </div>

            <div class="col-lg-3 col-md-6 mb-4">

                <div class="card shadow-sm border-0 rounded-4">

                    <div class="card-body">

                        <h5>Completed</h5>

                        <h2 class="mt-3 text-info">
                            126
                        </h2>

                    </div>

                </div>

            </div>

            <div class="col-lg-3 col-md-6 mb-4">

                <div class="card shadow-sm border-0 rounded-4">

                    <div class="card-body">

                        <h5>Pending Reviews</h5>

                        <h2 class="mt-3 text-danger">
                            18
                        </h2>

                    </div>

                </div>

            </div>

        </div>

    </div>

</asp:Content>