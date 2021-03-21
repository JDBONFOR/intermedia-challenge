import UIKit
import FirebaseAuth

protocol AuthViewModelProtocol: class {
    func setupUI()
    func showToast(backgroundColor: UIColor, title: String)
    func openApp(_ nav: UINavigationController)
}

public class AuthViewModel {
    
    // MARK: - Vars
    var delegate: AuthViewModelProtocol?
    
    init() {}
    
}

// MARK: - Extensions
extension AuthViewModel {
    
    func checkIfUserIsLogged() {
        let userID = UserDefaults.standard.object(forKey: "user")
        if userID != nil {
            let story = UIStoryboard(name: "App", bundle: nil)
            if let homeVC = story.instantiateInitialViewController() as? TabBarViewController {
                
                let nav = UINavigationController.init(rootViewController: homeVC)
                nav.modalPresentationStyle = .fullScreen
                self.delegate?.openApp(nav)
                
            } else {
                self.delegate?.setupUI()
            }
            
        } else {
            self.delegate?.setupUI()
        }
    }
    
    func isValidEmail(_ email: String, _ password: String, _ createUser: Bool) {
        let format = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailChecked = NSPredicate(format:"SELF MATCHES %@", format)
        
        if emailChecked.evaluate(with: email) {
            authUser(email, password, createUser)
        } else {
            self.delegate?.showToast(backgroundColor: .errorColor, title: "Format email is not valid, check it out")
        }
    }
    
    func authUser(_ email: String, _ password: String, _ createUser: Bool) {
        
        if createUser {
            
            Auth.auth().createUser(withEmail: email, password: password) { ( result, error) in
                if let error = error {
                    self.delegate?.showToast(backgroundColor: .errorColor, title: error.localizedDescription)
                } else {
                    self.delegate?.showToast(backgroundColor: .successColor, title: "Account created successfully, please Log in")
                }
            }
            
        } else {
            
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if let error = error {
                    
                    self.delegate?.showToast(backgroundColor: .errorColor, title: error.localizedDescription)
                    
                } else if let result = result {
                    
                    #if DEBUG
                    print("result \(result.user.uid)")
                    #endif
                    
                    UserDefaults.standard.set(result.user.uid, forKey: "user")
                    
                    self.delegate?.showToast(backgroundColor: .successColor, title: "Hi \(email) 👋")
                    Timer.scheduledTimer(withTimeInterval: 4, repeats: false, block: {_ in
                        self.checkIfUserIsLogged()
                    })
                }
            }
            
        }
    }
    
}
