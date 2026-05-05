<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="SearchReport.Report" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Search Repository</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.min.css" rel="stylesheet" />

    <style>

        body {
            background: linear-gradient(135deg,#edf4ff,#f8fbff);
            font-family: Segoe UI;
            min-height: 100vh;
        }

        .main-container {

            max-width: 1500px;
            width: 96%;
            margin: 35px auto;
            background: rgba(255,255,255,0.92);
            backdrop-filter: blur(10px);
            padding: 35px;
            border-radius: 24px;
            box-shadow: 0 18px 40px rgba(0,0,0,0.08);
            border: 1px solid rgba(255,255,255,0.7);
        }

        /* HEADER */

        .top-title {

            text-align: center;
            font-weight: 800;
            margin-bottom: 35px;
            font-size: 34px;
            color: #16304f;
        }

        /* TABS */

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

        /* CONTENT */

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

        .form-control:focus {

            border-color: #198754;
            box-shadow: 0 0 0 0.18rem rgba(25,135,84,0.18);
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

        /* SIDE PANELS */

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

        /* BUTTONS */

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
            transition: 0.3s;
        }

        .search-btn:hover {

            transform: translateY(-2px);
            box-shadow: 0 10px 22px rgba(25,135,84,0.28);
        }

        .reset-btn {

            background: white;
            color: #495057;
            border: 1px solid #d6dee7;
            padding: 12px 35px;
            border-radius: 40px;
            font-weight: 700;
            min-width: 150px;
            transition: 0.3s;
        }

        .reset-btn:hover {

            background: #f3f6fa;
            transform: translateY(-2px);
        }

        /* CHOSEN */

        .chosen-container-single .chosen-single,
        .chosen-container-multi .chosen-choices {

            min-height: 46px !important;
            border-radius: 14px !important;
            border: 1px solid #d7dee8 !important;
            background: #fff !important;
            padding-top: 5px !important;
            box-shadow: none !important;
        }

        .chosen-container-active .chosen-choices {

            border-color: #198754 !important;
            box-shadow: 0 0 0 0.18rem rgba(25,135,84,0.18) !important;
        }

        <!-- ADD THIS CSS BELOW YOUR EXISTING CSS -->

/* ================= RESULT TABLE ================= */

.result-section {

    margin-top: 35px;

    padding: 0;

    background: transparent;

    border: none;

    box-shadow: none;
}

.result-header {

    display: flex;

    justify-content: space-between;

    align-items: center;

    margin-bottom: 18px;

    padding: 0 4px;
}

.result-title {

    font-size: 24px;

    font-weight: 800;

    color: #2b4260;

    margin: 0;
}

.result-sub {

    font-size: 13px;

    color: #7b8794;

    margin-top: 4px;

    font-weight: 600;
}

/* TABLE WRAPPER */

.table-outer {

    width: 100%;

    background: #ffffff;

    border-radius: 20px;

    overflow: hidden;

    border: 1px solid #e4ebf3;

    box-shadow: 0 12px 28px rgba(15,23,42,0.06);
}

/* TABLE */

.custom-table {

    width: 100%;

    table-layout: fixed;

    border-collapse: collapse;
}

/* HEADER */

.custom-table thead {

    background: #f4f7fb;

    border-bottom: 1px solid #dde6f0;
}

.custom-table th {

    padding: 14px 8px;

    font-size: 11px;

    font-weight: 800;

    color: #32455c;

    text-transform: uppercase;

    letter-spacing: .3px;

    text-align: center;

    word-wrap: break-word;

    border-right: 1px solid #e7edf5;
}

/* BODY */

.custom-table td {

    padding: 14px 8px;

    font-size: 12px;

    color: #425466;

    text-align: center;

    border-right: 1px solid #edf2f7;

    border-bottom: 1px solid #edf2f7;

    word-wrap: break-word;

    font-weight: 600;
}

.custom-table tbody tr {

    transition: 0.2s ease;
}

.custom-table tbody tr:hover {

    background: #f8fbff;
}

/* REMOVE LAST BORDER */

.custom-table th:last-child,
.custom-table td:last-child {

    border-right: none;
}

/* STATUS BADGES */

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


        /* ANIMATION */

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

</head>

<body>

<form id="form1" runat="server">

<div class="main-container">

    <div class="top-title">
        Search Repository
    </div>

    <!-- TOP -->

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

    <!-- CONTENT -->

    <div class="custom-main-content">

        <div class="content-flex">

            <!-- LEFT -->

            <div class="left-panel" id="leftPanel">

                <div class="glass-card">

                    <div class="section-title">

                        <div class="green-dot"></div>

                        <h5>
                            Project Details Filters
                        </h5>

                    </div>

                    <!-- ROW 1 -->

                    <div class="filter-row">

                        <div class="filter-box">

                            <label>Project Type</label>

                            <select id="ddlProjectType" class="form-control reset-field">

                                <option value="">Select</option>
                                <option>Main Project</option>
                                <option>Task</option>
                                <option>Sub-project</option>

                            </select>

                        </div>

                        <div class="filter-box">

                            <label>Project Status</label>

                            <select id="ddlStatus" class="form-control reset-field">

                                <option value="">Select</option>
                                <option>Ongoing</option>
                                <option>Completed</option>
                                <option>Pending</option>

                            </select>

                        </div>

                        <div class="filter-box">

                            <label>Category</label>

                            <select id="ddlCategory" class="form-control reset-field chosen-select" multiple>

                                <option>MM</option>
                                <option>TD</option>
                                <option>IF</option>

                            </select>

                        </div>

                    </div>

                    <!-- ROW 2 -->

                    <div class="filter-row">

                        <div class="filter-box small-box">

                            <label>Search for</label>

                            <select id="ddlSearchFor" class="form-control reset-field">

                                <option value="">Select Date</option>
                                <option>Start date</option>
                                <option>Ongoing date</option>
                                <option>Closed date</option>

                            </select>

                        </div>

                        <div class="filter-box large-box">

                            <label>Between</label>

                            <div class="inline-fields">

                                <input type="date" id="txtFromDate" class="form-control reset-field" />

                                <span>to</span>

                                <input type="date" id="txtToDate" class="form-control reset-field" />

                            </div>

                        </div>

                    </div>

                    <!-- ROW 3 -->

                    <div class="filter-row align-bottom">

                        <div id="costFields" class="filter-box large-box">

                            <label>Cost Between</label>

                            <div class="inline-fields">

                                <input type="number" class="form-control reset-field" />

                                <span>to</span>

                                <input type="number" class="form-control reset-field" />

                            </div>

                        </div>

                        <div class="filter-box small-box">

                            <label>Sort by</label>

                            <select class="form-control reset-field">

                                <option value="">Select</option>
                                <option>Category</option>
                                <option>Start Date</option>
                                <option>Cost</option>

                            </select>

                        </div>

                    </div>

                </div>

            </div>

            <!-- RIGHT -->

            <div class="right-panel">

                <!-- PROJECT -->

                <div class="side-card dynamic-pane active-pane" id="projectPane">

                    <div class="side-title">
                        📁 Project Overview
                    </div>

                    <div class="info-box">
                        Configure filters and generate advanced repository reports.
                    </div>

                </div>

                <!-- TEAM -->

                <div class="side-card dynamic-pane" id="teamPane">

                    <div class="side-title">
                        👥 Project Team Filters
                    </div>

                    <div class="radio-wrap">

                        <label>
                            <input type="radio" name="searchType" value="roles" checked />
                            Roles
                        </label>

                        <label>
                            <input type="radio" name="searchType" value="emp" />
                            Employee Type
                        </label>

                    </div>

                    <div id="rolesDiv">

                        <label>Select Roles</label>

                        <select id="ddlRoles" class="form-control chosen-select reset-field" multiple>

                            <option>Project Director</option>
                            <option>Deputy PD</option>
                            <option>POC</option>
                            <option>Team Member</option>

                        </select>

                    </div>

                    <div id="empDiv" style="display:none; margin-top:18px;">

                        <label>Employee Type</label>

                        <select class="form-control reset-field">

                            <option value="">Select</option>
                            <option>DRDS</option>
                            <option>DRTC</option>

                        </select>

                    </div>

                </div>

                <!-- SUBPROJECT -->

                <div class="side-card dynamic-pane" id="subprojectsPane">

                    <div class="side-title">
                        🧩 Sub Projects
                    </div>

                    <div style="margin-bottom:18px;">

                        <label>Select Lab</label>

                        <select class="form-control chosen-select reset-field" multiple>

                            <option>Lab 1</option>
                            <option>Lab 2</option>
                            <option>Lab 3</option>

                        </select>

                    </div>

                    <div>

                        <label>Select Subproject Category</label>

                        <select class="form-control chosen-select reset-field" multiple>

                            <option>Hardware</option>
                            <option>Software</option>
                            <option>Testing</option>

                        </select>

                    </div>

                </div>

                <!-- TRIALS -->

                <div class="side-card dynamic-pane" id="trialsPane">

                    <div class="side-title">
                        🧪 Trials Filters
                    </div>

                    <div style="margin-bottom:18px;">

                        <label>Select Trial Type</label>

                        <select class="form-control chosen-select reset-field" multiple>

                            <option>Internal</option>
                            <option>External</option>

                        </select>

                    </div>

                    <div style="margin-bottom:18px;">

                        <label>Select Trial Status</label>

                        <select class="form-control chosen-select reset-field" multiple>

                            <option>Pending</option>
                            <option>Completed</option>

                        </select>

                    </div>

                    <label>Filter using</label>

                    <div class="radio-wrap">

                        <label>
                            <input type="radio" name="trialDateType" value="start" />
                            Trial Start Date
                        </label>

                        <label>
                            <input type="radio" name="trialDateType" value="end" />
                            Trial End Date
                        </label>

                    </div>

                    <div id="trialStartDiv" style="display:none;">

                        <label>Select Start Date Between</label>

                        <div class="inline-fields">

                            <input type="date" id="trialStart1" class="form-control reset-field" />

                            <span>to</span>

                            <input type="date" id="trialStart2" class="form-control reset-field" />

                        </div>

                    </div>

                    <div id="trialEndDiv" style="display:none;">

                        <label>Select End Date Between</label>

                        <div class="inline-fields">

                            <input type="date" id="trialEnd1" class="form-control reset-field" />

                            <span>to</span>

                            <input type="date" id="trialEnd2" class="form-control reset-field" />

                        </div>

                    </div>

                </div>

                <!-- PDC -->

                <div class="side-card dynamic-pane" id="pdcPane">

                    <div class="side-title">
                        📅 PDC Extension
                    </div>

                    <label>Select PDC Extension Between</label>

                    <div class="inline-fields">

                        <input type="date" class="form-control reset-field" />

                        <span>to</span>

                        <input type="date" class="form-control reset-field" />

                    </div>

                </div>

                <!-- COST -->

                <div class="side-card dynamic-pane" id="costenhancePane">

                    <div class="side-title">
                        💰 Cost Enhancement
                    </div>

                    <label>Select Cost Enhancement Between</label>

                    <div class="inline-fields">

                        <input type="date" class="form-control reset-field" />

                        <span>to</span>

                        <input type="date" class="form-control reset-field" />

                    </div>

                </div>

                <!-- REVIEWS -->

                <div class="side-card dynamic-pane" id="reviewsPane">

                    <div class="side-title">
                        ⭐ Reviews
                    </div>

                    <div style="margin-bottom:18px;">

                        <label>Technical Reviews Type</label>

                        <select class="form-control chosen-select reset-field" multiple>

                            <option>Design Review</option>
                            <option>QA Review</option>
                            <option>Code Review</option>

                        </select>

                    </div>

                    <label>Technical Reviews Happened Between</label>

                    <div class="inline-fields">

                        <input type="date" class="form-control reset-field" />

                        <span>to</span>

                        <input type="date" class="form-control reset-field" />

                    </div>

                </div>

                <!-- TOT -->

                <div class="side-card dynamic-pane" id="totPane">

                    <div class="side-title">
                        🎓 ToT
                    </div>

                    <div style="margin-bottom:18px;">

                        <label>Select Date Type</label>

                        <select id="ddlTotType" class="form-control reset-field">

                            <option value="">Select</option>
                            <option>Latto Signed Date</option>
                            <option>ToT Certificate Date</option>

                        </select>

                    </div>

                    <div id="totDatesDiv">

                        <label>Select Date Between</label>

                        <div class="inline-fields">

                            <input type="date" id="totDate1" class="form-control reset-field" />

                            <span>to</span>

                            <input type="date" id="totDate2" class="form-control reset-field" />

                        </div>

                    </div>

                </div>

            </div>

        </div>

        <!-- COMMON BUTTONS -->

        <div class="bottom-buttons">

            <button type="button" class="search-btn">
                Search
            </button>

            <button type="button" class="reset-btn" id="btnReset">
                Reset
            </button>

        </div>

        <!-- ADD THIS WHOLE SECTION BELOW bottom-buttons DIV -->

<!-- STATIC RESULT TABLE -->

    </div>

    <!-- ================= RESULT TABLE ================= -->

<div class="result-section">

    <div class="result-header">

        <div>

            <h3 class="result-title" id="tableHeading">
                Project Details Report
            </h3>

            <div class="result-sub">
                Repository Records Preview
            </div>

        </div>

    </div>

    <div class="table-outer">

        <table class="custom-table">

            <thead>

                <tr>

                    <th>Project ID</th>
                    <th>Project Name</th>
                    <th>Category</th>
                    <th>Status</th>
                    <th>Type</th>
                    <th>Lab</th>
                    <th>Start</th>
                    <th>End</th>
                    <th>PDC</th>
                    <th>Cost</th>
                    <th>Enh.</th>
                    <th>Director</th>
                    <th>Trial</th>
                    <th>Review</th>
                    <th>ToT</th>

                </tr>

            </thead>

            <tbody>

    <!-- ROW GROUP 1 -->

    <tr>

        <td rowspan="3">PRJ-101</td>

        <td rowspan="3">AI Surveillance</td>

        <td rowspan="3">MM</td>

        <td rowspan="3">
            <span class="status-badge status-active">
                Ongoing
            </span>
        </td>

        <td rowspan="3">Main</td>

        <td>Lab 01</td>

        <td rowspan="3">12-Jan-25</td>

        <td rowspan="3">28-Dec-26</td>

        <td rowspan="3">10-Feb-26</td>

        <td rowspan="3">₹4.5L</td>

        <td rowspan="3">₹50K</td>

        <td rowspan="3">Dr. Sharma</td>

        <td>Completed</td>

        <td>Design</td>

        <td rowspan="3">Issued</td>

    </tr>

    <tr>

        <td>Lab 02</td>

        <td>Pending</td>

        <td>QA</td>

    </tr>

    <tr>

        <td>Lab 04</td>

        <td>Ongoing</td>

        <td>Code</td>

    </tr>

    <!-- ROW GROUP 2 -->

    <tr>

        <td rowspan="2">PRJ-102</td>

        <td rowspan="2">Radar Tracking</td>

        <td rowspan="2">TD</td>

        <td rowspan="2">
            <span class="status-badge status-completed">
                Completed
            </span>
        </td>

        <td rowspan="2">Task</td>

        <td>Lab 03</td>

        <td rowspan="2">08-Feb-24</td>

        <td rowspan="2">17-Oct-25</td>

        <td rowspan="2">15-Nov-25</td>

        <td rowspan="2">₹8.7L</td>

        <td rowspan="2">₹1.2L</td>

        <td rowspan="2">Dr. Rao</td>

        <td>Pending</td>

        <td>QA</td>

        <td rowspan="2">Pending</td>

    </tr>

    <tr>

        <td>Lab 08</td>

        <td>Completed</td>

        <td>Security</td>

    </tr>

    <!-- ROW GROUP 3 -->

    <tr>

        <td rowspan="4">PRJ-103</td>

        <td rowspan="4">Defence Comm</td>

        <td rowspan="4">IF</td>

        <td rowspan="4">
            <span class="status-badge status-pending">
                Pending
            </span>
        </td>

        <td rowspan="4">Sub</td>

        <td>Lab 07</td>

        <td rowspan="4">20-Mar-25</td>

        <td rowspan="4">---</td>

        <td rowspan="4">05-Apr-26</td>

        <td rowspan="4">₹2.1L</td>

        <td rowspan="4">₹35K</td>

        <td rowspan="4">Dr. Patil</td>

        <td>Ongoing</td>

        <td>Code</td>

        <td rowspan="4">Not Started</td>

    </tr>

    <tr>

        <td>Lab 09</td>

        <td>Pending</td>

        <td>Internal</td>

    </tr>

    <tr>

        <td>Lab 11</td>

        <td>Completed</td>

        <td>Audit</td>

    </tr>

    <tr>

        <td>Lab 12</td>

        <td>Completed</td>

        <td>QA</td>

    </tr>

    <!-- SINGLE ENTRY -->

    <tr>

        <td>PRJ-104</td>

        <td>Naval Sensor</td>

        <td>TD</td>

        <td>
            <span class="status-badge status-active">
                Ongoing
            </span>
        </td>

        <td>Main</td>

        <td>Lab 15</td>

        <td>05-Jun-25</td>

        <td>10-Jan-27</td>

        <td>21-Feb-26</td>

        <td>₹9.2L</td>

        <td>₹70K</td>

        <td>Dr. Kulkarni</td>

        <td>Pending</td>

        <td>Field</td>

        <td>Processing</td>

    </tr>

    <!-- ROW GROUP 5 -->

    <tr>

        <td rowspan="2">PRJ-105</td>

        <td rowspan="2">Drone Mapping</td>

        <td rowspan="2">MM</td>

        <td rowspan="2">
            <span class="status-badge status-completed">
                Completed
            </span>
        </td>

        <td rowspan="2">Task</td>

        <td>Lab 05</td>

        <td rowspan="2">01-Jan-23</td>

        <td rowspan="2">15-Jul-24</td>

        <td rowspan="2">08-Aug-24</td>

        <td rowspan="2">₹6.4L</td>

        <td rowspan="2">₹90K</td>

        <td rowspan="2">Dr. Joshi</td>

        <td>Completed</td>

        <td>Design</td>

        <td rowspan="2">Issued</td>

    </tr>

    <tr>

        <td>Lab 06</td>

        <td>Completed</td>

        <td>QA</td>

    </tr>

</tbody>

        </table>

    </div>

</div>

</div>

</form>

<!-- JS -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.jquery.min.js"></script>

<script>

    $(document).ready(function () {

        /* CHOSEN */

        $('.chosen-select').chosen({
            width: "100%"
        });

        /* INITIAL DISABLE */

        $("#txtFromDate, #txtToDate").prop("disabled", true);

        $("#totDate1, #totDate2").prop("disabled", true);

        /* MOVE SLIDER */

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

        /* DATE ENABLE */

        $("#ddlSearchFor").change(function () {

            if ($(this).val() === "") {

                $("#txtFromDate, #txtToDate")
                    .prop("disabled", true)
                    .val('');

            }
            else {

                $("#txtFromDate, #txtToDate")
                    .prop("disabled", false);

            }

        });

        /* TOT */

        $("#ddlTotType").change(function () {

            if ($(this).val() === "") {

                $("#totDate1, #totDate2")
                    .prop("disabled", true)
                    .val('');
            }
            else {

                $("#totDate1, #totDate2")
                    .prop("disabled", false);
            }

        });

        /* TEAM RADIO */

        $('input[name="searchType"]').change(function () {

            if ($(this).val() === "roles") {

                $('#rolesDiv').show();
                $('#empDiv').hide();
            }
            else {

                $('#rolesDiv').hide();
                $('#empDiv').show();
            }

        });

        /* TRIAL RADIO */

        $('input[name="trialDateType"]').change(function () {

            $('#trialStartDiv').hide();
            $('#trialEndDiv').hide();

            if ($(this).val() === "start") {

                $('#trialStartDiv').fadeIn(150);
            }

            if ($(this).val() === "end") {

                $('#trialEndDiv').fadeIn(150);
            }

        });

        /* RESET FUNCTION */

        function resetAllFields() {

            $('.reset-field').each(function () {

                if ($(this).is('select')) {

                    $(this).val('');
                }
                else {

                    $(this).val('');
                }

            });

            $('.chosen-select').trigger('chosen:updated');

            $('input[type=radio]').prop('checked', false);

            $("#txtFromDate, #txtToDate").prop("disabled", true);

            $("#totDate1, #totDate2").prop("disabled", true);

            $('#trialStartDiv').hide();
            $('#trialEndDiv').hide();

            $('#rolesDiv').show();
            $('#empDiv').hide();

            $('input[name="searchType"][value="roles"]').prop('checked', true);
        }

        /* TAB CLICK */

        $('.custom-tabs .nav-link').click(function () {

            resetAllFields();

            $('.custom-tabs .nav-link').removeClass('active');

            $(this).addClass('active');

            var target = $(this).data('target');

            $('.dynamic-pane').removeClass('active-pane');

            if (target === "project") {

                $('#leftPanel').show();

                $('#costFields').show();

                $('#projectPane').addClass('active-pane');
            }

            else if (target === "tot") {

                $('#leftPanel').hide();

                $('#totPane').addClass('active-pane');
            }

            else {

                $('#leftPanel').show();

                $('#costFields').hide();

                $('#' + target + 'Pane').addClass('active-pane');
            }

            moveSlider($(this));

            /* ADD THIS INSIDE YOUR TAB CLICK FUNCTION */

            var titleText = "Project Details Report";

            if (target === "project") {
                titleText = "Project Details Report";
            }

            else if (target === "team") {
                titleText = "Project Team Report";
            }

            else if (target === "subprojects") {
                titleText = "Sub Projects Report";
            }

            else if (target === "trials") {
                titleText = "Trials Report";
            }

            else if (target === "pdc") {
                titleText = "PDC Extension Report";
            }

            else if (target === "costenhance") {
                titleText = "Cost Enhancement Report";
            }

            else if (target === "reviews") {
                titleText = "Technical Reviews Report";
            }

            else if (target === "tot") {
                titleText = "ToT Report";
            }

            $('#tableHeading').text(titleText);

        });

        /* RESET BUTTON */

        $('#btnReset').click(function () {

            resetAllFields();

        });

    });

</script>

</body>
</html>