using Toybox.Application;
using Toybox.Time;
using Toybox.Communications;


// Entry point
class KozlinaWatch extends Application.AppBase
{
    private var _mainWatchFaceView;

    function initialize() {
        AppBase.initialize();    
    }

    function onStart(state) { }

    function onStop(state)  { }

    // Main watch face 
    function getInitialView() {

        _mainWatchFaceView = new KozlinaWatchView();

        if( Toybox.WatchUi has :WatchFaceDelegate ) {
            return [_mainWatchFaceView, new KozlinaWatchDelegate()];
        } else {
            return [_mainWatchFaceView];
        }
    }

    // Goal screen
    function getGoalView(goal) {
        return [new KozlinaGoalView(goal)];
    }

}