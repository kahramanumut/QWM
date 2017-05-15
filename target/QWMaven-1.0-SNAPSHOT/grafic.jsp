<!DOCTYPE HTML>
<html>

    <head>  
        <style type="text/css">
.center { float:left; padding:10px; margin:150px; }
</style>
        <script type="text/javascript">
            window.onload = function () {
                var chart = new CanvasJS.Chart("chartContainer",
                        {
                            title: {
                                text: "US Mobile / Tablet OS Market Share, Dec 2012"
                            },
                            animationEnabled: true,
                            theme: "theme2",
                            data: [
                                {
                                    type: "doughnut",
                                    indexLabelFontFamily: "Garamond",
                                    indexLabelFontSize: 20,
                                    startAngle: 0,
                                    indexLabelFontColor: "dimgrey",
                                    indexLabelLineColor: "darkgrey",
                                    toolTipContent: "{y} %",
                                    dataPoints: [
                                        {y: 67.34, indexLabel: "iOS {y}%"},
                                        {y: 28.6, indexLabel: "Android {y}%"},
                                        {y: 1.78, indexLabel: "Kindle {y}%"},
                                        {y: 0.84, indexLabel: "Symbian {y}%"},
                                        {y: 0.74, indexLabel: "BlackBerry {y}%"},
                                        {y: 2.06, indexLabel: "Others {y}%"}

                                    ]
                                }
                            ]
                        });

                var chart2 = new CanvasJS.Chart("chartContainer2",
                        {
                            title: {
                                text: "US Mobile / Tablet OS Market Share, Dec 2012"
                            },
                            animationEnabled: true,
                            theme: "theme2",
                            data: [
                                {
                                    type: "doughnut",
                                    indexLabelFontFamily: "Garamond",
                                    indexLabelFontSize: 20,
                                    startAngle: 0,
                                    indexLabelFontColor: "dimgrey",
                                    indexLabelLineColor: "darkgrey",
                                    toolTipContent: "{y} %",
                                    dataPoints: [
                                        {y: 67.34, indexLabel: "iOS {y}%"},
                                        {y: 28.6, indexLabel: "Android {y}%"},
                                        {y: 1.78, indexLabel: "Kindle {y}%"},
                                        {y: 0.84, indexLabel: "Symbian {y}%"},
                                        {y: 0.74, indexLabel: "BlackBerry {y}%"},
                                        {y: 2.06, indexLabel: "Others {y}%"}

                                    ]
                                }
                            ]
                        });

                chart2.render();
                chart.render();
            }
        </script>
        <script type="text/javascript" src="assets/script/canvasjs.min.js"></script>
    </head>
    <body>
        
        <div class="center" id="chartContainer" style="height: 300px; width: 30%; "> </div> 
          <div class="center" id="chartContainer2" style="height: 300px; width: 30%;">
        </div>
    </body>
</html>