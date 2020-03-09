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
    let viewController: UIViewController =
    (UIApplication.shared.delegate?.window??.rootViewController)!
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

        // present the view controller
        
         self.uiVC.present(jitsiViewController, animated: true, completion: nil)
        
        //jitsiViewController.popoverPresentationController?.sourceView = self.uiVC.view
        
        
        
        //self.uiVC.show(jitsiViewController, sender: self)
        
        
        
        //UIApplication.shared.keyWindow?.rootViewController = jitsiViewController;
        
        //UIApplication.shared.keyWindow?.makeKeyAndVisible()
        
        //UIApplication.shared.keyWindow?.rootViewController?.navigationController?.pushViewController(jitsiViewController!, animated: true)
        
        //self.navigationController?.pushViewController(obj, animated: true)
        
        //let rootViewController:UIViewController! = UIApplication.shared.keyWindow?.rootViewController as! FlutterViewController
        
       // rootViewController?.navigationController?.pushViewController(jitsiViewController!, animated: true)
        //jitsiViewController?.popoverPresentationController?.sourceView = rootViewController.view
        
        //rootViewController.show(jitsiViewController!, sender: self)

//            let alertController = UIAlertController(title: "iOScreator", message:"Hello, world!", preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
//        result("iOS " + UIDevice.current.systemVersion)
//        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true)

                }
    else if (call.method == "showToast"){
           var map = call.arguments as? Dictionary<String, String>
           var message = map?["message"]
           var alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
           alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true)
       }
     
  }
}
