using Toybox.ActivityMonitor;
using Toybox.Application;
using Toybox.Graphics;
using Toybox.Lang;
using Toybox.Math;
using Toybox.System;

using Toybox.WatchUi;
using Toybox.Application.Storage as Storage;

using ThemeController as Theme;

var partialUpdatesAllowed = false;          // Outside class so the Delegate class below can access the value    

class KozlinaWatchView extends WatchUi.WatchFace
{
    // General class-level fields
    var _isAwake = true;                     // Flag indicating whether watch is awake or in sleep mode

    // UI Components
    var _digitalClock;
    var _dateTitle;                          // Reference to date in large font
    var _moveBar;                            // Reference to MoveBar object
    var _bluetoothIcon;                      // Reference to bluetooth icon when connected to phone
    var _stepsCount;                         // Reference to StepsCount object
    var _batteryStatus;                      // Reference to BatteryStatus object
    var _milesWalked;                        // Reference to MilesWalked object
    var _caloriesBurned;                     // Reference to CaloriesBurned object

    // Initialize variables for this view
    function initialize() {

        // Call base class constructor
        WatchFace.initialize();

        ThemeController.setTheme(false);
    }

    // Configure the layout of the watchface for this device
    function onLayout(dc) {

        // Initialize UI components
        initializeUIComponents(dc);

        // Clear any clip
        CommonMethods.clearDrawingClip(dc);
    }

    // Handle the full screen refresh/update event, called once per minute or upon request
    function onUpdate(dc) {

        // Clear the clip
        CommonMethods.clearDrawingClip(dc);
        
        // Draw background color to screen buffer
        Theme.setBothColors(dc, Theme.BACKGROUND_COLOR);
        dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());

        // Reset colors for rendering our info items (font, background)
        Theme.resetColors(dc);
        
        // Draw UI elements to buffer
        drawUIComponents(dc);
    }
   
    // This method is called when the device re-enters sleep mode.
    function onEnterSleep() {
        _isAwake = false;
        WatchUi.requestUpdate();
    }

    // This method is called when the device exits sleep mode.
    function onExitSleep() {
        _isAwake = true;
        //_mainClock.setClockCenterToScreenCenter();
    }

    function initializeUIComponents(dc){
        // Created instance of each UI component
       // _mainClock      = new MainClock(dc);
        _digitalClock   = new DigitalClock(dc);
        _dateTitle      = new DateTitle(dc);
        _moveBar        = new MoveBar(dc);
        _bluetoothIcon  = new BluetoothIcon(dc);
        _stepsCount     = new StepsCount(dc);
        _batteryStatus  = new BatteryStatus(dc);
        _caloriesBurned = new CaloriesBurned(dc);
    }

    function drawUIComponents(dc) {
        // Get steps info
        var activityInfo = ActivityMonitor.getInfo();

        // When awake only! -- Draw UI components onto the passed-in DC (buffer)
        if (_isAwake){
            _dateTitle.drawOnScreen(dc);
            _moveBar.drawOnScreen(dc, activityInfo);
            _bluetoothIcon.drawOnScreen(dc);
            _batteryStatus.drawOnScreen(dc);

            _stepsCount.drawOnScreen(dc, activityInfo);
            _caloriesBurned.drawOnScreen(dc, activityInfo);
        }

        // Draw clock last so it's over everything else
        _digitalClock.drawOnScreen(dc);      
    }
}

class KozlinaWatchDelegate extends WatchUi.WatchFaceDelegate {

    function initialize(){
        WatchFaceDelegate.initialize();
    }

    // The onPowerBudgetExceeded callback is called by the system if the
    // onPartialUpdate method exceeds the allowed power budget. If this occurs,
    // the system will stop invoking onPartialUpdate each second
    function onPowerBudgetExceeded(powerInfo) {
        System.println( "Average execution time: " + powerInfo.executionTimeAverage );
        System.println( "Allowed execution time: " + powerInfo.executionTimeLimit );
        partialUpdatesAllowed = false;
    }
}
