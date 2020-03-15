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
            
            if let args = call.arguments as? Dictionary<String, Any>,
                          let roomName = args["room"] as? String,
                          let subject = args["subject"] as? String,
                          let displayName = args["userDisplayName"] as? String,
                          let email = args["userEmail"] as? String,
                let avatarURL = args["userAvatarURL"] as? String,
                let audioOnly = args["audioOnly"] as? Bool,
            let audioMuted = args["audioMuted"] as? Bool,
                let videoMuted = args["videoMuted"] as? Bool
            {
                jitsiViewController!.roomName = roomName;
                jitsiViewController?.subject = subject;
                jitsiViewController?.audioMuted = audioMuted;
                jitsiViewController?.videoMuted = videoMuted;
                //TODO: This is giving errors for now 
                //jitsiViewController?.avatarURL = avatarURL;
                jitsiViewController!.jistiMeetUserInfo.displayName = displayName
                jitsiViewController?.jistiMeetUserInfo.email = email;
                
                
            }
            self.uiVC.present(jitsiViewController!, animated: true, completion: nil)
            //print("OPEN JITSI MEET CALLED")
        }
     
  }
}
}
