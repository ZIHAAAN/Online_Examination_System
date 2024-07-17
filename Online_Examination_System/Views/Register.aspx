<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Online_Examination_System.Views.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register</title>

    <%--    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Login</title>
    <link rel="stylesheet" href="../Assets/Lib/css/bootstrap.min.css" />--%>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Custom fonts for this template-->
    <link href="../Assets/Lib/css/all.min.css" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet" />

    <!-- Custom styles for this template-->
    <link href="../Assets/Lib/css/admin-2.min.css" rel="stylesheet" />
</head>
<body class="bg-gradient-primary">
    <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center">

            <div class="col-xl-10 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">Create an Account!</h1>
                                    </div>
                                    <form id="form1" runat="server" class="user">
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user" autocomplete="off" runat="server" id="Username" aria-describedby="emailHelp" placeholder="Username" />
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user" autocomplete="off" runat="server" id="Password" placeholder="Password" />
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user" autocomplete="off" runat="server" id="CPassword" placeholder="Confirm Password" />
                                        </div>
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user" autocomplete="off" runat="server" id="Name" aria-describedby="emailHelp" placeholder="Real Name" />
                                        </div>
                                        <div class="form-group">
                                            <label for="account">Account Type:</label>
                                            <select id="AccountType" name="account" runat="server" class="form-control" style="border-radius: 10rem">
                                                <option value="Student">Student</option>
                                                <option value="Teacher">Teacher</option>
                                            </select>
                                        </div>
                                        <asp:Button Text="Register" runat="server" Class="btn btn-primary btn-user btn-block" ID="RegisterBtn" OnClick="RegisterBtn_Click"/>

                                        <div class="row">
                                            <asp:Label ID="ErrMsg" runat="server" ForeColor="Red" />
                                        </div>
                                        <div class="text-center">
                                            <a class="small" href="Login.aspx">Already have an account? Login!</a>
                                        </div>
                                    </form>



                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>
    <!-- Bootstrap core JavaScript-->
    <script src="../Assets/Lib/js/jquery.min.js"></script>
    <script src="../Assets/Lib/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="../Assets/Lib/js/jquery.easing.min.js"></script>
    <!-- Custom scripts for all pages-->
    <script src="../Assets/Lib/js/admin-2.min.js"></script>
    <%--<form id="form1" runat="server">
        <div>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-4">
                    </div>
                    <div class="col-md-4">
                        <div class="row">
                            <div class="col-md-6 d-flex align-items-center justify-content-end h3">
                                Register
                            </div>
                        </div>
                        <div class="mt-2">
                            <div class="row">
                                <div class="col-md-3 d-flex align-items-center">
                                    <label for="" class="form-label">Username</label>
                                </div>
                                <div class="col-md-9 d-flex align-items-center">
                                    <input type="text" placeholder="" autocomplete="off" class="form-control" runat="server" id="Username" />
                                </div>
                            </div>

                        </div>
                        <div class="mt-2">
                            <div class="row">
                                <div class="col-md-3 d-flex align-items-center">
                                    <label for="" class="form-label">Password</label>
                                </div>
                                <div class="col-md-9 d-flex align-items-center">
                                    <input type="text" placeholder="" autocomplete="off" class="form-control" runat="server" id="Password" />
                                </div>
                            </div>

                        </div>
                        <div class="mt-2">
                            <div class="row">
                                <div class="col-md-3 d-flex align-items-center">
                                    <label for="" class="form-label">Confirm Password</label>
                                </div>
                                <div class="col-md-9 d-flex align-items-center">
                                    <input type="text" placeholder="" autocomplete="off" class="form-control" runat="server" id="CPassword" />
                                </div>
                            </div>

                        </div>
                        <div class="mt-2">
                            <div class="row">
                                <div class="col-md-3">
                                </div>
                                <div class="col-md-2">
                                    <label for="" class="form-label">Student</label>
                                </div>
                                <div class="col-md-1">
                                    <asp:RadioButton ID="RadioButton3" GroupName="AccountType" runat="server" OnCheckedChanged="RadioButton3_CheckedChanged" />
                                </div>
                                <div class="col-md-2">
                                    <label for="" class="form-label">Teacher</label>
                                </div>
                                <div class="col-md-1">
                                    <asp:RadioButton ID="RadioButton4" GroupName="AccountType" runat="server" OnCheckedChanged="RadioButton4_CheckedChanged" />
                                </div>
                                <div class="col-md-3">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md mt-2 d-grid">
                                <asp:Button Text="Register" runat="server" Class="btn" Style="background-color: lightskyblue;" ID="RegisterBtn" OnClick="RegisterBtn_Click" />
                            </div>
                        </div>
                        <div class="row">
                            <asp:Label ID="ErrMsg" runat="server" ForeColor="Red"/>
                        </div>

                        <div class="col-md-4">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>--%>
</body>
</html>
