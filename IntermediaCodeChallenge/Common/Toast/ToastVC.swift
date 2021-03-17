import UIKit

class ToastVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var toastBackgroundView: UIView!
    @IBOutlet private weak var toastMessageLabel: UILabel!
    
    // MARK: - Vars
    var backgroundColor: UIColor?
    var message: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

extension ToastVC {
    
    func setupUI() {
        
        if let title = self.message {
            toastMessageLabel?.text = title
        }
        
        if let background = self.backgroundColor {
            toastBackgroundView?.backgroundColor = background
        }
    }
}
