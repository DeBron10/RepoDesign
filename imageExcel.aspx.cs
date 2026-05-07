using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web.UI;

using MySql.Data.MySqlClient;

using OfficeOpenXml;
using OfficeOpenXml.Drawing;
using OfficeOpenXml.Style;

namespace ExcelApp
{
    public class LabProjectData
    {
        public string LabName { get; set; }

        public string ProjectType { get; set; }

        public string ProjectStatus { get; set; }

        public string Category { get; set; }

        public string ProjectNumber { get; set; }

        public string ProjectTitle { get; set; }

        public string ProjectDirector { get; set; }

        public int PermanentEmp { get; set; }

        public int ContractEmp { get; set; }

        public string OriginalPDC { get; set; }

        public string RevisionPDC { get; set; }

        public string CurrentPDC { get; set; }

        public int PDCRevisionCount { get; set; }

        public double OriginalCost { get; set; }

        public double CostRevision { get; set; }

        public double CurrentCost { get; set; }

        public int CostRevisionCount { get; set; }

        public double Expenditure { get; set; }

        public double InPipeline { get; set; }

        public double Commitment { get; set; }

        public double Balance { get; set; }

        public string MilestonesAchieved { get; set; }

        public string CriticalMilestones { get; set; }

        public string TestsConducted { get; set; }

        public string TestsPlanned { get; set; }
    }

    public partial class ExcelGen : Page
    {
        // ================= MYSQL CONNECTION =================

        string connectionString =
            "";



        protected void btnExportExcel_Click(object sender, EventArgs e)
        {
            GenerateExcel();
        }



        // ================= STATIC PROJECT DATA =================

        private List<LabProjectData> GetLabProjectList()
        {
            return new List<LabProjectData>
            {
                new LabProjectData
                {
                    LabName = "Bio Lab",
                    ProjectType = "Main",
                    ProjectStatus = "On Track",
                    Category = "Vaccine",
                    ProjectNumber = "BIO-01",
                    ProjectTitle = "Vaccine Stability Study",
                    ProjectDirector = "Dr. A",

                    PermanentEmp = 8,
                    ContractEmp = 4,

                    OriginalPDC = "01/12/2025",
                    RevisionPDC = "05/12/2025",
                    CurrentPDC = "10/12/2025",
                    PDCRevisionCount = 2,

                    OriginalCost = 10,
                    CostRevision = 2,
                    CurrentCost = 12,
                    CostRevisionCount = 2,

                    Expenditure = 5,
                    InPipeline = 2,
                    Commitment = 5,
                    Balance = 2,

                    MilestonesAchieved = "Stability 95%",
                    CriticalMilestones = "Next phase ready",
                    TestsConducted = "12",
                    TestsPlanned = "15"
                },

                new LabProjectData
                {
                    LabName = "AI Lab",
                    ProjectType = "Sub",
                    ProjectStatus = "At Risk",
                    Category = "AI Research",
                    ProjectNumber = "AI-01",
                    ProjectTitle = "Face Recognition System",
                    ProjectDirector = "Dr. B",

                    PermanentEmp = 5,
                    ContractEmp = 6,

                    OriginalPDC = "01/12/2025",
                    RevisionPDC = "03/12/2025",
                    CurrentPDC = "07/12/2025",
                    PDCRevisionCount = 1,

                    OriginalCost = 12,
                    CostRevision = 1,
                    CurrentCost = 13,
                    CostRevisionCount = 1,

                    Expenditure = 6,
                    InPipeline = 3,
                    Commitment = 4,
                    Balance = 2,

                    MilestonesAchieved = "Accuracy 98%",
                    CriticalMilestones = "GPU upgrade needed",
                    TestsConducted = "20",
                    TestsPlanned = "25"
                },

                new LabProjectData
                {
                    LabName = "Chem Lab",
                    ProjectType = "Main",
                    ProjectStatus = "Delayed",
                    Category = "Chemical",
                    ProjectNumber = "CHE-01",
                    ProjectTitle = "Polymer Synthesis",
                    ProjectDirector = "Dr. C",

                    PermanentEmp = 10,
                    ContractEmp = 3,

                    OriginalPDC = "01/12/2025",
                    RevisionPDC = "04/12/2025",
                    CurrentPDC = "08/12/2025",
                    PDCRevisionCount = 1,

                    OriginalCost = 15,
                    CostRevision = 2,
                    CurrentCost = 16,
                    CostRevisionCount = 2,

                    Expenditure = 7,
                    InPipeline = 3,
                    Commitment = 5,
                    Balance = 2,

                    MilestonesAchieved = "Compound synthesized",
                    CriticalMilestones = "Scale-up planned",
                    TestsConducted = "7",
                    TestsPlanned = "8"
                }
            };
        }



        // ================= FETCH IMAGES FROM DB =================

        private List<byte[]> GetProjectImages(int projectId)
        {
            List<byte[]> images = new List<byte[]>();

            using (MySqlConnection con =
                new MySqlConnection(connectionString))
            {
                con.Open();

                string query =
                    @"SELECT image_data
                      FROM project_images
                      WHERE project_id = @project_id";

                using (MySqlCommand cmd =
                    new MySqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue(
                        "@project_id",
                        projectId
                    );

                    using (MySqlDataReader reader =
                        cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            if (reader["image_data"] != DBNull.Value)
                            {
                                byte[] imageBytes =
                                    (byte[])reader["image_data"];

                                images.Add(imageBytes);
                            }
                        }
                    }
                }
            }

            return images;
        }



        // ================= GENERATE EXCEL =================

        private void GenerateExcel()
        {
            //ExcelPackage.LicenseContext =
            //    LicenseContext.NonCommercial;

            List<LabProjectData> data =
                GetLabProjectList();

            using (ExcelPackage package =
                new ExcelPackage())
            {
                ExcelWorksheet sheet =
                    package.Workbook.Worksheets.Add(
                        "Project MPR"
                    );

                int totalCols = 26;

                // ================= TITLE =================

                var monthCell =
                    sheet.Cells[1, 1, 1, totalCols];

                monthCell.Merge = true;

                monthCell.Value = "December 2025";

                monthCell.Style.Font.Bold = true;

                monthCell.Style.Font.Size = 16;

                monthCell.Style.Font.UnderLine = true;

                monthCell.Style.Font.Color.SetColor(
                    Color.Red
                );

                monthCell.Style.HorizontalAlignment =
                    ExcelHorizontalAlignment.Center;

                monthCell.Style.VerticalAlignment =
                    ExcelVerticalAlignment.Center;

                monthCell.Style.Border.BorderAround(
                    ExcelBorderStyle.Thin
                );



                int r2 = 2;
                int r3 = 3;



                // ================= FIXED HEADERS =================

                string[] fixedHeaders =
                {
                    "Sr. No",
                    "Project Type",
                    "Project Status",
                    "Product Images",
                    "Category",
                    "Project Number",
                    "Project Title",
                    "Project Director",
                    "Milestones Achieved & Other Progress",
                    "Critical Milestones Planned Next Month",
                    "Tests & Trials Conducted (Remarks)",
                    "Tests & Trials Planned"
                };

                int[] fixedCols =
                {
                    1,
                    2,
                    3,
                    4,
                    5,
                    6,
                    7,
                    8,
                    23,
                    24,
                    25,
                    26
                };

                for (int i = 0; i < fixedHeaders.Length; i++)
                {
                    var cell =
                        sheet.Cells[
                            r2,
                            fixedCols[i],
                            r3,
                            fixedCols[i]
                        ];

                    cell.Merge = true;

                    cell.Value = fixedHeaders[i];

                    ApplyHeaderStyle(cell);
                }



                // ================= MANPOWER =================

                var manpower =
                    sheet.Cells[r2, 9, r2, 10];

                manpower.Merge = true;

                manpower.Value = "Manpower";

                ApplyHeaderStyle(manpower);

                AddHeader(sheet, r3, 9, "Permanent Emp");

                AddHeader(sheet, r3, 10, "Contract Emp");



                // ================= PDC =================

                var pdc =
                    sheet.Cells[r2, 11, r2, 14];

                pdc.Merge = true;

                pdc.Value = "PDC Dates (Months)";

                ApplyHeaderStyle(pdc);

                string[] pdcHeaders =
                {
                    "Original PDC",
                    "Revision PDC",
                    "Current PDC",
                    "No. of Revisions"
                };

                for (int i = 0; i < pdcHeaders.Length; i++)
                {
                    AddHeader(
                        sheet,
                        r3,
                        11 + i,
                        pdcHeaders[i]
                    );
                }



                // ================= COST =================

                var cost =
                    sheet.Cells[r2, 15, r2, 18];

                cost.Merge = true;

                cost.Value = "Cost (₹ Cr)";

                ApplyHeaderStyle(cost);

                string[] costHeaders =
                {
                    "Original Cost",
                    "Cost Revision",
                    "Current Cost",
                    "No. of Cost Revisions"
                };

                for (int i = 0; i < costHeaders.Length; i++)
                {
                    AddHeader(
                        sheet,
                        r3,
                        15 + i,
                        costHeaders[i]
                    );
                }



                // ================= EXPENDITURE =================

                var exp =
                    sheet.Cells[r2, 19, r2, 22];

                exp.Merge = true;

                exp.Value = "Expenditure till date";

                ApplyHeaderStyle(exp);

                string[] expHeaders =
                {
                    "Expenditure",
                    "In Pipeline",
                    "Commitment",
                    "Balance"
                };

                for (int i = 0; i < expHeaders.Length; i++)
                {
                    AddHeader(
                        sheet,
                        r3,
                        19 + i,
                        expHeaders[i]
                    );
                }



                // ================= DATA =================

                int startRow = 4;

                int srNo = 1;

                var labGroups =
                    data.GroupBy(x => x.LabName);

                foreach (var labGroup in labGroups)
                {
                    var labCell =
                        sheet.Cells[
                            startRow,
                            1,
                            startRow,
                            totalCols
                        ];

                    labCell.Merge = true;

                    labCell.Value = labGroup.Key;

                    labCell.Style.Font.Bold = true;

                    labCell.Style.Font.Color.SetColor(
                        Color.Red
                    );

                    labCell.Style.Fill.PatternType =
                        ExcelFillStyle.Solid;

                    labCell.Style.Fill.BackgroundColor.SetColor(
                        Color.Yellow
                    );

                    labCell.Style.HorizontalAlignment =
                        ExcelHorizontalAlignment.Center;

                    labCell.Style.VerticalAlignment =
                        ExcelVerticalAlignment.Center;

                    labCell.Style.Border.BorderAround(
                        ExcelBorderStyle.Thin
                    );

                    startRow++;

                    foreach (var proj in labGroup)
                    {
                        int currentProjectId = srNo;

                        // ================= BASIC DATA =================

                        sheet.Cells[startRow, 1].Value = srNo++;

                        sheet.Cells[startRow, 2].Value =
                            proj.ProjectType;

                        sheet.Cells[startRow, 3].Value =
                            proj.ProjectStatus;



                        // ================= GET IMAGES =================

                        List<byte[]> projectImages =
                            GetProjectImages(
                                currentProjectId
                            );



                        // ================= INSERT IMAGES =================

                        if (projectImages.Count > 0)
                        {
                            int imageLeft = 0;

                            for (int i = 0;
                                 i < projectImages.Count;
                                 i++)
                            {
                                try
                                {
                                    byte[] imageBytes =
                                        projectImages[i];

                                    using (MemoryStream ms =
                                        new MemoryStream(
                                            imageBytes
                                        ))
                                    {
                                        Image img =
                                            Image.FromStream(ms);

                                        ExcelPicture picture =
                                            sheet.Drawings.AddPicture(
                                                "IMG_" +
                                                startRow +
                                                "_" +
                                                i,
                                                img
                                            );

                                        picture.SetPosition(
                                            startRow - 1,
                                            5,
                                            3,
                                            imageLeft
                                        );

                                        picture.SetSize(
                                            45,
                                            45
                                        );

                                        imageLeft += 50;
                                    }
                                }
                                catch (Exception ex)
                                {

                                }
                            }

                            sheet.Row(startRow).Height = 60;
                        }



                        // ================= OTHER DATA =================

                        sheet.Cells[startRow, 5].Value =
                            proj.Category;

                        sheet.Cells[startRow, 6].Value =
                            proj.ProjectNumber;

                        sheet.Cells[startRow, 7].Value =
                            proj.ProjectTitle;

                        sheet.Cells[startRow, 8].Value =
                            proj.ProjectDirector;

                        sheet.Cells[startRow, 9].Value =
                            proj.PermanentEmp;

                        sheet.Cells[startRow, 10].Value =
                            proj.ContractEmp;

                        sheet.Cells[startRow, 11].Value =
                            proj.OriginalPDC;

                        sheet.Cells[startRow, 12].Value =
                            proj.RevisionPDC;

                        sheet.Cells[startRow, 13].Value =
                            proj.CurrentPDC;

                        sheet.Cells[startRow, 14].Value =
                            proj.PDCRevisionCount;

                        sheet.Cells[startRow, 15].Value =
                            proj.OriginalCost;

                        sheet.Cells[startRow, 16].Value =
                            proj.CostRevision;

                        sheet.Cells[startRow, 17].Value =
                            proj.CurrentCost;

                        sheet.Cells[startRow, 18].Value =
                            proj.CostRevisionCount;

                        sheet.Cells[startRow, 19].Value =
                            proj.Expenditure;

                        sheet.Cells[startRow, 20].Value =
                            proj.InPipeline;

                        sheet.Cells[startRow, 21].Value =
                            proj.Commitment;

                        sheet.Cells[startRow, 22].Value =
                            proj.Balance;

                        sheet.Cells[startRow, 23].Value =
                            proj.MilestonesAchieved;

                        sheet.Cells[startRow, 24].Value =
                            proj.CriticalMilestones;

                        sheet.Cells[startRow, 25].Value =
                            proj.TestsConducted;

                        sheet.Cells[startRow, 26].Value =
                            proj.TestsPlanned;



                        // ================= BORDERS =================

                        for (int c = 1;
                             c <= totalCols;
                             c++)
                        {
                            sheet.Cells[startRow, c]
                                .Style.Border.Top.Style =
                                    ExcelBorderStyle.Thin;

                            sheet.Cells[startRow, c]
                                .Style.Border.Bottom.Style =
                                    ExcelBorderStyle.Thin;

                            sheet.Cells[startRow, c]
                                .Style.Border.Left.Style =
                                    ExcelBorderStyle.Thin;

                            sheet.Cells[startRow, c]
                                .Style.Border.Right.Style =
                                    ExcelBorderStyle.Thin;

                            sheet.Cells[startRow, c]
                                .Style.WrapText = true;

                            sheet.Cells[startRow, c]
                                .Style.VerticalAlignment =
                                    ExcelVerticalAlignment.Top;
                        }

                        startRow++;
                    }
                }



                // ================= COLUMN WIDTHS =================

                for (int c = 1;
                     c <= totalCols;
                     c++)
                {
                    sheet.Column(c).AutoFit();
                }

                // IMAGE COLUMN

                sheet.Column(4).Width = 80;



                // ================= FREEZE =================

                sheet.View.FreezePanes(4, 2);



                // ================= DOWNLOAD =================

                Response.Clear();

                Response.ContentType =
                    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

                Response.AddHeader(
                    "content-disposition",
                    "attachment; filename=Project_MPR.xlsx"
                );

                Response.BinaryWrite(
                    package.GetAsByteArray()
                );

                Response.End();
            }
        }



        // ================= HEADER STYLE =================

        private void ApplyHeaderStyle(ExcelRange cell)
        {
            cell.Style.Font.Bold = true;

            cell.Style.Font.Color.SetColor(
                Color.Blue
            );

            cell.Style.HorizontalAlignment =
                ExcelHorizontalAlignment.Center;

            cell.Style.VerticalAlignment =
                ExcelVerticalAlignment.Center;

            cell.Style.WrapText = true;

            cell.Style.Border.Top.Style =
                ExcelBorderStyle.Thin;

            cell.Style.Border.Bottom.Style =
                ExcelBorderStyle.Thin;

            cell.Style.Border.Left.Style =
                ExcelBorderStyle.Thin;

            cell.Style.Border.Right.Style =
                ExcelBorderStyle.Thin;
        }



        // ================= ADD HEADER =================

        private void AddHeader(
            ExcelWorksheet sheet,
            int row,
            int col,
            string value
        )
        {
            sheet.Cells[row, col].Value = value;

            ApplyHeaderStyle(
                sheet.Cells[row, col]
            );
        }
    }
}
