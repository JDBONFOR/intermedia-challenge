import UIKit

class TabBarViewController: UITabBarController {

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupUI()
    }

}

// MARK: - Private Methods
private extension TabBarViewController {
    
    func setupUI() {
        
        self.navigationController?.navigationBar.topItem?.title = "Marvel Challenge"
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "lock"), style: .plain, target: self, action: #selector(closeSession))
    }
    
    @objc func closeSession() {
        
        self.navigationController?.dismiss(animated: true) {
            UserDefaults.standard.removeObject(forKey: "user")
        }
        
    }
}
