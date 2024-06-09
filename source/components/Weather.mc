using Toybox.System;
using Toybox.WatchUi;
using Toybox.Graphics as Graphics;

using ThemeController as Theme;

class Weather {

    private var _screenWidth;
    private var _veryTinyFont;
    private var _fontHeight;
    private var _widgetHeight;

    private var _weatherX;
    private var _weatherY;

    private var _weatherPoints;
    private var _weatherIcon;

    function initialize(dc) {
        _screenWidth  = dc.getWidth();
        _veryTinyFont = Graphics.FONT_SYSTEM_XTINY;
        _fontHeight   = Graphics.getFontHeight(_veryTinyFont);
        _widgetHeight = (_fontHeight * 2) + 6;

        _weatherX = (_screenWidth / 2) - 72;
        _weatherY = 64;

        _weatherPoints = [
                        [_weatherX,       _weatherY],
                        [_weatherX + 144, _weatherY],
                        [_weatherX + 144, _weatherY + _widgetHeight],
                        [_weatherX,       _weatherY + _widgetHeight]
                     ];

        // Initialize weather icon
        _weatherIcon = WatchUi.loadResource(Rez.Drawables.rain_cloud_32);
    }

    function drawOnScreen(dc, info)
    {

        var conditions = info.Weather.getCurrentConditions();

        var currentTemp = CommonMethods.convertToFahrenheit(conditions.temperature).toString() + "°";
        var highTemp    = CommonMethods.convertToFahrenheit(conditions.highTemperature).toString() + "°";
        var lowTemp     = CommonMethods.convertToFahrenheit(conditions.lowTemperature).toString() + "°";

        CommonMethods.setDrawingClip(dc, _weatherPoints);

        ThemeController.setColor(dc, ThemeController.FONT_COLOR);

        // current temp, high temp, low temp
        dc.drawText(_weatherX + 30,  _weatherY + 14, Graphics.FONT_TINY, currentTemp, Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(_weatherX + 118, _weatherY + 4,  _veryTinyFont,      highTemp,    Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(_weatherX + 118, _weatherY + 34, _veryTinyFont,      lowTemp,     Graphics.TEXT_JUSTIFY_CENTER);

        // line between high and low
        dc.drawLine(_weatherX + 96, _weatherY + 35, _weatherX + 132, _weatherY + 35);

        // conditions icon (should be centered on screen horizontally)
        dc.drawBitmap(_weatherX + 56, _weatherY + 20, _weatherIcon);

        CommonMethods.clearDrawingClip(dc);

        Theme.resetColors(dc);
    }

}