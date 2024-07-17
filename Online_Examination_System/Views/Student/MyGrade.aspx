<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Student/StudentMaster.Master" AutoEventWireup="true" CodeBehind="MyGrade.aspx.cs" Inherits="Online_Examination_System.Views.Student.MyGrade" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../../Assets/Lib/js/jquery.min.js"></script>
    <script src="../../Assets/Lib/js/bootstrap.bundle.min.js"></script>
    <script src="../../Assets/Lib/js/jquery.easing.min.js"></script>
    <script src="../../Assets/Lib/js/admin-2.min.js"></script>
    <script src="../../Assets/Lib/js/jquery.dataTables.min.js"></script>
    <script src="../../Assets/Lib/js/dataTables.bootstrap4.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var active = document.getElementById('MyGrade');
            if (active) {
                active.classList.add('active');
            }
            $('#dataTable').DataTable();
            //var buttonHtml = '<button type="button" class="btn btn-danger" style="margin-left:15px;height: calc(1.5em + .5rem + 2px);" id="auto-mark" >Auto Mark</button>';
            //$("#dataTable_filter").append(buttonHtml);
            //$('.dataTables_empty').text('No papers to mark');

        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../../Assets/Lib/css/dataTables.bootstrap4.min.css" rel="stylesheet">

    <div style="display: flex; justify-content: center">
        <div class="card shadow mb-4" style="width: 95%">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">My Grade</h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>Exam ID</th>
                                <th>Exam Name</th>
                                <th>Grades</th>
                                <th>Operation</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="markTable" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td><%# string.Format("{0:D4}", Eval("examId")) %></td>
                                        <td><%# Eval("examName") %></td>
                                        <td><%# Eval("grades").ToString() == "-1" ? "Not marked" : Eval("grades").ToString() == "-2" ? "Not marked" : Eval("grades") %></td>
                                        <td></td>
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
