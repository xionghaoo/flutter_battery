import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    private let CHANNEL = "xh.zero/battery"
    
//    private var testViewController: TestViewController!
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    // 创建IOS方法连接
    let batteryChannel = FlutterMethodChannel(name: CHANNEL,
                                              binaryMessenger: controller.binaryMessenger)
    
    batteryChannel.setMethodCallHandler({
        [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        // Note: this method is invoked on the UI thread.
        // Handle battery messages.
        switch (call.method) {
        case "getBatteryLevel":
            self?.receiveBatteryLevel(result: result)
        case "startNativePage":
            self?.startTestPage()
        default:
            result(FlutterMethodNotImplemented)
        }
//        guard call.method == "getBatteryLevel" else {
//            result(FlutterMethodNotImplemented)
//            return
//        }
//        self?.receiveBatteryLevel(result: result)
    })
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func receiveBatteryLevel(result: FlutterResult) {
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        if device.batteryState == UIDevice.BatteryState.unknown {
            result(FlutterError(code: "UNAVAILABLE",
                                message: "Battery info unavailable",
                                details: nil))
        } else {
            result(Int(device.batteryLevel * 100))
        }
    }
    
    func startTestPage() {
        if let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil) {
            if let vc = storyboard.instantiateViewController(withIdentifier: "TestViewController") as? TestViewController {
//                window?.rootViewController?.addChildViewController()
                window?.rootViewController?.present(vc, animated: true, completion: nil)
            }
//            {
//                var myWindow = NSWindow(contentViewController: vc)
//                myWindow.makeKeyAndOrderFront(self)
//                let controller = NSWindowController(window: myWindow)
//
//                controller.showWindow(self)
//
//            }
        }
    }
}
