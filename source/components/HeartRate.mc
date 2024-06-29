using Toybox.System;
using Toybox.WatchUi;
using Toybox.Graphics as Graphics;

using ThemeController as Theme;

class HeartRate {

    private var _screenWidth;
    private var _screenHeight;
    private var _hrFont;
    private var _fontHeight;

    private var _hrX;
    private var _hrY;

    private var _hrPoints;

    private var _hrIcon;

    function initialize(dc) {
        _screenWidth  = dc.getWidth();
        _screenHeight = dc.getHeight();
        _hrFont       = Graphics.FONT_XTINY;
        _fontHeight   = Graphics.getFontHeight(_hrFont);

        _hrIcon =  WatchUi.loadResource(Rez.Drawables.HeartRateIcon);

        _hrX = dc.getWidth() / 2;
        _hrY = dc.getHeight() - 72;

        _hrPoints = [
                        [_hrX - 16, _hrY],
                        [_hrX + 16, _hrY],
                        [_hrX + 16, _hrY + _fontHeight],
                        [_hrX - 16, _hrY + _fontHeight]
                     ];
        Theme.resetColors(dc);
    }

    function drawOnScreen(dc){

        var hrHistory = Toybox.ActivityMonitor.getHeartRateHistory(null, true);
        var hrSample = hrHistory.next();
        var hr = hrSample.heartRate;

        var hrString = CommonMethods.getFormattedStringForNumber(hr);

        dc.drawBitmap(_hrX - 24, _hrY - 4, _hrIcon);
        dc.drawText(_hrX, _hrY, _hrFont, hrString, Graphics.TEXT_JUSTIFY_CENTER);

    }

}