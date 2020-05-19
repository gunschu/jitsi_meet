import Flutter
import UIKit
import JitsiMeet

public class SwiftJitsiMeetPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    var window: UIWindow?
    
    var uiVC : UIViewController
    
    var eventSink : FlutterEventSink?
    
    init(uiViewController: UIViewController) {
        self.uiVC = uiViewController
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "jitsi_meet", binaryMessenger: registrar.messenger())
        
        let viewController: UIViewController =
            (UIApplication.shared.delegate?.window??.rootViewController)!
        
        let instance = SwiftJitsiMeetPlugin(uiViewController: viewController)
        
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        // Set up event channel for conference events
        let eventChannelName = "jitsi_meet_events"
        
        let eventChannel = FlutterEventChannel(name: eventChannelName, binaryMessenger: registrar.messenger())
        eventChannel.setStreamHandler(instance)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if (call.method == "joinMeeting") {
            
            let jitsiViewController: JitsiViewController? = JitsiViewController.init()
            jitsiViewController?.eventSink = eventSink;
            // text = call.argument("text");
            
            guard let args = call.arguments else {
                return
            }
            
            if let myArgs = args as? [String: Any]
            {
                if let roomName = myArgs["room"] as? String {
                    if let serverURL = myArgs["serverURL"] as? String {
                        //                        print("serverUrl: ", serverURL);
                        jitsiViewController?.serverUrl = URL(string: serverURL);
                    }
                    let subject = myArgs["subject"] as? String
                    let displayName = myArgs["userDisplayName"] as? String
                    let email = myArgs["userEmail"] as? String
                    let appBarColor = myArgs["iosAppBarRGBAColor"] as? String
                    let token = myArgs["token"] as? String
                    
                    jitsiViewController?.roomName = roomName;
                    jitsiViewController?.subject = subject;
                    jitsiViewController?.jistiMeetUserInfo.displayName = displayName;
                    jitsiViewController?.jistiMeetUserInfo.email = email;
                    jitsiViewController?.token = token;
                 
                    jitsiViewController?.appBarColor = UIColor(hex: appBarColor ??  "#00000000")
                    
                    //                    let avatar = myArgs["userAvatarURL"] as? String,
                    //                    let avatarURL  = URL(string: avatar)
                    //                    jitsiViewController?.jistiMeetUserInfo.avatar = avatarURL;
                    if let audioOnly = myArgs["audioOnly"] as? Int {
                        let audioOnlyBool = audioOnly > 0 ? true : false
                        jitsiViewController?.audioOnly = audioOnlyBool;
                    }
                    
                    if let audioMuted = myArgs["audioMuted"] as? Int {
                        let audioMutedBool = audioMuted > 0 ? true : false
                        jitsiViewController?.audioMuted = audioMutedBool;
                    }
                    
                    if let videoMuted = myArgs["videoMuted"] as? Int {
                        let videoMutedBool = videoMuted > 0 ? true : false
                        jitsiViewController?.videoMuted = videoMutedBool;
                    }
                    
                } else {
                    result(FlutterError.init(code: "400", message: "room is null in arguments for method: (joinMeeting)", details: "room is null in arguments for method: (joinMeeting)"))
                }
            } else {
                result(FlutterError.init(code: "400", message: "arguments are null for method: (joinMeeting)", details: "arguments are null for method: (joinMeeting)"))
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
            navigationController.navigationBar.barTintColor = UIColor.black
            self.uiVC.present(navigationController, animated: true)
            
            //self.uiVC.modalPresentationStyle = .fullScreen
            //self.uiVC.present(jitsiViewController!, animated: true, completion: nil)
            //print("OPEN JITSI MEET CALLED")
        }
        
    }
    
    /**
     # FlutterStreamHandler methods
     */
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
}
