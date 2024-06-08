using Toybox.System;
using Toybox.WatchUi;
using Toybox.Graphics as Graphics;

using ThemeController as Theme;

class Weather {

    private var _screenWidth;
    private var _tinyFont;
    private var _fontHeight;
    private var _widgetHeight;

    private var _weatherX;
    private var _weatherY;

    private var _weatherPoints;

    function initialize(dc) {
        _screenWidth  = dc.getWidth();
        _tinyFont     = CommonMethods.getTinyFont(dc);
        _fontHeight   = Graphics.getFontHeight(_tinyFont);
        _widgetHeight = (_fontHeight * 2) + 6;

        _weatherX = (_screenWidth / 2) - 64;
        _weatherY = 84;

        _weatherPoints = [
                        [_weatherX,       _weatherY],
                        [_weatherX + 128, _weatherY],
                        [_weatherX + 128, _weatherY + _widgetHeight],
                        [_weatherX,       _weatherY + _widgetHeight]
                     ];
    }

    function drawOnScreen(dc, info)
    {

        var conditions = info.Weather.getCurrentConditions();

        var currentTemp = CommonMethods.convertToFahrenheit(conditions.temperature);
        var highTemp    = CommonMethods.convertToFahrenheit(conditions.highTemperature);
        var lowTemp     = CommonMethods.convertToFahrenheit(conditions.lowTemperature);

        CommonMethods.setDrawingClip(dc, _weatherPoints);

        ThemeController.setColor(dc, ThemeController.FONT_COLOR);

        // current temp, high temp, low temp
        dc.drawText(_weatherX + 24,  _weatherY + 10, Graphics.FONT_MEDIUM, currentTemp, Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(_weatherX + 108, _weatherY + 4,  _tinyFont,           highTemp,    Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(_weatherX + 108, _weatherY + 36, _tinyFont,           lowTemp,     Graphics.TEXT_JUSTIFY_CENTER);

        CommonMethods.clearDrawingClip(dc);

        Theme.resetColors(dc);
    }

}