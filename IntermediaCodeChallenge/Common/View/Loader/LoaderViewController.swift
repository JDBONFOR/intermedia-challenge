import UIKit
import Lottie

class LoaderViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var loaderView: AnimationView!
    
    // MARK: - Life Style
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

}

// MARK: - Private Methods
private extension LoaderViewController {
    
    func setupUI() {
        
        loaderView.contentMode = .scaleAspectFit
        loaderView.loopMode = .loop
        loaderView.animationSpeed = 1
        loaderView.play()
    }
}
