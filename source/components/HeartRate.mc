using Toybox.System;
using Toybox.WatchUi;
using Toybox.Graphics as Graphics;

using ThemeController as Theme;

class HeartRate {
    
    private var _hrX;
    private var _hrY;
    private var _hrIcon;
    private var _hrFont;

    private var _heartRatePoints;

    function initialize(dc) {

        _hrX    = (dc.getWidth() / 3) * 2;
        _hrY    = dc.getHeight() - 106;
        _hrIcon =  WatchUi.loadResource(Rez.Drawables.HeartRateIcon);
        _hrFont = Graphics.FONT_XTINY;

        _heartRatePoints = [
            [ _hrX - 24, _hrY - 4  ],
            [ _hrX + 24, _hrY - 4  ],
            [ _hrX + 24, _hrY + 48 ],
            [ _hrX - 24, _hrY + 48 ]
        ];

        Theme.resetColors(dc);
    }

    function drawOnScreen(dc){

        var hrHistory = Toybox.ActivityMonitor.getHeartRateHistory(null, true);
        var hrSample = hrHistory.next();
        var hr = hrSample.heartRate;

        var hrString = CommonMethods.getFormattedStringForNumber(hr);
        
        CommonMethods.setDrawingClip(dc, _heartRatePoints);

        dc.drawBitmap(_hrX - 24, _hrY - 4, _hrIcon);
        dc.drawText(_hrX, _hrY, _hrFont, hrString, Graphics.TEXT_JUSTIFY_CENTER);

        Theme.resetColors(dc);
    }

}