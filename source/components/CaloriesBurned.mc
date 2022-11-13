using Toybox.System;
using Toybox.WatchUi;
using Toybox.Graphics as Graphics;

using ThemeController as Theme;

class CaloriesBurned {

    private var _screenHeight;
    private var _tinyFont;
    private var _fontHeight;

    private var _calsX;
    private var _calsY;

    private var _calsPoints;

    function initialize(dc) {
        _screenHeight = dc.getHeight();
        _tinyFont     = CommonMethods.getTinyFont(dc);
        _fontHeight   = Graphics.getFontHeight(_tinyFont);

        _calsX = dc.getWidth() - 14;
        _calsY = _screenHeight - 48;
        _calsPoints = [
                        [_calsX - 100, _calsY],
                        [_calsX, _calsY],
                        [_calsX, _calsY + _fontHeight],
                        [_calsX - 100, _calsY + _fontHeight]
                     ];
    }

    function drawOnScreen(dc, info)
    {
        var caloriesBurned = info.calories + "c";

        CommonMethods.setDrawingClip(dc, _calsPoints);

        dc.drawText(_calsX, _calsY, _tinyFont, caloriesBurned, Graphics.TEXT_JUSTIFY_RIGHT);

        CommonMethods.clearDrawingClip(dc);

        Theme.resetColors(dc);
    }

}