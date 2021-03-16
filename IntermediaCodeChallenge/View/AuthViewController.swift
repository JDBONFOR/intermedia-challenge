import UIKit
import FirebaseAuth

class AuthViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var logInButton: UIButton!
    @IBOutlet private weak var signUpButton: UIButton!
    
    // MARK: - Vars
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - IBActions
    @IBAction func logInButtonAction(_ sender: Any) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            if isValidEmail(email) {
                authUser(email, password, false)
            } else {
                Utils.showToast(in: self, backgroundColor: .errorColor, title: "Format email is not valid, check it out")
            }
        }
        
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            if isValidEmail(email) {
                authUser(email, password, true)
            } else {
                Utils.showToast(in: self, backgroundColor: .errorColor, title: "Format email is not valid, check it out")
            }
        }
    }
    
}

// MARK: - Private Methods
private extension AuthViewController {
    
    func setupUI() {
        title = "Intermedia Challenge"
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let format = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailChecked = NSPredicate(format:"SELF MATCHES %@", format)
        return emailChecked.evaluate(with: email)
    }
    
    func authUser(_ email: String, _ password: String, _ createUser: Bool) {
        
        if createUser {
            
            Auth.auth().createUser(withEmail: email, password: password) { ( result, error) in
                if let error = error {
                    Utils.showToast(in: self, backgroundColor: .errorColor, title: error.localizedDescription)
                } else {
                    Utils.showToast(in: self, backgroundColor: .successColor, title: "Account created successfully, please Log in")
                }
            }
            
        } else {
            
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if let error = error {
                    Utils.showToast(in: self, backgroundColor: .errorColor, title: error.localizedDescription)
                } else if let result = result {
                    
                    print("result \(result.user.uid)")
                    UserDefaults.standard.set(result.user.uid, forKey: "user")
                    
                    Utils.showToast(in: self, backgroundColor: .successColor, title: "Hi \(email) 👋")
                    Timer.scheduledTimer(withTimeInterval: 4, repeats: false, block: {_ in
                        
                        let story = UIStoryboard(name: "App", bundle: nil)
                        let homeVC = story.instantiateInitialViewController()!
                        let nav = UINavigationController.init(rootViewController: homeVC)
                        
                        nav.navigationBar.barTintColor = .navBarColor
                        nav.navigationBar.titleTextAttributes = [
                            NSAttributedString.Key.foregroundColor: UIColor.white,
                            NSAttributedString.Key.font: UIFont(name: "RobotoCondensed-Bold", size: 20) ?? UIFont.boldSystemFont(ofSize: 20)
                        ]
                        nav.navigationBar.topItem?.title = "Marvel Challenge"
                        nav.modalPresentationStyle = .fullScreen
                        self.present(nav, animated: true, completion: nil)
                        
                    })
                }
            }
            
        }
    }    
}
