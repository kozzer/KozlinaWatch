using Toybox.System;
using Toybox.WatchUi;
using Toybox.Graphics as Graphics;
using Toybox.Time;
using Toybox.Time.Gregorian;

using ThemeController as Theme;

class DigitalClock {

    private var _normalTimeFont;
    private var _lightTimeFont;
    private var _timeX;
    private var _timeY;
    private var _timeHeight;
    private var _timePoints;

    function initialize(dc) {
        
        _normalTimeFont = Application.loadResource( Rez.Fonts.lemon_milk_144 );
        _lightTimeFont  = Application.loadResource( Rez.Fonts.lemon_milk_light_144 );

        _timeX = dc.getWidth() / 2;
        _timeY = (dc.getHeight() / 2) - 80;

        _timeHeight = Graphics.getFontHeight(_normalTimeFont) + 1;
        _timePoints = [
                        [_timeX - 150, _timeY],
                        [_timeX + 150, _timeY],
                        [_timeX + 150, _timeY + _timeHeight],
                        [_timeX - 150, _timeY + _timeHeight]
                    ];

    }       
    


        // Draw the date string into the provided buffer at the specified location
    function drawOnScreen(dc, isAwake) {

        // Get local copies of root values
        var timeX = _timeX;
        var timeY = _timeY;

        // Always-On Display: Randomly move time 4px in any direction upon each update 
        //  to help prevent burn in
        if (isAwake == false){
            timeX = timeX + (Math.rand() % 4) + 1;
            timeY = timeY + (Math.rand() % 4) + 1;
        }

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

        if (isAwake){

            // Normal thickness for when display is awake
            dc.drawText(timeX, timeY, _normalTimeFont, timeStr, Graphics.TEXT_JUSTIFY_CENTER);

        } else {

            // Thinner font for the "always-on display"
            dc.drawText(timeX, timeY, _lightTimeFont, timeStr, Graphics.TEXT_JUSTIFY_CENTER);
        }

        var ampmX = timeX + 112;
        var ampmY = timeY + (_timeHeight * 0.54);
        var ampmPoints = [ [ampmX, ampmY], [ampmX, ampmY + 100], [ampmX + 100, ampmY + 100], [ampmX + 100, ampmY] ];

        CommonMethods.setDrawingClip(dc, ampmPoints);

        // Only draw AM/PM when screen is awake
        //if (isAwake){
            dc.drawText(ampmX, ampmY, Graphics.FONT_GLANCE_NUMBER, ampm, Graphics.TEXT_JUSTIFY_LEFT);
        //}

        CommonMethods.clearDrawingClip(dc);
    }
}