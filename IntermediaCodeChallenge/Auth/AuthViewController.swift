import UIKit

class AuthViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var logInButton: UIButton!
    @IBOutlet private weak var signUpButton: UIButton!
    
    // MARK: - Vars
    private var viewModel: AuthViewModel = AuthViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        checkIfUserIsLogged()
    }
    
    // MARK: - IBActions
    @IBAction func logInButtonAction(_ sender: Any) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            viewModel.isValidEmail(email, password, false)
        }
        
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            viewModel.isValidEmail(email, password, true)
        }
    }
    
}

// MARK: - Private Methods
private extension AuthViewController {
    
    func checkIfUserIsLogged() {
        viewModel.checkIfUserIsLogged()
    }
    
        
}

// MARK: - Extensions
extension AuthViewController: AuthViewModelProtocol {
    func showToast(backgroundColor: UIColor, title: String) {
        Utils.showToast(in: self, backgroundColor: backgroundColor, title: title)
    }
    
    func openApp(_ nav: UINavigationController) {
        self.present(nav, animated: false, completion: nil)
    }
    
    func setupUI() {
        
        self.navigationController?.navigationBar.isHidden = true
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode = .scaleAspectFit
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
}
