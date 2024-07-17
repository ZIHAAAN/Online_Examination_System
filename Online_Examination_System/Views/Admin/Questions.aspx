<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Questions.aspx.cs" Inherits="Online_Examination_System.Views.Admin.Questions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../../Assets/Lib/js/jquery.min.js"></script>
    <script src="../../Assets/Lib/js/bootstrap.bundle.min.js"></script>
    <script src="../../Assets/Lib/js/jquery.easing.min.js"></script>
    <script src="../../Assets/Lib/js/admin-2.min.js"></script>
    <script src="../../Assets/Lib/js/jquery.dataTables.min.js"></script>
    <script src="../../Assets/Lib/js/dataTables.bootstrap4.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var active = document.getElementById('QuestionManagement');
            if (active) {
                active.classList.add('active');
            }
            $('#dataTable').DataTable();
            var buttonHtml = '<button type="button" class="btn btn-primary" style="margin-left:15px;height: calc(1.5em + .5rem + 2px);" data-toggle="modal" data-target="#addQuestionModal">Add Question</button>';
            $("#dataTable_filter").append(buttonHtml);
            $('.dataTables_empty').text('No questions');

        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        #multiple-answer {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
            gap: 10px;
            overflow: auto;
        }

        @media (max-width: 600px) {
            #multiple-answer {
                grid-template-columns: repeat(auto-fill, minmax(80px, 1fr));
            }
        }

        #multiple-answer div {
            flex: 1;
            min-width: 120px;
        }

        .student-table .row:nth-child(odd) {
            background-color: #f0f8ff; /* 浅蓝色背景 */
        }

        .student-table .row:nth-child(even) {
            background-color: #f8f8f8; /* 白灰色背景 */
        }

        .selected-row {
            background-color: #0d6efd; /* 浅蓝色背景 */
            color: #ffffff; /* 文字颜色 */
        }
    </style>
    <link href="../../Assets/Lib/css/dataTables.bootstrap4.min.css" rel="stylesheet">

    <div style="display: flex; justify-content: center">
        <div class="card shadow mb-4" style="width: 95%">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">Question Management</h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>Question ID</th>
                                <th>Question Content</th>
                                <th>Answer</th>
                                <th>Correct Sum</th>
                                <th>Submission Sum</th>
                                <th>Accuracy</th>
                                <th>Operation</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="questionTable" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td><%# string.Format("{0:D5}", Eval("questionId")) %></td>
                                        <td><%# Eval("content") %></td>
                                        <td><%# Eval("answer") %></td>
                                        <td><%# Eval("correct") %></td>
                                        <td><%# Eval("submissionSum") %></td>
                                        <td><%# Eval("accuracy") %></td>
                                        <td>
                                            <button type="button" class="btn btn-primary view-btn" data-toggle="modal" onclick="viewClick(this)" data-target="#addQuestionModal" data-questionid='<%# Eval("questionId") %>' data-imagelink='<%# Eval("imageLink") %>' data-type='<%# Eval("type") %>' data-questionoption='<%# Eval("questionOption") %>' data-content='<%# Eval("content") %>' data-answer='<%# Eval("answer") %>'>View</button>
                                            <asp:Button Text="Delete" runat="server" Class="btn btn-danger" OnClick="DeleteQuestion_Click" CommandArgument='<%# Eval("questionId") %>' />
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
                <h3 class="text-center">Questions mangement</h3>
            </div>
        </div>
        <div style="width: 80%; margin: auto">
            <div class="row m-3">
                <div class="col-md-9"></div>
                <div class="col-md-3 text-center align-self-center">
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addQuestionModal">Add Question</button>
                </div>
            </div>
        </div>

        <div class="student-table" style="width: 80%; margin: auto">
            <div class="row" style="border: 1px solid #d0d3da;">
                <div class="col-md-3 text-center align-self-center">Question ID</div>
                <div class="col-md-3 text-center align-self-center">Question Content</div>
                <div class="col-md-3 text-center align-self-center">Answer</div>
                <div class="col-md-3 text-center align-self-center">
                </div>
            </div>
            <asp:Repeater ID="questionTable" runat="server">
                <ItemTemplate>
                    <div class="row" style="border-left: 1px solid #d0d3da; border-bottom: 1px solid #d0d3da; border-right: 1px solid #d0d3da">
                        <div class="col-md-3 text-center align-self-center"><%# string.Format("{0:D5}", Eval("questionId")) %></div>

                        <div class="col-md-3 text-center align-self-center"><%# Eval("content") %></div>
                        <div class="col-md-3 text-center align-self-center"><%# Eval("answer") %></div>
                        <div class="col-md-3 text-center align-self-center">
                            <button type="button" class="btn btn-primary view-btn" data-toggle="modal" onclick="viewClick(this)" data-target="#addQuestionModal" data-questionid='<%# Eval("questionId") %>' data-imagelink='<%# Eval("imageLink") %>' data-type='<%# Eval("type") %>' data-questionoption='<%# Eval("questionOption") %>' data-content='<%# Eval("content") %>' data-answer='<%# Eval("answer") %>'>View</button>
                            <asp:Button Text="Delete" runat="server" Class="btn btn-danger" OnClick="DeleteQuestion_Click" CommandArgument='<%# Eval("questionId") %>' />
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
                    <h5 class="modal-title" id="addQuestionModalLabel">Add Question</h5>
                </div>
                <div class="modal-body">

                    <div>
                        <div class="form-group">

                            <div class="row">
                                <div class="col-md-2 text-center align-self-center" style="padding: 0px 3px 0px 3px;">
                                    <label class="text-black">Content</label>
                                </div>
                                <div class="col-md-10" style="padding: 0px 3px 0px 3px;">
                                    <input type="text" class="form-control" style="width: 100%;" id="QuestionName" placeholder="Enter question content">
                                </div>

                                <%--<div class="col-md-3" style="padding: 0px 3px 0px 3px;">
                                    <button id="searchButton" class="btn btn-primary" style="width: 100%;">Search</button>
                                </div>--%>
                            </div>
                            <div class="row" style="padding-top: 5px">
                                <div class="col-md-2 text-center align-self-center" style="padding: 0px 3px 0px 3px;">
                                    <label for="" class="text-black">Type</label>
                                </div>
                                <div class="col-md-6" style="padding: 0px 3px 0px 3px;">
                                    <select id="questionType" class="form-control">
                                        <option value="0">Single Choice Question</option>
                                        <option value="1">Multiple Choice Question</option>
                                        <option value="2">True or False Question</option>
                                        <option value="3">Objective Question</option>
                                    </select>
                                </div>
                                <div class="col-md-4 text-center align-self-center custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" id="includeImage" onchange="toggleUploadButton()">
                                    <label class="custom-control-label" for="includeImage">Including Image</label>
                                </div>
                                <%--<div class="col-md-3 text-center align-self-center" style="padding: 0px 3px 0px 3px;">
                                    <label class="text-black" for="includeImage">Including Image</label>
                                </div>
                                <div class="col-md-1 text-center align-self-center" style="padding: 0px 3px 0px 3px;">
                                    <input class="custom-control-input" style="" type="checkbox" id="includeImage" onchange="toggleUploadButton()">
                                </div>--%>
                            </div>
                            <div class="row" id="uploadImageButton" style="display: none; padding-top: 5px">
                                <label for="fileInput" class="btn btn-primary" style="width: 100%">Upload</label>
                                <input type="file" id="fileInput" class="btn btn-primary" style="display: none">
                            </div>
                            <div class="row" id="uploadImageShow" style="padding-top: 5px; display: none"></div>

                            <div id="questionOption">
                            </div>

                            <div class="row" id="addOption-div" style="padding-top: 5px">
                                <button id="addOption" type="button" class="btn btn-primary" style="width: 100%">Add option</button>
                            </div>

                            <div class="row" style="padding-top: 5px">
                                <div class="col-md-2 text-center align-self-center" style="padding: 0px 3px 0px 3px;">
                                    <label for="" class="text-black">Answer</label>
                                </div>
                                <div class="col-md-10" style="padding: 0px 3px 0px 3px;">
                                    <select id="answer-select" class="form-control"></select>
                                    <input type="text" class="form-control" style="width: 100%; display: none" id="answer-input" placeholder="Optional">
                                    <div id="multiple-answer" style="display: none"></div>
                                </div>
                            </div>



                            <div id="Question-container" style="padding-top: 10px;"></div>
                        </div>

                    </div>
                </div>
                <div class="modal-footer">
                    <div id="editDiv" style="display: none">
                        <button type="button" class="btn btn-link">Edit</button>
                    </div>
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
        addAnOption(); addAnOption(); addAnOption();
        var imageLink = '';
        var questionId = '';
        function toggleUploadButton() {
            var checkbox = document.getElementById("includeImage");
            var uploadButton = document.getElementById("uploadImageButton");
            var imageContainer = document.getElementById("uploadImageShow");
            if (checkbox.checked) {
                uploadButton.style.display = "block";
                if (imageLink !== '') {
                    imageContainer.style.display = "block";
                }
            } else {
                uploadButton.style.display = "none";
                imageContainer.style.display = "none";
            }
        }

        document.getElementById('fileInput').addEventListener('change', function () {
            var fileInput = document.getElementById('fileInput');
            var file = fileInput.files[0];
            var formData = new FormData();
            formData.append('file', file);
            var request = new XMLHttpRequest();
            request.open('POST', '../../UploadFile.aspx', true);
            request.onload = function () {
                if (request.status === 200) {

                    //alert(request.responseText);

                    var imageContainer = document.getElementById("uploadImageShow");
                    imageContainer.innerHTML = '<img style="width: 100%" src="../../ImageUploads/' + request.responseText + '" />';
                    imageLink = request.responseText;
                    imageContainer.style.display = "block";
                    //加一行
                } else {
                    alert('File upload failed. Error: ' + request.statusText);
                }
            };
            request.onerror = function () {
                alert('Request failed.');
            };
            request.send(formData);
        });
        document.getElementById('confirmButton').addEventListener('click', function () {
            var includeImage = document.getElementById("includeImage");

            var contentValue = document.getElementById("QuestionName").value;
            var typeValue = document.getElementById("questionType").value;
            var answerValue = '';
            var inputs = document.querySelectorAll('#questionOption input[type="text"]');


            if (typeValue === "0") {         //Single Choice Question
                answerValue = document.getElementById("answer-select").value;
            } else if (typeValue === "1") {     //Multiple Choice Question
                var selectedValues = [];
                var checkboxes = document.querySelectorAll('#multiple-answer input[type="checkbox"]');
                checkboxes.forEach(function (checkbox) {
                    if (checkbox.checked) {
                        selectedValues.push(checkbox.value);
                    }
                });
                answerValue = selectedValues.join('|');
            } else if (typeValue === "2") {     //True And False Question
                answerValue = document.getElementById("answer-select").value;
            } else if (typeValue === "3") {     //Objective
                answerValue = document.getElementById("answer-input").value;
            }
            var allQuestionOption = '';
            inputs.forEach((input, index) => {
                allQuestionOption += input.value;
                if (index < inputs.length - 1) {
                    allQuestionOption += '|';
                }
            });
            if (!includeImage.checked) {
                imageLink = '';
            }
            var request = new XMLHttpRequest();
            var action = "add";

            if (document.getElementById("addQuestionModalLabel").innerHTML !== "Add Question") {
                action = "updata";
            }
            request.open("GET", "../../AddQuestion.aspx?content=" + encodeURIComponent(contentValue) + "&type=" + encodeURIComponent(typeValue) + "&imageLink=" + encodeURIComponent(imageLink) + "&questionOption=" + encodeURIComponent(allQuestionOption) + "&answer=" + encodeURIComponent(answerValue) + "&questionId=" + encodeURIComponent(questionId) + "&action=" + encodeURIComponent(action), true);
            request.onload = function () {
                if (request.status === 200) {
                    if (request.responseText === "success") {
                        alert("success");
                        location.reload();
                    } else {
                        alert("fail");
                    }
                }
            }
            request.send();
        });
        document.getElementById('editDiv').addEventListener('click', function () {
            this.style.display = "none";

            var includeImage = document.getElementById("includeImage");
            var questionContent = document.getElementById("QuestionName");
            var questionType = document.getElementById("questionType");
            var answerInput = document.getElementById("answer-input");
            var answerSelect = document.getElementById("answer-select");
            var addOption = document.getElementById("addOption");
            document.getElementById('confirmButton').innerHTML = "Confirm";

            questionContent.disabled = false;
            questionType.disabled = false;
            answerSelect.disabled = false;
            includeImage.disabled = false;
            answerInput.disabled = false;
            addOption.disabled = false;
            confirmButton.disabled = false;

            var inputoptions = document.querySelectorAll('#questionOption input[type="text"]');
            var deleteButtons = document.querySelectorAll('#questionOption button[type="button"]');
            var multipleAnswers = document.querySelectorAll('#multiple-answer input[type="checkbox"]');
            inputoptions.forEach(function (input) {
                input.disabled = false;
            });
            deleteButtons.forEach(function (button) {
                button.disabled = false;
            });
            multipleAnswers.forEach(function (check) {
                check.disabled = false;
            });
        });
        document.getElementById('questionType').addEventListener('change', function () {
            var questionOptionDiv = document.getElementById('questionOption');
            var addOptionDiv = document.getElementById('addOption-div');
            var answerSelect = document.getElementById("answer-select");
            var answerInput = document.getElementById("answer-input");
            var multipleAnswer = document.getElementById("multiple-answer");
            answerSelect.style.display = "block";
            answerInput.style.display = "none";
            multipleAnswer.style.display = "none";

            questionOptionDiv.innerHTML = "";
            answerSelect.innerHTML = "";
            multipleAnswer.innerHTML = "";
            var questionType = this.value;
            if (questionType === "0") {         //Single Choice Question
                addAnOption(); addAnOption(); addAnOption();
            } else if (questionType === "1") {  //Multiple Choice Question
                addAnOption(); addAnOption();
                multipleAnswer.style.display = "flex";
                answerSelect.style.display = "none";
            } else if (questionType === "2") {   //True And False Question
                addOptionDiv.style.display = "none";
                answerSelect.innerHTML = `<option value="True">True</option><option value="False">False</option>`;
            } else if (questionType === "3") {   //Objective
                addOptionDiv.style.display = "none";
                answerSelect.style.display = "none";
                answerInput.style.display = "block";

            }

        });

        document.getElementById('addOption').addEventListener('click', function () {
            addAnOption();
        });

        function addAnOption(optionValue = "") {
            var questionOptionDiv = document.getElementById('questionOption');
            var optionIndex = questionOptionDiv.getElementsByClassName('row').length + 1;

            var newOptionDiv = document.createElement('div');
            newOptionDiv.classList.add('row', 'option-row');
            newOptionDiv.style.paddingTop = '5px';
            var disabled = "";
            if (optionValue !== "") {
                disabled = "disabled";
            }
            newOptionDiv.innerHTML = `
    <div class="col-md-2 text-center align-self-center" style="padding: 0px 3px 0px 3px;">
        <label for="option-${optionIndex}" class="text-black">Option ${optionIndex}</label>
    </div>
    <div class="col-md-8" style="padding: 0px 3px 0px 3px;">
        <input type="text" class="form-control" style="width: 100%;" id="option-${optionIndex}" placeholder="Enter option content" value="${optionValue}" ${disabled}>
    </div>
    <div class="col-md-1" style="padding: 0px 3px 0px 3px;">
        <button type="button" class="btn btn-danger delete-option" ${disabled}>Delete</button>
    </div>
`;
            questionOptionDiv.appendChild(newOptionDiv);
            var typeValue = document.getElementById("questionType").value;
            if (typeValue === "0") {
                var answerSelect = document.getElementById("answer-select");
                answerSelect.innerHTML = answerSelect.innerHTML + `<option value="${optionIndex}">Option ${optionIndex}</option>`;


                newOptionDiv.querySelector('.delete-option').addEventListener('click', function () {
                    var optionToRemove = answerSelect.querySelector(`option[value="${optionIndex}"]`);
                    if (optionToRemove) {
                        answerSelect.removeChild(optionToRemove);
                    }
                    this.closest('.row').remove();
                    updateOptionIndexes();
                });
            } else if (typeValue === "1") {
                var multipleAnswerDiv = document.getElementById("multiple-answer");
                var checkbox = document.createElement('input');
                checkbox.type = "checkbox";
                checkbox.id = `answer-${optionIndex}`;
                checkbox.name = "answers";
                checkbox.value = optionIndex;
                if (optionValue !== "") {
                    checkbox.disabled = true;
                }

                var label = document.createElement('label');
                label.htmlFor = `answer-${optionIndex}`;
                label.textContent = ` Option ${optionIndex}`;
                label.style.color = "black";

                var containerDiv = document.createElement('div');
                containerDiv.appendChild(checkbox);
                containerDiv.appendChild(label);
                multipleAnswerDiv.appendChild(containerDiv);

                newOptionDiv.querySelector('.delete-option').addEventListener('click', function () {
                    containerDiv.remove();
                    this.closest('.row').remove();
                    updateOptionIndexes();
                });
            }




        }

        function updateOptionIndexes() {
            var allOptions = document.querySelectorAll('#questionOption .option-row');
            var answerSelect = document.getElementById("answer-select");
            var multipleAnswerDiv = document.getElementById("multiple-answer");
            var typeValue = document.getElementById("questionType").value;

            answerSelect.innerHTML = '';
            if (typeValue === "1") {
                multipleAnswerDiv.innerHTML = '';
            }

            allOptions.forEach((optionDiv, index) => {
                var newIndex = index + 1;

                var label = optionDiv.querySelector('label');
                var input = optionDiv.querySelector('input[type="text"]');
                label.innerHTML = `Option ${newIndex}`;
                label.setAttribute('for', `option-${newIndex}`);
                input.id = `option-${newIndex}`;
                input.setAttribute('placeholder', 'Enter question content');

                if (typeValue === "0") {
                    var newOption = document.createElement('option');
                    newOption.value = newIndex;
                    newOption.textContent = `Option ${newIndex}`;
                    answerSelect.appendChild(newOption);
                }
                else if (typeValue === "1") {
                    var checkbox = document.createElement('input');
                    checkbox.type = "checkbox";
                    checkbox.id = `answer-${newIndex}`;
                    checkbox.name = "answers";
                    checkbox.value = newIndex;

                    var checkboxLabel = document.createElement('label');
                    checkboxLabel.htmlFor = `answer-${newIndex}`;
                    checkboxLabel.textContent = ` Option ${newIndex}`;
                    checkboxLabel.style.color = "black";

                    var containerDiv = document.createElement('div');
                    containerDiv.appendChild(checkbox);
                    containerDiv.appendChild(checkboxLabel);

                    multipleAnswerDiv.appendChild(containerDiv);
                }

            });
        }
        function viewClick(element) {
            var modalTitle = document.getElementById("addQuestionModalLabel");
            var questionContent = document.getElementById("QuestionName");
            var questionType = document.getElementById("questionType");
            var answerSelect = document.getElementById("answer-select");
            var addOptionDiv = document.getElementById('addOption-div');
            var includeImage = document.getElementById("includeImage");
            var answerInput = document.getElementById("answer-input");
            var multipleAnswer = document.getElementById("multiple-answer");
            var uploadButton = document.getElementById("uploadImageButton");
            var questionOptionDiv = document.getElementById('questionOption');
            var imageContainer = document.getElementById("uploadImageShow");
            var addOption = document.getElementById("addOption");
            var confirmButton = document.getElementById('confirmButton');
            var editDiv = document.getElementById('editDiv');

            includeImage.checked = false;


            questionContent.disabled = true;
            questionType.disabled = true;
            answerSelect.disabled = true;
            includeImage.disabled = true;
            answerInput.disabled = true;
            addOption.disabled = true;
            confirmButton.disabled = true;

            confirmButton.innerHTML = "Change";
            questionOptionDiv.innerHTML = "";
            uploadButton.style.display = "none";
            imageContainer.style.display = "none";
            answerSelect.style.display = "none";
            answerInput.style.display = "none";
            multipleAnswer.style.display = "none";
            addOptionDiv.style.display = "block";
            editDiv.style.display = "block";

            questionType.value = element.getAttribute('data-type');
            answerSelect.innerHTML = "";
            multipleAnswer.innerHTML = "";

            if (element.getAttribute('data-imageLink') !== "") {

                imageContainer.innerHTML = '<img style="width: 100%" src="../../ImageUploads/' + element.getAttribute('data-imageLink') + '" />';
                imageContainer.style.display = "block";
                includeImage.checked = true;
            }

            modalTitle.innerHTML = "Question ID: " + element.getAttribute('data-questionid');
            questionId = element.getAttribute('data-questionid');
            questionContent.value = element.getAttribute('data-content');

            console.log("data-answer is:", element.getAttribute('data-answer'));

            if (questionType.value === "0") {   //Single Choice Question
                var answerSelect = document.getElementById("answer-select");
                var optionArray = element.getAttribute('data-questionoption').split("|");
                for (var i = 0; i < optionArray.length; i++) {
                    addAnOption(optionArray[i]);
                    //document.getElementById("option-" + (i + 1)).disabled = true;

                }
                answerSelect.value = element.getAttribute('data-answer');
                answerSelect.style.display = "block";
            } else if (questionType.value === "1") {    //Multiple Choice Question
                var answerSelect = document.getElementById("answer-select");
                var optionArray = element.getAttribute('data-questionoption').split("|");
                for (var i = 0; i < optionArray.length; i++) {
                    addAnOption(optionArray[i]);
                    //document.getElementById("option-" + (i + 1)).disabled = true;
                }
                var answerArray = element.getAttribute('data-answer').split("|");
                for (var i = 0; i < answerArray.length; i++) {
                    document.getElementById("answer-" + answerArray[i]).checked = true;
                }
                multipleAnswer.style.display = "flex";


            } else if (questionType.value === "2") {   //True And False Question
                addOptionDiv.style.display = "none";
                answerSelect.innerHTML = `<option value="True">True</option><option value="False">False</option>`;
                answerSelect.value = element.getAttribute('data-answer');
                answerSelect.style.display = "block";
            } else if (questionType.value === "3") {   //Objective
                answerInput.value = element.getAttribute('data-answer');
                addOptionDiv.style.display = "none";
                answerSelect.style.display = "none";
                answerInput.style.display = "block";

            }
            //console.log("Button clicked with question ID:", element.getAttribute('data-questionid'));
        }
        $("#addQuestionModal").on('hidden.bs.modal', function () {
            var modalTitle = document.getElementById("addQuestionModalLabel");

            //console.log();
            if (modalTitle.innerHTML !== "Add Question") {
                modalTitle.innerHTML = "Add Question";
                var includeImage = document.getElementById("includeImage");
                var questionContent = document.getElementById("QuestionName");
                var questionType = document.getElementById("questionType");
                var questionOptionDiv = document.getElementById('questionOption');
                var answerInput = document.getElementById("answer-input");
                var answerSelect = document.getElementById("answer-select");
                var multipleAnswer = document.getElementById("multiple-answer");
                var imageContainer = document.getElementById("uploadImageShow");
                var addOption = document.getElementById("addOption");
                var editDiv = document.getElementById('editDiv');
                document.getElementById('confirmButton').innerHTML = "Confirm";

                multipleAnswer.style.display = "none";
                includeImage.checked = false;
                questionContent.value = "";
                questionType.value = "0";
                answerInput.style.display = "none";
                editDiv.style.display = "none";
                answerSelect.style.display = "block";
                answerSelect.innerHTML = ""; questionOptionDiv.innerHTML = ""; addAnOption(); addAnOption(); addAnOption();
                imageContainer.style.display = "none"; imageLink = '';

                questionContent.disabled = false;
                questionType.disabled = false;
                answerSelect.disabled = false;
                includeImage.disabled = false;
                answerInput.disabled = false;
                addOption.disabled = false;
                confirmButton.disabled = false;


            }
        });
    </script>
</asp:Content>
