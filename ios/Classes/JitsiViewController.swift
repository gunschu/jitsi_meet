import UIKit
import JitsiMeet

class JitsiViewController: UIViewController {

    @IBOutlet weak var videoButton: UIButton?

    fileprivate var pipViewCoordinator: PiPViewCoordinator?
    fileprivate var jitsiMeetView: JitsiMeetView?
    
    var roomName:String? = nil
    var subject:String? = nil
    
    var jistiMeetUserInfo = JitsiMeetUserInfo()
    
    
    
    lazy var mainView: UIView = {
        let view = UIView(frame: self.view.frame)
        view.backgroundColor = .white
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var meetingNameLabel: UILabel = {
        let textField = UILabel()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 30)
        textField.text = ""
        textField.tintColor = .red
        
        return textField
    }()
    
    lazy var subjectLabel: UILabel = {
        let textField = UILabel()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 30)
        textField.text = ""
        textField.tintColor = .red
        
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.titleLabel?.textColor = .white
        button.setTitle("Start Meeting", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(openButtonClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var loginButton2: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.titleLabel?.textColor = .white
        button.setTitle("End Meeting", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(closeButtonClicked), for: .touchUpInside)
        return button
    }()
    
    override func loadView() {
           super.loadView()
           view = mainView
       }
    
    @objc func openButtonClicked(sender : UIButton){
        
        openJitsiMeetWithOptions();
    }
    
    @objc func closeButtonClicked(sender : UIButton){
        cleanUp();
        self.dismiss(animated: true, completion: nil)
    }

       

    override func viewDidLoad() {
    
        //print("VIEW DID LOAD")
        //self.view.backgroundColor = .purple
        
    
    
               
        meetingNameLabel.text = roomName
        
               subjectLabel.text = subject
        
        
        
             view.addSubview(scrollView)
               scrollView.addSubview(containerView)
               containerView.addSubview(meetingNameLabel)
               containerView.addSubview(subjectLabel)
               containerView.addSubview(loginButton)
               containerView.addSubview(loginButton2)
               
               NSLayoutConstraint.activate([
                   scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                   scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                   scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                   scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
               ])
               
               NSLayoutConstraint.activate([
                   containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                   containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                   containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                   containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                   containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1)
               ])
               
                NSLayoutConstraint.activate([
                           meetingNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 36),
                           meetingNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
                           meetingNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
                       ])
                       
                       
                       NSLayoutConstraint.activate([
                           subjectLabel.topAnchor.constraint(equalTo: meetingNameLabel.bottomAnchor, constant: 36),
                           subjectLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
                           subjectLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
                       ])

               
               NSLayoutConstraint.activate([
                   loginButton.topAnchor.constraint(equalTo: subjectLabel.topAnchor, constant: 36),
                   loginButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1/2),
                   loginButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
               ])
               
               NSLayoutConstraint.activate([
                   loginButton2.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
                   loginButton2.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1/2),
                   loginButton2.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                   loginButton2.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
               ])
        
   
        super.viewDidLoad()
    }

    
    
    
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let rect = CGRect(origin: CGPoint.zero, size: size)
        pipViewCoordinator?.resetBounds(bounds: rect)
    }

    // MARK: - Actions

    func openJitsiMeet() {
        cleanUp()
        // create and configure jitsimeet view
        let jitsiMeetView = JitsiMeetView()
         
        jitsiMeetView.delegate = self
        self.jitsiMeetView = jitsiMeetView
        let options = JitsiMeetConferenceOptions.fromBuilder { (builder) in
            builder.welcomePageEnabled = true
            builder.room = "NewRoom"
            builder.subject = "Splendid Meeting"
            builder.userInfo = self.jistiMeetUserInfo
        }
        print("Options, \(options)!")
               
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
    
    func openJitsiMeetWithOptions() {
            cleanUp()
    print("OPEN JITSI MEET WITH OPTIONS")
            
            // create and configure jitsimeet view
            let jitsiMeetView = JitsiMeetView()
            jitsiMeetView.delegate = self
            self.jitsiMeetView = jitsiMeetView
            let options = JitsiMeetConferenceOptions.fromBuilder { (builder) in
                builder.welcomePageEnabled = true
                builder.room = self.roomName
                builder.subject = self.subject
                builder.userInfo = self.jistiMeetUserInfo
            }
            print("Options, \(options)!")
                   
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
    }
}

extension JitsiViewController: JitsiMeetViewDelegate {
    func conferenceTerminated(_ data: [AnyHashable : Any]!) {
        DispatchQueue.main.async {
            self.pipViewCoordinator?.hide() { _ in
                self.cleanUp()
                 
            }
           
        }
    }

    func enterPicture(inPicture data: [AnyHashable : Any]!) {
        DispatchQueue.main.async {
            self.pipViewCoordinator?.enterPictureInPicture()
        }
    }
}
