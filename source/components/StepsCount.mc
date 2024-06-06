using Toybox.System;
using Toybox.WatchUi;
using Toybox.Graphics as Graphics;

using ThemeController as Theme;

class StepsCount {

    private var _screenWidth;
    private var _screenHeight;
    private var _tinyFont;
    private var _fontHeight;

    private var _stepsX;
    private var _stepsY;

    private var _stepsPoints;

    function initialize(dc) {
        _screenWidth  = dc.getWidth();
        _screenHeight = dc.getHeight();
        _tinyFont     = CommonMethods.getTinyFont(dc);
        _fontHeight   = Graphics.getFontHeight(_tinyFont);

        _stepsX = _screenWidth / 3;
        _stepsY = _screenHeight - 126;
        _stepsPoints = [
                        [_stepsX - 100, _stepsY],
                        [_stepsX + 100, _stepsY],
                        [_stepsX + 100, _stepsY + _fontHeight],
                        [_stepsX - 100, _stepsY + _fontHeight]
                     ];
        Theme.resetColors(dc);
    }

    function drawOnScreen(dc, info)
    {
        var stepsString = CommonMethods.getFormattedStringForNumber(info.steps);

        var stepPerc   = ((info.steps * 100) / info.stepGoal).toNumber();

        CommonMethods.drawLabelAndRecangle(dc, _stepsX, _stepsY, "steps", Theme.STEPS_COLOR);

        setStepsDisplayLevelColor(dc, stepPerc);

        CommonMethods.setDrawingClip(dc, _stepsPoints);

        dc.drawText(_stepsX, _stepsY - 1, _tinyFont, stepsString, Graphics.TEXT_JUSTIFY_CENTER);
       
        Theme.resetColors(dc);
    }

  
    
    private function setStepsDisplayLevelColor(dc, perc){
        if (System.getClockTime().hour < 14) {
            // Only show step value colors if >= 2pm
            Theme.resetColors(dc);
        } else if (perc > 100) {
            // Step goal!
            Theme.setColor(dc, Theme.FULL_COLOR);
        } else if (perc > 60) {
            // 60+% of step goal
            Theme.setColor(dc, Theme.MOST_COLOR);
        } else if (perc > 30) {
            // 30-59% step goal
            Theme.setColor(dc, Theme.SOME_COLOR);
        } else if (perc > 0) {
            // 1-29% step goal
            Theme.setColor(dc, Theme.LOW_COLOR);
        } else {
            // 0% - Default to normal font color for 0 steps
            Theme.resetColors(dc);
        }
    }
}