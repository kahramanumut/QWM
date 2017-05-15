<%-- 
    Document   : search
    Created on : Aug 13, 2015, 1:25:32 PM
    Author     : umutk
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script type="text/javascript"
                src="http://code.jquery.com/jquery-1.10.1.min.js">
        </script>
        <style type="text/css">
            body {
                background-image:
                    url('http://subtlepatterns.com/patterns/cream_pixels.png') ;
                background-repeat: repeat;             
            }
            .textarea {
                border: 1px solid #765942;
                border-radius:5px;
                height: 22px;
                width: 150px;
            }
            .myButton {
                -moz-box-shadow:inset 0px 1px 0px 0px #3c9e8c;
                -webkit-box-shadow:inset 0px 1px 0px 0px #3c9e8c;
                box-shadow:inset 0px 1px 0px 0px #3c9e8c;
                background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #1ba08a), color-stop(1, #5dbdad));
                background:-moz-linear-gradient(top, #1ba08a 5%, #5dbdad 100%);
                background:-webkit-linear-gradient(top, #1ba08a 5%, #5dbdad 100%);
                background:-o-linear-gradient(top, #1ba08a 5%, #5dbdad 100%);
                background:-ms-linear-gradient(top, #1ba08a 5%, #5dbdad 100%);
                background:linear-gradient(to bottom, #1ba08a 5%, #5dbdad 100%);
                filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#1ba08a', endColorstr='#5dbdad',GradientType=0);
                background-color:#1ba08a;
                -moz-border-radius:6px;
                -webkit-border-radius:6px;
                border-radius:6px;
                display:inline-block;
                cursor:pointer;
                color:#ffffff;
                font-family:Georgia;
                font-size:13px;
                padding:5px 20px;
                text-decoration:none;
                text-shadow:0px 1px 0px #1fd9ba;
            }
            .myButton:hover {
                background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #5dbdad), color-stop(1, #1ba08a));
                background:-moz-linear-gradient(top, #5dbdad 5%, #1ba08a 100%);
                background:-webkit-linear-gradient(top, #5dbdad 5%, #1ba08a 100%);
                background:-o-linear-gradient(top, #5dbdad 5%, #1ba08a 100%);
                background:-ms-linear-gradient(top, #5dbdad 5%, #1ba08a 100%);
                background:linear-gradient(to bottom, #5dbdad 5%, #1ba08a 100%);
                filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#5dbdad', endColorstr='#1ba08a',GradientType=0);
                background-color:#5dbdad;
            }
            .myButton:active {
                position:relative;
                top:1px;
            }
        </style>
        <link rel="shortcut icon" href="http://www.cs.com.tr/TR/misc/favicon.ico" type="image/vnd.microsoft.icon" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sorgu Arama</title>
        <script type="text/javascript">
            function search(id) {
                $.ajax({
                    url: 'search',
                    type: "GET",
                    data: {
                        name: document.getElementById("inputname").value
                    },
                    success: function (data) {
                        if (data.Query !== undefined) {
                            var x = document.getElementById('queryTable');
                            var rowslength = x.rows.length;
                            x = document.getElementById('queryTable').insertRow(rowslength);
                            x.insertCell(0);
                            x.insertCell(1);
                            document.getElementById("hiddenOid").value = data.OID;
                            document.getElementById('queryTable').rows[rowslength].cells[0].innerHTML = document.getElementById("hiddenOid").value;
                            document.getElementById('queryTable').rows[rowslength].cells[1].innerHTML = data.Query;
                        } else {
                            alert(data.message);
                        }
                    }
                });
            }
            function sort(id) {
                var x = document.getElementById('queryTable');
                var rowslength = x.rows.length;
                for (var i = 0, max = rowslength; i < max; i++) {
                    document.getElementById('queryTable').deleteRow(0);
                }

                var y = document.getElementById('roleQueryTable');
                var rowslengthY = y.rows.length;
                for (var i = 0, max = rowslengthY; i < max; i++) {
                    document.getElementById('roleQueryTable').deleteRow(0);
                }

                var firstdate = new Date(document.getElementById("firstdate").value);
                var dd = firstdate.getDate();
                var mm = (firstdate.getMonth() + 1);
                var yyyy = firstdate.getFullYear();
                if (dd < 10)
                {
                    dd = '0' + dd;
                }
                if (mm < 10)
                {
                    mm = '0' + mm;
                }
                var firstDateString = dd + "-" + mm + "-" + yyyy;
                $.ajax({
                    url: 'sortDate',
                    type: "GET",
                    data: {
                        firstDate: firstDateString
                    },
                    success: function (data) {

                        debugger;
                        for (var i in data.Query) {
                            var x = document.getElementById('queryTable');
                            var rowslength = x.rows.length;
                            x = document.getElementById('queryTable').insertRow(rowslength);
                            x.insertCell(0);
                            document.getElementById('queryTable').rows[rowslength].cells[0].innerHTML = data.Query[i];
                        }

                        for (var i in data.roleQuery) {
                            var y = document.getElementById('roleQueryTable');
                            var rowslength = y.rows.length;
                            y = document.getElementById('roleQueryTable').insertRow(rowslength);
                            y.insertCell(0);
                            document.getElementById('roleQueryTable').rows[rowslength].cells[0].innerHTML = data.roleQuery[i];
                        }
                    }
                });
            }

        </script>
    </head>
    <body>
        <img src="http://www.cs.com.tr/TR/themes/touch/logo.png"><br><br>
        İsim:  <input type="text" class="textarea" name="inputname" value="" id="inputname" maxlength="200"/>&nbsp;&nbsp;
        <input type="submit" class="myButton" value="Ara" onclick="search()" id="search"/> &nbsp;&nbsp;&nbsp;&nbsp;
        <input type="date" name="firstdate" id="firstdate">&nbsp;&nbsp;
        <input type="submit" class="myButton" value="Listele" onclick="sort()" id="sort"/><br><br> 
        <table id="queryTable" style="border: 1px solid black" border="1" cellpadding="5" >  
        </table>
        <br><br>
        <br><br>
        <br><br>
        <table id="roleQueryTable" style="border: 1px solid black" border="1" cellpadding="5" >  
        </table>
        <input type="hidden" name="hiddenOid" value="" id ="hiddenOid"/>
        <input type="hidden" name="perOid" value="" id ="perOid"/>
        <input type="hidden" name="rolePerOid" value="" id ="rolePerOid"/>
    </body>
</html>
