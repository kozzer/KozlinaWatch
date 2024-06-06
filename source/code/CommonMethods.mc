using Toybox.Application;
using Toybox.Graphics;
using Toybox.Lang;

using ThemeController as Theme;

module CommonMethods {

    // Clip for partial updates, so only pixels where second hand is will actually be changed
    var _curClip;    

    // Draw the watch face background onto the given draw context
    function writeBufferToDisplay(screenDc, screenBuffer) { 
        // Write the entire display buffer to the display
        screenDc.drawBitmap(0, 0, screenBuffer);    
    }

    function resetColorsForRendering(dc) {
        dc.setColor(Theme.FONT_COLOR, Graphics.COLOR_TRANSPARENT);
    }

    function getTinyFont(dc){
        var width = dc.getWidth();
        if (width < 240){
            return Graphics.FONT_XTINY;
        } else {
            return Graphics.FONT_TINY;
        }
    }

    // Set the clip based on the passed-in set of coordinates
    function setDrawingClip(dc, rectanglePoints) {
        // Clear existing clip
        dc.clearClip();
    
        // Update the cliping rectangle to polygon
        _curClip        = getBoundingBox(rectanglePoints);
        var bboxWidth  = _curClip[1][0] - _curClip[0][0] + 1;
        var bboxHeight = _curClip[1][1] - _curClip[0][1] + 1;
        
        // Set new clip with new coordinates
        dc.setClip(_curClip[0][0], _curClip[0][1], bboxWidth, bboxHeight);        
    }

    // Clear drawing clip
    function clearDrawingClip(dc) {
        dc.clearClip();
        _curClip = null;
    }

    // Compute a bounding box from the passed in points
    function getBoundingBox(points) {
        var min = [9999,9999];
        var max = [0,0];

        for (var i = 0; i < points.size(); ++i) {
            if(points[i][0] < min[0]) {
                min[0] = points[i][0];
            }

            if(points[i][1] < min[1]) {
                min[1] = points[i][1];
            }

            if(points[i][0] > max[0]) {
                max[0] = points[i][0];
            }

            if(points[i][1] > max[1]) {
                max[1] = points[i][1];
            }
        }

        return [min, max];
    }

    public function drawLabelAndRecangle(dc, x, y, label, color){

        var rectanglePoints = [
                [x - 60, y],
                [x + 60, y],
                [x + 60, y + 69],
                [x - 60, y + 69]
        ];

        CommonMethods.setDrawingClip(dc, rectanglePoints);

        // Colored outline rect
        Theme.setColor(dc, color);
        dc.fillRoundedRectangle(x - 60, y, 120, 40, 4);

        // Black "fill" inside rect
        Theme.setColor(dc, 0x000000);
        dc.fillRoundedRectangle(x - 58, y + 2, 116, 36, 4);

        // Colored label text
        Theme.setColor(dc, color);
        var labelText = Lang.format(format, parameters);
        dc.drawText(x, y + 38, Graphics.FONT_XTINY, label, Graphics.TEXT_JUSTIFY_CENTER);

        Theme.resetColors(dc);
        CommonMethods.clearDrawingClip(dc);
    }

  }