<%-- 
    Document   : ajax
    Created on : Jun 30, 2015, 2:39:39 PM
    Author     : UMUT KAHRAMAN @HOPEHERO3 
--%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <TITLE>Sorgu Oluşturma</TITLE>
        <link rel="shortcut icon" href="http://www.cs.com.tr/TR/misc/favicon.ico" type="image/vnd.microsoft.icon" />
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
        <script type="text/javascript"
                src="http://code.jquery.com/jquery-1.10.1.min.js">
        </script>
        <script type="text/javascript">
            function generateQuery(id) {
                var control = true;
                var x = document.getElementById(id);
                for (var i = 0; i < x.rows.length; i++) {
                    var c = x.rows[i].cells[1].innerHTML;
                    if (c.indexOf(document.getElementById("inputname").value) > -1) {
                        control = false;
                        break;
                    }
                }
                if (control === true) {

                    $.ajax({
                        url: 'generatequery',
                        type: "GET",
                        data: {
                            name: document.getElementById("inputname").value,
                            lastOid: document.getElementById("hiddenOid").value
                        },
                        success: function (data) {
                            if (data.Query === "") {
                                alert("Bu kayıt dosyada bulunmaktadır.");
                            } else {
                                var x = document.getElementById(id);
                                var rowslength = x.rows.length;
                                x = document.getElementById(id).insertRow(rowslength);
                                x.insertCell(0);
                                x.insertCell(1);
                                x.insertCell(2);
                                x.insertCell(3);
                                document.getElementById("hiddenOid").value = data.OID;
                                document.getElementById(id).rows[rowslength].cells[0].innerHTML = document.getElementById("hiddenOid").value;
                                document.getElementById(id).rows[rowslength].cells[1].innerHTML = data.Query;
                                document.getElementById(id).rows[rowslength].cells[2].innerHTML = '<input type="submit" class="myButton" value="Oluştur" onclick="sorguOlustur(' + rowslength + ')"/>';
                                document.getElementById(id).rows[rowslength].cells[3].innerHTML = '<input type="submit" class="myButton" value="Sil" onclick="sorguSil(this)"/>';
                            }
                        }
                    });
                } else {
                    alert("Bu sorgu halihazırda listede bulunmaktadır.");
                }

            }

            function sorguSil(r) {
                debugger;
                var i = r.parentNode.parentNode.rowIndex;
                var oid = document.getElementById("table").rows[i].cells[0].innerHTML;
                var rowIndexForDelete = [];
                var t = 0;
                for (var j in document.getElementById("newtable").rows) {
                    var tempOid = document.getElementById("newtable").rows[j].cells;
                    if (tempOid !== undefined) {
                        if (oid === tempOid[0].innerHTML) {
                            rowIndexForDelete[t++] = j;
                        }
                    }
                }
                for (j in rowIndexForDelete) {
                    document.getElementById("newtable").deleteRow(rowIndexForDelete[j]);
                }
                document.getElementById("table").deleteRow(i);
            }

            function roleSil(r) {
                var i = r.parentNode.parentNode.rowIndex;
                document.getElementById("newtable").deleteRow(i);
            }

            function rolleriGetir(id) {
                $.ajax({
                    url: 'getOptionsOnLoad',
                    type: "GET",
                    success:
                            function (data) {
                                var myselect = document.getElementById(id);
                                for (var i = 0, max = data.length; i < max; i++) {
                                    myselect.add(new Option(data[i].name, data[i].value), myselect.options[i]);
                                }
                            }
                });
            }

            //Tablonun yanındaki buton
            function sorguOlustur(rowslength) {
                //  alert(document.getElementById('table').rows[rowslength].cells[2].value);
                document.getElementById("postrole").style.visibility = "visible";
                document.getElementById("perOid").value = document.getElementById("table").rows[rowslength].cells[0].innerHTML;
            }

            function save() {
                var queryList = {};
                for (var i = 0;
                        i < document.getElementById('table').rows.length; i++) {
                    queryList[i] =
                            document.getElementById('table').rows[i].cells[1].innerHTML;
                }
                var roleQueryList = {};
                for (var i = 0;
                        i < document.getElementById('newtable').rows.length; i++) {
                    roleQueryList[i] =
                            document.getElementById('newtable').rows[i].cells[1].innerHTML;
                }
                $.ajax({
                    url: 'save',
                    type: "GET",
                    data: {
                        queryList: JSON.stringify(queryList),
                        roleQueryList: JSON.stringify(roleQueryList)
                    },
                    success:
                            function (data) {
                                location.reload(true)
                            }
                });
            }
//select downlistenin altındaki buton clicki
            function generateRole(id) {
                var obj = postrole.role,
                        options = obj.options,
                        roleOidList = [], i;
                for (i = 0; i < options.length; i++) {
                    options[i].selected && roleOidList.push(obj[i].value);
                }
                var roles = roleOidList.toString();
                document.getElementById("postrole").style.visibility = "hidden";
                $.ajax({
                    url: 'generateRoleQuery',
                    type: "GET",
                    data: {
                        roleOidList: roles, //JSON.stringify(roleOidList),
                        ekrandanGelenOid: document.getElementById("rolePerOid").value,
                        permissionOid: document.getElementById("perOid").value
                    },
                    success:
                            function (data) {

                                for (var i in data) {
                                    var line = data[i];
                                    var x = document.getElementById(id);
                                    var rowslength = x.rows.length;
                                    x = document.getElementById(id).insertRow(rowslength);
                                    x.insertCell(0);
                                    x.insertCell(1);
                                    x.insertCell(2);
                                    document.getElementById("rolePerOid").value = line.lastOid;
                                    document.getElementById(id).rows[rowslength].cells[0].innerHTML = document.getElementById("perOid").value;
                                    document.getElementById(id).rows[rowslength].cells[1].innerHTML = line.Query;
                                    document.getElementById(id).rows[rowslength].cells[2].innerHTML = '<input type="submit" value="Sil" class="myButton" id=rowslength onclick="roleSil(this)"/>';
                                }
                            }
                });
            }
        </script>
    </head>
    <body onload="rolleriGetir('role')">
        <div>
            <img src="http://www.cs.com.tr/TR/themes/touch/logo.png">
            <br> <br>
            İsim:  <input type="text" class="textarea" name="inputname" value="" id="inputname" maxlength="200"/>  &nbsp;&nbsp;&nbsp;
            <input type="submit" class="myButton" value="Sorgu Oluştur" onclick="generateQuery('table')" id="generateQuery"/>
            <input type="submit" class="myButton" value="Dosyaya kaydet" onclick="save('table')"/>     
            <br> <br>  
            <form name="postrole" id="postrole" style="visibility: hidden">
                <div style="position: absolute;right: 280px">
                    <select name="Role" size="8" multiple="multiple" id="role" style="padding-right: 20px">
                    </select>
                    <br><br>
                    <input type="button" value="Rolleri Oluştur" class="myButton" onclick="generateRole('newtable')"/>
                </div>
            </form>
            <table id="table" style="border: 1px solid black" border="1" cellpadding="5" >  
            </table>
            <br><br>
            <br><br>
            <br><br>
            <table id="newtable" style="border: 1px solid black" border="1" cellpadding="5" >  
            </table>
            <input type="hidden" name="hiddenOid" value="" id ="hiddenOid"/>
            <input type="hidden" name="perOid" value="" id ="perOid"/>
            <input type="hidden" name="rolePerOid" value="" id ="rolePerOid"/>
        </div>
    </body>
</html>