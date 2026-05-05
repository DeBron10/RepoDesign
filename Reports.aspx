<%@ Page Title="Reports"
    Language="C#"
    MasterPageFile="~/MasterPages/Site.Master"
    AutoEventWireup="true"
    CodeBehind="Reports.aspx.cs"
    Inherits="APPEXS.Pages.Reports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- CHOSEN -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.min.css" rel="stylesheet" />

    <style>

        body {
            background: linear-gradient(135deg,#edf4ff,#f8fbff);
        }

        .main-container {

            max-width: 1500px;
            width: 100%;
            margin: 0 auto;
            background: rgba(255,255,255,0.92);
            backdrop-filter: blur(10px);
            padding: 35px;
            border-radius: 24px;
            box-shadow: 0 18px 40px rgba(0,0,0,0.08);
            border: 1px solid rgba(255,255,255,0.7);
        }

        .top-title {

            text-align: center;
            font-weight: 800;
            margin-bottom: 35px;
            font-size: 34px;
            color: #16304f;
        }

        .top-tabs-wrap {

            display: flex;
            gap: 25px;
            align-items: flex-start;
            margin-bottom: 25px;
        }

        .report-label {

            font-size: 17px;
            font-weight: 700;
            white-space: nowrap;
            padding-top: 12px;
            color: #234;
        }

        .tabs-wrapper {

            flex: 1;
            position: relative;
            padding-bottom: 28px;
        }

        .custom-tabs {

            display: flex;
            justify-content: space-between;
            gap: 10px;
            padding: 0;
            margin: 0;
            list-style: none;
            position: relative;
        }

        .custom-tabs .nav-link {

            border: none;
            background: transparent;
            color: #687387;
            font-weight: 700;
            font-size: 14px;
            padding: 12px 6px;
            position: relative;
            transition: 0.3s;
            white-space: nowrap;
            outline: none;
        }

        .custom-tabs .nav-link:hover {
            color: #198754;
        }

        .custom-tabs .nav-link.active {
            color: #198754;
        }

        .custom-tabs .nav-link.active::after {

            content: '';
            position: absolute;
            left: 0;
            bottom: -10px;
            width: 100%;
            height: 4px;
            background: #198754;
            border-radius: 30px;
            z-index: 5;
        }

        .custom-tabs .nav-link.active::before {

            content: '';
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
            bottom: -10px;

            border-left: 7px solid transparent;
            border-right: 7px solid transparent;
            border-bottom: 8px solid #198754;

            z-index: 6;
        }

        .hover-slider {

            position: absolute;
            left: 0;
            bottom: 18px;
            width: 80px;
            height: 4px;
            background: #198754;
            border-radius: 30px;
            transition: all 0.25s ease;
            opacity: 0.45;
            box-shadow: 0 0 14px rgba(25,135,84,0.35);
            z-index: 1;
        }

        .custom-main-content {

            background: linear-gradient(135deg,#f6faff,#f8f9fb);
            border-radius: 24px;
            padding: 28px;
            border: 1px solid #edf2f7;
        }

        .content-flex {

            display: flex;
            gap: 28px;
            align-items: flex-start;
        }

        .left-panel {
            flex: 1.9;
        }

        .right-panel {
            flex: 1;
            min-width: 340px;
        }

        .glass-card,
        .side-card {

            background: rgba(255,255,255,0.92);
            border-radius: 22px;
            padding: 26px;
            border: 1px solid #edf2f7;
            box-shadow: 0 10px 28px rgba(0,0,0,0.05);
        }

        .section-title {

            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 24px;
        }

        .green-dot {

            width: 13px;
            height: 13px;
            border-radius: 50%;
            background: #198754;
            box-shadow: 0 0 10px rgba(25,135,84,0.45);
        }

        .section-title h5 {

            margin: 0;
            font-weight: 800;
            color: #1c3556;
        }

        .filter-row {

            display: flex;
            gap: 18px;
            margin-bottom: 20px;
        }

        .filter-box {
            flex: 1;
        }

        .small-box {
            flex: 1;
        }

        .large-box {
            flex: 2;
        }

        label {

            font-weight: 700;
            margin-bottom: 8px;
            color: #35465d;
        }

        .form-control {

            border-radius: 14px;
            border: 1px solid #d7dee8;
            min-height: 46px;
            padding: 10px 14px;
            background: #fff;
            transition: 0.3s;
        }

        .inline-fields {

            display: flex;
            align-items: center;
            gap: 12px;
        }

        .inline-fields span {
            font-weight: 700;
            color: #556;
        }

        .align-bottom {
            align-items: flex-end;
        }

        .dynamic-pane {
            display: none;
            animation: fadeUp 0.35s ease;
        }

        .active-pane {
            display: block;
        }

        .side-title {

            font-size: 20px;
            font-weight: 800;
            margin-bottom: 22px;
            color: #198754;
        }

        .radio-wrap {

            display: flex;
            gap: 22px;
            margin-bottom: 18px;
            font-weight: 600;
        }

        .info-box {

            padding: 20px;
            border-radius: 16px;
            background: linear-gradient(135deg,#eef7ff,#f8fcff);
            border: 1px solid #dde8f5;
            color: #425468;
            font-weight: 600;
        }

        .bottom-buttons {

            margin-top: 30px;
            display: flex;
            justify-content: center;
            gap: 18px;
        }

        .search-btn {

            background: linear-gradient(135deg,#198754,#21c997);
            color: white;
            border: none;
            padding: 12px 35px;
            border-radius: 40px;
            font-weight: 700;
            min-width: 150px;
        }

        .reset-btn {

            background: white;
            color: #495057;
            border: 1px solid #d6dee7;
            padding: 12px 35px;
            border-radius: 40px;
            font-weight: 700;
            min-width: 150px;
        }

        .chosen-container-single .chosen-single,
        .chosen-container-multi .chosen-choices {

            min-height: 46px !important;
            border-radius: 14px !important;
            border: 1px solid #d7dee8 !important;
            background: #fff !important;
            padding-top: 5px !important;
            box-shadow: none !important;
        }

        .result-section {

            margin-top: 35px;
        }

        .result-title {

            font-size: 24px;
            font-weight: 800;
            color: #2b4260;
        }

        .table-outer {

            width: 100%;
            background: #ffffff;
            border-radius: 20px;
            overflow: auto;
            border: 1px solid #e4ebf3;
            box-shadow: 0 12px 28px rgba(15,23,42,0.06);
        }

        .custom-table {

            width: 100%;
            table-layout: fixed;
            border-collapse: collapse;
        }

        .custom-table thead {

            background: #f4f7fb;
        }

        .custom-table th {

            padding: 14px 8px;
            font-size: 11px;
            font-weight: 800;
            color: #32455c;
            text-align: center;
            border-right: 1px solid #e7edf5;
        }

        .custom-table td {

            padding: 14px 8px;
            font-size: 12px;
            color: #425466;
            text-align: center;
            border-right: 1px solid #edf2f7;
            border-bottom: 1px solid #edf2f7;
            font-weight: 600;
        }

        .status-badge {

            padding: 5px 10px;
            border-radius: 30px;
            font-size: 11px;
            font-weight: 700;
            display: inline-block;
        }

        .status-active {
            background: #e7f6ee;
            color: #198754;
        }

        .status-completed {
            background: #e7f0ff;
            color: #2764d8;
        }

        .status-pending {
            background: #fff4df;
            color: #c58a00;
        }

        @keyframes fadeUp {

            from {
                opacity: 0;
                transform: translateY(10px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

    </style>

    <div class="main-container">

        <div class="top-title">
            Search Repository
        </div>

        <div class="top-tabs-wrap">

            <div class="report-label">
                Generate report for:
            </div>

            <div class="tabs-wrapper">

                <ul class="nav custom-tabs">

                    <li class="nav-item">
                        <button type="button" class="nav-link active" data-target="project">
                            Project Details
                        </button>
                    </li>

                    <li class="nav-item">
                        <button type="button" class="nav-link" data-target="team">
                            Project Team
                        </button>
                    </li>

                    <li class="nav-item">
                        <button type="button" class="nav-link" data-target="subprojects">
                            Sub-Projects
                        </button>
                    </li>

                    <li class="nav-item">
                        <button type="button" class="nav-link" data-target="trials">
                            Trials
                        </button>
                    </li>

                    <li class="nav-item">
                        <button type="button" class="nav-link" data-target="pdc">
                            PDC Extension
                        </button>
                    </li>

                    <li class="nav-item">
                        <button type="button" class="nav-link" data-target="costenhance">
                            Cost Enhancement
                        </button>
                    </li>

                    <li class="nav-item">
                        <button type="button" class="nav-link" data-target="reviews">
                            Reviews
                        </button>
                    </li>

                    <li class="nav-item">
                        <button type="button" class="nav-link" data-target="tot">
                            ToT
                        </button>
                    </li>

                </ul>

                <div class="hover-slider" id="hoverSlider"></div>

            </div>

        </div>

        <!-- YOUR REMAINING HTML SAME AS BEFORE -->

    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.jquery.min.js"></script>

    <script type="text/javascript">

        $(document).ready(function () {

            $('.chosen-select').chosen({
                width: "100%"
            });

            $("#txtFromDate, #txtToDate").prop("disabled", true);

            $("#totDate1, #totDate2").prop("disabled", true);

            function moveSlider(element) {

                var left = element.position().left;

                var width = element.outerWidth();

                $('#hoverSlider').css({

                    left: left + 'px',
                    width: width + 'px'
                });
            }

            moveSlider($('.custom-tabs .nav-link.active'));

            $('.custom-tabs .nav-link').mouseenter(function () {

                moveSlider($(this));
            });

            $('.tabs-wrapper').mouseleave(function () {

                moveSlider($('.custom-tabs .nav-link.active'));
            });

            $('.custom-tabs .nav-link').click(function () {

                $('.custom-tabs .nav-link').removeClass('active');

                $(this).addClass('active');

                var target = $(this).data('target');

                $('.dynamic-pane').removeClass('active-pane');

                $('#' + target + 'Pane').addClass('active-pane');

                moveSlider($(this));

            });

        });

    </script>

</asp:Content>