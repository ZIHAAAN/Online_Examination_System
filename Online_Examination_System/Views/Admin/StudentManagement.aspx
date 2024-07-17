<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="StudentManagement.aspx.cs" Inherits="Online_Examination_System.Views.Admin.StudentManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../../Assets/Lib/js/jquery.min.js"></script>
    <script src="../../Assets/Lib/js/bootstrap.bundle.min.js"></script>
    <script src="../../Assets/Lib/js/jquery.easing.min.js"></script>
    <script src="../../Assets/Lib/js/admin-2.min.js"></script>
    <script src="../../Assets/Lib/js/jquery.dataTables.min.js"></script>
    <script src="../../Assets/Lib/js/dataTables.bootstrap4.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var active = document.getElementById('StudentManagement');
            if (active) {
                active.classList.add('active');
            }
            $('#dataTable').DataTable();
            var buttonHtml = '<button type="button" class="btn btn-primary" style="margin-left:15px;height: calc(1.5em + .5rem + 2px);" data-toggle="modal" data-target="#addStudentModal">Add Student</button>';
            $("#dataTable_filter").append(buttonHtml);
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        /*.student-table .row:nth-child(odd) {
            background-color: #f0f8ff;*/ /* 浅蓝色背景 */
        /*}

        .student-table .row:nth-child(even) {
            background-color: #f8f8f8;*/ /* 白灰色背景 */
        /*}*/

        .selected-row {
            background-color: #0d6efd; /* 浅蓝色背景 */
            color: #ffffff; /* 文字颜色 */
        }
    </style>

    <link href="../../Assets/Lib/css/dataTables.bootstrap4.min.css" rel="stylesheet">

    <div style="display: flex; justify-content: center">
        <div class="card shadow mb-4" style="width: 95%">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">My Students</h6>

            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>Student ID</th>
                                <th>Student Name</th>
                                <th>Username</th>
                                <th>Operation</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="studentTable" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td><%# string.Format("{0:D5}", Eval("id")) %></td>
                                        <td><%# Eval("realName") %></td>
                                        <td><%# Eval("nickName") %></td>
                                        <td>
                                            <asp:Button Text="Delete" runat="server" Class="btn btn-danger" OnClick="DeleteStudent_Click" CommandArgument='<%# Eval("id") %>' />
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <%--<div class="container-fluid">
        <div class="row">
            <div class="col">
                <h3 class="text-center">Student Management</h3>
            </div>
        </div>
        <div style="width: 80%; margin: auto">
            <div class="row m-3">
                <div class="col-md-9"></div>
                <div class="col-md-3 text-center align-self-center">
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addStudentModal">Add Student</button>
                </div>
            </div>
        </div>


        <div class="student-table" style="width: 80%; margin: auto">
            <div class="row" style="border: 1px solid #d0d3da;">
                <div class="col-md-3 text-center align-self-center">Student ID</div>
                <div class="col-md-3 text-center align-self-center">Student Name</div>
                <div class="col-md-3 text-center align-self-center">Username</div>
                <div class="col-md-3 text-center align-self-center">
                </div>
            </div>
            <asp:Repeater ID="studentTable" runat="server">
                <ItemTemplate>
                    <div class="row" style="border-left: 1px solid #d0d3da; border-bottom: 1px solid #d0d3da; border-right: 1px solid #d0d3da">
                        <div class="col-md-3 text-center align-self-center"><%# string.Format("{0:D5}", Eval("id")) %></div>

                        <div class="col-md-3 text-center align-self-center"><%# Eval("realName") %></div>
                        <div class="col-md-3 text-center align-self-center"><%# Eval("nickName") %></div>
                        <div class="col-md-3 text-center align-self-center">
                            <asp:Button Text="Delete" runat="server" Class="btn btn-danger" OnClick="DeleteStudent_Click" CommandArgument='<%# Eval("id") %>' />
                        </div>
                    </div>



                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>--%>
    <div class="row">
    </div>
    <!-- Modal -->
    <div class="modal fade" id="addStudentModal" tabindex="-1" role="dialog" aria-labelledby="addStudentModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addStudentModalLabel">Add Student</h5>
                </div>
                <div class="modal-body">

                    <div>
                        <div class="form-group">
                            <label for="searchStudent" class="text-black">Search Student</label>
                            <div class="row">
                                <div class="col-md-9" style="padding: 0px 3px 0px 3px;">
                                    <input type="text" class="form-control" style="width: 100%;" id="studentName" placeholder="Enter student name or student ID">
                                </div>
                                <div class="col-md-3" style="padding: 0px 3px 0px 3px;">
                                    <button id="searchButton" class="btn btn-primary" style="width: 100%;">Search</button>
                                </div>
                            </div>
                            <div id="student-container" style="padding-top: 10px;"></div>



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
    <!-- Bootstrap JavaScript -->
    <%--<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>--%>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        var selectedStudentID = null;

        document.addEventListener('DOMContentLoaded', function () {
            document.getElementById("searchButton").addEventListener("click", function (event) {
                event.preventDefault();
                var keyword = document.getElementById("studentName").value;
                var request = new XMLHttpRequest();

                request.open("GET", "../../Search_Student.aspx?keyword=" + encodeURIComponent(keyword), true);
                request.onload = function () {
                    if (request.status === 200) {
                        var jsonResponse = JSON.parse(request.responseText);
                        var studentInfoArray = jsonResponse.student_info;
                        var studentContainer = document.getElementById("student-container");
                        studentContainer.innerHTML = "";
                        if (jsonResponse.status === "success") {
                            var headerRow = document.createElement("div");
                            headerRow.classList.add("row", "header-row");
                            headerRow.innerHTML = '<div class="col"><b>Student ID</b></div>' +
                                '<div class="col"><b>Username</b></div>' +
                                '<div class="col"><b>Name</b></div>';
                            studentContainer.appendChild(headerRow);

                            studentInfoArray.forEach(function (student) {
                                var studentDiv = document.createElement("div");
                                studentDiv.classList.add("row", "student-row");
                                studentDiv.innerHTML = '<div class="col">' + ('00000' + student.studentid).slice(-5) + '</div>' +
                                    '<div class="col">' + student.username + '</div>' +
                                    '<div class="col">' + student.name + '</div>';
                                studentContainer.appendChild(studentDiv);

                                studentDiv.addEventListener('click', function () {
                                    var selectedRow = document.querySelector('.selected-row');
                                    if (selectedRow) {
                                        selectedRow.classList.remove('selected-row');
                                    }
                                    this.classList.add('selected-row');
                                    selectedStudentID = student.studentid;
                                });
                            });
                        } else {
                            var statusMessage = document.createElement("p");
                            statusMessage.textContent = "No student information found.";
                            studentContainer.appendChild(statusMessage);
                        }
                    } else {
                        alert("Error: " + request.status);
                    }
                };
                request.send();
            });


            document.getElementById("confirmButton").addEventListener("click", function () {
                if (!selectedStudentID) {
                    alert("Please select a student first.");
                    return;
                }
                this.disabled = true;

                var requestAdd = new XMLHttpRequest();
                requestAdd.open("GET", "../../AddStudent.aspx?studentid=" + encodeURIComponent(selectedStudentID), true);
                requestAdd.onload = function () {
                    document.getElementById("confirmButton").disabled = false;
                    if (requestAdd.status === 200) {
                        var jsonAddResponse = JSON.parse(requestAdd.responseText);
                        if (jsonAddResponse.status === "success") {
                            alert("Add Student Success");
                            $('#addStudentModal').modal('hide');
                            selectedStudentID = null;
                            location.reload();
                        } else {
                            console.log(jsonAddResponse.status);
                            alert("The student already exists");
                            selectedStudentID = null;
                        }
                    }
                };
                requestAdd.send();
            });
        });
    </script>

</asp:Content>
