<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Examination.aspx.cs" Inherits="Online_Examination_System.Views.Admin.Examination" %>

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
            var active = document.getElementById('Examination');
            if (active) {
                active.classList.add('active');
            }
            $('#dataTable').DataTable();
            var buttonHtml = '<button type="button" class="btn btn-primary" style="margin-left:15px;height: calc(1.5em + .5rem + 2px);" data-toggle="modal" data-target="#addQuestionModal">New Examination</button>';
            $("#dataTable_filter").append(buttonHtml);
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../../Assets/Lib/css/dataTables.bootstrap4.min.css" rel="stylesheet">

<div style="display: flex; justify-content: center">
    <div class="card shadow mb-4" style="width: 95%">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Examination arrangements</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                    <thead>
                        <tr>
                            <th>Exam ID</th>
                            <th>Exam Name</th>
                            <th>Start Time</th>
                            <th>End Time</th>
                            <th>Operation</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="examTable" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td><%# string.Format("{0:D4}", Eval("examId")) %></td>
                                    <td><%# Eval("examName") %></td>
                                    <td><%# Eval("startTime") %></td>
                                    <td><%# Eval("endTime") %></td>
                                    <td><asp:Button Text="Delete" runat="server" Class="btn btn-danger" OnClick="DeleteExam_Click" CommandArgument='<%# Eval("examId") %>' /></td>
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
                <h3 class="text-center">Examination arrangements</h3>
            </div>
        </div>
        <div style="width: 80%; margin: auto">
            <div class="row m-3">
                <div class="col-md-9"></div>
                <div class="col-md-3 text-center align-self-center">
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addQuestionModal">New Examination</button>
                </div>
            </div>
        </div>


        <div class="exam-table" style="width: 80%; margin: auto">
            <div class="row" style="border: 1px solid #d0d3da;">
                <div class="col-md-1 text-center align-self-center">Exam ID</div>
                <div class="col-md-3 text-center align-self-center">Examination Name</div>
                <div class="col-md-3 text-center align-self-center">Start Time</div>
                <div class="col-md-3 text-center align-self-center">End Time</div>
                <div class="col-md-2 text-center align-self-center">Operation</div>
            </div>
            <asp:Repeater ID="examTable" runat="server">
                <ItemTemplate>
                    <div class="row" style="border-left: 1px solid #d0d3da; border-bottom: 1px solid #d0d3da; border-right: 1px solid #d0d3da">
                        <div class="col-md-1 text-center align-self-center"><%# string.Format("{0:D4}", Eval("examId")) %></div>
                        <div class="col-md-3 text-center align-self-center"><%# Eval("examName") %></div>
                        <div class="col-md-3 text-center align-self-center"><%# Eval("startTime") %></div>
                        <div class="col-md-3 text-center align-self-center"><%# Eval("endTime") %></div>
                        <div class="col-md-2 text-center align-self-center">
                            <asp:Button Text="Delete" runat="server" Class="btn btn-danger" OnClick="DeleteExam_Click" CommandArgument='<%# Eval("examId") %>' />
                        </div>
                    </div>



                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>--%>
    <!-- Modal -->
    <div class="modal fade" id="addQuestionModal" tabindex="-1" role="dialog" aria-labelledby="addQuestionModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addQuestionModalLabel">New Examination</h5>
                </div>
                <div class="modal-body">

                    <div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-3 text-center align-self-center" style="padding: 0px 3px 0px 3px;">
                                    <label class="text-black">Exam Name</label>
                                </div>
                                <div class="col-md-9" style="padding: 0px 3px 0px 3px;">
                                    <input type="text" class="form-control" style="width: 100%;" id="examination-name" placeholder="Geography midterm exam">
                                </div>
                            </div>
                            <label for="searchQuestion" class="text-black">Search Question</label>
                            <div class="row">
                                <div class="col-md-9" style="padding: 0px 3px 0px 3px;">
                                    <input type="text" class="form-control" style="width: 100%;" id="question-keyword" placeholder="Enter keyword or question ID">
                                </div>
                                <div class="col-md-3" style="padding: 0px 3px 0px 3px;">
                                    <button id="searchButton" class="btn btn-primary" style="width: 100%;">Search</button>
                                </div>
                            </div>
                            <div id="question-container" style="padding-top: 10px;"></div>
                            <div class="row">
                                <label for="startTime" class="col-md-3" style="color: black">Start Time:</label>
                                <input type="datetime-local" class="col-md-6" id="startTime" name="startTime">
                            </div>
                            <div class="row">
                                <label for="endTime" class="col-md-3" style="color: black">End Time:</label>
                                <input type="datetime-local" class="col-md-6" id="endTime" name="endTime">
                            </div>
                            <label for="searchMember" class="text-black">Search Student</label>
                            <div class="row">
                                <div class="col-md-9" style="padding: 0px 3px 0px 3px;">
                                    <input type="text" class="form-control" style="width: 100%;" id="member-keyword" placeholder="Enter keyword or student ID">
                                </div>
                                <div class="col-md-3" style="padding: 0px 3px 0px 3px;">
                                    <button id="searchMemberButton" class="btn btn-primary" style="width: 100%;">Search</button>
                                </div>
                            </div>
                            <div id="member-container" style="padding-top: 10px;"></div>
                            <label class="text-black">Exam settings</label>
                            <div class="row">
                                <div class="col-md-6" style="display: flex; align-items: center; padding: 0px 3px 0px 20px;">
                                    <input type="checkbox" id="question-out-of-order" name="answers" value="2">
                                    <label for="question-out-of-order" style="color: black; margin-left: 5px;">Question out of order</label>
                                </div>

                                <div class="col-md-6" style="display: flex; align-items: center; padding: 0px 3px 0px 3px;">
                                    <input type="checkbox" id="option-out-of-order" name="answers" value="2">
                                    <label for="option-out-of-order" style="color: black; margin-left: 5px;">Option out of order</label>
                                </div>
                            </div>

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
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script> 
        var selectedQuestionID = null;
        document.getElementById("searchButton").addEventListener("click", function (event) {
            event.preventDefault();
            var keyword = document.getElementById("question-keyword").value;
            var request = new XMLHttpRequest();
            request.open("GET", "../../Search_Question.aspx?keyword=" + encodeURIComponent(keyword), true);
            request.onload = function () {
                if (request.status === 200) {
                    //var jsonResponse = JSON.parse(request.responseText);
                    //console.log(request.responseText);
                    var jsonResponse = JSON.parse(request.responseText);
                    //var questionInfoArray = jsonResponse.question_info;
                    var questionContainer = document.getElementById("question-container");
                    questionContainer.innerHTML = "";
                    if (jsonResponse.status === "success") {
                        var questionInfoArray = jsonResponse.question_info;
                        var headerRow = document.createElement("div");
                        headerRow.classList.add("row", "header-row");
                        headerRow.innerHTML = '<div class="col-md-3"><b>Question ID</b></div>' +
                            '<div class="col-md-6"><b>Content</b></div>' +
                            '<div class="col-md-3"><b>Type</b></div>';
                        questionContainer.appendChild(headerRow);

                        var typeMapping = {
                            0: "Single Choice",
                            1: "Multichoice",
                            2: "True/False",
                            3: "Short Answer"
                        };

                        questionInfoArray.forEach(function (question) {
                            var questionDiv = document.createElement("div");
                            questionDiv.classList.add("row", "question-row");
                            var questionTypeText = typeMapping[question.type];
                            questionDiv.innerHTML = '<input class="col-md-1" type="checkbox" id="question-' + question.questionId + '" value="' + question.questionId + '">' +
                                '<div class="col-md-2">' + ('00000' + question.questionId).slice(-5) + '</div>' +
                                '<div class="col-md-6">' + question.content + '</div>' +
                                '<div class="col-md-3">' + questionTypeText + '</div>';
                            questionContainer.appendChild(questionDiv);

                        });
                    }
                }
            }
            request.send();

        });
        document.getElementById("searchMemberButton").addEventListener("click", function (event) {
            event.preventDefault();
            var keyword = document.getElementById("member-keyword").value;
            var request = new XMLHttpRequest();

            request.open("GET", "../../Search_Member.aspx?keyword=" + encodeURIComponent(keyword), true);
            request.onload = function () {
                if (request.status === 200) {
                    //console.log(request.responseText);
                    var jsonResponse = JSON.parse(request.responseText);
                    var memberContainer = document.getElementById("member-container");
                    memberContainer.innerHTML = "";
                    if (jsonResponse.status === "success") {
                        var memberInfoArray = jsonResponse.student_info;
                        var headerRow = document.createElement("div");
                        headerRow.classList.add("row", "header-row");
                        headerRow.innerHTML = '<div class="col-md-3"><b>Student ID</b></div>' +
                            '<div class="col-md-6"><b>Username</b></div>' +
                            '<div class="col-md-3"><b>Name</b></div>';
                        memberContainer.appendChild(headerRow);

                        memberInfoArray.forEach(function (member) {
                            var memberDiv = document.createElement("div");
                            memberDiv.classList.add("row", "member-row");
                            memberDiv.innerHTML = '<input class="col-md-1" type="checkbox" id="student-' + member.userid + '" value="' + member.userid + '">' +
                                '<div class="col-md-2">' + ('00000' + member.userid).slice(-5) + '</div>' +
                                '<div class="col-md-6">' + member.username + '</div>' +
                                '<div class="col-md-3">' + member.name + '</div>';
                            memberContainer.appendChild(memberDiv);

                        });
                    }

                }
            };
            request.send();
        });
        document.getElementById("confirmButton").addEventListener("click", function () {

            var questionCheckBoxes = document.querySelectorAll('.question-row input[type="checkbox"]');
            var questionList = [], memberList = [];

            questionCheckBoxes.forEach(function (checkbox) {
                if (checkbox.checked) {
                    questionList.push(checkbox.value);
                }
            });
            var questionListValues = questionList.join('|');
            var memberCheckBoxes = document.querySelectorAll('.member-row input[type="checkbox"]');
            memberCheckBoxes.forEach(function (checkbox) {
                if (checkbox.checked) {
                    memberList.push(checkbox.value);
                }
            });
            var memberListValues = memberList.join('|');
            //var examSetting;
            var questionOrder = "False";
            var optionOrder = "False";
            if (document.getElementById("question-out-of-order").checked) {
                questionOrder = "True";
            }
            if (document.getElementById("option-out-of-order").checked) {
                optionOrder = "True";
            }
            var startTime = document.getElementById("startTime").value;
            var endTime = document.getElementById("endTime").value;
            var examinationName = document.getElementById("examination-name").value;
            console.log(questionListValues);
            console.log(memberListValues);
            console.log(questionOrder + '|' + optionOrder);
            console.log(startTime + '|' + endTime);
            if (questionListValues && memberListValues && startTime && endTime && examinationName) {
                var request = new XMLHttpRequest();
                request.open("GET", "../../AddExamination.aspx?examinationName=" + encodeURIComponent(examinationName) + "&questionList=" + encodeURIComponent(questionListValues) + "&startTime=" + encodeURIComponent(startTime) + "&endTime=" + encodeURIComponent(endTime) + "&memberList=" + memberListValues + "&config=" + questionOrder + '|' + optionOrder, true);
                request.onload = function () {
                    if (request.status === 200 && request.responseText === "success") {
                        alert("Add Exam Success");
                        //$('#addStudentModal').modal('hide');
                        location.reload();
                    }
                }
                request.send();
            } else if (!examinationName) {
                alert("Input the examination name.");
            } else if (!questionListValues) {
                alert("Select at least one exam question.");
            } else if (!memberListValues) {
                alert("Select at least one exam member.");
            }  else {
                alert("Exam start and end times must be set.");
            }




        });
    </script>
</asp:Content>
