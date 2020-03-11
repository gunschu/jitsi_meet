class RootVC: UIViewController {

    //happens only once:
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    //happens every time when shown:
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLayout()
    }

        private func setupLayout() {
            
    }
}
