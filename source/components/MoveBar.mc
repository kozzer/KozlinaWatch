using Toybox.System;
using Toybox.WatchUi;
using Toybox.Graphics as Graphics;

using ThemeController as Theme;

class MoveBar {

    // Move Bar
    private const _moveBarHeight = 6;   
    private const _moveBarWidth = 112; 
    private var   _barX;
    private var   _barY;

    private var _barPoints;

    function initialize(dc){
        // Get location of the blue bar
        _barX = ((dc.getWidth() / 2) - (_moveBarWidth / 2));      // Total 116px wide, so 58px left of center
        _barY = Graphics.getFontHeight(Graphics.FONT_MEDIUM) + 4;

        _barPoints = [
                        [_barX, _barY], 
                        [_barX + _moveBarWidth, _barY], 
                        [_barX + _moveBarWidth, _barY + _moveBarHeight], 
                        [_barX, _barY + _moveBarHeight]
                    ];
    }

    function drawOnScreen(dc, info) {

        // Get Move bar status
        var barLevel = info.moveBarLevel;

        var drawBarX = _barX;

        CommonMethods.setDrawingClip(dc, _barPoints);

        // Draw bars based on bar level
        if (barLevel >= 1) {
            Theme.setColor(dc, Theme.BLUE_COLOR);
            dc.fillRectangle(drawBarX, _barY, 44, _moveBarHeight);
            drawBarX += 48;
        }
        if (barLevel >= 2){
            Theme.setColor(dc, Theme.FULL_COLOR);
            dc.fillRectangle(drawBarX, _barY, 14, _moveBarHeight);
            drawBarX += 18;
        }
        if (barLevel >= 3){
            Theme.setColor(dc, Theme.MOST_COLOR);
            dc.fillRectangle(drawBarX, _barY, 14, _moveBarHeight);
            drawBarX += 18;
        }
        if (barLevel >= 4){
            Theme.setColor(dc, Theme.SOME_COLOR);
            dc.fillRectangle(drawBarX, _barY, 14, _moveBarHeight);
            drawBarX += 18;
        }
        if (barLevel >= 5){
            Theme.setColor(dc, Theme.LOW_COLOR);
            dc.fillRectangle(drawBarX, _barY, 14, _moveBarHeight);
        }

        CommonMethods.clearDrawingClip(dc);
    }

}