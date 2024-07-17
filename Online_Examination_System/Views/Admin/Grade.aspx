<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Grade.aspx.cs" Inherits="Online_Examination_System.Views.Admin.Grade" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../../Assets/Lib/js/jquery.min.js"></script>
    <script src="../../Assets/Lib/js/bootstrap.bundle.min.js"></script>
    <script src="../../Assets/Lib/js/jquery.easing.min.js"></script>
    <script src="../../Assets/Lib/js/admin-2.min.js"></script>
    <script src="../../Assets/Lib/js/jquery.dataTables.min.js"></script>
    <script src="../../Assets/Lib/js/dataTables.bootstrap4.min.js"></script>
    <script src="../../Assets/Lib/js/Chart.min.js"></script>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var active = document.getElementById('Grade');
            if (active) {
                active.classList.add('active');
            }
            $('#dataTable').DataTable();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<h3 class="text-center">Grade Reports</h3>--%>
    <link href="../../Assets/Lib/css/dataTables.bootstrap4.min.css" rel="stylesheet">

    <div style="display: flex; justify-content: center">
        <div class="card shadow mb-4" style="width: 95%">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">Grade Reports</h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>Exam ID</th>
                                <th>Exam Name</th>
                                <th>Number of submissions</th>
                                <th>Average Grades</th>
                                <th>Operation</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="gradeTable" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td><%# string.Format("{0:D4}", Eval("examId")) %></td>
                                        <td><%# Eval("examName") %></td>
                                        <td><%# Eval("submissions") %></td>
                                        <td><%# Double.IsNaN(Convert.ToDouble(Eval("averageGrades"))) ? "0%" : String.Format("{0:F2}%", Eval("averageGrades")) %></td>
                                        <td>
                                            <button type="button" class="btn btn-primary" style="margin-left: 15px; height: calc(1.5em + .5rem + 2px);" data-toggle="modal"
                                                onclick="viewClick(this)" data-target="#viewGradeModal" data-examid='<%# Eval("examId") %>' data-examname='<%# Eval("examName") %>'>
                                                View</button></td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal -->
    <div class="modal fade" id="viewGradeModal" tabindex="-1" role="dialog" aria-labelledby="viewGradeLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="viewGradeLabel"></h5>
                </div>
                <div class="modal-body">

                    <div>
                        <div class="form-group">
                            <div style="display: flex;justify-content: center" id="no-grade"><code>No Result</code></div>
                            
                            <div class="card shadow mb-4" id="chart-div">
                                <!-- Card Header - Dropdown -->
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">Grade Distribution</h6>
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                    <div class="chart-pie pt-4">
                                        <canvas id="myPieChart"></canvas>
                                    </div>
                                    <%--<hr>
                                    Styling for the donut chart can be found in the
                                    <code>/js/demo/chart-pie-demo.js</code> file.--%>
                                </div>
                            </div>
                            <div class="row">
                                <%--<div class="col-md-9" style="padding: 0px 3px 0px 3px;">
                                    <input type="text" class="form-control" style="width: 100%;" id="studentName" placeholder="Enter student name or student ID">
                                </div>
                                <div class="col-md-3" style="padding: 0px 3px 0px 3px;">
                                    <button id="searchButton" class="btn btn-primary" style="width: 100%;">Search</button>
                                </div>--%>
                            </div>
                            <div id="grade-container" style="padding-top: 10px;"></div>



                        </div>

                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button id="confirmButton" type="button" class="btn btn-primary">Confirm</button>
                </div>

            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        let myPieChart;
        function viewClick(element) {
            if (myPieChart) {
                myPieChart.destroy();
                myPieChart = null;
                console.log("aaa");
            }
            //console.log(element.getAttribute('data-examId'));
            document.getElementById("viewGradeLabel").innerHTML = element.getAttribute('data-examName') + " Grade Report";
            var request = new XMLHttpRequest();
            request.open("GET", "../../GetStudentsGrade.aspx?examId=" + encodeURIComponent(element.getAttribute('data-examId')), true)
            request.onload = function () {
                if (request.status === 200) {
                    //console.log(request.responseText);
                    var json = JSON.parse(request.responseText);
                    var gradesArray = json.grades_info;

                    var gradeContainer = document.getElementById("grade-container");
                    gradeContainer.innerHTML = "";
                    if (json.status === "success") {
                        document.getElementById("chart-div").style.display = "block";
                        document.getElementById("no-grade").style.display = "none";
                        var headerRow = document.createElement("div");
                        headerRow.classList.add("row", "header-row");
                        headerRow.innerHTML = '<div class="col"><b>Student ID</b></div>' +
                            '<div class="col"><b>Student Name</b></div>' +
                            '<div class="col"><b>Grade</b></div>';
                        gradeContainer.appendChild(headerRow);
                        let a = 0, b = 0, c = 0, d = 0, e = 0;
                        gradesArray.forEach(function (grade) {
                            if (grade !== '-1' || grade !== '-2') {
                                var parts = grade.grades.split('/');
                                var numerator = parseInt(parts[0], 10);
                                var denominator = parseInt(parts[1], 10);
                                var percentage = (numerator / denominator) * 100;
                                var roundedPercentage = percentage.toFixed(2) + '%';
                                if (percentage.toFixed(2) < 60) {
                                    e++;
                                } else if (percentage.toFixed(2) > 60 && percentage.toFixed(2) <= 70) {
                                    d++;
                                } else if (percentage.toFixed(2) > 70 && percentage.toFixed(2) <= 80) {
                                    c++;
                                } else if (percentage.toFixed(2) > 80 && percentage.toFixed(2) <= 90) {
                                    b++;
                                } else {
                                    a++;
                                }
                                var gradeDiv = document.createElement("div");
                                gradeDiv.classList.add("row", "grade-row");
                                gradeDiv.innerHTML = '<div class="col">' + ('00000' + grade.studentsId).slice(-5) + '</div>' +
                                    '<div class="col">' + grade.studentsName + '</div>' +
                                    '<div class="col">' + roundedPercentage + '</div>';
                                gradeContainer.appendChild(gradeDiv);
                            }

                        });


                        // Set new default font family and font color to mimic Bootstrap's default styling
                        Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
                        Chart.defaults.global.defaultFontColor = '#858796';

                        
                        var ctx = document.getElementById("myPieChart");
                        
                        myPieChart = new Chart(ctx, {
                            type: 'doughnut',
                            data: {
                                labels: [">90%", "80%~90%", "70%~80%", "60%~70%", "<60%"],
                                datasets: [{
                                    data: [a, b, c, d, e],
                                    backgroundColor: ['#4e73df', '#1cc88a', '#36b9cc', '#732AAF', '#AF265F'],
                                    hoverBackgroundColor: ['#2e59d9', '#17a673', '#2c9faf', '#541F80', '#801C45'],
                                    hoverBorderColor: "rgba(234, 236, 244, 1)",
                                }],
                            },
                            options: {
                                animation: {
                                    animateRotate: true,
                                    animateScale: true,
                                    duration: 1000
                                },
                                maintainAspectRatio: false,
                                tooltips: {
                                    backgroundColor: "rgb(255,255,255)",
                                    bodyFontColor: "#858796",
                                    borderColor: '#dddfeb',
                                    borderWidth: 1,
                                    xPadding: 15,
                                    yPadding: 15,
                                    displayColors: false,
                                    caretPadding: 10,
                                },
                                legend: {
                                    display: false
                                },
                                cutoutPercentage: 80,
                            },
                        });
                        //window.myPieChart = myPieChart;
                    } else {
                        document.getElementById("chart-div").style.display = "none";
                        document.getElementById("no-grade").style.display = "flex";
                    }
                }
            }
            request.send();
        }
    </script>
    <%--<script src="../../Assets/Lib/js/chart-pie-demo.js"></script>--%>
</asp:Content>
