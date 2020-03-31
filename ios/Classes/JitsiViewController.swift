import UIKit
import JitsiMeet

class JitsiViewController: UIViewController {

    @IBOutlet weak var videoButton: UIButton?

    fileprivate var pipViewCoordinator: PiPViewCoordinator?
    fileprivate var jitsiMeetView: JitsiMeetView?
    
    var roomName:String? = nil
    var serverUrl:URL? = nil
    var subject:String? = nil
    var audioOnly:Bool? = false
    var audioMuted: Bool? = false
    var videoMuted: Bool? = false
    
    var jistiMeetUserInfo = JitsiMeetUserInfo()
    
    override func loadView() {
        
           super.loadView()
       }
    
    @objc func openButtonClicked(sender : UIButton){
        
        //openJitsiMeetWithOptions();
    }
    
    @objc func closeButtonClicked(sender : UIButton){
        cleanUp();
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
    
        //print("VIEW DID LOAD")
        self.view.backgroundColor = .black
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        openJitsiMeet();
    }

    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let rect = CGRect(origin: CGPoint.zero, size: size)
        pipViewCoordinator?.resetBounds(bounds: rect)
    }

    func openJitsiMeet() {
        cleanUp()
        // create and configure jitsimeet view
        let jitsiMeetView = JitsiMeetView()
        
        
        jitsiMeetView.delegate = self
        self.jitsiMeetView = jitsiMeetView
        let options = JitsiMeetConferenceOptions.fromBuilder { (builder) in
            builder.welcomePageEnabled = true
            builder.room = self.roomName
            builder.serverURL = self.serverUrl
            builder.subject = self.subject
            builder.userInfo = self.jistiMeetUserInfo
            builder.audioOnly = self.audioOnly ?? false
            builder.audioMuted = self.audioMuted ?? false
            builder.videoMuted = self.videoMuted ?? false
        }
//        print("Options, \(options.serverURL)!")
               
        jitsiMeetView.join(options)
       
        // Enable jitsimeet view to be a view that can be displayed
        // on top of all the things, and let the coordinator to manage
        // the view state and interactions
        pipViewCoordinator = PiPViewCoordinator(withView: jitsiMeetView)
        pipViewCoordinator?.configureAsStickyView(withParentView: view)

        // animate in
        jitsiMeetView.alpha = 0
        pipViewCoordinator?.show()
    }
    
    
    fileprivate func cleanUp() {
        jitsiMeetView?.removeFromSuperview()
        jitsiMeetView = nil
        pipViewCoordinator = nil
        //self.dismiss(animated: true, completion: nil)
    }
}



extension JitsiViewController: JitsiMeetViewDelegate {
    func conferenceTerminated(_ data: [AnyHashable : Any]!) {
        //print("CONFERENCE TERMINATED")
        DispatchQueue.main.async {
            self.pipViewCoordinator?.hide() { _ in
                self.cleanUp()
                self.dismiss(animated: true, completion: nil)
            }
        }
       
    }

    func enterPicture(inPicture data: [AnyHashable : Any]!) {
        //print("CONFERENCE PIP")
        DispatchQueue.main.async {
            self.pipViewCoordinator?.enterPictureInPicture()
        }
    }
}
