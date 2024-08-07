using Toybox.System;
using Toybox.WatchUi;

class BluetoothIcon {

    // Reference to bluetooth icon png
    private var _iconBitmap;  

    // Icon location and bounding rectangle
    private var _iconX;     
    private var _iconY;     
    private var _iconPoints;                    

    function initialize(dc){
        // Initialize bluetooth icon
        _iconBitmap = WatchUi.loadResource(Rez.Drawables.BluetoothIcon);

        // Set location of points for icon location (upper right corner)
        _iconX      = dc.getWidth() / 2 - 12;
        //_iconY      = dc.getHeight() - 64;
        _iconY      = 80;
        _iconPoints = [ 
                        [_iconX, _iconY], 
                        [_iconX + 24, _iconY], 
                        [_iconX + 24, _iconY + 36], 
                        [_iconX, _iconY + 36] 
                     ];
    }

    // Draw icon onto given dc
    public function drawOnScreen(dc){
        
        // Only do anything if bluetooth is active
        if (System.getDeviceSettings().phoneConnected) {  
 
            // Update the cliping rectangle to the location of the icon
            CommonMethods.setDrawingClip(dc, _iconPoints);
            
            // Actually write the icon to the dc
            dc.drawBitmap(_iconX, _iconY, _iconBitmap);

            // Clear the clip
            CommonMethods.clearDrawingClip(dc);
        }
    }
}