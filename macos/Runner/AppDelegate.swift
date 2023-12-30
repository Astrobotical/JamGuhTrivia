import Cocoa
import FlutterMacOS
import GoogleMobileAds

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
   // GADMobileAds.sharedInstance().start(completionHandler: nil)
    return true
  }
}
