<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Student/StudentMaster.Master" AutoEventWireup="true" CodeBehind="ExamProgress.aspx.cs" Inherits="Online_Examination_System.Views.Student.ExamProgress" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../../Assets/Lib/js/jquery.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var myExamination = document.getElementById('ExamProgress');
            if (myExamination) {
                myExamination.classList.add('active');
            }
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .scrollable-div {
            margin-left: 1vw;
            height: 75vh;
            width: 100%;
            overflow-y: auto;
            overflow-x: hidden;
        }

            .scrollable-div label {
                font-size: 20px;
            }

        .fixed-div {
            position: fixed;
            top: 40vh;
            right: 5vw;
            width: 20vw;
            height: 15vh;
        }
    </style>
    <link href="../../Assets/Lib/css/admin-2.min.css" rel="stylesheet">
    <div class="container-fluid">
        <div class="row">
            <div class="col">
                <h3 class="text-center" id="examination-title">Examination in progress</h3>
            </div>
        </div>
        <div style="display: flex; justify-content: center; margin-top: 20px">
            <div class="card shadow mb-4" style="width: 95%; display: none" id="no-exam">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">Please take the exam first on the My Examination page!</h6>
                </div>
                <div class="card-body">
                    <p>There are currently no exams in progress</p>
                </div>
            </div>
        </div>

        <div class="row" style="margin-top: 30px">
            <%--<div class="col-md-1"></div>--%>
            <div class="scrollable-div" id="question-container">
            </div>

            <div class="fixed-div" id="time-left-div">
                <div class="card border-left-primary shadow h-100 py-2">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xxs font-weight-bold text-primary text-uppercase mb-1">
                                    Time Left
                                </div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800" id="countdown">00:00:00</div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-calendar fa-2x text-gray-300"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <button class="btn btn-success btn-icon-split" type="button" style="width: 100%" id="submitButton">
                    <span class="icon text-white-50">
                        <i class="fas fa-check"></i>
                    </span>
                    <span class="text">Finish And Submit</span>
                </button>
            </div>


        </div>

    </div>
    <script lang="scrollable-div">
        function shuffleArray(array) {
            for (let i = array.length - 1; i > 0; i--) {
                const j = Math.floor(Math.random() * (i + 1));
                [array[i], array[j]] = [array[j], array[i]];
            }
        }
        function requestSubmit() {
            const inputs = document.querySelectorAll('#question-container input');
            const questionAnswers = {};

            inputs.forEach(input => {
                //const match = input.id.match(/^question-(\d+)-(\d+)$/);
                const match = input.id.match(/^question-(\d+)-(\w+)$/);
                if (match) {
                    const questionId = match[1];
                    //const optionIndex = parseInt(match[2], 10) + 1;
                    if (/^\d+$/.test(match[2])) {
                        optionIndex = parseInt(match[2], 10) + 1;
                    } else {
                        optionIndex = match[2];
                    }
                    if (!questionAnswers[questionId]) {
                        questionAnswers[questionId] = [];
                    }
                    if (input.type === 'radio' || input.type === 'checkbox') {
                        if (input.checked) {
                            questionAnswers[questionId].push(optionIndex);
                        }
                    } else if (input.type === 'text') {
                        questionAnswers[questionId] = input.value.trim();
                    }
                }
            });

            Object.keys(questionAnswers).forEach(questionId => {
                if (Array.isArray(questionAnswers[questionId])) {
                    questionAnswers[questionId].sort((a, b) => a - b);
                    questionAnswers[questionId] = questionAnswers[questionId].join('|');
                }
            });

            //console.log(questionAnswers);
            var request = new XMLHttpRequest();
            request.open("GET", "../../SubmitExamination.aspx?content=" + encodeURIComponent(JSON.stringify(questionAnswers)) + "&examinationId=" + encodeURIComponent(examinationId) + "&teachersId=" + encodeURIComponent(teachersId) + "&examinationName=" + encodeURIComponent(examinationName), true);
            request.onload = function () {
                if (request.status === 200) {
                    console.log(request.responseText);
                    if (request.responseText === 'success') {
                        alert("success");
                        //Redirect to anther page.
                        window.location.href = 'MyExamination.aspx';
                    }
                }
            };
            request.send();
        }
        var examinationId = "";
        var teachersId = "";
        var examinationName = "";
        document.addEventListener('DOMContentLoaded', function () {
            var request = new XMLHttpRequest();
            request.open("GET", "../../LoadExamination.aspx", true);
            request.onload = function () {
                if (request.status === 200) {
                    var json = JSON.parse(request.responseText);
                    console.log(json);
                    examinationId = json.examinationId;
                    teachersId = json.teachersId;
                    examinationName = json.examinationName;
                    //Time countdown
                    const leftTime = parseFloat(json.secondsLeft);
                    var display = document.getElementById('countdown');
                    startCountdown(leftTime, display);

                    if (examinationId != null) {
                        document.getElementById("no-exam").style.display = "none";
                        document.getElementById("examination-title").innerHTML = json.examinationName;
                        var configArrary = json.config.split("|");
                        var questionArray = json.questionList;
                        if (configArrary[0] === 'True') {
                            shuffleArray(questionArray);
                        }
                        questionArray.forEach(function (questionJson, index) {
                            //console.log(questionJson);
                            var questionContainer = document.getElementById("question-container");
                            var question = document.createElement("div");
                            question.className = 'card shadow mb-4';
                            question.style.width = '70%';
                            //question.innerHTML = '<div style="margin-top: 20px;font-weight: bold"><label class="text-black">' + (index + 1) + '.' + questionJson.content + '</label></div>';
                            question.innerHTML = '<div class="card-header py-3"><h6 class="m-0 font-weight-bold text-primary">' + (index + 1) + '.' + questionJson.content + '</h6></div>';

                            let htmlContent = '<div class="card-body">';
                            if (questionJson.imageLink !== '') {
                                htmlContent += '<img src="../../ImageUploads/' + questionJson.imageLink + '" style="width:25vw" />';
                            }
                            if (questionJson.type === 0) {
                                var options = questionJson.questionOption.split("|");
                                var optionArray = options.map((option, index) => ({
                                    text: option,
                                    originalIndex: index
                                }));
                                if (configArrary[1] === 'True') {
                                    shuffleArray(optionArray);
                                }
                                optionArray.forEach(function (option, index) {
                                    htmlContent += '<div><input id="question-' + questionJson.questionId + '-' + option.originalIndex +
                                        '" type="radio" name="' + questionJson.questionId +
                                        '"><label class="text-black" for="question-' + questionJson.questionId + '-' + option.originalIndex + '">' + option.text + '</label></div>';
                                });
                                htmlContent += '</div>';
                                question.innerHTML += htmlContent;
                            }
                            else if (questionJson.type === 1) {
                                var options = questionJson.questionOption.split("|");
                                var optionArray = options.map((option, index) => ({
                                    text: option,
                                    originalIndex: index
                                }));
                                if (configArrary[1] === 'True') {
                                    shuffleArray(optionArray);
                                }
                                optionArray.forEach(function (option) {
                                    htmlContent += '<div><input id="question-' + questionJson.questionId + '-' + option.originalIndex + '" type="checkbox" class="form-check-input" style="margin-left:0px" name="question-' + questionJson.questionId + '" value="' + option.originalIndex + '">' +
                                        '<label class="text-black" style="margin-left:25px" for="question-' + questionJson.questionId + '-' + option.originalIndex + '">' + option.text + '</label></div>';
                                });
                                htmlContent += '</div>';
                                question.innerHTML += htmlContent;
                            }
                            else if (questionJson.type === 2) {
                                htmlContent += '<div><input id="question-' + questionJson.questionId + '-True" type="radio" name="' + questionJson.questionId +
                                    '"><label class="text-black" for="question-' + questionJson.questionId + '-True">True</label></div><div><input id="question-' + questionJson.questionId + '-False" type="radio" name="' + questionJson.questionId +
                                    '"><label class="text-black" for="question-' + questionJson.questionId + '-False">False</label></div>';
                                htmlContent += '</div>';
                                question.innerHTML += htmlContent;
                            } else if (questionJson.type === 3) {
                                htmlContent += '<div><label class="text-black">Answer</label><input id="question-' + questionJson.questionId + '-' + index + '" class="form-control" type="text" name="' + questionJson.questionId +
                                    '"></div>';
                                htmlContent += '</div>';
                                question.innerHTML += htmlContent;
                            }
                            questionContainer.appendChild(question);
                        });
                    } else {
                        //console.log("no exam");
                        document.getElementById("no-exam").style.display = "block";
                        document.getElementById("time-left-div").style.display = "none";
                    }

                }
            };
            request.send();

            document.getElementById("submitButton").addEventListener("click", function () {
                requestSubmit();
            });

            function startCountdown(duration, display) {
                let timer = duration, days, hours, minutes, seconds;
                const interval = setInterval(() => {
                    days = parseInt(timer / (60 * 60 * 24), 10);
                    hours = parseInt((timer / (60 * 60)) % 24, 10);
                    minutes = parseInt((timer / 60) % 60, 10);
                    seconds = parseInt(timer % 60, 10);

                    hours = hours < 10 ? "0" + hours : hours;
                    minutes = minutes < 10 ? "0" + minutes : minutes;
                    seconds = seconds < 10 ? "0" + seconds : seconds;

                    if (days > 0) {
                        display.textContent = days + ":" + hours + ":" + minutes + ":" + seconds;
                    } else {
                        display.textContent = hours + ":" + minutes + ":" + seconds;
                    }

                    if (--timer < 0) {
                        clearInterval(interval);
                        display.textContent = "Time end!";
                        requestSubmit();
                    }
                }, 1000);
            }


        });
    </script>
</asp:Content>

