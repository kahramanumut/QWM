<html>
    <head>
        <meta http-equiv="content-type" content="text/html; charset=utf-8">
        <title>Panel</title>
        <script src="http://code.interactjs.io/interact-1.2.4.min.js"></script>
        <script src="http://code.interactjs.io/interact-1.2.4.js"></script>
        <style type="text/css">
            .resize-drag {
                background-color: #29e;
                color: white;
                font-size: 20px;
                font-family: sans-serif;
                border-radius: 8px;
                padding: 20px;
                margin: 30px 20px;

                width: 120px;

                /* This makes things *much* easier */
                box-sizing: border-box;
            }

            .resize-container {
                width: 100%;
                height: 240px;
            }
        </style>

        <script type="text/javascript">
            interact('.resize-drag')
                    .draggable({
                        onmove: window.dragMoveListener
                    })
                    .resizable({
                        edges: {left: true, right: true, bottom: true, top: true}
                    })
                    .on('resizemove', function (event) {
                        var target = event.target,
                                x = (parseFloat(target.getAttribute('data-x')) || 0),
                                y = (parseFloat(target.getAttribute('data-y')) || 0);

                        // update the element's style
                        target.style.width = event.rect.width + 'px';
                        target.style.height = event.rect.height + 'px';

                        // translate when resizing from top or left edges
                        x += event.deltaRect.left;
                        y += event.deltaRect.top;

                        target.style.webkitTransform = target.style.transform =
                                'translate(' + x + 'px,' + y + 'px)';

                        target.setAttribute('data-x', x);
                        target.setAttribute('data-y', y);
                        target.textContent = event.rect.width + '�' + event.rect.height;
                    });
        </script>
    </head>
    <body>
        <div class="resize-container">
            <div class="resize-drag">
                Resize from any edge or corner
            </div>
        </div>
    </body>
</html>