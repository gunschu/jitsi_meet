import Flutter
import UIKit
import JitsiMeet

public class SwiftJitsiMeetPlugin: NSObject, FlutterPlugin {
    
    var window: UIWindow?
    
    var uiVC : UIViewController
    
   init(uiViewController: UIViewController) {
          self.uiVC = uiViewController
      }
      
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "jitsi_meet", binaryMessenger: registrar.messenger())
    let viewController: UIViewController = (UIApplication.shared.delegate?.window??.rootViewController)!
    let instance = SwiftJitsiMeetPlugin(uiViewController: viewController)
    
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if (call.method == "getPlatformVersion") {
           result("iOS " + UIDevice.current.systemVersion)
        }
        else if (call.method == "openJitsiMeet") {
            //var jitsiViewController: JitsiViewController? = JitsiViewController.init()
            let jitsiViewController = JitsiViewController()
            
            jitsiViewController.modalPresentationStyle = .popover
            jitsiViewController.popoverPresentationController?.sourceView = UIApplication.shared.keyWindow?.rootViewController?.view
            jitsiViewController.modalPresentationStyle = .popover
            jitsiViewController.preferredContentSize = CGSize(width: 200, height: 200)
            // present the view controller
            self.uiVC.present(jitsiViewController, animated: true, completion: nil)
        }
        else if ((call.method == "joinMeetingWithOptions") ) {
            if let args = call.arguments as? Dictionary<String, Any>,
                let roomName = args["roomName"] as? String,
                let subject = args["subject"] as? String{
                let jitsiViewController = JitsiViewController()
                      
                jitsiViewController.modalPresentationStyle = .popover
                jitsiViewController.popoverPresentationController?.sourceView
                UIApplication.shared.keyWindow?.rootViewController = jitsiViewController
                    
                jitsiViewController.modalPresentationStyle = .fullScreen
                jitsiViewController.roomName = roomName;
                jitsiViewController.subject = subject;
                
                
                
                    
                // present the view controller
                self.uiVC.present(jitsiViewController, animated: true, completion: nil)
                
                
    }

       
     
  }
}
}
