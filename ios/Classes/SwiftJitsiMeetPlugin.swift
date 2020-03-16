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
        else if (call.method == "joinMeeting") {
            
            var jitsiViewController: JitsiViewController? = JitsiViewController.init()
            // text = call.argument("text");
            
             guard let args = call.arguments else {
                   return
                 }
                 if let myArgs = args as? [String: Any],
                    let roomName = myArgs["room"] as? String,
                    let subject = myArgs["subject"] as? String,
                    let displayName = myArgs["userDisplayName"] as? String,
                    let email = myArgs["userEmail"] as? String,
                    let avatar = myArgs["userAvatarURL"] as? String,
                    let audioOnly = myArgs["audioOnly"] as? Int,
                    let audioMuted = myArgs["audioMuted"] as? Int,
                    let videoMuted = myArgs["videoMuted"] as? Int
                 {
                   //result("Params received on iOS = \(someInfo1), \(someInfo2)")
                    print(myArgs)
                    jitsiViewController?.roomName = roomName;
                    jitsiViewController?.subject = subject;
                    jitsiViewController?.jistiMeetUserInfo.displayName = displayName;
                    jitsiViewController?.jistiMeetUserInfo.email = email;
                    let avatarURL  = URL(string: avatar)
                    jitsiViewController?.jistiMeetUserInfo.avatar = avatarURL;
                    
                    let audioOnlyBool = audioOnly > 0 ? true : false
                    jitsiViewController?.audioOnly = audioOnlyBool;
                    
                    let audioMutedBool = audioMuted > 0 ? true : false
                    jitsiViewController?.audioMuted = audioMutedBool;
                    
                    let videoMutedBool = videoMuted > 0 ? true : false
                    jitsiViewController?.videoMuted = videoMutedBool;
                    
                    
                 } else {
                   result("iOS could not extract flutter arguments in method: (sendParams)")
                 }
               
        
            //jitsiViewController!.roomName = call.arguments!["room"] as? String;
           // jitsiViewController!.subject = call.arguments!["subject"] as? String;
           // jitsiViewController?.jistiMeetUserInfo.displayName = call.arguments?["userDisplayName"] as? String;
           // jitsiViewController?.jistiMeetUserInfo.email = call.arguments?["userEmail"] as? String;
           // jitsiViewController?.jistiMeetUserInfo.avatar = call.arguments["userAvatarURL"] as? URL;
            //jitsiViewController.serverURL = call.argument["serverURL"] as? URL;
          //  jitsiViewController?.audioOnly = call.arguments?["audioOnly"] as? Bool;
          //  jitsiViewController?.audioMuted = call.arguments?["audioMuted"] as? Bool;
           // jitsiViewController?.videoMuted = call.arguments?["videoMuted"] as? Bool;
        
            let navigationController = UINavigationController(rootViewController: (jitsiViewController)!)
            navigationController.modalPresentationStyle = .fullScreen
            self.uiVC.present(navigationController, animated: true)
            
            //self.uiVC.modalPresentationStyle = .fullScreen
            //self.uiVC.present(jitsiViewController!, animated: true, completion: nil)
            //print("OPEN JITSI MEET CALLED")
        }
     
  }
}
