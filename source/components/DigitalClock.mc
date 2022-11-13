using Toybox.System;
using Toybox.WatchUi;
using Toybox.Graphics as Graphics;
using Toybox.Time;
using Toybox.Time.Gregorian;

using ThemeController as Theme;

class DigitalClock {

    private var _timeFont;
    private var _timeX;
    private var _timeY;
    private var _timeHeight;
    private var _timePoints;

    function initialize(dc) {
        
        _timeFont = Application.loadResource( Rez.Fonts.lemon_milk );

        _timeX = (dc.getWidth() / 2) - 12;
        _timeY = (dc.getHeight() / 2) - 48;

        _timeHeight = Graphics.getFontHeight(_timeFont) + 1;
        _timePoints = [
                        [_timeX - 100, _timeY],
                        [_timeX + 100, _timeY],
                        [_timeX + 100, _timeY + _timeHeight],
                        [_timeX - 100, _timeY + _timeHeight]
                    ];

    }       
    


        // Draw the date string into the provided buffer at the specified location
    function drawOnScreen(dc) {
        var greg = Gregorian.info(Time.now(), Time.FORMAT_SHORT);       // Greg is 16th century new hotness, Julian is old and busted
        
        // Get the display hour and AM/PM 
        var hour = greg.hour;
        var ampm = "AM";
        if (hour == 0){
            hour = 12;
        } else if (hour == 12){
            ampm = "PM";
        } else if (hour > 12){
            hour = hour - 12;
            ampm = "PM";
        }
       
        var hourString = hour.format("%1d");
        var minString  = greg.min.format("%02d");
        var timeStr    = hourString + ":" + minString;

        CommonMethods.setDrawingClip(dc, _timePoints);

        CommonMethods.resetColorsForRendering(dc);
        dc.drawText(_timeX, _timeY, _timeFont, timeStr, Graphics.TEXT_JUSTIFY_CENTER);

        var ampmX = _timeX + 84;
        var ampmY = _timeY + (_timeHeight * 0.55);
        var ampmPoints = [ [ampmX, ampmY], [ampmX, ampmY + 100], [ampmX + 100, ampmY + 100], [ampmX + 100, ampmY] ];

        CommonMethods.setDrawingClip(dc, ampmPoints);

        dc.drawText(ampmX, ampmY, Graphics.FONT_GLANCE_NUMBER, ampm, Graphics.TEXT_JUSTIFY_LEFT);

        CommonMethods.clearDrawingClip(dc);
    }
}