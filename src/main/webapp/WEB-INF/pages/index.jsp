<%-- 
    Document   : index
    Created on : Aug 13, 2015, 1:55:50 PM
    Author     : umutk
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" href="http://www.cs.com.tr/TR/misc/favicon.ico" type="image/vnd.microsoft.icon" />
        <title>Query Manager</title>
        <style type="text/css">
            body {
                background-image:
                    url('http://subtlepatterns.com/patterns/cream_pixels.png') ;
                background-repeat: repeat;             
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
                font-size:52px;
                padding:20px 80px;
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
    </head>
    <body>
    <center>
         <div style="margin-top: 200px">
             <img src="http://www.cs.com.tr/TR/themes/touch/logo.png" width=600 height=200><br></div>
        <div style="margin-top: 100px">
        <input type="submit" class="myButton" value="Sorgu Ara" onclick="location.href='arama.jsp';"/>&nbsp;&nbsp;&nbsp;
        <input type="submit" class="myButton" value="Sorgu Oluştur" onclick="location.href='query.jsp';" /></div> </center>

    </body>
</html>
