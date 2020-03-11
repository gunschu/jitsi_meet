import UIKit
import JitsiMeet

class JitsiViewController: UIViewController {

    @IBOutlet weak var videoButton: UIButton?

    fileprivate var pipViewCoordinator: PiPViewCoordinator?
    fileprivate var jitsiMeetView: JitsiMeetView?
    
    var roomName:String? = nil
    var subject:String? = nil
    
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
    
    lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.borderStyle = .roundedRect
        textField.tintColor = .red
        textField.placeholder = "Username"
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.borderStyle = .roundedRect
        textField.tintColor = .red
        textField.placeholder = "Password"
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
        openJitsiMeet();
    }
    
    @objc func closeButtonClicked(sender : UIButton){
        cleanUp();
        self.dismiss(animated: true, completion: nil)
    }

       

    override func viewDidLoad() {
    
        //print("VIEW DID LOAD")
        //self.view.backgroundColor = .purple
       
             view.addSubview(scrollView)
               scrollView.addSubview(containerView)
               //containerView.addSubview(usernameTextField)
               //containerView.addSubview(passwordTextField)
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
                   loginButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
                   loginButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1/2),
                   loginButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
               ])
               
               NSLayoutConstraint.activate([
                   loginButton2.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 8),
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
