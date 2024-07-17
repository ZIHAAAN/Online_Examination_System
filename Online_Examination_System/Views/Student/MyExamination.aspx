<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Student/StudentMaster.Master" AutoEventWireup="true" CodeBehind="MyExamination.aspx.cs" Inherits="Online_Examination_System.Views.Student.MyExamination" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../../Assets/Lib/js/jquery.min.js"></script>
    <script src="../../Assets/Lib/js/bootstrap.bundle.min.js"></script>
    <script src="../../Assets/Lib/js/jquery.easing.min.js"></script>
    <script src="../../Assets/Lib/js/admin-2.min.js"></script>
    <script src="../../Assets/Lib/js/jquery.dataTables.min.js"></script>
    <script src="../../Assets/Lib/js/dataTables.bootstrap4.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var myExamination = document.getElementById('MyExamination');
            if (myExamination) {
                myExamination.classList.add('active');
            }
            $('#dataTable').DataTable();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../../Assets/Lib/css/dataTables.bootstrap4.min.css" rel="stylesheet">

    <div style="display: flex; justify-content: center">
        <div class="card shadow mb-4" style="width: 95%">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">My Examination</h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>Exam ID</th>
                                <th>Examination Name</th>
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
                                        <td>
                                            <asp:Button
                                                Text='<%# Convert.ToBoolean(Eval("submitted")) ? "Submitted" : (IsExamTimeValid(Eval("startTime"), Eval("endTime")) ? "Start" : "Unavailable") %>'
                                                CssClass='<%# IsExamTimeValid(Eval("startTime"), Eval("endTime")) && !Convert.ToBoolean(Eval("submitted")) ? "btn btn-primary" : "btn btn-secondary" %>'
                                                runat="server"
                                                OnClick="StartExam_Click"
                                                CommandArgument='<%# Eval("examId") %>'
                                                Enabled='<%# !Convert.ToBoolean(Eval("submitted")) && IsExamTimeValid(Eval("startTime"), Eval("endTime")) %>' />
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
</asp:Content>
